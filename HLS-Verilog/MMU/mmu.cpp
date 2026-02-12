#include "mmu.hpp"
#include "Weight_stager.hpp"

// ============================================================================
// STATIC INTERNAL STATE
// ============================================================================

// FSM state
static MMUFsmState fsm_state;

// URAM bank allocation tracking (64 banks)
static uint32_t bank_offsets[MMU_URAM_BANKS];
static uint8_t active_bank;

// Tile cache (64 entries)
static DmaSel   tt_sel[MMU_MAX_TILES];
static int8_t   tt_layer[MMU_MAX_TILES];
static int8_t   tt_head[MMU_MAX_TILES];
static int8_t   tt_tile[MMU_MAX_TILES];
static uint32_t tt_total_size[MMU_MAX_TILES];
static bool     tt_valid[MMU_MAX_TILES];
static uint8_t  tt_alloc_num_chunks[MMU_MAX_TILES];
static uint8_t  tt_alloc_bank[MMU_MAX_TILES][MMU_MAX_CHUNKS];
static uint32_t tt_alloc_offset[MMU_MAX_TILES][MMU_MAX_CHUNKS];
static uint32_t tt_alloc_size[MMU_MAX_TILES][MMU_MAX_CHUNKS];
static uint16_t num_tiles;

// DMA queue (16 deep)
static uint32_t dq_packed[MMU_DMA_QUEUE_DEPTH];
static bool     dq_is_headed[MMU_DMA_QUEUE_DEPTH];
static bool     dq_valid[MMU_DMA_QUEUE_DEPTH];
static uint8_t  dma_q_head;
static uint8_t  dma_q_tail;
static uint8_t  dma_q_count;

// Compute queue (16 deep)
static ComputeReqType cq_type[MMU_COMPUTE_QUEUE_DEPTH];
static uint32_t cq_packed[MMU_COMPUTE_QUEUE_DEPTH];
static bool     cq_is_headed[MMU_COMPUTE_QUEUE_DEPTH];
static uint8_t  cq_head_idx[MMU_COMPUTE_QUEUE_DEPTH];
static bool     cq_valid[MMU_COMPUTE_QUEUE_DEPTH];
static uint8_t  comp_q_head;
static uint8_t  comp_q_tail;
static uint8_t  comp_q_count;

// Head arbiter (32 heads, round-robin)
static bool     arb_pending[MMU_MAX_HEADS];
static bool     arb_grant[MMU_MAX_HEADS];
static uint8_t  arb_current;
static uint8_t  arb_rr_ptr;
static bool     arb_busy;

// Active operation state
static uint32_t active_dma_req;
static bool     active_dma_is_headed;
static ComputeReqType active_compute_type;
static uint32_t active_compute_packed;
static uint8_t  active_compute_head;
static bool     active_compute_is_headed;

// Chunked allocation state
static uint8_t  alloc_bank[MMU_MAX_CHUNKS];
static uint32_t alloc_offset[MMU_MAX_CHUNKS];
static uint32_t alloc_size[MMU_MAX_CHUNKS];
static uint8_t  alloc_num_chunks;
static uint8_t  current_chunk;

// Done flags
static bool     head_dma_done_flags[MMU_MAX_HEADS];
static bool     head_compute_done_flags[MMU_MAX_HEADS];
static bool     main_dma_done_flag;
static bool     main_compute_done_flag;

// Error flags
static bool     err_overflow;
static bool     err_invalid;

// In-progress flags
static bool     dma_in_progress;
static bool     transfer_in_progress;

// Latched DMA address (from Weight Stager)
static uint32_t latched_dma_addr;

// ============================================================================
// Helper Functions 
// ============================================================================

bool mmu_is_headed_op(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_Q: case CMP_K: case CMP_V:
        case CMP_K_REQUANT: case CMP_V_REQUANT: case CMP_REQUANT_Q: case CMP_HEAD_REQUANT:
        case CMP_ATT_SCORES: case CMP_VALUE_SCALE: case CMP_SOFTMAX: case CMP_ATT_VALUE:
            return true;
        default:
            return false;
    }
}

bool mmu_is_headed_dma(DmaSel sel) {
#pragma HLS INLINE
    switch (sel) {
        case DMASEL_WQ: case DMASEL_WK: case DMASEL_WV:
        case DMASEL_K_WRITE: case DMASEL_V_WRITE:
        case DMASEL_CTX_K: case DMASEL_CTX_V:
            return true;
        default:
            return false;
    }
}

bool mmu_is_dma_write(DmaSel sel) {
#pragma HLS INLINE
    return (sel == DMASEL_K_WRITE || sel == DMASEL_V_WRITE);
}

uint32_t mmu_calc_dma_size(DmaSel sel, ModelDims dims, int tile) {
#pragma HLS INLINE
    (void)tile;
    switch (sel) {
        case DMASEL_WQ: case DMASEL_WK: case DMASEL_WV:
            return ((uint32_t)dims.d_heads * dims.d_model / 2) + (dims.d_heads / 2);
        case DMASEL_K_WRITE: case DMASEL_V_WRITE:
            return dims.d_heads;
        case DMASEL_CTX_K: case DMASEL_CTX_V:
            return (uint32_t)dims.context_len * dims.d_heads;
        case DMASEL_WO:
            return ((uint32_t)dims.d_tile_wo * dims.d_model / 2) + (dims.d_tile_wo * 4);
        case DMASEL_W1:
            return ((uint32_t)dims.d_tile_w1 * dims.d_model / 2) + (dims.d_tile_w1 * 4) + (dims.d_tile_w1 * 2);
        case DMASEL_W2:
            return ((uint32_t)dims.d_tile_w2 * dims.d_ffn / 2) + (dims.d_tile_w2 * 4) + (dims.d_tile_w2 * 2);
        default:
            return 0;
    }
}

KVCacheAddr mmu_calc_kv_write_addr(uint32_t k_base, uint32_t v_base, uint16_t token,
                                    ModelDims dims, int layer, int head, bool is_v) {
#pragma HLS INLINE
    KVCacheAddr addr;
    uint32_t base = is_v ? v_base : k_base;
    uint32_t layer_stride = (uint32_t)dims.num_heads * dims.context_len * dims.d_heads;
    uint32_t head_stride = (uint32_t)dims.context_len * dims.d_heads;
    uint32_t token_stride = dims.d_heads;
    
    addr.base_addr = base + layer * layer_stride + head * head_stride + token * token_stride;
    addr.token_offset = token;
    addr.head = head;
    addr.valid = (layer >= 0 && layer < dims.num_layers &&
                  head >= 0 && head < dims.num_heads &&
                  token < dims.context_len);
    return addr;
}

KVCacheAddr mmu_calc_kv_read_addr(uint32_t k_base, uint32_t v_base,
                                   ModelDims dims, int layer, int head, bool is_v) {
#pragma HLS INLINE
    KVCacheAddr addr;
    uint32_t base = is_v ? v_base : k_base;
    uint32_t layer_stride = (uint32_t)dims.num_heads * dims.context_len * dims.d_heads;
    uint32_t head_stride = (uint32_t)dims.context_len * dims.d_heads;
    
    addr.base_addr = base + layer * layer_stride + head * head_stride;
    addr.token_offset = 0;
    addr.head = head;
    addr.valid = (layer >= 0 && layer < dims.num_layers && head >= 0 && head < dims.num_heads);
    return addr;
}

uint32_t mmu_calc_kv_cache_size(ModelDims dims) {
#pragma HLS INLINE
    return (uint32_t)dims.num_layers * dims.num_heads * dims.context_len * dims.d_heads;
}

WeightBlobLayout mmu_calc_weight_blob(DmaSel sel, ModelDims dims) {
#pragma HLS INLINE
    WeightBlobLayout l;
    switch (sel) {
        case DMASEL_WQ: case DMASEL_WK: case DMASEL_WV: {
            uint32_t w = (uint32_t)dims.d_heads * dims.d_model / 2;
            uint32_t b = dims.d_heads / 2;
            l.weights = BufferField(0, w, DataType::DTYPE_INT4, dims.d_heads * dims.d_model);
            l.bias = BufferField(w, b, DataType::DTYPE_INT4, dims.d_heads);
            l.total_size = w + b;
            break;
        }
        case DMASEL_WO: {
            uint32_t w = (uint32_t)dims.d_tile_wo * dims.d_model / 2;
            uint32_t b = dims.d_tile_wo * 4;
            l.weights = BufferField(0, w, DataType::DTYPE_INT4, dims.d_tile_wo * dims.d_model);
            l.bias = BufferField(w, b, DataType::DTYPE_INT32, dims.d_tile_wo);
            l.total_size = w + b;
            break;
        }
        case DMASEL_W1: {
            uint32_t w = (uint32_t)dims.d_tile_w1 * dims.d_model / 2;
            uint32_t b = dims.d_tile_w1 * 4;
            uint32_t s = dims.d_tile_w1 * 2;
            l.weights = BufferField(0, w, DataType::DTYPE_INT4, dims.d_tile_w1 * dims.d_model);
            l.bias = BufferField(w, b, DataType::DTYPE_INT32, dims.d_tile_w1);
            l.scale = BufferField(w + b, s, DataType::DTYPE_INT16, dims.d_tile_w1);
            l.total_size = w + b + s;
            break;
        }
        case DMASEL_W2: {
            uint32_t w = (uint32_t)dims.d_tile_w2 * dims.d_ffn / 2;
            uint32_t b = dims.d_tile_w2 * 4;
            uint32_t s = dims.d_tile_w2 * 2;
            l.weights = BufferField(0, w, DataType::DTYPE_INT4, dims.d_tile_w2 * dims.d_ffn);
            l.bias = BufferField(w, b, DataType::DTYPE_INT32, dims.d_tile_w2);
            l.scale = BufferField(w + b, s, DataType::DTYPE_INT16, dims.d_tile_w2);
            l.total_size = w + b + s;
            break;
        }
        default:
            l.total_size = 0;
    }
    return l;
}

InputBufferLayout mmu_calc_input_layout(ComputeOp op, ModelDims dims) {
#pragma HLS INLINE
    InputBufferLayout l;
    switch (op) {
        case CMP_Q: case CMP_K: case CMP_V:
            l.act = BufferField(0, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.weights = BufferField(dims.d_model, dims.d_model * dims.d_heads / 2, DataType::DTYPE_INT4, dims.d_model * dims.d_heads);
            l.bias = BufferField(dims.d_model + dims.d_model * dims.d_heads / 2, dims.d_heads / 2, DataType::DTYPE_INT4, dims.d_heads);
            l.total_size = dims.d_model + dims.d_model * dims.d_heads / 2 + dims.d_heads / 2;
            break;
        case CMP_ATT_SCORES:
            l.act = BufferField(0, dims.d_heads, DataType::DTYPE_INT8, dims.d_heads);
            l.k_cache = BufferField(dims.d_heads, dims.context_len * dims.d_heads, DataType::DTYPE_INT8, dims.context_len * dims.d_heads);
            l.total_size = dims.d_heads + dims.context_len * dims.d_heads;
            break;
        case CMP_ATT_VALUE:
            l.act = BufferField(0, dims.context_len * 2, DataType::DTYPE_INT16, dims.context_len);
            l.v_cache = BufferField(dims.context_len * 2, dims.context_len * dims.d_heads, DataType::DTYPE_INT8, dims.context_len * dims.d_heads);
            l.total_size = (dims.context_len * 2) + dims.context_len * dims.d_heads;
            break;
        default:
            l.total_size = dims.d_model;
    }
    return l;
}

OutputBufferLayout mmu_calc_output_layout(ComputeOp op, ModelDims dims) {
#pragma HLS INLINE
    OutputBufferLayout l;
    switch (op) {
        case CMP_Q:
            l.result = BufferField(0, dims.d_heads, DataType::DTYPE_INT8, dims.d_heads);
            l.out_dtype = DataType::DTYPE_INT8;
            l.total_size = dims.d_heads;
            break;
        case CMP_K: case CMP_V:
            l.result = BufferField(0, dims.d_heads * 4, DataType::DTYPE_INT32, dims.d_heads);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = dims.d_heads * 4;
            break;
        case CMP_K_REQUANT: case CMP_V_REQUANT: case CMP_REQUANT_Q:
            l.result = BufferField(0, dims.d_heads, DataType::DTYPE_INT8, dims.d_heads);
            l.out_dtype = DataType::DTYPE_INT8;
            l.total_size = dims.d_heads;
            break;
        case CMP_ATT_SCORES:
            l.result = BufferField(0, dims.context_len * 4, DataType::DTYPE_INT32, dims.context_len);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = dims.context_len * 4;
            break;
        default:
            l.result = BufferField(0, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.out_dtype = DataType::DTYPE_INT8;
            l.total_size = dims.d_model;
    }
    return l;
}

const char* mmu_state_name(MMUFsmState s) {
    switch (s) {
        case MMUFsmState::IDLE:          return "IDLE";
        case MMUFsmState::DMA_ARBITRATE: return "DMA_ARB";
        case MMUFsmState::DMA_ALLOC:     return "DMA_ALLOC";
        case MMUFsmState::DMA_ISSUE:     return "DMA_ISSUE";
        case MMUFsmState::DMA_WAIT:      return "DMA_WAIT";
        case MMUFsmState::DMA_WRITEBACK: return "DMA_WB";
        case MMUFsmState::COMPUTE_ARB:   return "CMP_ARB";
        case MMUFsmState::URAM_TO_INBUF: return "URAM2IN";
        case MMUFsmState::OUTBUF_TO_URAM:return "OUT2URAM";
        case MMUFsmState::TRANSFER_DONE: return "XFER_DONE";
        default:                         return "?";
    }
}

// ============================================================================
// Internal Tile Cache Functions
// ============================================================================

static bool tile_cache_check(DmaSel sel, int layer, int head, int tile) {
#pragma HLS INLINE
    bool found = false;
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL factor=8
        if (tt_valid[i] && tt_sel[i] == sel && 
            tt_layer[i] == layer && tt_head[i] == head && tt_tile[i] == tile) {
            found = true;
        }
    }
    return found;
}

static bool tile_cache_lookup(DmaSel sel, int layer, int head, int tile,
                              uint8_t &out_bank, uint32_t &out_offset) {
#pragma HLS INLINE
    int found_idx = -1;
    for (int i = MMU_MAX_TILES - 1; i >= 0; --i) {
#pragma HLS UNROLL factor=8
        if (tt_valid[i] && tt_sel[i] == sel && 
            tt_layer[i] == layer && tt_head[i] == head && tt_tile[i] == tile) {
            found_idx = i;
        }
    }
    
    if (found_idx >= 0) {
        out_bank = tt_alloc_bank[found_idx][0];
        out_offset = tt_alloc_offset[found_idx][0];
        return true;
    }
    return false;
}

static void tile_cache_commit(DmaSel sel, int layer, int head, int tile, uint32_t total_size) {
#pragma HLS INLINE
    int insert_idx = -1;
    for (int i = MMU_MAX_TILES - 1; i >= 0; --i) {
#pragma HLS UNROLL factor=8
        if (!tt_valid[i]) insert_idx = i;
    }
    
    if (insert_idx >= 0) {
        tt_sel[insert_idx] = sel;
        tt_layer[insert_idx] = layer;
        tt_head[insert_idx] = head;
        tt_tile[insert_idx] = tile;
        tt_total_size[insert_idx] = total_size;
        tt_alloc_num_chunks[insert_idx] = alloc_num_chunks;
        for (int c = 0; c < MMU_MAX_CHUNKS; ++c) {
#pragma HLS UNROLL
            tt_alloc_bank[insert_idx][c] = alloc_bank[c];
            tt_alloc_offset[insert_idx][c] = alloc_offset[c];
            tt_alloc_size[insert_idx][c] = alloc_size[c];
        }
        tt_valid[insert_idx] = true;
        num_tiles++;
    }
}

// ============================================================================
// Internal Arbitration Functions
// ============================================================================

static void arbiter_request(int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) arb_pending[head] = true;
}

static void arbiter_release(int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) {
        arb_pending[head] = false;
        arb_grant[head] = false;
        if (arb_current == head) arb_busy = false;
    }
}

static void arbiter_arbitrate() {
#pragma HLS INLINE
    if (arb_busy) return;
    
    int grant_idx = -1;
    for (int i = MMU_MAX_HEADS - 1; i >= 0; --i) {
#pragma HLS UNROLL
        int h = (arb_rr_ptr + i) % MMU_MAX_HEADS;
        if (arb_pending[h]) grant_idx = h;
    }
    
    if (grant_idx >= 0) {
        for (int j = 0; j < MMU_MAX_HEADS; ++j) {
#pragma HLS UNROLL
            arb_grant[j] = (j == grant_idx);
        }
        arb_current = grant_idx;
        arb_rr_ptr = (grant_idx + 1) % MMU_MAX_HEADS;
        arb_busy = true;
    }
}

static bool arbiter_is_granted(int head) {
#pragma HLS INLINE
    return (head >= 0 && head < MMU_MAX_HEADS) ? arb_grant[head] : false;
}

// ============================================================================
// Internal Chunked Allocation
// ============================================================================

static bool allocate_chunked_internal(uint32_t size) {
#pragma HLS INLINE
    uint32_t remaining = size;
    uint8_t bank = active_bank;
    alloc_num_chunks = 0;
    
    for (int c = 0; c < MMU_MAX_CHUNKS; ++c) {
#pragma HLS UNROLL
        if (remaining > 0) {
            uint32_t offset = bank_offsets[bank];
            uint32_t space = MMU_BANK_SIZE - offset;
            
            if (space > 0) {
                uint32_t chunk_size = (remaining < space) ? remaining : space;
                alloc_bank[alloc_num_chunks] = bank;
                alloc_offset[alloc_num_chunks] = offset;
                alloc_size[alloc_num_chunks] = chunk_size;
                remaining -= chunk_size;
                alloc_num_chunks++;
            }
            bank = (bank + 1) % MMU_URAM_BANKS;
        }
    }
    
    if (remaining > 0) {
        alloc_num_chunks = 0;
        return false;
    }
    return true;
}

static void commit_chunked_internal() {
#pragma HLS INLINE
    for (int c = 0; c < MMU_MAX_CHUNKS; ++c) {
#pragma HLS UNROLL
        if (c < alloc_num_chunks) {
            uint8_t b = alloc_bank[c];
            bank_offsets[b] = alloc_offset[c] + alloc_size[c];
            if (bank_offsets[b] >= MMU_BANK_SIZE) {
                active_bank = (b + 1) % MMU_URAM_BANKS;
            }
        }
    }
}

// ============================================================================
// Main FSM
// ============================================================================

void mmu_fsm(
    // Control
    bool                reset,
    
    // External DMA Interface
    bool                dma_ready,
    bool                dma_done,
    bool               &dma_start,
    uint32_t           &dma_addr,
    uint32_t           &dma_len,
    bool               &dma_is_write,
    uint8_t            &uram_bank,
    uint32_t           &uram_offset,
    
    // Compute Buffer Interface
    bool                buffer_ready,
    bool               &buffer_valid,
    bool               &transfer_done,
    
    // DMA Request Interface
    bool                dma_req_valid,
    uint32_t            dma_req_packed,
    bool               &dma_req_ready,
    
    // Compute Request Interface
    bool                compute_req_valid,
    uint32_t            compute_req_packed,
    ComputeReqType      compute_req_type,
    uint8_t             compute_req_head,
    bool               &compute_req_ready,
    
    // Done Flags Output
    bool               &main_dma_done,
    bool               &main_compute_done,
    
    // Per-Head Done Flags
    bool                head_dma_done_out[MMU_MAX_HEADS],
    bool                head_compute_done_out[MMU_MAX_HEADS],
    
    // Tile Cache Query Interface
    bool                tile_query_valid,
    DmaSel              tile_query_sel,
    int                 tile_query_layer,
    int                 tile_query_head,
    int                 tile_query_tile,
    bool               &tile_query_hit,
    uint8_t            &tile_query_bank,
    uint32_t           &tile_query_offset,
    
    // Head Arbitration Interface
    bool                arb_request_valid,
    int                 arb_request_head,
    bool                arb_release_valid,
    int                 arb_release_head,
    bool               &arb_grant_valid,
    int                &arb_granted_head,
    
    // Done Flag Clear Interface
    bool                clear_head_dma_done_valid,
    int                 clear_head_dma_done_idx,
    bool                clear_head_compute_done_valid,
    int                 clear_head_compute_done_idx,
    bool                clear_main_dma_done,
    bool                clear_main_compute_done,
    bool                clear_all_flags,
    
    // Status Output
    MMUFsmState        &fsm_state_out,
    bool               &error_overflow,
    bool               &error_invalid,
    
    // Configuration
    ControlMemSpace     ctrl_mem,
    ModelDims           dims,
    uint32_t            k_cache_base,
    uint32_t            v_cache_base,
    uint16_t            current_token
) {
#pragma HLS INLINE off

    // HLS pragmas for static state
#pragma HLS reset variable=fsm_state
#pragma HLS reset variable=bank_offsets
#pragma HLS reset variable=active_bank
#pragma HLS reset variable=tt_valid
#pragma HLS reset variable=num_tiles
#pragma HLS reset variable=dq_valid
#pragma HLS reset variable=dma_q_head
#pragma HLS reset variable=dma_q_tail
#pragma HLS reset variable=dma_q_count
#pragma HLS reset variable=cq_valid
#pragma HLS reset variable=comp_q_head
#pragma HLS reset variable=comp_q_tail
#pragma HLS reset variable=comp_q_count
#pragma HLS reset variable=arb_pending
#pragma HLS reset variable=arb_grant
#pragma HLS reset variable=arb_current
#pragma HLS reset variable=arb_rr_ptr
#pragma HLS reset variable=arb_busy
#pragma HLS reset variable=head_dma_done_flags
#pragma HLS reset variable=head_compute_done_flags
#pragma HLS reset variable=main_dma_done_flag
#pragma HLS reset variable=main_compute_done_flag
#pragma HLS reset variable=err_overflow
#pragma HLS reset variable=err_invalid
#pragma HLS reset variable=dma_in_progress
#pragma HLS reset variable=transfer_in_progress
#pragma HLS reset variable=latched_dma_addr

    // ========================================================================
    // Reset
    // ========================================================================
    if (reset) {
        fsm_state = MMUFsmState::IDLE;
        active_bank = 0;
        num_tiles = 0;
        dma_q_head = dma_q_tail = dma_q_count = 0;
        comp_q_head = comp_q_tail = comp_q_count = 0;
        arb_current = 0;
        arb_rr_ptr = 0;
        arb_busy = false;
        main_dma_done_flag = main_compute_done_flag = false;
        err_overflow = err_invalid = false;
        dma_in_progress = transfer_in_progress = false;
        latched_dma_addr = 0;
        alloc_num_chunks = 0;
        current_chunk = 0;
        
        for (int i = 0; i < MMU_URAM_BANKS; ++i) {
#pragma HLS UNROLL
            bank_offsets[i] = 0;
        }
        for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL factor=8
            tt_valid[i] = false;
        }
        for (int i = 0; i < MMU_DMA_QUEUE_DEPTH; ++i) {
#pragma HLS UNROLL
            dq_valid[i] = false;
        }
        for (int i = 0; i < MMU_COMPUTE_QUEUE_DEPTH; ++i) {
#pragma HLS UNROLL
            cq_valid[i] = false;
        }
        for (int i = 0; i < MMU_MAX_HEADS; ++i) {
#pragma HLS UNROLL
            arb_pending[i] = arb_grant[i] = false;
            head_dma_done_flags[i] = head_compute_done_flags[i] = false;
        }
        
        // Default outputs
        dma_start = false;
        dma_addr = 0;
        dma_len = 0;
        dma_is_write = false;
        uram_bank = 0;
        uram_offset = 0;
        buffer_valid = false;
        transfer_done = false;
        dma_req_ready = true;
        compute_req_ready = true;
        main_dma_done = false;
        main_compute_done = false;
        tile_query_hit = false;
        tile_query_bank = 0;
        tile_query_offset = 0;
        arb_grant_valid = false;
        arb_granted_head = -1;
        fsm_state_out = MMUFsmState::IDLE;
        error_overflow = false;
        error_invalid = false;
        
        for (int i = 0; i < MMU_MAX_HEADS; ++i) {
#pragma HLS UNROLL
            head_dma_done_out[i] = false;
            head_compute_done_out[i] = false;
        }
        return;
    }

    // ========================================================================
    // Default Outputs
    // ========================================================================
    dma_start = false;
    buffer_valid = false;
    transfer_done = false;
    dma_req_ready = (dma_q_count < MMU_DMA_QUEUE_DEPTH);
    compute_req_ready = (comp_q_count < MMU_COMPUTE_QUEUE_DEPTH);
    fsm_state_out = fsm_state;
    error_overflow = err_overflow;
    error_invalid = err_invalid;
    main_dma_done = main_dma_done_flag;
    main_compute_done = main_compute_done_flag;
    
    // Copy per-head done flags to output
    for (int i = 0; i < MMU_MAX_HEADS; ++i) {
#pragma HLS UNROLL
        head_dma_done_out[i] = head_dma_done_flags[i];
        head_compute_done_out[i] = head_compute_done_flags[i];
    }

    // ========================================================================
    // Tile Cache Query (Combinational - always active)
    // ========================================================================
    if (tile_query_valid) {
        tile_query_hit = tile_cache_lookup(tile_query_sel, tile_query_layer, 
                                            tile_query_head, tile_query_tile,
                                            tile_query_bank, tile_query_offset);
    } else {
        tile_query_hit = false;
        tile_query_bank = 0;
        tile_query_offset = 0;
    }

    // ========================================================================
    // External Arbitration Interface (signal-based)
    // ========================================================================
    if (arb_request_valid) {
        arbiter_request(arb_request_head);
    }
    if (arb_release_valid) {
        arbiter_release(arb_release_head);
    }
    arb_grant_valid = arb_busy;
    arb_granted_head = arb_busy ? (int)arb_current : -1;

    // ========================================================================
    // Done Flag Clear Interface
    // ========================================================================
    if (clear_all_flags) {
        main_dma_done_flag = main_compute_done_flag = false;
        for (int i = 0; i < MMU_MAX_HEADS; ++i) {
#pragma HLS UNROLL
            head_dma_done_flags[i] = head_compute_done_flags[i] = false;
        }
    } else {
        if (clear_main_dma_done) main_dma_done_flag = false;
        if (clear_main_compute_done) main_compute_done_flag = false;
        if (clear_head_dma_done_valid && clear_head_dma_done_idx >= 0 && 
            clear_head_dma_done_idx < MMU_MAX_HEADS) {
            head_dma_done_flags[clear_head_dma_done_idx] = false;
        }
        if (clear_head_compute_done_valid && clear_head_compute_done_idx >= 0 && 
            clear_head_compute_done_idx < MMU_MAX_HEADS) {
            head_compute_done_flags[clear_head_compute_done_idx] = false;
        }
    }

    // ========================================================================
    // Enqueue DMA Request
    // ========================================================================
    if (dma_req_valid && dma_req_ready) {
        DmaSel sel; int layer, head, tile;
        mmu_unpack_dma(dma_req_packed, sel, layer, head, tile);
        
        dq_packed[dma_q_tail] = dma_req_packed;
        dq_is_headed[dma_q_tail] = mmu_is_headed_dma(sel);
        dq_valid[dma_q_tail] = true;
        dma_q_tail = (dma_q_tail + 1) % MMU_DMA_QUEUE_DEPTH;
        dma_q_count++;
    }

    // ========================================================================
    // Enqueue Compute Request
    // ========================================================================
    if (compute_req_valid && compute_req_ready) {
        ComputeOp op; int layer, head, tile;
        mmu_unpack_compute(compute_req_packed, op, layer, head, tile);
        
        cq_type[comp_q_tail] = compute_req_type;
        cq_packed[comp_q_tail] = compute_req_packed;
        cq_is_headed[comp_q_tail] = mmu_is_headed_op(op);
        cq_head_idx[comp_q_tail] = compute_req_head;
        cq_valid[comp_q_tail] = true;
        comp_q_tail = (comp_q_tail + 1) % MMU_COMPUTE_QUEUE_DEPTH;
        comp_q_count++;
    }

    // ========================================================================
    // FSM
    // ========================================================================
    switch (fsm_state) {
        
        case MMUFsmState::IDLE: {
            current_chunk = 0;
            alloc_num_chunks = 0;
            if (dma_q_count > 0) {
                fsm_state = MMUFsmState::DMA_ARBITRATE;
            } else if (comp_q_count > 0) {
                fsm_state = MMUFsmState::COMPUTE_ARB;
            }
            break;
        }
        
        case MMUFsmState::DMA_ARBITRATE: {
            if (dma_q_count > 0) {
                // Pop from DMA queue
                active_dma_req = dq_packed[dma_q_head];
                active_dma_is_headed = dq_is_headed[dma_q_head];
                dq_valid[dma_q_head] = false;
                dma_q_head = (dma_q_head + 1) % MMU_DMA_QUEUE_DEPTH;
                dma_q_count--;
                
                DmaSel sel; int layer, head, tile;
                mmu_unpack_dma(active_dma_req, sel, layer, head, tile);
                
                if (active_dma_is_headed) {
                    arbiter_request(head);
                    arbiter_arbitrate();
                    if (arbiter_is_granted(head)) {
                        fsm_state = MMUFsmState::DMA_ALLOC;
                    }
                } else {
                    fsm_state = MMUFsmState::DMA_ALLOC;
                }
            } else {
                fsm_state = MMUFsmState::IDLE;
            }
            break;
        }
        
        case MMUFsmState::DMA_ALLOC: {
            DmaSel sel; int layer, head, tile;
            mmu_unpack_dma(active_dma_req, sel, layer, head, tile);
            
            if (mmu_is_dma_write(sel)) {
                // KV writeback - compute address via KV calc
                bool is_v = (sel == DMASEL_V_WRITE);
                KVCacheAddr kv = mmu_calc_kv_write_addr(k_cache_base, v_cache_base, 
                                                         current_token, dims, layer, head, is_v);
                if (kv.valid) {
                    latched_dma_addr = kv.base_addr;
                    fsm_state = MMUFsmState::DMA_WRITEBACK;
                } else {
                    err_invalid = true;
                    fsm_state = MMUFsmState::IDLE;
                }
            } else {
                // DMA read - use Weight Stager for address computation
                bool wl_ready, wl_memory_request, wl_error;
                uint32_t wl_addr;
                
                weight_stager(
                    false,              // reset
                    true,               // wl_start
                    sel,                // wl_addr_sel
                    layer,              // wl_layer
                    head,               // wl_head
                    tile,               // wl_tile
                    ctrl_mem,           // ctrl_mem
                    wl_ready,           // &wl_ready
                    wl_memory_request,  // &memory_request
                    wl_error,           // &error
                    wl_addr             // &addr_latched
                );
                
                if (wl_error) {
                    err_invalid = true;
                    fsm_state = MMUFsmState::IDLE;
                } else if (wl_memory_request) {
                    latched_dma_addr = wl_addr;
                    
                    // Allocate URAM space
                    uint32_t size = mmu_calc_dma_size(sel, dims, tile);
                    bool alloc_ok = allocate_chunked_internal(size);
                    
                    if (alloc_ok && alloc_num_chunks > 0) {
                        current_chunk = 0;
                        fsm_state = MMUFsmState::DMA_ISSUE;
                    } else {
                        err_overflow = true;
                        fsm_state = MMUFsmState::IDLE;
                    }
                }
            }
            break;
        }
        
        case MMUFsmState::DMA_ISSUE: {
            if (dma_ready && current_chunk < alloc_num_chunks) {
                dma_start = true;
                dma_addr = latched_dma_addr;
                uram_bank = alloc_bank[current_chunk];
                uram_offset = alloc_offset[current_chunk];
                dma_len = alloc_size[current_chunk];
                dma_is_write = false;
                dma_in_progress = true;
                
                // Advance address for next chunk
                latched_dma_addr += alloc_size[current_chunk];
                
                fsm_state = MMUFsmState::DMA_WAIT;
            }
            break;
        }
        
        case MMUFsmState::DMA_WAIT: {
            if (dma_done) {
                current_chunk++;
                if (current_chunk < alloc_num_chunks) {
                    fsm_state = MMUFsmState::DMA_ISSUE;
                } else {
                    // All chunks done - commit
                    DmaSel sel; int layer, head, tile;
                    mmu_unpack_dma(active_dma_req, sel, layer, head, tile);
                    uint32_t total_size = mmu_calc_dma_size(sel, dims, tile);
                    
                    commit_chunked_internal();
                    tile_cache_commit(sel, layer, head, tile, total_size);
                    
                    if (mmu_is_headed_dma(sel)) {
                        head_dma_done_flags[head] = true;
                        arbiter_release(head);
                    } else {
                        main_dma_done_flag = true;
                    }
                    dma_in_progress = false;
                    fsm_state = MMUFsmState::IDLE;
                }
            }
            break;
        }
        
        case MMUFsmState::DMA_WRITEBACK: {
            if (dma_ready) {
                DmaSel sel; int layer, head, tile;
                mmu_unpack_dma(active_dma_req, sel, layer, head, tile);
                
                dma_start = true;
                dma_addr = latched_dma_addr;
                dma_len = dims.d_heads;
                dma_is_write = true;
                dma_in_progress = true;
                
                // For writeback, we read from URAM - lookup where data is
                uint8_t src_bank;
                uint32_t src_offset;
                DmaSel lookup_sel = (sel == DMASEL_K_WRITE) ? DMASEL_WK : DMASEL_WV;
                if (tile_cache_lookup(lookup_sel, layer, head, tile, src_bank, src_offset)) {
                    uram_bank = src_bank;
                    uram_offset = src_offset;
                } else {
                    // Fallback - use active bank
                    uram_bank = active_bank;
                    uram_offset = 0;
                }
                
                current_chunk = 0;
                alloc_num_chunks = 1;
                fsm_state = MMUFsmState::DMA_WAIT;
            }
            break;
        }
        
        case MMUFsmState::COMPUTE_ARB: {
            if (comp_q_count > 0) {
                // Pop from compute queue
                active_compute_type = cq_type[comp_q_head];
                active_compute_packed = cq_packed[comp_q_head];
                active_compute_is_headed = cq_is_headed[comp_q_head];
                active_compute_head = cq_head_idx[comp_q_head];
                cq_valid[comp_q_head] = false;
                comp_q_head = (comp_q_head + 1) % MMU_COMPUTE_QUEUE_DEPTH;
                comp_q_count--;
                
                if (active_compute_is_headed) {
                    arbiter_request(active_compute_head);
                    arbiter_arbitrate();
                    if (arbiter_is_granted(active_compute_head)) {
                        fsm_state = (active_compute_type == ComputeReqType::REQ_READ) 
                            ? MMUFsmState::URAM_TO_INBUF : MMUFsmState::OUTBUF_TO_URAM;
                    }
                } else {
                    fsm_state = (active_compute_type == ComputeReqType::REQ_READ)
                        ? MMUFsmState::URAM_TO_INBUF : MMUFsmState::OUTBUF_TO_URAM;
                }
            } else {
                fsm_state = MMUFsmState::IDLE;
            }
            break;
        }
        
        case MMUFsmState::URAM_TO_INBUF: {
            // Data remains in URAM until explicitly overwritten
            // Q value retained until attention scores computed
            // K retained until writeback
            if (buffer_ready) {
                buffer_valid = true;
                transfer_in_progress = true;
                fsm_state = MMUFsmState::TRANSFER_DONE;
            }
            break;
        }
        
        case MMUFsmState::OUTBUF_TO_URAM: {
            // Data remains in URAM until explicitly overwritten
            if (buffer_ready) {
                ComputeOp op; int layer, head, tile;
                mmu_unpack_compute(active_compute_packed, op, layer, head, tile);
                OutputBufferLayout out = mmu_calc_output_layout(op, dims);
                
                bool alloc_ok = allocate_chunked_internal(out.total_size);
                if (alloc_ok && alloc_num_chunks > 0) {
                    uram_bank = alloc_bank[0];
                    uram_offset = alloc_offset[0];
                    buffer_valid = true;
                    transfer_in_progress = true;
                    commit_chunked_internal();
                    fsm_state = MMUFsmState::TRANSFER_DONE;
                } else {
                    err_overflow = true;
                    fsm_state = MMUFsmState::IDLE;
                }
            }
            break;
        }
        
        case MMUFsmState::TRANSFER_DONE: {
            transfer_done = true;
            if (active_compute_is_headed) {
                head_compute_done_flags[active_compute_head] = true;
                arbiter_release(active_compute_head);
            } else {
                main_compute_done_flag = true;
            }
            transfer_in_progress = false;
            fsm_state = MMUFsmState::IDLE;
            break;
        }
        
        default:
            fsm_state = MMUFsmState::IDLE;
    }
}
