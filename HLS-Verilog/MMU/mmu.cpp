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
        case DmaSel::DMASEL_CONCAT: {
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

BufferLayout mmu_calc_input_layout(ComputeOp op, const ModelDims &dims) {
#pragma HLS INLINE off
    
    BufferLayout layout;
    uint16_t offset = 0;
    
    switch (op) {
        case ComputeOp::CMP_Q:
        case ComputeOp::CMP_K:
        case ComputeOp::CMP_V: {
            // Region 0: @0..2047 (prod)
            layout.regions[0] = BufferRegion(offset, dims.d_model);
            offset += dims.d_model;
            
            // Region 1: W (i4) @16.. (test)
            uint16_t w_size = (dims.d_heads * dims.d_model) / 2;
            layout.regions[1] = BufferRegion(offset, w_size);
            offset += w_size;
            
            // Region 2: B (i4)
            uint16_t b_size = dims.d_heads / 2;
            layout.regions[2] = BufferRegion(offset, b_size);
            offset += b_size;
            
            layout.num_regions = 3;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_K_REQUANT:
        case ComputeOp::CMP_V_REQUANT:
        case ComputeOp::CMP_Q_REQUANT:
        case ComputeOp::CMP_HEAD_REQUANT: {

            layout.regions[0] = BufferRegion(offset, 4 * dims.d_heads);
            offset += 4 * dims.d_heads;

            layout.regions[1] = BufferRegion(offset, 4);
            offset += 4;

            layout.regions[2] = BufferRegion(offset, 4);
            offset += 4;

            layout.regions[3] = BufferRegion(offset, 4);
            offset += 4;
            layout.num_regions = 4;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_ATT_SCORES: {

            layout.regions[0] = BufferRegion(offset, dims.d_heads);
            offset += dims.d_heads;

            layout.regions[1] = BufferRegion(offset, dims.context_len * dims.d_heads);
            offset += dims.context_len * dims.d_heads;
            
            layout.num_regions = 2;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_VALUE_SCALE: {
            layout.regions[0] = BufferRegion(offset, 4 * dims.context_len);
            offset += 4 * dims.context_len;
            
            layout.regions[1] = BufferRegion(offset, 2);
            offset += 2;
            
            layout.num_regions = 2;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_SOFTMAX: {
            layout.regions[0] = BufferRegion(offset, 2 * dims.context_len);
            offset += 2 * dims.context_len;
            
            layout.num_regions = 1;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_ATT_VALUE: {
            layout.regions[0] = BufferRegion(offset, dims.context_len);
            offset += dims.context_len;
            
            layout.regions[1] = BufferRegion(offset, dims.context_len * dims.d_heads);
            offset += dims.context_len * dims.d_heads;
            
            layout.num_regions = 2;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_LN0:
        case ComputeOp::CMP_LN1: {
            // Region 0: X (i8) @0..15 (test)
            layout.regions[0] = BufferRegion(offset, dims.d_model);
            offset += dims.d_model;
            
            // Region 1: GAMMA (i32) @16..79 (test)
            layout.regions[1] = BufferRegion(offset, 4 * dims.d_model);
            offset += 4 * dims.d_model;
            
            // Region 2: EPS (i32) @80..83 (test)
            layout.regions[2] = BufferRegion(offset, 4);
            offset += 4;
            
            layout.num_regions = 3;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_REQUANT1:
        case ComputeOp::CMP_REQUANT2:
        case ComputeOp::CMP_REQUANT3:
        case ComputeOp::CMP_REQUANT4: {
            // Region 0: X (i32) @0..63 (test)
            layout.regions[0] = BufferRegion(offset, 4 * dims.d_model);
            offset += 4 * dims.d_model;
            
            // Region 1: M (i32) @64
            layout.regions[1] = BufferRegion(offset, 4);
            offset += 4;
            
            // Region 2: N (i32) @68
            layout.regions[2] = BufferRegion(offset, 4);
            offset += 4;
            
            // Region 3: Z (i32) @72
            layout.regions[3] = BufferRegion(offset, 4);
            offset += 4;
            
            layout.num_regions = 4;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_RESID0:
        case ComputeOp::CMP_RESID1: {
            // Region 0: X (i8) @0..15 (test)
            layout.regions[0] = BufferRegion(offset, dims.d_model);
            offset += dims.d_model;
            
            // Region 1: R (i8) @16..31 (test)
            layout.regions[1] = BufferRegion(offset, dims.d_model);
            offset += dims.d_model;
            
            layout.num_regions = 2;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_OUT_PROJ: {
            // Region 0: ACT (i8) @0..15 (test)
            layout.regions[0] = BufferRegion(offset, dims.d_model);
            offset += dims.d_model;
            
            // Region 1: W (i4)
            uint16_t w_size = (dims.d_tile_wo * dims.d_model) / 2;
            layout.regions[1] = BufferRegion(offset, w_size);
            offset += w_size;
            
            // Region 2: B (i32)
            uint16_t b_size = dims.d_tile_wo * 4;
            layout.regions[2] = BufferRegion(offset, b_size);
            offset += b_size;
            
            layout.num_regions = 3;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_FFN_W1: {
            // Region 0: X (i8) @0..15 (test)
            layout.regions[0] = BufferRegion(offset, dims.d_model);
            offset += dims.d_model;
            
            // Region 1: W (i4)
            uint16_t w_size = (dims.d_tile_w1 * dims.d_model) / 2;
            layout.regions[1] = BufferRegion(offset, w_size);
            offset += w_size;
            
            // Region 2: B (i32)
            uint16_t b_size = dims.d_tile_w1 * 4;
            layout.regions[2] = BufferRegion(offset, b_size);
            offset += b_size;
            
            // Region 3: S (i16)
            uint16_t s_size = dims.d_tile_w1 * 2;
            layout.regions[3] = BufferRegion(offset, s_size);
            offset += s_size;
            
            layout.num_regions = 4;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_FFN_ACT: {
            // Region 0: X (i16) @0..(2*D_FFN-1) (test)
            layout.regions[0] = BufferRegion(offset, 2 * dims.d_ffn);
            offset += 2 * dims.d_ffn;
            
            layout.num_regions = 1;
            layout.total_size = offset;
            break;
        }
        
        case ComputeOp::CMP_FFN_W2: {
            // Region 0: X (i16) @0..43 (test)
            layout.regions[0] = BufferRegion(offset, 2 * dims.d_tile_w2);
            offset += 2 * dims.d_tile_w2;
            
            // Region 1: W (i4)
            uint16_t w_size = (dims.d_tile_w2 * dims.d_ffn) / 2;
            layout.regions[1] = BufferRegion(offset, w_size);
            offset += w_size;
            
            // Region 2: B (i32)
            uint16_t b_size = dims.d_tile_w2 * 4;
            layout.regions[2] = BufferRegion(offset, b_size);
            offset += b_size;
            
            // Region 3: S (i16)
            uint16_t s_size = dims.d_tile_w2 * 2;
            layout.regions[3] = BufferRegion(offset, s_size);
            offset += s_size;
            
            layout.num_regions = 4;
            layout.total_size = offset;
            break;
        }
        
        default:
            layout.num_regions = 0;
            layout.total_size = 0;
            break;
    }
    
    return layout;
}

BufferLayout mmu_calc_output_layout(ComputeOp op, const ModelDims &dims) {
#pragma HLS INLINE off
    
    BufferLayout layout;
    uint16_t offset = 0;
    
    uint16_t out_size = mmu_calc_output_buffer_size(op, dims);
    layout.regions[0] = BufferRegion(offset, out_size);
    layout.num_regions = 1;
    layout.total_size = out_size;
    
    return layout;
}

BufferRegion mmu_get_head_input_slice(ComputeOp op, int head, const ModelDims &dims) {
#pragma HLS INLINE off
    
    if (!mmu_is_headed_op(op)) {
        BufferLayout layout = mmu_calc_input_layout(op, dims);
        return BufferRegion(0, layout.total_size);
    }
    
    BufferLayout layout = mmu_calc_input_layout(op, dims);
    return BufferRegion(0, layout.total_size);
}

BufferRegion mmu_get_head_output_slice(ComputeOp op, int head, const ModelDims &dims) {
#pragma HLS INLINE off
    
    if (!mmu_is_headed_op(op)) {
        // Non-headed operations don't have per-head slices
        BufferLayout layout = mmu_calc_output_layout(op, dims);
        return BufferRegion(0, layout.total_size);
    }
    
    // For headed operations, each head's output is D_HEADS elements
    uint16_t per_head_size = mmu_calc_output_buffer_size(op, dims);
    uint16_t offset = head * per_head_size;
    
    return BufferRegion(offset, per_head_size);
}

WeightBlob mmu_parse_weight_blob(DmaSel sel, const ModelDims &dims) {
#pragma HLS INLINE off
    
    WeightBlob blob;
    uint16_t offset = 0;
    
    switch (sel) {
        case DmaSel::DMASEL_WQ:
        case DmaSel::DMASEL_WK:
        case DmaSel::DMASEL_WV: {
            // W (i4): D_HEADS × D_MODEL × 0.5 bytes
            uint16_t w_size = (dims.d_heads * dims.d_model) / 2;
            blob.weights = BufferRegion(offset, w_size);
            offset += w_size;
            
            // B (i4): D_HEADS × 0.5 bytes
            uint16_t b_size = dims.d_heads / 2;
            blob.biases = BufferRegion(offset, b_size);
            offset += b_size;
            
            blob.total_size = offset;
            break;
        }
        
        case DmaSel::DMASEL_WO: {
            // W (i4): D_TILE_WO × D_MODEL × 0.5 bytes
            uint16_t w_size = (dims.d_tile_wo * dims.d_model) / 2;
            blob.weights = BufferRegion(offset, w_size);
            offset += w_size;
            
            // B (i32): D_TILE_WO × 4 bytes
            uint16_t b_size = dims.d_tile_wo * 4;
            blob.biases = BufferRegion(offset, b_size);
            offset += b_size;
            
            blob.total_size = offset;
            break;
        }
        
        case DmaSel::DMASEL_W1: {
            // W (i4): D_TILE_W1 × D_MODEL × 0.5 bytes
            uint16_t w_size = (dims.d_tile_w1 * dims.d_model) / 2;
            blob.weights = BufferRegion(offset, w_size);
            offset += w_size;
            
            // B (i32): D_TILE_W1 × 4 bytes
            uint16_t b_size = dims.d_tile_w1 * 4;
            blob.biases = BufferRegion(offset, b_size);
            offset += b_size;
            
            // S (i16): D_TILE_W1 × 2 bytes
            uint16_t s_size = dims.d_tile_w1 * 2;
            blob.scales = BufferRegion(offset, s_size);
            offset += s_size;
            
            blob.total_size = offset;
            break;
        }
        
        case DmaSel::DMASEL_W2: {
            // W (i4): D_TILE_W2 × D_FFN × 0.5 bytes
            uint16_t w_size = (dims.d_tile_w2 * dims.d_ffn) / 2;
            blob.weights = BufferRegion(offset, w_size);
            offset += w_size;
            
            // B (i32): D_TILE_W2 × 4 bytes
            uint16_t b_size = dims.d_tile_w2 * 4;
            blob.biases = BufferRegion(offset, b_size);
            offset += b_size;
            
            // S (i16): D_TILE_W2 × 2 bytes
            uint16_t s_size = dims.d_tile_w2 * 2;
            blob.scales = BufferRegion(offset, s_size);
            offset += s_size;
            
            blob.total_size = offset;
            break;
        }
        
        default:
            blob.total_size = 0;
            break;
    }
    
    return blob;
}

KVCacheAddr mmu_calc_kv_write_addr(MMUState &state, int layer, int head, bool is_v) {
#pragma HLS INLINE off
    
    KVCacheAddr addr;
    
    // Base address for K or V cache
    uint32_t base = is_v ? state.v_cache_base : state.k_cache_base;
    
    if (base == 0) {
        addr.valid = false;
        return addr;
    }
    
    // Calculate offset: layer_offset + token_offset + head_offset
    // Layout: [layer][token][head]
    uint16_t cache_size_per_layer = state.dims.context_len * state.dims.d_heads;
    uint16_t cache_size_per_token = state.dims.d_heads;
    
    uint32_t layer_offset = layer * cache_size_per_layer;
    uint32_t token_offset = state.current_token * cache_size_per_token;
    uint32_t head_offset = head * state.dims.d_heads;  // Per-head size
    
    addr.base_addr = base + layer_offset + token_offset + head_offset;
    addr.token_offset = state.current_token;
    addr.head = head;
    addr.valid = true;
    
    return addr;
}

KVCacheAddr mmu_calc_kv_read_addr(MMUState &state, int layer, int head, bool is_v) {
#pragma HLS INLINE off
    
    KVCacheAddr addr;
    uint32_t base = is_v ? state.v_cache_base : state.k_cache_base;
    
    if (base == 0) {
        addr.valid = false;
        return addr;
    }
    
    // Read full cache for this layer and head (all tokens)
    // Layout: [layer][head][all_tokens] for efficient reading
    uint16_t cache_size_per_layer = state.dims.context_len * state.dims.d_heads;
    uint16_t cache_size_per_head = state.dims.context_len * state.dims.d_heads;
    
    uint32_t layer_offset = layer * cache_size_per_layer;
    uint32_t head_offset = head * cache_size_per_head;
    
    addr.base_addr = base + layer_offset + head_offset;
    addr.token_offset = 0;  // Reading all tokens
    addr.head = head;
    addr.valid = true;
    
    return addr;
}

uint32_t mmu_calc_kv_cache_size(const ModelDims &dims) {
#pragma HLS INLINE
    // Total cache size: NUM_LAYERS × CONTEXT_LEN × NUM_HEADS × D_HEADS
    return dims.num_layers * dims.context_len * dims.num_heads * dims.d_heads;
}

static bool tiles_match(
    const TileDescriptor &desc,
    DmaSel sel, int layer, int head, int tile
) {
#pragma HLS INLINE
    return desc.valid &&
           desc.addr_sel == sel &&
           desc.layer == layer &&
           desc.head == head &&
           desc.tile == tile;
}

bool mmu_check_cache(const MMUState &state, DmaSel sel, int layer, int head, int tile) {
#pragma HLS INLINE off
    
    // K_WRITE and V_WRITE don't get cached
    if (sel == DmaSel::DMASEL_K_WRITE || sel == DmaSel::DMASEL_V_WRITE) {
        return false;
    }
    
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS PIPELINE II=1
        if (tiles_match(state.tile_table[i], sel, layer, head, tile)) {
            return true;
        }
    }
    return false;
}

MMULookup mmu_lookup(const MMUState &state, DmaSel sel, int layer, int head, int tile) {
#pragma HLS INLINE off
    
    MMULookup result;
    
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS PIPELINE II=1
        if (tiles_match(state.tile_table[i], sel, layer, head, tile)) {
            result.found = true;
            result.uram_bank = state.tile_table[i].uram_bank;
            result.uram_offset = state.tile_table[i].uram_offset;
            result.size = state.tile_table[i].size;
            return result;
        }
    }
    
    return result;  // Not found
}

MMUAllocation mmu_allocate(MMUState &state, DmaSel sel, int layer, int head, int tile) {
#pragma HLS INLINE off
    
    MMUAllocation result;
    
    // K_WRITE and V_WRITE don't occupy URAM
    if (sel == DmaSel::DMASEL_K_WRITE || sel == DmaSel::DMASEL_V_WRITE) {
        result.success = true;
        result.uram_bank = 0;
        result.uram_offset = 0;
        result.size = mmu_calc_dma_size(sel, state.dims, tile);
        return result;
    }
    
    uint16_t size = mmu_calc_dma_size(sel, state.dims, tile);
    
    // Check for overflow in target bank
    uint8_t target_bank = state.next_bank;
    uint32_t target_offset = state.bank_offsets[target_bank];
    
    uint64_t new_offset = static_cast<uint64_t>(target_offset) + 
                         static_cast<uint64_t>(size);
    
    if (new_offset > MMU_BANK_SIZE) {
        result.overflow = true;
        return result;
    }
    
    result.success = true;
    result.uram_bank = target_bank;
    result.uram_offset = target_offset;
    result.size = size;
    
    return result;
}

void mmu_commit(MMUState &state, DmaSel sel, int layer, int head, int tile,
                uint8_t bank, uint32_t offset, uint16_t size) {
#pragma HLS INLINE
    
    if (sel == DmaSel::DMASEL_K_WRITE || sel == DmaSel::DMASEL_V_WRITE) {
        return;
    }
    
    int slot = -1;
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS PIPELINE II=1
        if (!state.tile_table[i].valid) {
            slot = i;
            break;
        }
    }
    
    if (slot == -1) {
        for (int i = 0; i < MMU_MAX_TILES - 1; ++i) {
#pragma HLS UNROLL
            state.tile_table[i] = state.tile_table[i + 1];
        }
        slot = MMU_MAX_TILES - 1;
    }
    
    TileDescriptor &desc = state.tile_table[slot];
    desc.addr_sel = sel;
    desc.layer = layer;
    desc.head = head;
    desc.tile = tile;
    desc.uram_bank = bank;
    desc.uram_offset = offset;
    desc.size = size;
    desc.valid = true;
    
    state.bank_offsets[bank] += size;
    
    state.next_bank = 1 - state.next_bank;
    
    if (state.num_tiles < MMU_MAX_TILES) {
        state.num_tiles++;
    }
}


void mmu_set_head_dma_done(MMUState &state, int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) {
        state.head_dma_done[head] = true;
    }
}

void mmu_set_head_compute_done(MMUState &state, int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) {
        state.head_compute_done[head] = true;
    }
}

void mmu_set_main_dma_done(MMUState &state) {
#pragma HLS INLINE
    state.main_dma_done = true;
}

void mmu_set_main_compute_done(MMUState &state) {
#pragma HLS INLINE
    state.main_compute_done = true;
}

bool mmu_get_head_dma_done(const MMUState &state, int head) {
#pragma HLS INLINE
    if (head < 0 || head >= MMU_MAX_HEADS) {
        return false;
    }
    return state.head_dma_done[head];
}

bool mmu_get_head_compute_done(const MMUState &state, int head) {
#pragma HLS INLINE
    if (head < 0 || head >= MMU_MAX_HEADS) {
        return false;
    }
    return state.head_compute_done[head];
}

bool mmu_get_main_dma_done(const MMUState &state) {
#pragma HLS INLINE
    return state.main_dma_done;
}

bool mmu_get_main_compute_done(const MMUState &state) {
#pragma HLS INLINE
    return state.main_compute_done;
}

void mmu_clear_head_dma_done(MMUState &state, int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) {
        state.head_dma_done[head] = false;
    }
}

void mmu_clear_head_compute_done(MMUState &state, int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) {
        state.head_compute_done[head] = false;
    }
}

void mmu_clear_main_dma_done(MMUState &state) {
#pragma HLS INLINE
    state.main_dma_done = false;
}

void mmu_clear_main_compute_done(MMUState &state) {
#pragma HLS INLINE
    state.main_compute_done = false;
}


bool mmu_is_headed_op(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case ComputeOp::CMP_Q:
        case ComputeOp::CMP_K:
        case ComputeOp::CMP_V:
        case ComputeOp::CMP_K_REQUANT:
        case ComputeOp::CMP_V_REQUANT:
        case ComputeOp::CMP_Q_REQUANT:
        case ComputeOp::CMP_ATT_SCORES:
        case ComputeOp::CMP_VALUE_SCALE:
        case ComputeOp::CMP_SOFTMAX:
        case ComputeOp::CMP_ATT_VALUE:
        case ComputeOp::CMP_HEAD_REQUANT:
            return true;
        default:
            return false;
    }
}

bool mmu_is_dma_write(DmaSel sel) {
#pragma HLS INLINE
    return (sel == DmaSel::DMASEL_K_WRITE || sel == DmaSel::DMASEL_V_WRITE);
}

const char* mmu_op_name(ComputeOp op) {
    switch (op) {
        case ComputeOp::CMP_NONE: return "NONE";
        case ComputeOp::CMP_LN0: return "LN0";
        case ComputeOp::CMP_REQUANT1: return "RQ1";
        case ComputeOp::CMP_Q: return "Q";
        case ComputeOp::CMP_K: return "K";
        case ComputeOp::CMP_K_REQUANT: return "K_RQ";
        case ComputeOp::CMP_V: return "V";
        case ComputeOp::CMP_V_REQUANT: return "V_RQ";
        case ComputeOp::CMP_Q_REQUANT: return "Q_RQ";
        case ComputeOp::CMP_ATT_SCORES: return "ATT_SCO";
        case ComputeOp::CMP_VALUE_SCALE: return "VAL_SCL";
        case ComputeOp::CMP_SOFTMAX: return "SOFTMAX";
        case ComputeOp::CMP_ATT_VALUE: return "ATT_VAL";
        case ComputeOp::CMP_HEAD_REQUANT: return "HEAD_RQ";
        case ComputeOp::CMP_CONCAT: return "CONCAT";
        case ComputeOp::CMP_OUT_PROJ: return "OUT_PROJ";
        case ComputeOp::CMP_RESID0: return "RESID0";
        case ComputeOp::CMP_REQUANT2: return "RQ2";
        case ComputeOp::CMP_FFN_W1: return "FFN_W1";
        case ComputeOp::CMP_FFN_ACT: return "FFN_ACT";
        case ComputeOp::CMP_FFN_W2: return "FFN_W2";
        case ComputeOp::CMP_REQUANT3: return "RQ3";
        case ComputeOp::CMP_RESID1: return "RESID1";
        case ComputeOp::CMP_LN1: return "LN1";
        case ComputeOp::CMP_REQUANT4: return "RQ4";
        default: return "UNKNOWN";
    }
}

const char* mmu_dma_name(DmaSel sel) {
    switch (sel) {
        case DmaSel::DMASEL_NONE: return "NONE";
        case DmaSel::DMASEL_WQ: return "WQ";
        case DmaSel::DMASEL_WK: return "WK";
        case DmaSel::DMASEL_K_WRITE: return "K_WR";
        case DmaSel::DMASEL_WV: return "WV";
        case DmaSel::DMASEL_V_WRITE: return "V_WR";
        case DmaSel::DMASEL_CTX_K: return "CTX_K";
        case DmaSel::DMASEL_CTX_V: return "CTX_V";
        case DmaSel::DMASEL_WO: return "WO";
        case DmaSel::DMASEL_W1: return "W1";
        case DmaSel::DMASEL_W2: return "W2";
        case DmaSel::DMASEL_WLOGIT: return "WLOGIT";
        case DmaSel::DMASEL_CONCAT: return "CONCAT";
        default: return "UNKNOWN";
    }
}
