#pragma once
#ifndef MMU_HPP
#define MMU_HPP

#include "top_params.hpp"

// Data types for buffer layout tracking
enum class DataType : uint8_t {
    DTYPE_NONE  = 0,
    DTYPE_INT4  = 1,
    DTYPE_INT8  = 2,
    DTYPE_INT16 = 3,
    DTYPE_INT32 = 4
};

// Model dimensions 
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

// Buffer field with byte offset and data type
struct BufferField {
    uint32_t offset;
    uint32_t size;
    DataType dtype;
    uint16_t num_elements;
    
    BufferField() : offset(0), size(0), dtype(DataType::DTYPE_NONE), num_elements(0) {}
    BufferField(uint32_t off, uint32_t sz, DataType dt, uint16_t n) 
        : offset(off), size(sz), dtype(dt), num_elements(n) {}
};

// Input buffer layout with named fields
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

// Output buffer layout
struct OutputBufferLayout {
    BufferField result;
    DataType out_dtype;
    uint32_t total_size;
    
    OutputBufferLayout() : out_dtype(DataType::DTYPE_NONE), total_size(0) {}
};

// Weight blob layout for DMA payloads
struct WeightBlobLayout {
    BufferField weights;
    BufferField bias;
    BufferField scale;
    uint32_t total_size;
    
    WeightBlobLayout() : total_size(0) {}
};

// KV cache address
struct KVCacheAddr {
    uint32_t base_addr;
    uint16_t token_offset;
    uint8_t  head;
    bool     valid;
    
    KVCacheAddr() : base_addr(0), token_offset(0), head(0), valid(false) {}
};

// Constants
constexpr int MMU_MAX_TILES           = 64;
constexpr int MMU_MAX_HEADS           = 32;
constexpr int MMU_URAM_BANKS          = 2;
constexpr uint32_t MMU_BANK_SIZE      = 0x100000;
constexpr int MMU_DMA_QUEUE_DEPTH     = 16;
constexpr int MMU_COMPUTE_QUEUE_DEPTH = 16;

// MMU FSM states
enum class MMUFsmState : uint8_t {
    IDLE            = 0,
    DMA_ARBITRATE   = 1,
    DMA_ISSUE       = 2,
    DMA_WAIT        = 3,
    DMA_WRITEBACK   = 4,
    COMPUTE_ARB     = 5,
    URAM_TO_INBUF   = 6,
    OUTBUF_TO_URAM  = 7,
    TRANSFER_DONE   = 8
};

// DMA queue entry
struct DmaQueueEntry {
    uint32_t packed_req;
    bool     valid;
    bool     is_headed;
    
    DmaQueueEntry() : packed_req(0), valid(false), is_headed(false) {}
};

// Compute buffer request type
enum class ComputeReqType : uint8_t {
    REQ_NONE  = 0,
    REQ_READ  = 1,
    REQ_WRITE = 2
};

// Compute buffer request
struct ComputeBufferRequest {
    ComputeReqType type;
    uint32_t packed_req;
    bool     valid;
    bool     is_headed;
    uint8_t  head_idx;
    
    ComputeBufferRequest() : type(ComputeReqType::REQ_NONE), packed_req(0), 
                             valid(false), is_headed(false), head_idx(0) {}
};

// Tile descriptor for URAM cache tracking
struct TileDescriptor {
    DmaSel   addr_sel;
    int8_t   layer;
    int8_t   head;
    int8_t   tile;
    uint8_t  uram_bank;
    uint32_t uram_offset;
    uint32_t size;
    bool     valid;
    
    TileDescriptor() : addr_sel(DMASEL_NONE), layer(-1), head(-1), tile(-1),
                       uram_bank(0), uram_offset(0), size(0), valid(false) {}
};

// Head arbiter for round-robin arbitration
struct HeadArbiter {
    bool     pending[MMU_MAX_HEADS];
    bool     grant[MMU_MAX_HEADS];
    uint8_t  current;
    uint8_t  rr_ptr;
    bool     busy;
    
    HeadArbiter() : current(0), rr_ptr(0), busy(false) {
        for (int i = 0; i < MMU_MAX_HEADS; ++i) {
            pending[i] = false;
            grant[i] = false;
        }
    }
};

// Full MMU context
struct MMUContext {
    MMUFsmState fsm_state;
    ModelDims dims;
    
    // Tile cache
    TileDescriptor tile_table[MMU_MAX_TILES];
    uint16_t num_tiles;
    uint8_t  active_bank;
    uint32_t bank_offsets[MMU_URAM_BANKS];
    
    // Request queues
    DmaQueueEntry dma_queue[MMU_DMA_QUEUE_DEPTH];
    uint8_t dma_head, dma_tail, dma_count;
    
    ComputeBufferRequest compute_queue[MMU_COMPUTE_QUEUE_DEPTH];
    uint8_t compute_head, compute_tail, compute_count;
    
    // Arbitration
    HeadArbiter arbiter;
    
    // Active requests
    uint32_t active_dma_req;
    ComputeBufferRequest active_compute_req;
    bool dma_in_progress;
    bool transfer_in_progress;
    
    // KV cache
    uint32_t k_cache_base;
    uint32_t v_cache_base;
    uint16_t current_token;
    
    // Status flags
    bool head_dma_done[MMU_MAX_HEADS];
    bool head_compute_done[MMU_MAX_HEADS];
    bool main_dma_done;
    bool main_compute_done;
    
    // Errors
    bool error_overflow;
    bool error_invalid;
    
    MMUContext() : fsm_state(MMUFsmState::IDLE), num_tiles(0), active_bank(0),
                   dma_head(0), dma_tail(0), dma_count(0),
                   compute_head(0), compute_tail(0), compute_count(0),
                   active_dma_req(0), dma_in_progress(false), transfer_in_progress(false),
                   k_cache_base(0), v_cache_base(0), current_token(0),
                   main_dma_done(false), main_compute_done(false),
                   error_overflow(false), error_invalid(false) {
        for (int i = 0; i < MMU_URAM_BANKS; ++i) bank_offsets[i] = 0;
        for (int i = 0; i < MMU_MAX_HEADS; ++i) {
            head_dma_done[i] = false;
            head_compute_done[i] = false;
        }
    }
};

// Initialization
void mmu_init(MMUContext &ctx, const ModelDims &dims);
void mmu_reset(MMUContext &ctx);
void mmu_set_kv_cache_bases(MMUContext &ctx, uint32_t k_base, uint32_t v_base);

// Main FSM (call every cycle)
void mmu_fsm(
    MMUContext &ctx,
    bool dma_ready, bool dma_done,
    bool &dma_start, uint32_t &dma_addr, uint32_t &dma_len, bool &dma_is_write,
    uint8_t &uram_bank, uint32_t &uram_offset,
    bool buffer_ready, bool &buffer_valid, bool &transfer_done
);

// Scheduler interface
bool mmu_push_dma_request(MMUContext &ctx, uint32_t packed);
bool mmu_push_dma_request_headed(MMUContext &ctx, uint32_t packed, int head);

// Compute controller interface
bool mmu_request_input_buffer(MMUContext &ctx, uint32_t packed_op, int head);
bool mmu_signal_output_ready(MMUContext &ctx, uint32_t packed_op, int head);

// Buffer layouts
InputBufferLayout  mmu_calc_input_layout(ComputeOp op, const ModelDims &dims);
OutputBufferLayout mmu_calc_output_layout(ComputeOp op, const ModelDims &dims);
WeightBlobLayout   mmu_calc_weight_blob(DmaSel sel, const ModelDims &dims);

// KV cache
KVCacheAddr mmu_calc_kv_write_addr(const MMUContext &ctx, int layer, int head, bool is_v);
KVCacheAddr mmu_calc_kv_read_addr(const MMUContext &ctx, int layer, int head, bool is_v);
uint32_t    mmu_calc_kv_cache_size(const ModelDims &dims);

// URAM cache
bool     mmu_check_cache(const MMUContext &ctx, DmaSel sel, int layer, int head, int tile);
uint32_t mmu_lookup_uram(const MMUContext &ctx, DmaSel sel, int layer, int head, int tile, uint8_t &bank);
bool     mmu_allocate_uram(MMUContext &ctx, uint32_t size, uint8_t &bank, uint32_t &offset);
void     mmu_commit_tile(MMUContext &ctx, DmaSel sel, int layer, int head, int tile,
                         uint8_t bank, uint32_t offset, uint32_t size);
void     mmu_invalidate_tile(MMUContext &ctx, DmaSel sel, int layer, int head, int tile);

// Arbitration
void mmu_request_head(MMUContext &ctx, int head);
void mmu_release_head(MMUContext &ctx, int head);
void mmu_arbitrate(MMUContext &ctx);
int  mmu_granted_head(const MMUContext &ctx);
bool mmu_is_granted(const MMUContext &ctx, int head);

// Status flags
void mmu_set_head_dma_done(MMUContext &ctx, int head);
void mmu_set_head_compute_done(MMUContext &ctx, int head);
void mmu_set_main_dma_done(MMUContext &ctx);
void mmu_set_main_compute_done(MMUContext &ctx);
bool mmu_get_head_dma_done(const MMUContext &ctx, int head);
bool mmu_get_head_compute_done(const MMUContext &ctx, int head);
bool mmu_get_main_dma_done(const MMUContext &ctx);
bool mmu_get_main_compute_done(const MMUContext &ctx);
void mmu_clear_head_dma_done(MMUContext &ctx, int head);
void mmu_clear_head_compute_done(MMUContext &ctx, int head);
void mmu_clear_main_dma_done(MMUContext &ctx);
void mmu_clear_main_compute_done(MMUContext &ctx);
void mmu_clear_all_flags(MMUContext &ctx);

// Utilities
bool mmu_is_headed_op(ComputeOp op);
bool mmu_is_headed_dma(DmaSel sel);
bool mmu_is_dma_write(DmaSel sel);
uint32_t mmu_calc_dma_size(DmaSel sel, const ModelDims &dims, int tile);
const char* mmu_state_name(MMUFsmState state);

// Request packing helpers
inline uint32_t mmu_pack_dma(DmaSel sel, int layer, int head, int tile) {
    return static_cast<uint32_t>(sel) |
           (static_cast<uint32_t>(layer) << 8) |
           (static_cast<uint32_t>(head) << 16) |
           (static_cast<uint32_t>(tile) << 24);
}

inline uint32_t mmu_pack_compute(ComputeOp op, int layer, int head, int tile) {
    return static_cast<uint32_t>(op) |
           (static_cast<uint32_t>(layer) << 8) |
           (static_cast<uint32_t>(head) << 16) |
           (static_cast<uint32_t>(tile) << 24);
}

inline void mmu_unpack_dma(uint32_t packed, DmaSel &sel, int &layer, int &head, int &tile) {
    sel   = static_cast<DmaSel>(packed & 0xFF);
    layer = (packed >> 8) & 0xFF;
    head  = (packed >> 16) & 0xFF;
    tile  = (packed >> 24) & 0xFF;
}

inline void mmu_unpack_compute(uint32_t packed, ComputeOp &op, int &layer, int &head, int &tile) {
    op    = static_cast<ComputeOp>(packed & 0xFF);
    layer = (packed >> 8) & 0xFF;
    head  = (packed >> 16) & 0xFF;
    tile  = (packed >> 24) & 0xFF;
}

#endif
