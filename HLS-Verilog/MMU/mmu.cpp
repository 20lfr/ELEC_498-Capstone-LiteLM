#include "mmu_v2.hpp"

// Initialization
void mmu_init(MMUContext &ctx, const ModelDims &dims) {
#pragma HLS INLINE
    ctx.dims = dims;
    ctx.fsm_state = MMUFsmState::IDLE;
    ctx.num_tiles = 0;
    ctx.active_bank = 0;
    
    for (int i = 0; i < MMU_URAM_BANKS; ++i) {
#pragma HLS UNROLL
        ctx.bank_offsets[i] = 0;
    }
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL factor=8
        ctx.tile_table[i].valid = false;
    }
    
    ctx.dma_head = ctx.dma_tail = ctx.dma_count = 0;
    ctx.compute_head = ctx.compute_tail = ctx.compute_count = 0;
    
    for (int i = 0; i < MMU_DMA_QUEUE_DEPTH; ++i) ctx.dma_queue[i].valid = false;
    for (int i = 0; i < MMU_COMPUTE_QUEUE_DEPTH; ++i) ctx.compute_queue[i].valid = false;
    
    ctx.arbiter.current = ctx.arbiter.rr_ptr = 0;
    ctx.arbiter.busy = false;
    for (int i = 0; i < MMU_MAX_HEADS; ++i) {
#pragma HLS UNROLL
        ctx.arbiter.pending[i] = ctx.arbiter.grant[i] = false;
        ctx.head_dma_done[i] = ctx.head_compute_done[i] = false;
    }
    
    ctx.dma_in_progress = ctx.transfer_in_progress = false;
    ctx.k_cache_base = ctx.v_cache_base = 0;
    ctx.current_token = 0;
    ctx.main_dma_done = ctx.main_compute_done = false;
    ctx.error_overflow = ctx.error_invalid = false;
}

void mmu_reset(MMUContext &ctx) {
#pragma HLS INLINE
    ModelDims dims = ctx.dims;
    uint32_t k = ctx.k_cache_base, v = ctx.v_cache_base;
    mmu_init(ctx, dims);
    ctx.k_cache_base = k;
    ctx.v_cache_base = v;
}

void mmu_set_kv_cache_bases(MMUContext &ctx, uint32_t k_base, uint32_t v_base) {
#pragma HLS INLINE
    ctx.k_cache_base = k_base;
    ctx.v_cache_base = v_base;
}

// Queue operations
bool mmu_push_dma_request(MMUContext &ctx, uint32_t packed) {
#pragma HLS INLINE
    if (ctx.dma_count >= MMU_DMA_QUEUE_DEPTH) {
        ctx.error_overflow = true;
        return false;
    }
    DmaSel sel; int layer, head, tile;
    mmu_unpack_dma(packed, sel, layer, head, tile);
    
    ctx.dma_queue[ctx.dma_tail].packed_req = packed;
    ctx.dma_queue[ctx.dma_tail].valid = true;
    ctx.dma_queue[ctx.dma_tail].is_headed = mmu_is_headed_dma(sel);
    ctx.dma_tail = (ctx.dma_tail + 1) % MMU_DMA_QUEUE_DEPTH;
    ctx.dma_count++;
    return true;
}

bool mmu_push_dma_request_headed(MMUContext &ctx, uint32_t packed, int head) {
#pragma HLS INLINE
    if (ctx.dma_count >= MMU_DMA_QUEUE_DEPTH) {
        ctx.error_overflow = true;
        return false;
    }
    DmaSel sel; int layer, h, tile;
    mmu_unpack_dma(packed, sel, layer, h, tile);
    uint32_t new_packed = mmu_pack_dma(sel, layer, head, tile);
    
    ctx.dma_queue[ctx.dma_tail].packed_req = new_packed;
    ctx.dma_queue[ctx.dma_tail].valid = true;
    ctx.dma_queue[ctx.dma_tail].is_headed = true;
    ctx.dma_tail = (ctx.dma_tail + 1) % MMU_DMA_QUEUE_DEPTH;
    ctx.dma_count++;
    return true;
}

static bool pop_dma(MMUContext &ctx, DmaQueueEntry &e) {
#pragma HLS INLINE
    if (ctx.dma_count == 0) return false;
    e = ctx.dma_queue[ctx.dma_head];
    ctx.dma_queue[ctx.dma_head].valid = false;
    ctx.dma_head = (ctx.dma_head + 1) % MMU_DMA_QUEUE_DEPTH;
    ctx.dma_count--;
    return true;
}

bool mmu_request_input_buffer(MMUContext &ctx, uint32_t packed_op, int head) {
#pragma HLS INLINE
    if (ctx.compute_count >= MMU_COMPUTE_QUEUE_DEPTH) {
        ctx.error_overflow = true;
        return false;
    }
    ComputeOp op; int layer, h, tile;
    mmu_unpack_compute(packed_op, op, layer, h, tile);
    
    ctx.compute_queue[ctx.compute_tail].type = ComputeReqType::REQ_READ;
    ctx.compute_queue[ctx.compute_tail].packed_req = packed_op;
    ctx.compute_queue[ctx.compute_tail].valid = true;
    ctx.compute_queue[ctx.compute_tail].is_headed = mmu_is_headed_op(op);
    ctx.compute_queue[ctx.compute_tail].head_idx = head;
    ctx.compute_tail = (ctx.compute_tail + 1) % MMU_COMPUTE_QUEUE_DEPTH;
    ctx.compute_count++;
    return true;
}

bool mmu_signal_output_ready(MMUContext &ctx, uint32_t packed_op, int head) {
#pragma HLS INLINE
    if (ctx.compute_count >= MMU_COMPUTE_QUEUE_DEPTH) {
        ctx.error_overflow = true;
        return false;
    }
    ComputeOp op; int layer, h, tile;
    mmu_unpack_compute(packed_op, op, layer, h, tile);
    
    ctx.compute_queue[ctx.compute_tail].type = ComputeReqType::REQ_WRITE;
    ctx.compute_queue[ctx.compute_tail].packed_req = packed_op;
    ctx.compute_queue[ctx.compute_tail].valid = true;
    ctx.compute_queue[ctx.compute_tail].is_headed = mmu_is_headed_op(op);
    ctx.compute_queue[ctx.compute_tail].head_idx = head;
    ctx.compute_tail = (ctx.compute_tail + 1) % MMU_COMPUTE_QUEUE_DEPTH;
    ctx.compute_count++;
    return true;
}

static bool pop_compute(MMUContext &ctx, ComputeBufferRequest &e) {
#pragma HLS INLINE
    if (ctx.compute_count == 0) return false;
    e = ctx.compute_queue[ctx.compute_head];
    ctx.compute_queue[ctx.compute_head].valid = false;
    ctx.compute_head = (ctx.compute_head + 1) % MMU_COMPUTE_QUEUE_DEPTH;
    ctx.compute_count--;
    return true;
}

// Arbitration
void mmu_request_head(MMUContext &ctx, int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) ctx.arbiter.pending[head] = true;
}

void mmu_release_head(MMUContext &ctx, int head) {
#pragma HLS INLINE
    if (head >= 0 && head < MMU_MAX_HEADS) {
        ctx.arbiter.pending[head] = false;
        ctx.arbiter.grant[head] = false;
        if (ctx.arbiter.current == head) ctx.arbiter.busy = false;
    }
}

void mmu_arbitrate(MMUContext &ctx) {
#pragma HLS INLINE
    if (ctx.arbiter.busy) return;
    for (int i = 0; i < MMU_MAX_HEADS; ++i) {
#pragma HLS UNROLL factor=4
        int h = (ctx.arbiter.rr_ptr + i) % MMU_MAX_HEADS;
        if (ctx.arbiter.pending[h]) {
            for (int j = 0; j < MMU_MAX_HEADS; ++j) ctx.arbiter.grant[j] = (j == h);
            ctx.arbiter.current = h;
            ctx.arbiter.rr_ptr = (h + 1) % MMU_MAX_HEADS;
            ctx.arbiter.busy = true;
            return;
        }
    }
}

int mmu_granted_head(const MMUContext &ctx) {
#pragma HLS INLINE
    return ctx.arbiter.busy ? ctx.arbiter.current : -1;
}

bool mmu_is_granted(const MMUContext &ctx, int head) {
#pragma HLS INLINE
    return (head >= 0 && head < MMU_MAX_HEADS) ? ctx.arbiter.grant[head] : false;
}

// URAM cache
bool mmu_check_cache(const MMUContext &ctx, DmaSel sel, int layer, int head, int tile) {
#pragma HLS INLINE
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL factor=8
        const TileDescriptor &t = ctx.tile_table[i];
        if (t.valid && t.addr_sel == sel && t.layer == layer && t.head == head && t.tile == tile)
            return true;
    }
    return false;
}

uint32_t mmu_lookup_uram(const MMUContext &ctx, DmaSel sel, int layer, int head, int tile, uint8_t &bank) {
#pragma HLS INLINE
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL factor=8
        const TileDescriptor &t = ctx.tile_table[i];
        if (t.valid && t.addr_sel == sel && t.layer == layer && t.head == head && t.tile == tile) {
            bank = t.uram_bank;
            return t.uram_offset;
        }
    }
    bank = 0;
    return 0xFFFFFFFF;
}

bool mmu_allocate_uram(MMUContext &ctx, uint32_t size, uint8_t &bank, uint32_t &offset) {
#pragma HLS INLINE
    bank = ctx.active_bank;
    offset = ctx.bank_offsets[bank];
    if (offset + size <= MMU_BANK_SIZE) return true;
    
    bank = (ctx.active_bank + 1) % MMU_URAM_BANKS;
    offset = ctx.bank_offsets[bank];
    return (offset + size <= MMU_BANK_SIZE);
}

void mmu_commit_tile(MMUContext &ctx, DmaSel sel, int layer, int head, int tile,
                     uint8_t bank, uint32_t offset, uint32_t size) {
#pragma HLS INLINE
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL factor=8
        if (!ctx.tile_table[i].valid) {
            ctx.tile_table[i].addr_sel = sel;
            ctx.tile_table[i].layer = layer;
            ctx.tile_table[i].head = head;
            ctx.tile_table[i].tile = tile;
            ctx.tile_table[i].uram_bank = bank;
            ctx.tile_table[i].uram_offset = offset;
            ctx.tile_table[i].size = size;
            ctx.tile_table[i].valid = true;
            ctx.bank_offsets[bank] = offset + size;
            ctx.active_bank = (bank + 1) % MMU_URAM_BANKS;
            ctx.num_tiles++;
            return;
        }
    }
}

void mmu_invalidate_tile(MMUContext &ctx, DmaSel sel, int layer, int head, int tile) {
#pragma HLS INLINE
    for (int i = 0; i < MMU_MAX_TILES; ++i) {
#pragma HLS UNROLL factor=8
        TileDescriptor &t = ctx.tile_table[i];
        if (t.valid && t.addr_sel == sel && t.layer == layer && t.head == head && t.tile == tile) {
            t.valid = false;
            ctx.num_tiles--;
            return;
        }
    }
}

// KV cache addressing
KVCacheAddr mmu_calc_kv_write_addr(const MMUContext &ctx, int layer, int head, bool is_v) {
#pragma HLS INLINE
    KVCacheAddr addr;
    uint32_t base = is_v ? ctx.v_cache_base : ctx.k_cache_base;
    uint32_t layer_stride = (uint32_t)ctx.dims.num_heads * ctx.dims.context_len * ctx.dims.d_heads;
    uint32_t head_stride = (uint32_t)ctx.dims.context_len * ctx.dims.d_heads;
    uint32_t token_stride = ctx.dims.d_heads;
    
    addr.base_addr = base + layer * layer_stride + head * head_stride + ctx.current_token * token_stride;
    addr.token_offset = ctx.current_token;
    addr.head = head;
    addr.valid = (layer >= 0 && layer < ctx.dims.num_layers &&
                  head >= 0 && head < ctx.dims.num_heads &&
                  ctx.current_token < ctx.dims.context_len);
    return addr;
}

KVCacheAddr mmu_calc_kv_read_addr(const MMUContext &ctx, int layer, int head, bool is_v) {
#pragma HLS INLINE
    KVCacheAddr addr;
    uint32_t base = is_v ? ctx.v_cache_base : ctx.k_cache_base;
    uint32_t layer_stride = (uint32_t)ctx.dims.num_heads * ctx.dims.context_len * ctx.dims.d_heads;
    uint32_t head_stride = (uint32_t)ctx.dims.context_len * ctx.dims.d_heads;
    
    addr.base_addr = base + layer * layer_stride + head * head_stride;
    addr.token_offset = 0;
    addr.head = head;
    addr.valid = (layer >= 0 && layer < ctx.dims.num_layers && head >= 0 && head < ctx.dims.num_heads);
    return addr;
}

uint32_t mmu_calc_kv_cache_size(const ModelDims &dims) {
#pragma HLS INLINE
    return (uint32_t)dims.num_layers * dims.num_heads * dims.context_len * dims.d_heads;
}

// DMA size calculation
uint32_t mmu_calc_dma_size(DmaSel sel, const ModelDims &dims, int tile) {
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

// Weight blob layout
WeightBlobLayout mmu_calc_weight_blob(DmaSel sel, const ModelDims &dims) {
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

// Input buffer layout (uses head_buf/compute_buf layouts from top_params.hpp)
InputBufferLayout mmu_calc_input_layout(ComputeOp op, const ModelDims &dims) {
#pragma HLS INLINE
    InputBufferLayout l;
    uint32_t off = 0;
    
    switch (op) {
        case CMP_Q: case CMP_K: case CMP_V: {
            l.act = BufferField(head_buf::QkvLayout::ACT, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.weights = BufferField(head_buf::QkvLayout::W, head_buf::QKV_W_BYTES, DataType::DTYPE_INT4, dims.d_model * dims.d_heads);
            l.bias = BufferField(head_buf::QkvLayout::B, head_buf::QKV_B_BYTES, DataType::DTYPE_INT4, dims.d_heads);
            l.total_size = head_buf::QKV_IN_BYTES;
            break;
        }
        case CMP_K_REQUANT: case CMP_V_REQUANT: case CMP_REQUANT_Q: case CMP_HEAD_REQUANT: {
            l.act = BufferField(head_buf::HeadRequantLayout::X, dims.d_heads * 4, DataType::DTYPE_INT32, dims.d_heads);
            l.m_param = BufferField(head_buf::HeadRequantLayout::M, 4, DataType::DTYPE_INT32, 1);
            l.n_param = BufferField(head_buf::HeadRequantLayout::N, 4, DataType::DTYPE_INT32, 1);
            l.z_param = BufferField(head_buf::HeadRequantLayout::Z, 4, DataType::DTYPE_INT32, 1);
            l.total_size = head_buf::HEAD_REQUANT_IN_BYTES;
            break;
        }
        case CMP_ATT_SCORES: {
            l.act = BufferField(head_buf::AttScoresLayout::Q, dims.d_heads, DataType::DTYPE_INT8, dims.d_heads);
            l.k_cache = BufferField(head_buf::AttScoresLayout::K_CACHE, dims.context_len * dims.d_heads, DataType::DTYPE_INT8, dims.context_len * dims.d_heads);
            l.total_size = head_buf::ATT_SCORES_IN_BYTES;
            break;
        }
        case CMP_VALUE_SCALE: {
            l.act = BufferField(head_buf::ValueScaleLayout::X, dims.context_len * 4, DataType::DTYPE_INT32, dims.context_len);
            l.total_size = head_buf::VALUE_SCALE_IN_BYTES;
            break;
        }
        case CMP_SOFTMAX: {
            l.act = BufferField(head_buf::SoftmaxLayout::X, dims.context_len * 2, DataType::DTYPE_INT16, dims.context_len);
            l.total_size = head_buf::SOFTMAX_IN_BYTES;
            break;
        }
        case CMP_ATT_VALUE: {
            l.act = BufferField(head_buf::AttValueLayout::WEIGHTS, dims.context_len, DataType::DTYPE_INT8, dims.context_len);
            l.v_cache = BufferField(head_buf::AttValueLayout::V_CACHE, dims.context_len * dims.d_heads, DataType::DTYPE_INT8, dims.context_len * dims.d_heads);
            l.total_size = head_buf::ATT_VALUE_IN_BYTES;
            break;
        }
        case CMP_LN0: case CMP_LN1: case CMP_FINAL_NORM: {
            l.act = BufferField(compute_buf::LayerNormLayout::X, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.gamma = BufferField(compute_buf::LayerNormLayout::GAMMA, dims.d_model * 4, DataType::DTYPE_INT32, dims.d_model);
            l.eps = BufferField(compute_buf::LayerNormLayout::EPS, 4, DataType::DTYPE_INT32, 1);
            l.total_size = compute_buf::LN_IN_BYTES;
            break;
        }
        case CMP_REQUANT1: case CMP_REQUANT2: case CMP_REQUANT3: case CMP_REQUANT4: {
            l.act = BufferField(compute_buf::RequantLayout::X, dims.d_model * 4, DataType::DTYPE_INT32, dims.d_model);
            l.m_param = BufferField(compute_buf::RequantLayout::M, 4, DataType::DTYPE_INT32, 1);
            l.n_param = BufferField(compute_buf::RequantLayout::N, 4, DataType::DTYPE_INT32, 1);
            l.z_param = BufferField(compute_buf::RequantLayout::Z, 4, DataType::DTYPE_INT32, 1);
            l.total_size = compute_buf::REQUANT_IN_BYTES;
            break;
        }
        case CMP_RESID0: case CMP_RESID1: {
            l.act = BufferField(compute_buf::ResidLayout::X, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.residual = BufferField(compute_buf::ResidLayout::R, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.total_size = compute_buf::RESID_IN_BYTES;
            break;
        }
        case CMP_OUT_PROJ: {
            l.act = BufferField(compute_buf::OutProjLayout::ACT, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.weights = BufferField(compute_buf::OutProjLayout::W, compute_buf::OUT_PROJ_W_BYTES, DataType::DTYPE_INT4, dims.d_model * dims.d_tile_wo);
            l.bias = BufferField(compute_buf::OutProjLayout::B, compute_buf::OUT_PROJ_B_BYTES, DataType::DTYPE_INT32, dims.d_tile_wo);
            l.total_size = compute_buf::OUT_PROJ_IN_BYTES;
            break;
        }
        case CMP_FFN_W1: {
            l.act = BufferField(compute_buf::FfnW1Layout::X, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.weights = BufferField(compute_buf::FfnW1Layout::W, compute_buf::FFN_W1_W_BYTES, DataType::DTYPE_INT4, dims.d_model * dims.d_tile_w1);
            l.bias = BufferField(compute_buf::FfnW1Layout::B, compute_buf::FFN_W1_B_BYTES, DataType::DTYPE_INT32, dims.d_tile_w1);
            l.scale = BufferField(compute_buf::FfnW1Layout::S, dims.d_tile_w1 * 2, DataType::DTYPE_INT16, dims.d_tile_w1);
            l.total_size = compute_buf::FFN_W1_IN_BYTES;
            break;
        }
        case CMP_FFN_ACT: {
            l.act = BufferField(compute_buf::FfnActLayout::X, dims.d_ffn * 2, DataType::DTYPE_INT16, dims.d_ffn);
            l.total_size = compute_buf::FFN_ACT_IN_BYTES;
            break;
        }
        case CMP_FFN_W2: {
            l.act = BufferField(compute_buf::FfnW2Layout::X, dims.d_ffn * 2, DataType::DTYPE_INT16, dims.d_ffn);
            l.weights = BufferField(compute_buf::FfnW2Layout::W, compute_buf::FFN_W2_W_BYTES, DataType::DTYPE_INT4, dims.d_ffn * dims.d_tile_w2);
            l.bias = BufferField(compute_buf::FfnW2Layout::B, compute_buf::FFN_W2_B_BYTES, DataType::DTYPE_INT32, dims.d_tile_w2);
            l.scale = BufferField(compute_buf::FfnW2Layout::S, dims.d_tile_w2 * 2, DataType::DTYPE_INT16, dims.d_tile_w2);
            l.total_size = compute_buf::FFN_W2_IN_BYTES;
            break;
        }
        case CMP_CONCAT: {
            l.act = BufferField(0, dims.num_heads * dims.d_heads, DataType::DTYPE_INT8, dims.num_heads * dims.d_heads);
            l.total_size = dims.num_heads * dims.d_heads;
            break;
        }
        default:
            l.total_size = 0;
    }
    return l;
}

// Output buffer layout
OutputBufferLayout mmu_calc_output_layout(ComputeOp op, const ModelDims &dims) {
#pragma HLS INLINE
    OutputBufferLayout l;
    switch (op) {
        case CMP_Q: case CMP_K: case CMP_V:
            l.result = BufferField(0, dims.d_heads * 4, DataType::DTYPE_INT32, dims.d_heads);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = head_buf::QKV_OUT_BYTES;
            break;
        case CMP_K_REQUANT: case CMP_V_REQUANT: case CMP_REQUANT_Q: case CMP_HEAD_REQUANT:
            l.result = BufferField(0, dims.d_heads, DataType::DTYPE_INT8, dims.d_heads);
            l.out_dtype = DataType::DTYPE_INT8;
            l.total_size = head_buf::HEAD_REQUANT_OUT_BYTES;
            break;
        case CMP_ATT_SCORES:
            l.result = BufferField(0, dims.context_len * 4, DataType::DTYPE_INT32, dims.context_len);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = head_buf::ATT_SCORES_OUT_BYTES;
            break;
        case CMP_VALUE_SCALE:
            l.result = BufferField(0, dims.context_len * 2, DataType::DTYPE_INT16, dims.context_len);
            l.out_dtype = DataType::DTYPE_INT16;
            l.total_size = head_buf::VALUE_SCALE_OUT_BYTES;
            break;
        case CMP_SOFTMAX:
            l.result = BufferField(0, dims.context_len * 2, DataType::DTYPE_INT16, dims.context_len);
            l.out_dtype = DataType::DTYPE_INT16;
            l.total_size = head_buf::SOFTMAX_OUT_BYTES;
            break;
        case CMP_ATT_VALUE:
            l.result = BufferField(0, dims.d_heads * 4, DataType::DTYPE_INT32, dims.d_heads);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = head_buf::ATT_VALUE_OUT_BYTES;
            break;
        case CMP_LN0: case CMP_LN1: case CMP_FINAL_NORM:
            l.result = BufferField(0, dims.d_model * 4, DataType::DTYPE_INT32, dims.d_model);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = compute_buf::LN_OUT_BYTES;
            break;
        case CMP_REQUANT1: case CMP_REQUANT2: case CMP_REQUANT3: case CMP_REQUANT4:
            l.result = BufferField(0, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.out_dtype = DataType::DTYPE_INT8;
            l.total_size = compute_buf::REQUANT_OUT_BYTES;
            break;
        case CMP_RESID0: case CMP_RESID1:
            l.result = BufferField(0, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.out_dtype = DataType::DTYPE_INT8;
            l.total_size = compute_buf::RESID_OUT_BYTES;
            break;
        case CMP_OUT_PROJ:
            l.result = BufferField(0, dims.d_tile_wo * 4, DataType::DTYPE_INT32, dims.d_tile_wo);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = compute_buf::OUT_PROJ_OUT_BYTES;
            break;
        case CMP_FFN_W1:
            l.result = BufferField(0, dims.d_tile_w1 * 2, DataType::DTYPE_INT16, dims.d_tile_w1);
            l.out_dtype = DataType::DTYPE_INT16;
            l.total_size = compute_buf::FFN_W1_OUT_BYTES;
            break;
        case CMP_FFN_ACT:
            l.result = BufferField(0, dims.d_ffn * 2, DataType::DTYPE_INT16, dims.d_ffn);
            l.out_dtype = DataType::DTYPE_INT16;
            l.total_size = compute_buf::FFN_ACT_OUT_BYTES;
            break;
        case CMP_FFN_W2:
            l.result = BufferField(0, dims.d_tile_w2 * 4, DataType::DTYPE_INT32, dims.d_tile_w2);
            l.out_dtype = DataType::DTYPE_INT32;
            l.total_size = compute_buf::FFN_W2_OUT_BYTES;
            break;
        case CMP_CONCAT:
            l.result = BufferField(0, dims.d_model, DataType::DTYPE_INT8, dims.d_model);
            l.out_dtype = DataType::DTYPE_INT8;
            l.total_size = dims.d_model;
            break;
        default:
            l.total_size = 0;
    }
    return l;
}

// Status flags
void mmu_set_head_dma_done(MMUContext &ctx, int h) {
#pragma HLS INLINE
    if (h >= 0 && h < MMU_MAX_HEADS) ctx.head_dma_done[h] = true;
}
void mmu_set_head_compute_done(MMUContext &ctx, int h) {
#pragma HLS INLINE
    if (h >= 0 && h < MMU_MAX_HEADS) ctx.head_compute_done[h] = true;
}
void mmu_set_main_dma_done(MMUContext &ctx) {
#pragma HLS INLINE
    ctx.main_dma_done = true;
}
void mmu_set_main_compute_done(MMUContext &ctx) {
#pragma HLS INLINE
    ctx.main_compute_done = true;
}
bool mmu_get_head_dma_done(const MMUContext &ctx, int h) {
#pragma HLS INLINE
    return (h >= 0 && h < MMU_MAX_HEADS) ? ctx.head_dma_done[h] : false;
}
bool mmu_get_head_compute_done(const MMUContext &ctx, int h) {
#pragma HLS INLINE
    return (h >= 0 && h < MMU_MAX_HEADS) ? ctx.head_compute_done[h] : false;
}
bool mmu_get_main_dma_done(const MMUContext &ctx) {
#pragma HLS INLINE
    return ctx.main_dma_done;
}
bool mmu_get_main_compute_done(const MMUContext &ctx) {
#pragma HLS INLINE
    return ctx.main_compute_done;
}
void mmu_clear_head_dma_done(MMUContext &ctx, int h) {
#pragma HLS INLINE
    if (h >= 0 && h < MMU_MAX_HEADS) ctx.head_dma_done[h] = false;
}
void mmu_clear_head_compute_done(MMUContext &ctx, int h) {
#pragma HLS INLINE
    if (h >= 0 && h < MMU_MAX_HEADS) ctx.head_compute_done[h] = false;
}
void mmu_clear_main_dma_done(MMUContext &ctx) {
#pragma HLS INLINE
    ctx.main_dma_done = false;
}
void mmu_clear_main_compute_done(MMUContext &ctx) {
#pragma HLS INLINE
    ctx.main_compute_done = false;
}
void mmu_clear_all_flags(MMUContext &ctx) {
#pragma HLS INLINE
    ctx.main_dma_done = ctx.main_compute_done = false;
    for (int i = 0; i < MMU_MAX_HEADS; ++i) {
        ctx.head_dma_done[i] = ctx.head_compute_done[i] = false;
    }
}

// Utilities
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

const char* mmu_state_name(MMUFsmState s) {
    switch (s) {
        case MMUFsmState::IDLE:          return "IDLE";
        case MMUFsmState::DMA_ARBITRATE: return "DMA_ARB";
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

// Main FSM
void mmu_fsm(
    MMUContext &ctx,
    bool dma_ready, bool dma_done,
    bool &dma_start, uint32_t &dma_addr, uint32_t &dma_len, bool &dma_is_write,
    uint8_t &uram_bank, uint32_t &uram_offset,
    bool buffer_ready, bool &buffer_valid, bool &transfer_done
) {
#pragma HLS INLINE off
    dma_start = false; dma_addr = 0; dma_len = 0; dma_is_write = false;
    uram_bank = 0; uram_offset = 0; buffer_valid = false; transfer_done = false;
    
    DmaQueueEntry dma_entry;
    ComputeBufferRequest compute_entry;
    
    switch (ctx.fsm_state) {
        case MMUFsmState::IDLE:
            if (ctx.dma_count > 0) ctx.fsm_state = MMUFsmState::DMA_ARBITRATE;
            else if (ctx.compute_count > 0) ctx.fsm_state = MMUFsmState::COMPUTE_ARB;
            break;
            
        case MMUFsmState::DMA_ARBITRATE:
            if (pop_dma(ctx, dma_entry)) {
                ctx.active_dma_req = dma_entry.packed_req;
                DmaSel sel; int layer, head, tile;
                mmu_unpack_dma(dma_entry.packed_req, sel, layer, head, tile);
                if (dma_entry.is_headed) {
                    mmu_request_head(ctx, head);
                    mmu_arbitrate(ctx);
                    if (mmu_is_granted(ctx, head)) ctx.fsm_state = MMUFsmState::DMA_ISSUE;
                } else {
                    ctx.fsm_state = MMUFsmState::DMA_ISSUE;
                }
            } else {
                ctx.fsm_state = MMUFsmState::IDLE;
            }
            break;
            
        case MMUFsmState::DMA_ISSUE:
            if (dma_ready) {
                DmaSel sel; int layer, head, tile;
                mmu_unpack_dma(ctx.active_dma_req, sel, layer, head, tile);
                if (mmu_is_dma_write(sel)) {
                    ctx.fsm_state = MMUFsmState::DMA_WRITEBACK;
                } else {
                    uint32_t size = mmu_calc_dma_size(sel, ctx.dims, tile);
                    uint8_t bank; uint32_t offset;
                    if (mmu_allocate_uram(ctx, size, bank, offset)) {
                        dma_start = true;
                        dma_len = size;
                        uram_bank = bank;
                        uram_offset = offset;
                        ctx.dma_in_progress = true;
                        ctx.fsm_state = MMUFsmState::DMA_WAIT;
                    } else {
                        ctx.error_overflow = true;
                        ctx.fsm_state = MMUFsmState::IDLE;
                    }
                }
            }
            break;
            
        case MMUFsmState::DMA_WAIT:
            if (dma_done) {
                DmaSel sel; int layer, head, tile;
                mmu_unpack_dma(ctx.active_dma_req, sel, layer, head, tile);
                uint32_t size = mmu_calc_dma_size(sel, ctx.dims, tile);
                mmu_commit_tile(ctx, sel, layer, head, tile, uram_bank, uram_offset, size);
                if (mmu_is_headed_dma(sel)) {
                    mmu_set_head_dma_done(ctx, head);
                    mmu_release_head(ctx, head);
                } else {
                    mmu_set_main_dma_done(ctx);
                }
                ctx.dma_in_progress = false;
                ctx.fsm_state = MMUFsmState::IDLE;
            }
            break;
            
        case MMUFsmState::DMA_WRITEBACK:
            if (dma_ready) {
                DmaSel sel; int layer, head, tile;
                mmu_unpack_dma(ctx.active_dma_req, sel, layer, head, tile);
                bool is_v = (sel == DMASEL_V_WRITE);
                KVCacheAddr kv = mmu_calc_kv_write_addr(ctx, layer, head, is_v);
                if (kv.valid) {
                    dma_start = true;
                    dma_addr = kv.base_addr;
                    dma_len = ctx.dims.d_heads;
                    dma_is_write = true;
                    ctx.dma_in_progress = true;
                    ctx.fsm_state = MMUFsmState::DMA_WAIT;
                } else {
                    ctx.error_invalid = true;
                    ctx.fsm_state = MMUFsmState::IDLE;
                }
            }
            break;
            
        case MMUFsmState::COMPUTE_ARB:
            if (pop_compute(ctx, compute_entry)) {
                ctx.active_compute_req = compute_entry;
                if (compute_entry.is_headed) {
                    mmu_request_head(ctx, compute_entry.head_idx);
                    mmu_arbitrate(ctx);
                    if (mmu_is_granted(ctx, compute_entry.head_idx)) {
                        ctx.fsm_state = (compute_entry.type == ComputeReqType::REQ_READ) 
                            ? MMUFsmState::URAM_TO_INBUF : MMUFsmState::OUTBUF_TO_URAM;
                    }
                } else {
                    ctx.fsm_state = (compute_entry.type == ComputeReqType::REQ_READ)
                        ? MMUFsmState::URAM_TO_INBUF : MMUFsmState::OUTBUF_TO_URAM;
                }
            } else {
                ctx.fsm_state = MMUFsmState::IDLE;
            }
            break;
            
        case MMUFsmState::URAM_TO_INBUF:
            if (buffer_ready) {
                buffer_valid = true;
                ctx.transfer_in_progress = true;
                ctx.fsm_state = MMUFsmState::TRANSFER_DONE;
            }
            break;
            
        case MMUFsmState::OUTBUF_TO_URAM:
            if (buffer_ready) {
                ComputeOp op; int layer, head, tile;
                mmu_unpack_compute(ctx.active_compute_req.packed_req, op, layer, head, tile);
                OutputBufferLayout out = mmu_calc_output_layout(op, ctx.dims);
                uint8_t bank; uint32_t offset;
                if (mmu_allocate_uram(ctx, out.total_size, bank, offset)) {
                    uram_bank = bank;
                    uram_offset = offset;
                    buffer_valid = true;
                    ctx.transfer_in_progress = true;
                    ctx.fsm_state = MMUFsmState::TRANSFER_DONE;
                } else {
                    ctx.error_overflow = true;
                    ctx.fsm_state = MMUFsmState::IDLE;
                }
            }
            break;
            
        case MMUFsmState::TRANSFER_DONE:
            transfer_done = true;
            if (ctx.active_compute_req.is_headed) {
                mmu_set_head_compute_done(ctx, ctx.active_compute_req.head_idx);
                mmu_release_head(ctx, ctx.active_compute_req.head_idx);
            } else {
                mmu_set_main_compute_done(ctx);
            }
            ctx.transfer_in_progress = false;
            ctx.fsm_state = MMUFsmState::IDLE;
            break;
            
        default:
            ctx.fsm_state = MMUFsmState::IDLE;
    }
}
