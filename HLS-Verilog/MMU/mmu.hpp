#pragma once
#ifndef MMU_HPP
#define MMU_HPP

#include "top_params.hpp"

// ----------------------------------------------------------------------------
// Data Types
// ----------------------------------------------------------------------------
enum class DataType : uint8_t {
    DTYPE_NONE  = 0,
    DTYPE_INT4  = 1,
    DTYPE_INT8  = 2,
    DTYPE_INT16 = 3,
    DTYPE_INT32 = 4
};

enum class MemType : uint8_t {
    BRAM = 0,
    URAM = 1
};

// ----------------------------------------------------------------------------
// Model Dimensions 
// ----------------------------------------------------------------------------
struct ModelDims {
    uint16_t d_model     = D_MODEL;
    uint16_t d_ffn       = D_FFN;
    uint16_t d_heads     = D_HEADS;
    uint16_t num_heads   = NUM_HEADS;
    uint16_t num_layers  = NUM_LAYERS;
    uint16_t context_len = CONTEXT_LENGTH;
    uint16_t d_tile_wo   = D_TILE_WO;
    uint16_t d_tile_w1   = D_TILE_W1;
    uint16_t d_tile_w2   = D_TILE_W2;
    uint16_t num_wo_tiles = NUM_WO_TILES;
    uint16_t num_w1_tiles = NUM_W1_TILES;
    uint16_t num_w2_tiles = NUM_W2_TILES;
};

// ----------------------------------------------------------------------------
// Buffer Field Descriptor
// ----------------------------------------------------------------------------
struct BufferField {
    uint32_t offset;
    uint32_t size;
    DataType dtype;
    uint16_t num_elements;
    
    BufferField() : offset(0), size(0), dtype(DataType::DTYPE_NONE), num_elements(0) {}
    BufferField(uint32_t off, uint32_t sz, DataType dt, uint16_t n) 
        : offset(off), size(sz), dtype(dt), num_elements(n) {}
};

// ----------------------------------------------------------------------------
// Buffer Layouts
// ----------------------------------------------------------------------------
struct InputBufferLayout {
    BufferField act;
    BufferField weights;
    BufferField bias;
    BufferField scale;
    BufferField gamma;
    BufferField eps;
    BufferField residual;
    BufferField k_cache;
    BufferField v_cache;
    BufferField m_param;
    BufferField n_param;
    BufferField z_param;
    uint32_t total_size;
    
    InputBufferLayout() : total_size(0) {}
};

struct OutputBufferLayout {
    BufferField result;
    DataType out_dtype;
    uint32_t total_size;
    
    OutputBufferLayout() : out_dtype(DataType::DTYPE_NONE), total_size(0) {}
};

struct WeightBlobLayout {
    BufferField weights;
    BufferField bias;
    BufferField scale;
    uint32_t total_size;
    
    WeightBlobLayout() : total_size(0) {}
};

// ----------------------------------------------------------------------------
// KV Cache Address
// ----------------------------------------------------------------------------
struct KVCacheAddr {
    uint32_t base_addr;
    uint16_t token_offset;
    uint8_t  head;
    bool     valid;
    
    KVCacheAddr() : base_addr(0), token_offset(0), head(0), valid(false) {}
};

// ----------------------------------------------------------------------------
// Configuration Constants
// ----------------------------------------------------------------------------
constexpr int MMU_MAX_CHUNKS          = 8;
constexpr int MMU_MAX_TILES           = 64;
constexpr int MMU_MAX_HEADS           = 32;
constexpr int MMU_URAM_BANKS          = 64;
constexpr uint32_t MMU_BANK_SIZE      = 36864;  // 288 Kb per URAM block
constexpr int MMU_DMA_QUEUE_DEPTH     = 16;
constexpr int MMU_COMPUTE_QUEUE_DEPTH = 16;

// ----------------------------------------------------------------------------
// Chunked Allocation (for multi-bank spanning)
// ----------------------------------------------------------------------------
struct ChunkedAllocation {
    uint8_t  bank[MMU_MAX_CHUNKS];
    uint32_t offset[MMU_MAX_CHUNKS];
    uint32_t size[MMU_MAX_CHUNKS];
    uint8_t  num_chunks;
    
    ChunkedAllocation() : num_chunks(0) {
        for (int i = 0; i < MMU_MAX_CHUNKS; ++i) {
            bank[i] = 0;
            offset[i] = 0;
            size[i] = 0;
        }
    }
};

// ----------------------------------------------------------------------------
// FSM States
// ----------------------------------------------------------------------------
enum class MMUFsmState : uint8_t {
    IDLE            = 0,
    DMA_ARBITRATE   = 1,
    DMA_ALLOC       = 2,
    DMA_ISSUE       = 3,
    DMA_WAIT        = 4,
    DMA_WRITEBACK   = 5,
    COMPUTE_ARB     = 6,
    URAM_TO_INBUF   = 7,
    OUTBUF_TO_URAM  = 8,
    TRANSFER_DONE   = 9
};

// ----------------------------------------------------------------------------
// Compute Request Types
// ----------------------------------------------------------------------------
enum class ComputeReqType : uint8_t {
    REQ_NONE  = 0,
    REQ_READ  = 1,
    REQ_WRITE = 2
};

// ============================================================================
// Main FSM Function 
// ============================================================================
void mmu_fsm(
    // Reset (active high)
    bool        reset,
    
    // External DMA interface
    bool        dma_ready,
    bool        dma_done,
    bool       &dma_start,
    uint32_t   &dma_addr,
    uint32_t   &dma_len,
    bool       &dma_is_write,
    uint8_t    &uram_bank,
    uint32_t   &uram_offset,
    
    // Compute buffer interface
    bool        buffer_ready,
    bool       &buffer_valid,
    bool       &transfer_done,
    
    // DMA request interface (from scheduler)
    bool        dma_req_valid,
    uint32_t    dma_req_packed,
    bool       &dma_req_ready,
    
    // Compute request interface (from compute)
    bool        compute_req_valid,
    uint32_t    compute_req_packed,
    ComputeReqType compute_req_type,
    uint8_t     compute_req_head,
    bool       &compute_req_ready,
    
    // Done flags output
    bool       &main_dma_done,
    bool       &main_compute_done,
    
    // Status output
    MMUFsmState &fsm_state_out,
    bool       &error_overflow,
    bool       &error_invalid,
    
    // Configuration (passed by value)
    ModelDims   dims,
    uint32_t    k_cache_base,
    uint32_t    v_cache_base,
    uint16_t    current_token
);

// ============================================================================
// Tile Cache Interface 
// ============================================================================
bool mmu_check_cache(DmaSel sel, int layer, int head, int tile);

bool mmu_lookup_tile(DmaSel sel, int layer, int head, int tile,
                     ChunkedAllocation &alloc_out);

void mmu_invalidate_tile(DmaSel sel, int layer, int head, int tile);

// ============================================================================
// Head Arbitration Interface 
// ============================================================================
void mmu_request_head(int head);
void mmu_release_head(int head);
void mmu_arbitrate();
int  mmu_granted_head();
bool mmu_is_granted(int head);

// ============================================================================
// Done Flag Interface 
// ============================================================================
bool mmu_get_head_dma_done(int head);
bool mmu_get_head_compute_done(int head);
void mmu_clear_head_dma_done(int head);
void mmu_clear_head_compute_done(int head);
void mmu_clear_main_dma_done();
void mmu_clear_main_compute_done();
void mmu_clear_all_flags();

// ============================================================================
// Helper Functions 
// ============================================================================
bool mmu_is_headed_op(ComputeOp op);
bool mmu_is_headed_dma(DmaSel sel);
bool mmu_is_dma_write(DmaSel sel);
uint32_t mmu_calc_dma_size(DmaSel sel, ModelDims dims, int tile);
InputBufferLayout mmu_calc_input_layout(ComputeOp op, ModelDims dims);
OutputBufferLayout mmu_calc_output_layout(ComputeOp op, ModelDims dims);
WeightBlobLayout mmu_calc_weight_blob(DmaSel sel, ModelDims dims);
KVCacheAddr mmu_calc_kv_write_addr(uint32_t k_base, uint32_t v_base, uint16_t token,
                                    ModelDims dims, int layer, int head, bool is_v);
KVCacheAddr mmu_calc_kv_read_addr(uint32_t k_base, uint32_t v_base,
                                   ModelDims dims, int layer, int head, bool is_v);
uint32_t mmu_calc_kv_cache_size(ModelDims dims);
const char* mmu_state_name(MMUFsmState s);

// ============================================================================
// Pack/Unpack Utilities
// ============================================================================
inline uint32_t mmu_pack_dma(DmaSel sel, int layer, int head, int tile) {
#pragma HLS INLINE
    return static_cast<uint32_t>(sel) |
           (static_cast<uint32_t>(layer & 0xFF) << 8) |
           (static_cast<uint32_t>(head & 0xFF) << 16) |
           (static_cast<uint32_t>(tile & 0xFF) << 24);
}

inline uint32_t mmu_pack_compute(ComputeOp op, int layer, int head, int tile) {
#pragma HLS INLINE
    return static_cast<uint32_t>(op) |
           (static_cast<uint32_t>(layer & 0xFF) << 8) |
           (static_cast<uint32_t>(head & 0xFF) << 16) |
           (static_cast<uint32_t>(tile & 0xFF) << 24);
}

inline void mmu_unpack_dma(uint32_t packed, DmaSel &sel, int &layer, int &head, int &tile) {
#pragma HLS INLINE
    sel   = static_cast<DmaSel>(packed & 0xFF);
    layer = (packed >> 8) & 0xFF;
    head  = (packed >> 16) & 0xFF;
    tile  = (packed >> 24) & 0xFF;
}

inline void mmu_unpack_compute(uint32_t packed, ComputeOp &op, int &layer, int &head, int &tile) {
#pragma HLS INLINE
    op    = static_cast<ComputeOp>(packed & 0xFF);
    layer = (packed >> 8) & 0xFF;
    head  = (packed >> 16) & 0xFF;
    tile  = (packed >> 24) & 0xFF;
}

#endif // MMU_HPP
