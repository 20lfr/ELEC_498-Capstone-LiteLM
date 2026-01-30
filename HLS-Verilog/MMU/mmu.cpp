#include "mmu.hpp"

void mmu_init(MMUState &state, const ModelDims &dims) {
#pragma HLS INLINE
    state.dims = dims;
    state.num_tiles = 0;
    state.next_bank = 0;
    state.current_token = 0;
    state.k_cache_base = 0;
    state.v_cache_base = 0;
    state.main_dma_done = false;
    state.main_compute_done = false;
    
    for (int i = 0; i < MMU_URAM_BANKS; ++i) {
#pragma HLS UNROLL
        state.bank_offsets[i] = 0;
    }
    
    for (int i = 0; i < MMU_MAX_HEADS; ++i) {
#pragma HLS UNROLL
        state.head_dma_done[i] = false;
        state.head_compute_done[i] = false;
    }
    
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL
        state.tile_table[i].valid = false;
    }
}

void mmu_reset(MMUState &state) {
#pragma HLS INLINE
    ModelDims dims = state.dims;  
    uint32_t k_base = state.k_cache_base;
    uint32_t v_base = state.v_cache_base;
    mmu_init(state, dims);
    state.k_cache_base = k_base;
    state.v_cache_base = v_base;
}

void mmu_set_kv_cache_bases(MMUState &state, uint32_t k_base, uint32_t v_base) {
#pragma HLS INLINE
    state.k_cache_base = k_base;
    state.v_cache_base = v_base;
}

MemoryRequest mmu_decode_memory_request(uint32_t packed) {
#pragma HLS INLINE
    return MemoryRequest(packed);
}

ComputeRequest mmu_decode_compute_request(uint32_t packed) {
#pragma HLS INLINE
    return ComputeRequest(packed);
}

uint16_t mmu_calc_dma_size(DmaSel sel, const ModelDims &dims, int tile) {
#pragma HLS INLINE off
    
    switch (sel) {
        case DmaSel::DMASEL_WQ:
        case DmaSel::DMASEL_WK:
        case DmaSel::DMASEL_WV: {
            // W (i4): D_HEADS × D_MODEL × 0.5 bytes
            // B (i4): D_HEADS × 0.5 bytes
            uint16_t w_size = (dims.d_heads * dims.d_model) / 2;
            uint16_t b_size = dims.d_heads / 2;
            return w_size + b_size;
        }
        
        case DmaSel::DMASEL_K_WRITE:
        case DmaSel::DMASEL_V_WRITE: {
            // Single token: D_HEADS × i8
            return dims.d_heads;
        }
        
        case DmaSel::DMASEL_CTX_K:
        case DmaSel::DMASEL_CTX_V: {
            // Full cache: CONTEXT_LEN × D_HEADS × i8
            return dims.context_len * dims.d_heads;
        }
        
        case DmaSel::DMASEL_WO: {
            // W (i4): D_TILE_WO × D_MODEL × 0.5 bytes
            // B (i32): D_TILE_WO × 4 bytes
            uint16_t w_size = (dims.d_tile_wo * dims.d_model) / 2;
            uint16_t b_size = dims.d_tile_wo * 4;
            return w_size + b_size;
        }
        
        case DmaSel::DMASEL_W1: {
            // W (i4): D_TILE_W1 × D_MODEL × 0.5 bytes
            // B (i32): D_TILE_W1 × 4 bytes
            // S (i16): D_TILE_W1 × 2 bytes
            uint16_t w_size = (dims.d_tile_w1 * dims.d_model) / 2;
            uint16_t b_size = dims.d_tile_w1 * 4;
            uint16_t s_size = dims.d_tile_w1 * 2;
            return w_size + b_size + s_size;
        }
        
        case DmaSel::DMASEL_W2: {
            // W (i4): D_TILE_W2 × D_FFN × 0.5 bytes
            // B (i32): D_TILE_W2 × 4 bytes
            // S (i16): D_TILE_W2 × 2 bytes
            uint16_t w_size = (dims.d_tile_w2 * dims.d_ffn) / 2;
            uint16_t b_size = dims.d_tile_w2 * 4;
            uint16_t s_size = dims.d_tile_w2 * 2;
            return w_size + b_size + s_size;
        }
        
        case DmaSel::DMASEL_WLOGIT: {
            //TODO
            // Placeholder: assume similar to WO
            return 0;
        }
        
        default:
            return 0;
    }
}

uint16_t mmu_calc_input_buffer_size(ComputeOp op, const ModelDims &dims) {
#pragma HLS INLINE off
    
    switch (op) {
        case ComputeOp::CMP_Q:
        case ComputeOp::CMP_K:
        case ComputeOp::CMP_V: {
            // ACT (i8): D_MODEL 2048 bytes 
            // W (i4): D_HEADS × D_MODEL × 0.5
            // B (i4): D_HEADS × 0.5
            uint16_t act_size = dims.d_model;
            uint16_t w_size = (dims.d_heads * dims.d_model) / 2;
            uint16_t b_size = dims.d_heads / 2;
            return act_size + w_size + b_size;
        }
        
        case ComputeOp::CMP_K_REQUANT:
        case ComputeOp::CMP_V_REQUANT:
        case ComputeOp::CMP_Q_REQUANT:
        case ComputeOp::CMP_HEAD_REQUANT: {
            // X (i32): 4 × D_HEADS
            // M, N, Z (i32): 4 bytes each
            return 4 * dims.d_heads + 12;
        }
        
        case ComputeOp::CMP_ATT_SCORES: {
            // Q (i8): D_HEADS = 4 bytes (test)
            // K_CACHE (i8): CONTEXT_LEN × D_HEADS (t-major)
            return dims.d_heads + (dims.context_len * dims.d_heads);
        }
        
        case ComputeOp::CMP_VALUE_SCALE: {
            // X (i32): 4 × CONTEXT_LEN
            // SCALE (i16): 2 bytes
            return 4 * dims.context_len + 2;
        }
        
        case ComputeOp::CMP_SOFTMAX: {
            // X (i16): 2 × CONTEXT_LEN
            return 2 * dims.context_len;
        }
        
        case ComputeOp::CMP_ATT_VALUE: {
            // WGHT (i8): CONTEXT_LEN
            // V_CACHE (i8): CONTEXT_LEN × D_HEADS (h-major)
            return dims.context_len + (dims.context_len * dims.d_heads);
        }
        
        case ComputeOp::CMP_LN0:
        case ComputeOp::CMP_LN1: {
            // X (i8): D_MODEL
            // GAMMA (i32): 4 × D_MODEL
            // EPS (i32): 4 bytes
            return dims.d_model + (4 * dims.d_model) + 4;
        }
        
        case ComputeOp::CMP_REQUANT1:
        case ComputeOp::CMP_REQUANT2:
        case ComputeOp::CMP_REQUANT3:
        case ComputeOp::CMP_REQUANT4: {
            // X (i32): 4 × D_MODEL
            // M, N, Z (i32): 4 bytes each
            return 4 * dims.d_model + 12;
        }
        
        case ComputeOp::CMP_RESID0:
        case ComputeOp::CMP_RESID1: {
            // X (i8): D_MODEL
            // R (i8): D_MODEL
            return 2 * dims.d_model;
        }
        
        case ComputeOp::CMP_OUT_PROJ: {
            // ACT (i8): D_MODEL
            // W (i4): D_TILE_WO × D_MODEL × 0.5
            // B (i32): D_TILE_WO × 4
            uint16_t act_size = dims.d_model;
            uint16_t w_size = (dims.d_tile_wo * dims.d_model) / 2;
            uint16_t b_size = dims.d_tile_wo * 4;
            return act_size + w_size + b_size;
        }
        
        case ComputeOp::CMP_FFN_W1: {
            // X (i8): D_MODEL
            // W (i4): D_TILE_W1 × D_MODEL × 0.5
            // B (i32): D_TILE_W1 × 4
            // S (i16): D_TILE_W1 × 2
            uint16_t x_size = dims.d_model;
            uint16_t w_size = (dims.d_tile_w1 * dims.d_model) / 2;
            uint16_t b_size = dims.d_tile_w1 * 4;
            uint16_t s_size = dims.d_tile_w1 * 2;
            return x_size + w_size + b_size + s_size;
        }
        
        case ComputeOp::CMP_FFN_ACT: {
            // X (i16): 2 × D_FFN
            return 2 * dims.d_ffn;
        }
        
        case ComputeOp::CMP_FFN_W2: {
            // X (i16): 2 × D_TILE_W2
            // W (i4): D_TILE_W2 × D_FFN × 0.5
            // B (i32): D_TILE_W2 × 4
            // S (i16): D_TILE_W2 × 2
            uint16_t x_size = 2 * dims.d_tile_w2;
            uint16_t w_size = (dims.d_tile_w2 * dims.d_ffn) / 2;
            uint16_t b_size = dims.d_tile_w2 * 4;
            uint16_t s_size = dims.d_tile_w2 * 2;
            return x_size + w_size + b_size + s_size;
        }
        
        default:
            return 0;
    }
}

uint16_t mmu_calc_output_buffer_size(ComputeOp op, const ModelDims &dims) {
#pragma HLS INLINE off
    
    switch (op) {
        case ComputeOp::CMP_Q:
        case ComputeOp::CMP_K:
        case ComputeOp::CMP_V:
        case ComputeOp::CMP_ATT_SCORES:
        case ComputeOp::CMP_ATT_VALUE: {
            // Output (i32): 4 × D_HEADS
            return 4 * dims.d_heads;
        }
        
        case ComputeOp::CMP_K_REQUANT:
        case ComputeOp::CMP_V_REQUANT:
        case ComputeOp::CMP_Q_REQUANT:
        case ComputeOp::CMP_HEAD_REQUANT: {
            // Output (i8): D_HEADS
            return dims.d_heads;
        }
        
        case ComputeOp::CMP_VALUE_SCALE: {
            // Output (i16): 2 × CONTEXT_LEN
            return 2 * dims.context_len;
        }
        
        case ComputeOp::CMP_SOFTMAX: {
            // Output (i16): 2 × CONTEXT_LEN
            return 2 * dims.context_len;
        }
        
        case ComputeOp::CMP_LN0:
        case ComputeOp::CMP_LN1: {
            // Output (i32): 4 × D_MODEL
            return 4 * dims.d_model;
        }
        
        case ComputeOp::CMP_REQUANT1:
        case ComputeOp::CMP_REQUANT2:
        case ComputeOp::CMP_REQUANT3:
        case ComputeOp::CMP_REQUANT4:
        case ComputeOp::CMP_RESID0:
        case ComputeOp::CMP_RESID1: {
            // Output (i8): D_MODEL
            return dims.d_model;
        }
        
        case ComputeOp::CMP_OUT_PROJ: {
            // Output (i32): 4 × D_TILE_WO
            return 4 * dims.d_tile_wo;
        }
        
        case ComputeOp::CMP_FFN_W1: {
            // Output (i16): 2 × D_TILE_W1
            return 2 * dims.d_tile_w1;
        }
        
        case ComputeOp::CMP_FFN_ACT: {
            // Output (i16): 2 × D_FFN
            return 2 * dims.d_ffn;
        }
        
        case ComputeOp::CMP_FFN_W2: {
            // Output (i32): 4 × D_TILE_W2
            return 4 * dims.d_tile_w2;
        }
        
        default:
            return 0;
    }
}

