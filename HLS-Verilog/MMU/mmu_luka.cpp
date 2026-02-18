#include "mmu_luka.hpp"

namespace {

constexpr int MAX_DMA_PIECES = 3;

struct DmaQueueEntry {
    bool valid = false;
    uint32_t packed = 0;
    bool headed = false;
};

struct ComputeQueueEntry {
    bool valid = false;
    uint32_t packed = 0;
    ComputeReqType type = ComputeReqType::NONE;
    bool headed = false;
    uint8_t head = 0;
};

// ---------------------------------------------------------------------------
// Static memory resources
// ---------------------------------------------------------------------------
static uint8_t uram_banks[URAM_BANKS][URAM_BANK_BYTES];

static uint32_t bank_offsets[URAM_BANKS];

static DmaQueueEntry dma_q[DMA_QUEUE_DEPTH];
static uint8_t dma_q_head = 0;
static uint8_t dma_q_tail = 0;
static uint8_t dma_q_count = 0;

static ComputeQueueEntry compute_q[COMPUTE_QUEUE_DEPTH];
static uint8_t compute_q_head = 0;
static uint8_t compute_q_tail = 0;
static uint8_t compute_q_count = 0;

static Region regions[MAX_REGIONS];
static uint16_t region_count = 0;

static bool arb_pending[NUM_HEADS];
static bool arb_grant[NUM_HEADS];
static int arb_current = -1;
static int arb_rr_ptr = 0;
static bool arb_busy = false;

static State g_state = State::IDLE;
static bool g_overflow = false;
static bool g_invalid = false;
static uint32_t g_error_code = ERR_NONE;
static uint8_t g_active_bank = 0;

// Active DMA request context
static bool active_dma_valid = false;
static bool active_dma_headed = false;
static DmaSel active_dma_sel = DMASEL_NONE;
static int active_dma_layer = 0;
static int active_dma_head = -1;
static int active_dma_tile = -1;
static uint32_t active_dma_addr_base = 0;
static uint8_t active_piece_idx = 0;
static uint8_t active_piece_count = 0;
static uint32_t active_piece_bytes[MAX_DMA_PIECES];
static uint32_t active_piece_addr_off[MAX_DMA_PIECES];
static Tag active_piece_tag[MAX_DMA_PIECES];

// Active compute request context
static bool active_compute_valid = false;
static bool active_compute_headed = false;
static ComputeReqType active_compute_type = ComputeReqType::NONE;
static ComputeOp active_compute_op = ComputeOp::CMP_NONE;
static int active_compute_layer = 0;
static int active_compute_head = -1;
static int active_compute_tile = -1;

// Edge-detect latches so level-style requests do not enqueue repeatedly.
static bool main_wl_accepted = false;
static bool head_wl_accepted[NUM_HEADS];
static bool prev_main_mem_req = false;
static uint32_t prev_main_mem_op = 0;
static bool prev_head_mem_req[HEADS_PARALLEL];
static uint32_t prev_head_mem_op[HEADS_PARALLEL];
static bool prev_axis_in_start = false;
static bool prev_stream_start = false;
static int g_current_layer = -1;

// Scratch buffer for region copy/construction
static uint8_t scratch[DMA_BUF_BYTES];

// ---------------------------------------------------------------------------
// Utility
// ---------------------------------------------------------------------------
static inline int decode_s8(uint32_t v) {
    return static_cast<int>(static_cast<int8_t>(v & 0xFFu));
}

static inline void mmu_set_invalid(uint32_t err_bit) {
#pragma HLS INLINE
    g_invalid = true;
    g_error_code |= err_bit;
}

static inline void mmu_set_overflow(uint32_t err_bit) {
#pragma HLS INLINE
    g_overflow = true;
    g_error_code |= err_bit;
}

static inline void unpack_dma(uint32_t packed, DmaSel &sel, int &layer, int &head, int &tile) {
#pragma HLS INLINE
    sel = static_cast<DmaSel>(packed & 0xFFu);
    layer = decode_s8((packed >> 8) & 0xFFu);
    head = decode_s8((packed >> 16) & 0xFFu);
    tile = decode_s8((packed >> 24) & 0xFFu);
}

static inline void unpack_compute(uint32_t packed, ComputeOp &op, int &layer, int &head, int &tile) {
#pragma HLS INLINE
    op = static_cast<ComputeOp>(packed & 0xFFu);
    layer = decode_s8((packed >> 8) & 0xFFu);
    head = decode_s8((packed >> 16) & 0xFFu);
    tile = decode_s8((packed >> 24) & 0xFFu);
}

static inline bool is_headed_dma(DmaSel sel) {
#pragma HLS INLINE
    switch (sel) {
        case DMASEL_WQ:
        case DMASEL_WK:
        case DMASEL_WV:
        case DMASEL_K_WRITE:
        case DMASEL_V_WRITE:
        case DMASEL_CTX_K:
        case DMASEL_CTX_V: {
            return true;
        }
        default: {
            return false;
        }
    }
}

static inline bool is_headed_compute(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V:
        case CMP_ATT_SCORES:
        case CMP_VALUE_SCALE:
        case CMP_SOFTMAX:
        case CMP_ATT_VALUE:
        case CMP_HEAD_REQUANT: {
            return true;
        }
        default: {
            return false;
        }
    }
}

static inline bool is_disabled_compute_op(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_CONCAT: {
            return true;
        }
        default: {
            return false;
        }
    }
}

static inline int head_to_lane(int head) {
#pragma HLS INLINE
    if (head < 0) return 0;
    return head % HEADS_PARALLEL;
}

static inline void signal_head_compute_done(
    ComputeHeadCtx (&head_compute_ctx)[HEADS_PARALLEL],
    int done_head
) {
#pragma HLS INLINE
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        ComputeOp op = ComputeOp::CMP_NONE;
        int layer = 0, head = -1, tile = -1;
        unpack_compute(head_compute_ctx[lane].mem_op, op, layer, head, tile);
        if (head < 0 || head >= NUM_HEADS) {
            unpack_compute(head_compute_ctx[lane].compute_instruction, op, layer, head, tile);
        }
        if (head == done_head) {
            head_compute_ctx[lane].mem_transfer_done = true;
        }
    }
}

static inline uint32_t main_op_out_bytes(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_OUT_PROJ: {
            return compute_buf::OUTOutProjLayout::TOTAL_BYTES;
        }
        case CMP_RESID1:
        case CMP_RESID2: {
            return compute_buf::OUTResidLayout::TOTAL_BYTES;
        }
        case CMP_LN0:
        case CMP_LN1:
        case CMP_FINAL_NORM: {
            return compute_buf::OUTLayerNormLayout::TOTAL_BYTES;
        }
        case CMP_FFN_W1: {
            return compute_buf::OUTFfnW1Layout::TOTAL_BYTES;
        }
        case CMP_FFN_ACT: {
            return compute_buf::OUTFfnActLayout::TOTAL_BYTES;
        }
        case CMP_FFN_W2: {
            return compute_buf::OUTFfnW2Layout::TOTAL_BYTES;
        }
        case CMP_CONCAT: {
            return D_MODEL;
        }
        default: {
            return compute_buf::OUT_BUF_BYTES;
        }
    }
}

static inline uint32_t head_op_out_bytes(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V: {
            return head_buf::OUTQkvLayout::TOTAL_BYTES;
        }
        case CMP_HEAD_REQUANT: {
            return head_buf::OUTHeadRequantLayout::TOTAL_BYTES;
        }
        case CMP_ATT_SCORES: {
            return head_buf::OUTAttScoresLayout::TOTAL_BYTES;
        }
        case CMP_VALUE_SCALE: {
            return head_buf::OUTValueScaleLayout::TOTAL_BYTES;
        }
        case CMP_SOFTMAX: {
            return head_buf::OUTSoftmaxLayout::TOTAL_BYTES;
        }
        case CMP_ATT_VALUE: {
            return head_buf::OUTAttValueLayout::TOTAL_BYTES;
        }
        default: {
            return head_buf::OUT_BUF_BYTES;
        }
    }
}

static inline uint8_t default_retain(Tag tag) {
#pragma HLS INLINE
    switch (tag) {
        case Tag::WQ_W:
        case Tag::WQ_B:
        case Tag::WK_W:
        case Tag::WK_B:
        case Tag::WV_W:
        case Tag::WV_B:
        case Tag::WO_W:
        case Tag::WO_B:
        case Tag::W1_W:
        case Tag::W1_B:
        case Tag::W2_W:
        case Tag::W2_B:
        case Tag::CTX_K:
        case Tag::CTX_V:
        case Tag::LN1_GAMMA:
        case Tag::LN1_EPS: {
            return 1; // single-use DMA payloads
        }
        case Tag::LN0_GAMMA:
        case Tag::LN0_EPS: {
            return 1; // consumed on FINAL_NORM after LN0 use
        }
        case Tag::STREAM_IN_TOKEN: {
            return 0xFF; // keep indefinitely unless explicitly reset
        }
        case Tag::RESID1_OUT: {
            return 0xFF; // cross-layer carry
        }
        case Tag::RESID0_OUT:
        case Tag::LN0_OUT:
        case Tag::LN1_OUT:
        case Tag::OUT_PROJ_PACKED:
        case Tag::FFN_W1_PACKED:
        case Tag::FFN_ACT_OUT:
        case Tag::FFN_W2_PACKED:
        case Tag::Q_OUT:
        case Tag::K_OUT:
        case Tag::V_OUT:
        case Tag::ATT_SCORES_OUT:
        case Tag::VALUE_SCALE_OUT:
        case Tag::SOFTMAX_OUT:
        case Tag::ATT_VALUE_OUT:
        case Tag::HEAD_REQUANT_PACKED:
        case Tag::CONCAT_OUT: {
            return 1;
        }
        default: {
            return 2;
        }
    }
}

static inline bool should_consume(Tag tag) {
#pragma HLS INLINE
    switch (tag) {
        case Tag::WQ_W:
        case Tag::WQ_B:
        case Tag::WK_W:
        case Tag::WK_B:
        case Tag::WV_W:
        case Tag::WV_B:
        case Tag::WO_W:
        case Tag::WO_B:
        case Tag::W1_W:
        case Tag::W1_B:
        case Tag::W2_W:
        case Tag::W2_B:
        case Tag::CTX_K:
        case Tag::CTX_V:
        case Tag::LN0_GAMMA:
        case Tag::LN0_EPS:
        case Tag::LN1_GAMMA:
        case Tag::LN1_EPS:
        case Tag::HEAD_REQUANT_PACKED:
        case Tag::CONCAT_OUT:
        case Tag::OUT_PROJ_PACKED:
        case Tag::FFN_W1_PACKED:
        case Tag::FFN_ACT_OUT:
        case Tag::FFN_W2_PACKED:
        case Tag::Q_OUT:
        case Tag::K_OUT:
        case Tag::V_OUT:
        case Tag::ATT_SCORES_OUT:
        case Tag::VALUE_SCALE_OUT:
        case Tag::SOFTMAX_OUT:
        case Tag::ATT_VALUE_OUT: {
            return true;
        }
        default: {
            return false;
        }
    }
}

static inline bool is_cross_layer_carry_tag(Tag tag) {
#pragma HLS INLINE
    switch (tag) {
        case Tag::RESID1_OUT: {
            return true;
        }
        default: {
            return false;
        }
    }
}

static inline bool keep_region_on_layer_purge(const Region &r, int new_layer) {
#pragma HLS INLINE
    if (!r.valid || !r.used) return false;
    if (r.layer < 0) return true;
    if (r.layer >= new_layer) return true;
    if (is_cross_layer_carry_tag(r.tag) && r.layer == (new_layer - 1)) {
        return true;
    }
    return false;
}

// ---------------------------------------------------------------------------
// Arbitration
// ---------------------------------------------------------------------------
static void arb_request(int head) {
#pragma HLS INLINE
    if (head >= 0 && head < NUM_HEADS) arb_pending[head] = true;
}

static void arb_release(int head) {
#pragma HLS INLINE
    if (head >= 0 && head < NUM_HEADS) {
        arb_pending[head] = false;
        arb_grant[head] = false;
        if (arb_current == head) {
            arb_current = -1;
            arb_busy = false;
        }
    }
}

static void arb_step() {
#pragma HLS INLINE
    if (arb_busy) return;
    int grant = -1;
    for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
        const int h = (arb_rr_ptr + i) % NUM_HEADS;
        if (arb_pending[h]) {
            grant = h;
            break;
        }
    }
    if (grant >= 0) {
        for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
            arb_grant[i] = (i == grant);
        }
        arb_current = grant;
        arb_rr_ptr = (grant + 1) % NUM_HEADS;
        arb_busy = true;
    }
}

static bool arb_is_granted(int head) {
#pragma HLS INLINE
    if (head < 0 || head >= NUM_HEADS) return false;
    return arb_grant[head];
}

// ---------------------------------------------------------------------------
// Queue helpers
// ---------------------------------------------------------------------------
static inline bool dma_q_push(uint32_t packed, bool headed) {
#pragma HLS INLINE
    if (dma_q_count >= DMA_QUEUE_DEPTH) return false;
    dma_q[dma_q_tail].valid = true;
    dma_q[dma_q_tail].packed = packed;
    dma_q[dma_q_tail].headed = headed;
    dma_q_tail = static_cast<uint8_t>((dma_q_tail + 1) % DMA_QUEUE_DEPTH);
    dma_q_count++;
    return true;
}

static inline bool dma_q_pop(DmaQueueEntry &out) {
#pragma HLS INLINE
    if (dma_q_count == 0) return false;
    out = dma_q[dma_q_head];
    dma_q[dma_q_head].valid = false;
    dma_q_head = static_cast<uint8_t>((dma_q_head + 1) % DMA_QUEUE_DEPTH);
    dma_q_count--;
    return true;
}

static inline bool compute_q_push(uint32_t packed, ComputeReqType type, bool headed, uint8_t head) {
#pragma HLS INLINE
    if (compute_q_count >= COMPUTE_QUEUE_DEPTH) return false;
    compute_q[compute_q_tail].valid = true;
    compute_q[compute_q_tail].packed = packed;
    compute_q[compute_q_tail].type = type;
    compute_q[compute_q_tail].headed = headed;
    compute_q[compute_q_tail].head = head;
    compute_q_tail = static_cast<uint8_t>((compute_q_tail + 1) % COMPUTE_QUEUE_DEPTH);
    compute_q_count++;
    return true;
}

static inline bool compute_q_pop(ComputeQueueEntry &out) {
#pragma HLS INLINE
    if (compute_q_count == 0) return false;
    out = compute_q[compute_q_head];
    compute_q[compute_q_head].valid = false;
    compute_q_head = static_cast<uint8_t>((compute_q_head + 1) % COMPUTE_QUEUE_DEPTH);
    compute_q_count--;
    return true;
}

// ---------------------------------------------------------------------------
// Region/URAM management
// ---------------------------------------------------------------------------
static bool allocate_chunks(uint32_t total_bytes, Chunk chunks[MAX_CHUNKS], uint8_t &num_chunks) {
#pragma HLS INLINE
    uint32_t remaining = total_bytes;
    uint8_t bank = g_active_bank;
    num_chunks = 0;
    while (remaining > 0) {
#pragma HLS LOOP_TRIPCOUNT min=1 max=8
        if (num_chunks >= MAX_CHUNKS) return false;
        const int bank_i = static_cast<int>(bank);
        const uint32_t off = bank_offsets[bank_i];
        if (off >= URAM_BANK_BYTES) {
            bank = static_cast<uint8_t>((bank + 1) % URAM_BANKS);
            continue;
        }
        const uint32_t space = URAM_BANK_BYTES - off;
        const uint32_t take = (remaining < space) ? remaining : space;
        chunks[num_chunks].bank = bank;
        chunks[num_chunks].offset = off;
        chunks[num_chunks].size = take;
        remaining -= take;
        num_chunks++;
        bank = static_cast<uint8_t>((bank + 1) % URAM_BANKS);
    }
    return true;
}

static void commit_chunks(const Chunk chunks[MAX_CHUNKS], uint8_t num_chunks) {
#pragma HLS INLINE
    for (int c = 0; c < MAX_CHUNKS; ++c) {
#pragma HLS UNROLL
        if (c < num_chunks) {
            const uint8_t b = chunks[c].bank;
            const int bank_i = static_cast<int>(b);
            bank_offsets[bank_i] = chunks[c].offset + chunks[c].size;
            if (bank_offsets[bank_i] >= URAM_BANK_BYTES) {
                g_active_bank = static_cast<uint8_t>((b + 1) % URAM_BANKS);
            }
        }
    }
}

static int find_region(Tag tag, int layer, int head, int tile) {
#pragma HLS INLINE off
    for (int i = 0; i < MAX_REGIONS; ++i) {
        if (regions[i].valid &&
            regions[i].tag == tag &&
            regions[i].layer == layer &&
            regions[i].head == head &&
            regions[i].tile == tile) {
            return i;
        }
    }
    return -1;
}

static bool region_ready(const Region &r) {
#pragma HLS INLINE
    return r.valid && r.used && (r.expected_parts == 0 || r.written_parts >= r.expected_parts);
}

static void maybe_consume(int idx) {
#pragma HLS INLINE
    if (idx < 0 || idx >= MAX_REGIONS) return;
    Region &r = regions[idx];
    if (!r.valid) return;
    if (r.retain_count == 0xFF) return;
    if (r.retain_count > 0) {
        r.retain_count--;
    }
    if (r.retain_count == 0) {
        r.used = false;
    }
}

static void gc_scan() {
#pragma HLS INLINE off
    bool any_live = false;
    for (int i = 0; i < MAX_REGIONS; ++i) {
        if (regions[i].valid && regions[i].used) {
            any_live = true;
        }
    }

    if (!any_live) {
        region_count = 0;
        g_active_bank = 0;
        for (int b = 0; b < URAM_BANKS; ++b) {
            bank_offsets[b] = 0;
        }
        for (int i = 0; i < MAX_REGIONS; ++i) {
            regions[i].valid = false;
            regions[i].used = false;
        }
        return;
    }

    for (int i = 0; i < MAX_REGIONS; ++i) {
        if (regions[i].valid && !regions[i].used) {
            regions[i].valid = false;
            if (region_count > 0) region_count--;
        }
    }
}

static void purge_layers_before(int new_layer) {
#pragma HLS INLINE
    if (new_layer <= 0) return;

    for (int i = 0; i < MAX_REGIONS; ++i) {
        if (!regions[i].valid || !regions[i].used) {
            continue;
        }
        if (!keep_region_on_layer_purge(regions[i], new_layer)) {
            regions[i].used = false;
        }
    }
    gc_scan();
}

static void on_layer_transition(int req_layer) {
#pragma HLS INLINE
    if (req_layer < 0) return;
    if (g_current_layer < 0) {
        g_current_layer = req_layer;
        return;
    }
    if (req_layer > g_current_layer) {
        purge_layers_before(req_layer);
        g_current_layer = req_layer;
    }
}

static int create_region(Tag tag, int layer, int head, int tile, uint32_t total_bytes,
                         uint16_t expected_parts, uint32_t part_bytes, uint8_t retain_count,
                         bool &overflow_flag) {
#pragma HLS INLINE
    int free_idx = -1;
    for (int i = 0; i < MAX_REGIONS; ++i) {
        if (!regions[i].valid) {
            free_idx = i;
            break;
        }
    }
    if (free_idx < 0) {
        gc_scan();
        for (int i = 0; i < MAX_REGIONS; ++i) {
            if (!regions[i].valid) {
                free_idx = i;
                break;
            }
        }
    }
    if (free_idx < 0) {
        overflow_flag = true;
        mmu_set_overflow(ERR_MMU_REGION_TABLE_FULL);
        return -1;
    }

    Chunk chunks[MAX_CHUNKS];
    uint8_t num_chunks = 0;
    if (!allocate_chunks(total_bytes, chunks, num_chunks)) {
        gc_scan();
        if (!allocate_chunks(total_bytes, chunks, num_chunks)) {
            overflow_flag = true;
            mmu_set_overflow(ERR_MMU_URAM_CHUNK_ALLOC_FAIL);
            return -1;
        }
    }

    commit_chunks(chunks, num_chunks);

    Region &r = regions[free_idx];
    r.valid = true;
    r.used = true;
    r.tag = tag;
    r.layer = static_cast<int16_t>(layer);
    r.head = static_cast<int16_t>(head);
    r.tile = static_cast<int16_t>(tile);
    r.total_bytes = total_bytes;
    r.expected_parts = expected_parts;
    r.written_parts = 0;
    r.part_bytes = part_bytes;
    r.part_mask = 0;
    r.retain_count = retain_count;
    r.num_chunks = num_chunks;
    for (int i = 0; i < MAX_CHUNKS; ++i) {
#pragma HLS UNROLL
        if (i < num_chunks) {
            r.chunks[i] = chunks[i];
        } else {
            r.chunks[i] = Chunk{};
        }
    }
    region_count++;
    return free_idx;
}

static int get_or_create_region(Tag tag, int layer, int head, int tile, uint32_t total_bytes,
                                uint16_t expected_parts, uint32_t part_bytes,
                                bool &overflow_flag) {
#pragma HLS INLINE
    const int idx = find_region(tag, layer, head, tile);
    if (idx >= 0) return idx;
    return create_region(tag, layer, head, tile, total_bytes, expected_parts,
                         part_bytes, default_retain(tag), overflow_flag);
}

static bool region_write_bytes(const Region &r, uint32_t dst_offset, const uint8_t *src, uint32_t bytes) {
#pragma HLS INLINE off
    if (dst_offset + bytes > r.total_bytes) return false;
    uint32_t remaining = bytes;
    uint32_t written = 0;
    uint32_t logical = dst_offset;

    for (int c = 0; c < MAX_CHUNKS && remaining > 0; ++c) {
#pragma HLS LOOP_FLATTEN off
        if (c >= r.num_chunks) break;
        const Chunk &ck = r.chunks[c];
        if (logical >= ck.size) {
            logical -= ck.size;
            continue;
        }
        const uint32_t room = ck.size - logical;
        const uint32_t take = (remaining < room) ? remaining : room;
        for (uint32_t i = 0; i < take; ++i) {
#pragma HLS PIPELINE II=1
            uram_banks[ck.bank][ck.offset + logical + i] = src[written + i];
        }
        written += take;
        remaining -= take;
        logical = 0;
    }
    return (remaining == 0);
}

static bool region_read_bytes(const Region &r, uint32_t src_offset, uint8_t *dst, uint32_t bytes) {
#pragma HLS INLINE off
    if (src_offset + bytes > r.total_bytes) return false;
    uint32_t remaining = bytes;
    uint32_t copied = 0;
    uint32_t logical = src_offset;

    for (int c = 0; c < MAX_CHUNKS && remaining > 0; ++c) {
#pragma HLS LOOP_FLATTEN off
        if (c >= r.num_chunks) break;
        const Chunk &ck = r.chunks[c];
        if (logical >= ck.size) {
            logical -= ck.size;
            continue;
        }
        const uint32_t room = ck.size - logical;
        const uint32_t take = (remaining < room) ? remaining : room;
        for (uint32_t i = 0; i < take; ++i) {
#pragma HLS PIPELINE II=1
            dst[copied + i] = uram_banks[ck.bank][ck.offset + logical + i];
        }
        copied += take;
        remaining -= take;
        logical = 0;
    }
    return (remaining == 0);
}

static bool region_write_part(int idx, int part_idx, const uint8_t *src, uint32_t bytes) {
#pragma HLS INLINE
    if (idx < 0 || idx >= MAX_REGIONS) return false;
    Region &r = regions[idx];
    if (!r.valid) return false;
    const uint32_t off = static_cast<uint32_t>(part_idx) * r.part_bytes;
    if (!region_write_bytes(r, off, src, bytes)) return false;

    if (part_idx >= 0 && part_idx < 32) {
        const uint32_t bit = (1u << static_cast<uint32_t>(part_idx));
        if ((r.part_mask & bit) == 0u) {
            r.part_mask |= bit;
            r.written_parts++;
        }
    } else if (r.written_parts < r.expected_parts) {
        r.written_parts++;
    }
    return true;
}

static bool load_region_to_buf(Tag tag, int layer, int head, int tile,
                               uint8_t *dst, int dst_off, uint32_t bytes,
                               bool consume, bool &invalid_flag) {
#pragma HLS INLINE
    const int idx = find_region(tag, layer, head, tile);
    if (idx < 0 || !region_ready(regions[idx])) {
        mmu_set_invalid(ERR_MMU_MISSING_REGION_FULL_READ);
        invalid_flag = true;
        return false;
    }
    if (!region_read_bytes(regions[idx], 0, &dst[dst_off], bytes)) {
        mmu_set_invalid(ERR_MMU_REGION_ACCESS);
        invalid_flag = true;
        return false;
    }
    if (consume && should_consume(tag)) {
        maybe_consume(idx);
    }
    return true;
}

static bool load_region_partial_to_buf(Tag tag, int layer, int head, int tile,
                                       uint8_t *dst, int dst_off, uint32_t bytes,
                                       bool consume, bool &invalid_flag) {
#pragma HLS INLINE
    const int idx = find_region(tag, layer, head, tile);
    if (idx < 0 || !region_ready(regions[idx])) {
        mmu_set_invalid(ERR_MMU_MISSING_REGION_PARTIAL_READ);
        invalid_flag = true;
        return false;
    }
    const uint32_t copy_bytes = (regions[idx].total_bytes < bytes) ? regions[idx].total_bytes : bytes;
    if (!region_read_bytes(regions[idx], 0, &dst[dst_off], copy_bytes)) {
        mmu_set_invalid(ERR_MMU_REGION_ACCESS);
        invalid_flag = true;
        return false;
    }
    if (consume && should_consume(tag)) {
        maybe_consume(idx);
    }
    return true;
}

// ---------------------------------------------------------------------------
// Tag mapping for compute writes (includes tiled/contiguous aggregation rules)
// ---------------------------------------------------------------------------
struct WriteSpec {
    Tag tag = Tag::NONE;
    int key_head = -1;
    int key_tile = -1;
    uint16_t expected_parts = 1;
    int part_idx = 0;
    uint32_t part_bytes = 0;
    uint32_t total_bytes = 0;
};

static WriteSpec build_write_spec(ComputeOp op, bool headed, int head, int tile) {
#pragma HLS INLINE off
    WriteSpec s;
    s.part_bytes = headed ? head_op_out_bytes(op) : main_op_out_bytes(op);
    s.total_bytes = s.part_bytes;

    if (headed) {
        s.key_head = head;
        switch (op) {
            case CMP_Q: {
                s.tag = Tag::Q_OUT;
                break;
            }
            case CMP_K: {
                s.tag = Tag::K_OUT;
                break;
            }
            case CMP_V: {
                s.tag = Tag::V_OUT;
                break;
            }
            case CMP_ATT_SCORES: {
                s.tag = Tag::ATT_SCORES_OUT;
                break;
            }
            case CMP_VALUE_SCALE: {
                s.tag = Tag::VALUE_SCALE_OUT;
                break;
            }
            case CMP_SOFTMAX: {
                s.tag = Tag::SOFTMAX_OUT;
                break;
            }
            case CMP_ATT_VALUE: {
                s.tag = Tag::ATT_VALUE_OUT;
                break;
            }
            case CMP_HEAD_REQUANT: {
                // Contiguous pack across all heads for HEAD_CONCAT handoff.
                s.tag = Tag::HEAD_REQUANT_PACKED;
                s.key_head = -1;
                s.expected_parts = NUM_HEADS;
                s.part_idx = (head >= 0) ? head : 0;
                s.total_bytes = static_cast<uint32_t>(NUM_HEADS) * s.part_bytes;
                break;
            }
            default: {
                s.tag = Tag::HEAD_REQUANT_PACKED;
                break;
            }
        }
        return s;
    }

    s.key_tile = tile;
    switch (op) {
        case CMP_CONCAT: {
            s.tag = Tag::CONCAT_OUT;
            s.key_tile = -1;
            break;
        }
        case CMP_OUT_PROJ: {
            // Contiguous tile pack for downstream stage.
            s.tag = Tag::OUT_PROJ_PACKED;
            s.key_tile = -1;
            s.expected_parts = NUM_WO_TILES;
            s.part_idx = (tile >= 0) ? tile : 0;
            s.total_bytes = static_cast<uint32_t>(NUM_WO_TILES) * s.part_bytes;
            break;
        }
        case CMP_RESID1: {
            s.tag = Tag::RESID0_OUT;
            s.key_tile = -1;
            break;
        }
        case CMP_LN1: {
            s.tag = Tag::LN1_OUT;
            s.key_tile = -1;
            break;
        }
        case CMP_FFN_W1: {
            // Contiguous tile pack for FFN activation stage.
            s.tag = Tag::FFN_W1_PACKED;
            s.key_tile = -1;
            s.expected_parts = NUM_W1_TILES;
            s.part_idx = (tile >= 0) ? tile : 0;
            s.total_bytes = static_cast<uint32_t>(NUM_W1_TILES) * s.part_bytes;
            break;
        }
        case CMP_FFN_ACT: {
            s.tag = Tag::FFN_ACT_OUT;
            s.key_tile = -1;
            break;
        }
        case CMP_FFN_W2: {
            // Contiguous tile pack for downstream requant/residual.
            s.tag = Tag::FFN_W2_PACKED;
            s.key_tile = -1;
            s.expected_parts = NUM_W2_TILES;
            s.part_idx = (tile >= 0) ? tile : 0;
            s.total_bytes = static_cast<uint32_t>(NUM_W2_TILES) * s.part_bytes;
            break;
        }
        case CMP_RESID2: {
            s.tag = Tag::RESID1_OUT;
            s.key_tile = -1;
            break;
        }
        case CMP_FINAL_NORM: {
            s.tag = Tag::FINAL_NORM_OUT;
            s.key_tile = -1;
            break;
        }
        case CMP_LN0: {
            s.tag = Tag::LN0_OUT;
            s.key_tile = -1;
            break;
        }
        default: {
            s.tag = Tag::FINAL_NORM_OUT;
            s.key_tile = -1;
            break;
        }
    }
    return s;
}

// ---------------------------------------------------------------------------
// DMA planning
// ---------------------------------------------------------------------------
static bool build_dma_piece_plan(DmaSel sel,
                                 uint8_t &piece_count, uint32_t piece_bytes[MAX_DMA_PIECES],
                                 uint32_t piece_addr_off[MAX_DMA_PIECES], Tag piece_tag[MAX_DMA_PIECES]) {
#pragma HLS INLINE off
    piece_count = 0;
    for (int i = 0; i < MAX_DMA_PIECES; ++i) {
#pragma HLS UNROLL
        piece_bytes[i] = 0;
        piece_addr_off[i] = 0;
        piece_tag[i] = Tag::NONE;
    }

    switch (sel) {
        case DMASEL_WQ: {
            piece_count = 2;
            piece_bytes[0] = head_buf::INQkvLayout::W_BYTES;
            piece_bytes[1] = head_buf::INQkvLayout::B_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = piece_bytes[0];
            piece_tag[0] = Tag::WQ_W;
            piece_tag[1] = Tag::WQ_B;
            return true;
        }
        case DMASEL_WK: {
            piece_count = 2;
            piece_bytes[0] = head_buf::INQkvLayout::W_BYTES;
            piece_bytes[1] = head_buf::INQkvLayout::B_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = piece_bytes[0];
            piece_tag[0] = Tag::WK_W;
            piece_tag[1] = Tag::WK_B;
            return true;
        }
        case DMASEL_WV: {
            piece_count = 2;
            piece_bytes[0] = head_buf::INQkvLayout::W_BYTES;
            piece_bytes[1] = head_buf::INQkvLayout::B_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = piece_bytes[0];
            piece_tag[0] = Tag::WV_W;
            piece_tag[1] = Tag::WV_B;
            return true;
        }
        case DMASEL_WO: {
            piece_count = 2;
            piece_bytes[0] = compute_buf::INOutProjLayout::W_BYTES;
            piece_bytes[1] = compute_buf::INOutProjLayout::B_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = piece_bytes[0];
            piece_tag[0] = Tag::WO_W;
            piece_tag[1] = Tag::WO_B;
            return true;
        }
        case DMASEL_W1: {
            piece_count = 2;
            piece_bytes[0] = compute_buf::INFfnW1Layout::W_BYTES;
            piece_bytes[1] = compute_buf::INFfnW1Layout::B_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = piece_bytes[0];
            piece_tag[0] = Tag::W1_W;
            piece_tag[1] = Tag::W1_B;
            return true;
        }
        case DMASEL_W2: {
            piece_count = 2;
            piece_bytes[0] = compute_buf::INFfnW2Layout::W_BYTES;
            piece_bytes[1] = compute_buf::INFfnW2Layout::B_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = piece_bytes[0];
            piece_tag[0] = Tag::W2_W;
            piece_tag[1] = Tag::W2_B;
            return true;
        }
        case DMASEL_CTX_K: {
            piece_count = 1;
            piece_bytes[0] = head_buf::INAttScoresLayout::K_CACHE_BYTES;
            piece_tag[0] = Tag::CTX_K;
            return true;
        }
        case DMASEL_CTX_V: {
            piece_count = 1;
            piece_bytes[0] = head_buf::INAttValueLayout::V_CACHE_BYTES;
            piece_tag[0] = Tag::CTX_V;
            return true;
        }
        case DMASEL_LN0: {
            piece_count = 2;
            piece_bytes[0] = compute_buf::INLayerNormLayout::GAMMA_BYTES;
            piece_bytes[1] = compute_buf::INLayerNormLayout::EPS_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = 0;
            piece_tag[0] = Tag::LN0_GAMMA;
            piece_tag[1] = Tag::LN0_EPS;
            return true;
        }
        case DMASEL_LN1: {
            piece_count = 2;
            piece_bytes[0] = compute_buf::INLayerNormLayout::GAMMA_BYTES;
            piece_bytes[1] = compute_buf::INLayerNormLayout::EPS_BYTES;
            piece_addr_off[0] = 0;
            piece_addr_off[1] = 0;
            piece_tag[0] = Tag::LN1_GAMMA;
            piece_tag[1] = Tag::LN1_EPS;
            return true;
        }
        case DMASEL_WLOGIT:
        case DMASEL_NONE: {
            piece_count = 0;
            return true;
        }
        case DMASEL_CONCAT:
        case DMASEL_K_WRITE:
        case DMASEL_V_WRITE: {
            return true;
        }
        default: {
            return false;
        }
    }
}

static bool calc_dma_base_addr(ControlMemSpace ctrl_mem, DmaSel sel, int layer, int head, int tile,
                               uint32_t &addr_out) {
#pragma HLS INLINE off
    if (layer < 0) return false;
    switch (sel) {
        case DmaSel::DMASEL_WQ: {
            if (head < 0) return false;
            addr_out = ctrl_mem.wq_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(head) * ctrl_mem.wq_head_stride;
            return true;
        }
        case DmaSel::DMASEL_WK: {
            if (head < 0) return false;
            addr_out = ctrl_mem.wk_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(head) * ctrl_mem.wk_head_stride;
            return true;
        }
        case DmaSel::DMASEL_WV: {
            if (head < 0) return false;
            addr_out = ctrl_mem.wv_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(head) * ctrl_mem.wv_head_stride;
            return true;
        }
        case DmaSel::DMASEL_CTX_K: {
            if (head < 0) return false;
            addr_out = ctrl_mem.k_cache_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(head) * ctrl_mem.k_cache_stride;
            return true;
        }
        case DmaSel::DMASEL_CTX_V: {
            if (head < 0) return false;
            addr_out = ctrl_mem.v_cache_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(head) * ctrl_mem.v_cache_stride;
            return true;
        }
        case DmaSel::DMASEL_WO: {
            if (tile < 0) return false;
            addr_out = ctrl_mem.wo_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(tile) * ctrl_mem.wo_tile_stride;
            return true;
        }
        case DmaSel::DMASEL_W1: {
            if (tile < 0) return false;
            addr_out = ctrl_mem.w1_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(tile) * ctrl_mem.w1_tile_stride;
            return true;
        }
        case DmaSel::DMASEL_W2: {
            if (tile < 0) return false;
            addr_out = ctrl_mem.w2_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.layer_stride
                     + static_cast<uint32_t>(tile) * ctrl_mem.w2_tile_stride;
            return true;
        }
        case DmaSel::DMASEL_LN0: {
            addr_out = ctrl_mem.ln0_gamma_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.ln0_gamma_stride;
            return true;
        }
        case DmaSel::DMASEL_LN1: {
            addr_out = ctrl_mem.ln1_gamma_base_addr
                     + static_cast<uint32_t>(layer) * ctrl_mem.ln1_gamma_stride;
            return true;
        }
        case DmaSel::DMASEL_CONCAT:
        case DmaSel::DMASEL_WLOGIT:
        case DmaSel::DMASEL_NONE:
        case DmaSel::DMASEL_K_WRITE:
        case DmaSel::DMASEL_V_WRITE: {
            addr_out = 0;
            return true;
        }
        default: {
            return false;
        }
    }
}

static uint32_t calc_kv_write_addr(ControlMemSpace ctrl_mem, DmaSel sel, int layer, int head) {
#pragma HLS INLINE
    const uint32_t base = (sel == DMASEL_K_WRITE)
        ? static_cast<uint32_t>(ctrl_mem.k_cache_addr)
        : static_cast<uint32_t>(ctrl_mem.v_cache_addr);
    const uint32_t layer_stride = (ctrl_mem.layer_stride != 0)
        ? ctrl_mem.layer_stride
        : static_cast<uint32_t>(NUM_HEADS * CONTEXT_LENGTH * D_HEADS);
    const uint32_t head_stride = (sel == DMASEL_K_WRITE)
        ? ((ctrl_mem.k_cache_stride != 0) ? ctrl_mem.k_cache_stride
                                          : static_cast<uint32_t>(CONTEXT_LENGTH * D_HEADS))
        : ((ctrl_mem.v_cache_stride != 0) ? ctrl_mem.v_cache_stride
                                          : static_cast<uint32_t>(CONTEXT_LENGTH * D_HEADS));
    return base + static_cast<uint32_t>(layer) * layer_stride
                + static_cast<uint32_t>(head) * head_stride;
}

// ---------------------------------------------------------------------------
// Compute read population
// ---------------------------------------------------------------------------
static void zero_buf(uint8_t *buf, int n) {
    for (int i = 0; i < n; ++i) {
#pragma HLS PIPELINE II=1
        buf[i] = 0;
    }
}

static bool build_head_in_buf(ComputeOp op, int layer, int head,
                              uint8_t lane_buf[head_buf::IN_BUF_BYTES], bool &invalid_flag) {
#pragma HLS INLINE off
    zero_buf(lane_buf, head_buf::IN_BUF_BYTES);
    switch (op) {
        case CMP_Q: {
            bool ok = load_region_to_buf(Tag::LN0_OUT, layer, -1, -1,
                                         lane_buf, head_buf::INQkvLayout::ACT, head_buf::INQkvLayout::ACT_BYTES,
                                         false, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WQ_W, layer, head, -1,
                                    lane_buf, head_buf::INQkvLayout::W, head_buf::INQkvLayout::W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WQ_B, layer, head, -1,
                                      lane_buf, head_buf::INQkvLayout::B, head_buf::INQkvLayout::B_BYTES,
                                      true, invalid_flag);
        }
        case CMP_K: {
            bool ok = load_region_to_buf(Tag::LN0_OUT, layer, -1, -1,
                                         lane_buf, head_buf::INQkvLayout::ACT, head_buf::INQkvLayout::ACT_BYTES,
                                         false, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WK_W, layer, head, -1,
                                    lane_buf, head_buf::INQkvLayout::W, head_buf::INQkvLayout::W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WK_B, layer, head, -1,
                                      lane_buf, head_buf::INQkvLayout::B, head_buf::INQkvLayout::B_BYTES,
                                      true, invalid_flag);
        }
        case CMP_V: {
            bool ok = load_region_to_buf(Tag::LN0_OUT, layer, -1, -1,
                                         lane_buf, head_buf::INQkvLayout::ACT, head_buf::INQkvLayout::ACT_BYTES,
                                         false, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WV_W, layer, head, -1,
                                    lane_buf, head_buf::INQkvLayout::W, head_buf::INQkvLayout::W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WV_B, layer, head, -1,
                                      lane_buf, head_buf::INQkvLayout::B, head_buf::INQkvLayout::B_BYTES,
                                      true, invalid_flag);
        }
        case CMP_ATT_SCORES: {
            bool ok = load_region_to_buf(Tag::Q_OUT, layer, head, -1,
                                         lane_buf, head_buf::INAttScoresLayout::Q, head_buf::INAttScoresLayout::Q_BYTES,
                                         true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::CTX_K, layer, head, -1,
                                      lane_buf, head_buf::INAttScoresLayout::K_CACHE, head_buf::INAttScoresLayout::K_CACHE_BYTES,
                                      true, invalid_flag);
        }
        case CMP_VALUE_SCALE: {
            return load_region_to_buf(Tag::ATT_SCORES_OUT, layer, head, -1,
                                      lane_buf, head_buf::INValueScaleLayout::X, head_buf::INValueScaleLayout::X_BYTES,
                                      true, invalid_flag);
        }
        case CMP_SOFTMAX: {
            return load_region_to_buf(Tag::VALUE_SCALE_OUT, layer, head, -1,
                                      lane_buf, head_buf::INSoftmaxLayout::X, head_buf::INSoftmaxLayout::X_BYTES,
                                      true, invalid_flag);
        }
        case CMP_ATT_VALUE: {
            bool ok = load_region_to_buf(Tag::SOFTMAX_OUT, layer, head, -1,
                                         lane_buf, head_buf::INAttValueLayout::WEIGHTS, head_buf::INAttValueLayout::WEIGHTS_BYTES,
                                         true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::CTX_V, layer, head, -1,
                                      lane_buf, head_buf::INAttValueLayout::V_CACHE, head_buf::INAttValueLayout::V_CACHE_BYTES,
                                      true, invalid_flag);
        }
        case CMP_HEAD_REQUANT: {
            return load_region_to_buf(Tag::ATT_VALUE_OUT, layer, head, -1,
                                      lane_buf, head_buf::INHeadRequantLayout::X, head_buf::INHeadRequantLayout::X_BYTES,
                                      true, invalid_flag);
        }
        default: {
            mmu_set_invalid(ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED);
            invalid_flag = true;
            return false;
        }
    }
}

static bool build_main_in_buf(ComputeOp op, int layer, int tile,
                              uint8_t buf[compute_buf::IN_BUF_BYTES], bool &invalid_flag) {
#pragma HLS INLINE off
    zero_buf(buf, compute_buf::IN_BUF_BYTES);
    switch (op) {
        case CMP_LN0: {
            // Layer input:
            //  - layer 0: original streamed token
            //  - layer n>0: previous layer residual output
            Tag x_tag = Tag::STREAM_IN_TOKEN;
            int x_layer = 0;
            if (layer > 0) {
                x_tag = Tag::RESID1_OUT;
                x_layer = layer - 1;
            }

            bool ok = load_region_to_buf(x_tag, x_layer, -1, -1,
                                         buf, compute_buf::INLayerNormLayout::X,
                                         compute_buf::INLayerNormLayout::X_BYTES, false, invalid_flag);
            if (!ok) return false;
            if (MMU_USE_HARDCODED_LN_PARAMS) {
                // Default gamma=1.0 (Q19.13) and epsilon=1 for bring-up.
                for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                    compute_buf::write_i32(buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), 8192);
                }
                compute_buf::write_i32(buf, compute_buf::INLayerNormLayout::EPS, 1);
                return true;
            } else {
                ok = load_region_to_buf(Tag::LN0_GAMMA, layer, -1, -1,
                                        buf, compute_buf::INLayerNormLayout::GAMMA,
                                        compute_buf::INLayerNormLayout::GAMMA_BYTES, false, invalid_flag);
                if (!ok) return false;
                return load_region_to_buf(Tag::LN0_EPS, layer, -1, -1,
                                          buf, compute_buf::INLayerNormLayout::EPS,
                                          compute_buf::INLayerNormLayout::EPS_BYTES, false, invalid_flag);
            }
        }
        case CMP_CONCAT: {
            return load_region_to_buf(Tag::HEAD_REQUANT_PACKED, layer, -1, -1,
                                      buf, 0, D_MODEL, true, invalid_flag);
        }
        case CMP_OUT_PROJ: {
            const bool consume_concat_out =
                (tile >= 0) && (tile >= (NUM_WO_TILES - 1));
            bool ok = load_region_to_buf(Tag::CONCAT_OUT, layer, -1, -1,
                                         buf, compute_buf::INOutProjLayout::ACT,
                                         compute_buf::INOutProjLayout::ACT_BYTES, consume_concat_out, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WO_W, layer, -1, tile,
                                    buf, compute_buf::INOutProjLayout::W,
                                    compute_buf::INOutProjLayout::W_BYTES, true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WO_B, layer, -1, tile,
                                      buf, compute_buf::INOutProjLayout::B,
                                      compute_buf::INOutProjLayout::B_BYTES, true, invalid_flag);
        }
        case CMP_RESID1: {
            Tag x_tag = Tag::STREAM_IN_TOKEN;
            int x_layer = 0;
            if (layer > 0) {
                x_tag = Tag::RESID1_OUT;
                x_layer = layer - 1;
            }

            bool ok = load_region_to_buf(x_tag, x_layer, -1, -1,
                                         buf, compute_buf::INResidLayout::X,
                                         compute_buf::INResidLayout::X_BYTES, false, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::OUT_PROJ_PACKED, layer, -1, -1,
                                      buf, compute_buf::INResidLayout::R,
                                      compute_buf::INResidLayout::R_BYTES, true, invalid_flag);
        }
        case CMP_LN1: {
            bool ok = load_region_to_buf(Tag::RESID0_OUT, layer, -1, -1,
                                         buf, compute_buf::INLayerNormLayout::X,
                                         compute_buf::INLayerNormLayout::X_BYTES, false, invalid_flag);
            if (!ok) return false;
            if (MMU_USE_HARDCODED_LN_PARAMS) {
                for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                    compute_buf::write_i32(buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), 8192);
                }
                compute_buf::write_i32(buf, compute_buf::INLayerNormLayout::EPS, 1);
                return true;
            } else {
                ok = load_region_to_buf(Tag::LN1_GAMMA, layer, -1, -1,
                                        buf, compute_buf::INLayerNormLayout::GAMMA,
                                        compute_buf::INLayerNormLayout::GAMMA_BYTES, true, invalid_flag);
                if (!ok) return false;
                return load_region_to_buf(Tag::LN1_EPS, layer, -1, -1,
                                          buf, compute_buf::INLayerNormLayout::EPS,
                                          compute_buf::INLayerNormLayout::EPS_BYTES, true, invalid_flag);
            }
        }
        case CMP_FFN_W1: {
            bool ok = load_region_to_buf(Tag::LN1_OUT, layer, -1, -1,
                                         buf, compute_buf::INFfnW1Layout::X,
                                         compute_buf::INFfnW1Layout::X_BYTES, false, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::W1_W, layer, -1, tile,
                                    buf, compute_buf::INFfnW1Layout::W,
                                    compute_buf::INFfnW1Layout::W_BYTES, true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::W1_B, layer, -1, tile,
                                      buf, compute_buf::INFfnW1Layout::B,
                                      compute_buf::INFfnW1Layout::B_BYTES, true, invalid_flag);
        }
        case CMP_FFN_ACT: {
            return load_region_to_buf(Tag::FFN_W1_PACKED, layer, -1, -1,
                                      buf, compute_buf::INFfnActLayout::GATE,
                                      compute_buf::INFfnActLayout::TOTAL_BYTES, true, invalid_flag);
        }
        case CMP_FFN_W2: {
            const bool consume_ffn_act_out =
                (tile >= 0) && (tile >= (NUM_W2_TILES - 1));
            bool ok = load_region_to_buf(Tag::FFN_ACT_OUT, layer, -1, -1,
                                         buf, compute_buf::INFfnW2Layout::X,
                                         compute_buf::INFfnW2Layout::X_BYTES, consume_ffn_act_out, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::W2_W, layer, -1, tile,
                                    buf, compute_buf::INFfnW2Layout::W,
                                    compute_buf::INFfnW2Layout::W_BYTES, true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::W2_B, layer, -1, tile,
                                      buf, compute_buf::INFfnW2Layout::B,
                                      compute_buf::INFfnW2Layout::B_BYTES, true, invalid_flag);
        }
        case CMP_RESID2: {
            bool ok = load_region_to_buf(Tag::RESID0_OUT, layer, -1, -1,
                                         buf, compute_buf::INResidLayout::X,
                                         compute_buf::INResidLayout::X_BYTES, true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::FFN_W2_PACKED, layer, -1, -1,
                                      buf, compute_buf::INResidLayout::R,
                                      compute_buf::INResidLayout::R_BYTES, true, invalid_flag);
        }
        case CMP_FINAL_NORM: {
            bool ok = load_region_to_buf(Tag::RESID1_OUT, layer, -1, -1,
                                         buf, compute_buf::INLayerNormLayout::X,
                                         compute_buf::INLayerNormLayout::X_BYTES, false, invalid_flag);
            if (!ok) return false;
            if (MMU_USE_HARDCODED_LN_PARAMS) {
                for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                    compute_buf::write_i32(buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), 8192);
                }
                compute_buf::write_i32(buf, compute_buf::INLayerNormLayout::EPS, 1);
                return true;
            } else {
                ok = load_region_to_buf(Tag::LN0_GAMMA, layer, -1, -1,
                                        buf, compute_buf::INLayerNormLayout::GAMMA,
                                        compute_buf::INLayerNormLayout::GAMMA_BYTES, true, invalid_flag);
                if (!ok) return false;
                return load_region_to_buf(Tag::LN0_EPS, layer, -1, -1,
                                          buf, compute_buf::INLayerNormLayout::EPS,
                                          compute_buf::INLayerNormLayout::EPS_BYTES, true, invalid_flag);
            }
        }
        default: {
            mmu_set_invalid(ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED);
            invalid_flag = true;
            return false;
        }
    }
}

// ---------------------------------------------------------------------------
// State string
// ---------------------------------------------------------------------------
const char *state_name_local(State s) {
    switch (s) {
        case State::IDLE: {
            return "IDLE";
        }
        case State::DMA_POP: {
            return "DMA_POP";
        }
        case State::DMA_PREP: {
            return "DMA_PREP";
        }
        case State::DMA_ISSUE: {
            return "DMA_ISSUE";
        }
        case State::DMA_WAIT: {
            return "DMA_WAIT";
        }
        case State::DMA_STORE: {
            return "DMA_STORE";
        }
        case State::DMA_INTERNAL_CONCAT: {
            return "DMA_CONCAT";
        }
        case State::DMA_WRITEBACK_PREP: {
            return "DMA_WB_PREP";
        }
        case State::DMA_WRITEBACK_ISSUE: {
            return "DMA_WB_ISSUE";
        }
        case State::DMA_WRITEBACK_WAIT: {
            return "DMA_WB_WAIT";
        }
        case State::COMPUTE_POP: {
            return "CMP_POP";
        }
        case State::COMPUTE_READ_PREP: {
            return "CMP_RD_PREP";
        }
        case State::COMPUTE_READ_DONE: {
            return "CMP_RD_DONE";
        }
        case State::COMPUTE_WRITE_PREP: {
            return "CMP_WR_PREP";
        }
        case State::COMPUTE_WRITE_DONE: {
            return "CMP_WR_DONE";
        }
        case State::GC_SCAN: {
            return "GC_SCAN";
        }
        default: {
            return "?";
        }
    }
}

} // namespace

const char *state_name(State s) {
    return state_name_local(s);
}

// ---------------------------------------------------------------------------
// Top-level FSM
// ---------------------------------------------------------------------------
void mmu_fsm(
    // Control / configuration
    bool            reset_n,                        // [INPUT] Active-low reset
    ControlMemSpace ctrl_mem,                       // [INPUT] Control memory snapshot

    // External DMA control/payload
    bool            dma_ready,                      // [INPUT] DMA command interface ready
    bool            dma_done,                       // [INPUT] DMA completion pulse
    const uint8_t   dma_rx_buf[DMA_BUF_BYTES],      // [INPUT] DMA read payload into MMU
    uint8_t         dma_tx_buf[DMA_BUF_BYTES],      // [OUTPUT] DMA write payload from MMU
    bool            &dma_start,                     // [OUTPUT] Start DMA transfer
    uint32_t        &dma_addr,                      // [OUTPUT] DMA address
    uint32_t        &dma_len,                       // [OUTPUT] DMA transfer length
    bool            &dma_is_write,                  // [OUTPUT] DMA direction (1=MMU->DDR)

    // Stream ingress/egress buffers controlled by scheduler pulses
    bool            axis_in_ready,                  // [INPUT] Scheduler AXIS ingress ready flag
    bool            axis_in_start,                  // [INPUT] Scheduler pulse: stream-in payload complete
    bool            stream_start,                   // [INPUT] Scheduler pulse: begin stream-out payload
    const uint8_t   stream_in_buf[STREAM_IN_BUF_BYTES], // [INPUT] Constructed stream-in payload
    uint8_t         stream_out_buf[STREAM_OUT_BUF_BYTES], // [OUTPUT] Stream-out payload produced by MMU

    // Main scheduler DMA request (non-headed path)
    bool            mmu_dma_req_start,              // [INPUT] Main scheduler DMA request valid
    uint32_t        mmu_dma_instruction,            // [INPUT] Packed request [sel|layer|head|tile]
    bool            &mmu_req_ready,                 // [OUTPUT] MMU can accept new DMA request
    bool            &main_wl_accept,                // [OUTPUT] Main scheduler request accepted/captured
    bool            &main_dma_done,                 // [OUTPUT] Main scheduler DMA done pulse

    // Main compute request (non-headed path)
    bool            mem_read_request,               // [INPUT] Main compute read request
    bool            mem_write_request,              // [INPUT] Main compute write request
    uint32_t        mem_op,                         // [INPUT] Packed request [op|layer|head|tile]
    bool            &mem_transfer_done,             // [OUTPUT] Main compute transfer done pulse

    // Head contexts (headed scheduler + headed compute request signals)
    HeadCtx         (&head_ctx)[NUM_HEADS],         // [BOTH] Per-head scheduler handshake
    ComputeHeadCtx  (&head_compute_ctx)[HEADS_PARALLEL], // [BOTH] Per-lane headed compute handshake

    
    // BRAM compute buffers
    uint8_t in_buf[compute_buf::IN_BUF_BYTES],                              // [OUTPUT] MMU fills for main compute
    const uint8_t out_buf[compute_buf::OUT_BUF_BYTES],                      // [INPUT] MMU reads for main writeback
    uint8_t head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES],            // [OUTPUT] MMU fills headed buffers
    const uint8_t head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES],    // [INPUT] MMU reads headed outputs

    // Status
    Status &status                      // [OUTPUT] MMU internal state and errors
) {
#pragma HLS INLINE off
#pragma HLS ARRAY_PARTITION variable=head_in_buf complete dim=1
#pragma HLS ARRAY_PARTITION variable=head_out_buf complete dim=1
#pragma HLS ARRAY_PARTITION variable=head_ctx complete dim=1
#pragma HLS ARRAY_PARTITION variable=head_compute_ctx complete dim=1
#pragma HLS BIND_STORAGE variable=uram_banks type=ram_t2p impl=uram
#pragma HLS BIND_STORAGE variable=bank_offsets type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=dma_q type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=compute_q type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=regions type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=scratch type=ram_1p impl=bram

    // Default outputs
    dma_start = false;
    dma_addr = 0;
    dma_len = 0;
    dma_is_write = false;
    main_dma_done = false;
    mem_transfer_done = false;
    mmu_req_ready = (dma_q_count < DMA_QUEUE_DEPTH);
    if (!mmu_dma_req_start) {
        main_wl_accepted = false;
    }
    main_wl_accept = main_wl_accepted;
    for (int h = 0; h < NUM_HEADS; ++h) {
#pragma HLS UNROLL
        head_ctx[h].wl_ready = mmu_req_ready;
        if (!head_ctx[h].wl_start) {
            head_wl_accepted[h] = false;
        }
        head_ctx[h].wl_accept = head_wl_accepted[h];
        head_ctx[h].dma_done = false;
    }
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        head_compute_ctx[lane].mem_transfer_done = false;
    }

    if (!reset_n) {
        g_state = State::IDLE;
        g_overflow = false;
        g_invalid = false;
        g_error_code = ERR_NONE;
        g_active_bank = 0;
        region_count = 0;
        g_current_layer = -1;

        active_dma_valid = false;
        active_compute_valid = false;
        dma_q_head = dma_q_tail = dma_q_count = 0;
        compute_q_head = compute_q_tail = compute_q_count = 0;

        arb_current = -1;
        arb_rr_ptr = 0;
        arb_busy = false;
        for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
            arb_pending[i] = false;
            arb_grant[i] = false;
            head_wl_accepted[i] = false;
        }
        main_wl_accepted = false;
        prev_main_mem_req = false;
        prev_main_mem_op = 0;
        for (int i = 0; i < HEADS_PARALLEL; ++i) {
#pragma HLS UNROLL
            prev_head_mem_req[i] = false;
            prev_head_mem_op[i] = 0;
        }
        prev_axis_in_start = false;
        prev_stream_start = false;
        for (int i = 0; i < URAM_BANKS; ++i) {
            bank_offsets[i] = 0;
        }
        for (int i = 0; i < DMA_QUEUE_DEPTH; ++i) {
#pragma HLS UNROLL
            dma_q[i] = DmaQueueEntry{};
        }
        for (int i = 0; i < COMPUTE_QUEUE_DEPTH; ++i) {
#pragma HLS UNROLL
            compute_q[i] = ComputeQueueEntry{};
        }
        for (int i = 0; i < MAX_REGIONS; ++i) {
            regions[i] = Region{};
        }

        status.state = g_state;
        status.overflow = g_overflow;
        status.invalid = g_invalid;
        status.error_code = g_error_code;
        status.region_count = region_count;
        return;
    }

    const bool axis_in_start_edge = reset_n && axis_in_ready && axis_in_start && !prev_axis_in_start;
    if (axis_in_start_edge) {
        const int idx = get_or_create_region(
            Tag::STREAM_IN_TOKEN, 0, -1, -1,
            static_cast<uint32_t>(STREAM_IN_BUF_BYTES),
            1,
            static_cast<uint32_t>(STREAM_IN_BUF_BYTES),
            g_overflow);
        if (idx < 0) {
            mmu_set_overflow(ERR_MMU_REGION_OVERFLOW_STREAM_IN);
        } else if (!region_write_part(
                       idx,
                       0,
                       stream_in_buf,
                       static_cast<uint32_t>(STREAM_IN_BUF_BYTES))) {
            mmu_set_invalid(ERR_MMU_REGION_ACCESS);
        }
    }
    prev_axis_in_start = axis_in_start;

    const bool stream_start_edge = reset_n && stream_start && !prev_stream_start;
    if (stream_start_edge) {
        bool stream_invalid = false;
        zero_buf(stream_out_buf, STREAM_OUT_BUF_BYTES);
        const int out_layer = (NUM_LAYERS > 0) ? (NUM_LAYERS - 1) : 0;
        bool ok = load_region_partial_to_buf(
            Tag::FINAL_NORM_OUT,
            out_layer,
            -1,
            -1,
            stream_out_buf,
            0,
            static_cast<uint32_t>(STREAM_OUT_BUF_BYTES),
            false,
            stream_invalid);
        if (!ok) {
            // Fallback to layer 0 when single-layer test payloads are used.
            stream_invalid = false;
            ok = load_region_partial_to_buf(
                Tag::FINAL_NORM_OUT,
                0,
                -1,
                -1,
                stream_out_buf,
                0,
                static_cast<uint32_t>(STREAM_OUT_BUF_BYTES),
                false,
                stream_invalid);
        }
        if (!ok) {
            mmu_set_invalid(ERR_MMU_STREAM_OUTPUT_MISSING);
        }
    }
    prev_stream_start = stream_start;

    // Enqueue main DMA request.
    // Level handshake: MMU accepts when wl_start is high and holds wl_accept until wl_start drops.
    const bool main_dma_req_pending = reset_n && mmu_dma_req_start && !main_wl_accepted;
    if (main_dma_req_pending) {
        if (dma_q_count < DMA_QUEUE_DEPTH) {
            DmaSel sel = DMASEL_NONE;
            int layer = 0, head = -1, tile = -1;
            unpack_dma(mmu_dma_instruction, sel, layer, head, tile);
            const bool headed = is_headed_dma(sel);
            if (dma_q_push(mmu_dma_instruction, headed)) {
                main_wl_accepted = true;
                main_wl_accept = true;
            }
        }
    }

    // Enqueue per-head DMA requests via HeadCtx.
    // Level handshake: MMU accepts when wl_start is high and holds wl_accept until wl_start drops.
    for (int h = 0; h < NUM_HEADS; ++h) {
#pragma HLS UNROLL
        const bool head_dma_req_pending = reset_n && head_ctx[h].wl_start && !head_wl_accepted[h];
        if (head_dma_req_pending) {
            if (dma_q_count >= DMA_QUEUE_DEPTH) {
                continue;
            }
            DmaSel sel = DMASEL_NONE;
            int layer = 0, head = -1, tile = -1;
            unpack_dma(head_ctx[h].wl_instruction, sel, layer, head, tile);
            const bool headed = is_headed_dma(sel);
            if (!dma_q_push(head_ctx[h].wl_instruction, headed)) {
                continue;
            } else {
                head_wl_accepted[h] = true;
                head_ctx[h].wl_accept = true;
            }
        }
    }

    // Enqueue main compute request (edge-triggered).
    const bool main_mem_req = (mem_read_request || mem_write_request);
    const bool main_mem_req_edge = reset_n && main_mem_req &&
                                   (!prev_main_mem_req || (mem_op != prev_main_mem_op));
    if (main_mem_req_edge) {
        if (compute_q_count >= COMPUTE_QUEUE_DEPTH) {
            mmu_set_overflow(ERR_MMU_QUEUE_OVERFLOW);
        } else {
        ComputeOp op = ComputeOp::CMP_NONE;
        int layer = 0, head = -1, tile = -1;
        unpack_compute(mem_op, op, layer, head, tile);
        const bool headed = is_headed_compute(op);
        uint8_t req_head = 0;
        if (head >= 0 && head < NUM_HEADS) req_head = static_cast<uint8_t>(head);
        const ComputeReqType req_type = mem_read_request ? ComputeReqType::READ : ComputeReqType::WRITE;
        if (!compute_q_push(mem_op, req_type, headed, req_head)) {
            mmu_set_overflow(ERR_MMU_QUEUE_OVERFLOW);
        }
        }
    }

    // Enqueue headed compute requests via ComputeHeadCtx lanes.
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const bool req_read = head_compute_ctx[lane].mem_read_request;
        const bool req_write = head_compute_ctx[lane].mem_write_request;
        const bool req_active = (req_read || req_write);
        const bool lane_mem_req_edge =
            reset_n && req_active &&
            (!prev_head_mem_req[lane] || (head_compute_ctx[lane].mem_op != prev_head_mem_op[lane]));
        if (!lane_mem_req_edge) continue;
        if (compute_q_count >= COMPUTE_QUEUE_DEPTH) {
            mmu_set_overflow(ERR_MMU_QUEUE_OVERFLOW);
            continue;
        }

        ComputeOp op = ComputeOp::CMP_NONE;
        int layer = 0, head = -1, tile = -1;
        unpack_compute(head_compute_ctx[lane].mem_op, op, layer, head, tile);
        const bool headed = is_headed_compute(op);
        uint8_t req_head = static_cast<uint8_t>(lane);
        if (head >= 0 && head < NUM_HEADS) req_head = static_cast<uint8_t>(head);
        const ComputeReqType req_type = req_read ? ComputeReqType::READ : ComputeReqType::WRITE;
        if (!compute_q_push(head_compute_ctx[lane].mem_op, req_type, headed, req_head)) {
            mmu_set_overflow(ERR_MMU_QUEUE_OVERFLOW);
        }
    }

    // Update edge-detect latches.
    prev_main_mem_req = main_mem_req;
    prev_main_mem_op = mem_op;
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const bool req_active = head_compute_ctx[lane].mem_read_request || head_compute_ctx[lane].mem_write_request;
        prev_head_mem_req[lane] = req_active;
        prev_head_mem_op[lane] = head_compute_ctx[lane].mem_op;
    }

    // Arbitration progression
    arb_step();

    switch (g_state) {
        case State::IDLE: {
            if (dma_q_count > 0) {
                g_state = State::DMA_POP;
            } else if (compute_q_count > 0) {
                g_state = State::COMPUTE_POP;
            } else {
                g_state = State::GC_SCAN;
            }
            break;
        }
        case State::GC_SCAN: {
            gc_scan();
            g_state = State::IDLE;
            break;
        }
        case State::DMA_POP: {
            DmaQueueEntry q{};
            if (!active_dma_valid) {
                if (!dma_q_pop(q)) {
                    g_state = State::IDLE;
                    break;
                }
                active_dma_valid = true;
                active_dma_headed = q.headed;
                unpack_dma(q.packed, active_dma_sel, active_dma_layer, active_dma_head, active_dma_tile);
                on_layer_transition(active_dma_layer);
            }

            // No-op guard: ignore placeholder/no-request DMA entries.
            if (active_dma_sel == DMASEL_NONE) {
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            if (active_dma_headed && active_dma_head >= 0 && active_dma_head < NUM_HEADS) {
                arb_request(active_dma_head);
                arb_step();
                if (!arb_is_granted(active_dma_head)) {
                    break;
                }
            }

            if (active_dma_sel == DMASEL_K_WRITE || active_dma_sel == DMASEL_V_WRITE) {
                g_state = State::DMA_WRITEBACK_PREP;
            } else if (active_dma_sel == DMASEL_CONCAT) {
                g_state = State::DMA_INTERNAL_CONCAT;
            } else {
                g_state = State::DMA_PREP;
            }
            break;
        }
        case State::DMA_INTERNAL_CONCAT: {
            // Internal operation: build contiguous concat output from packed head requant output.
            const int src_idx = find_region(Tag::HEAD_REQUANT_PACKED, active_dma_layer, -1, -1);
            if (src_idx < 0 || !region_ready(regions[src_idx])) {
                mmu_set_invalid(ERR_MMU_CONCAT_SOURCE);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            const int dst_idx = get_or_create_region(
                Tag::CONCAT_OUT, active_dma_layer, -1, -1,
                static_cast<uint32_t>(D_MODEL), 1, static_cast<uint32_t>(D_MODEL), g_overflow);
            if (dst_idx < 0) {
                mmu_set_overflow(ERR_MMU_REGION_OVERFLOW_DMA_CONCAT);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            const uint32_t copy_bytes = (regions[src_idx].total_bytes < static_cast<uint32_t>(D_MODEL))
                ? regions[src_idx].total_bytes
                : static_cast<uint32_t>(D_MODEL);
            zero_buf(scratch, D_MODEL);
            if (!region_read_bytes(regions[src_idx], 0, scratch, copy_bytes)) {
                mmu_set_invalid(ERR_MMU_REGION_ACCESS);
            } else {
                if (!region_write_part(dst_idx, 0, scratch, static_cast<uint32_t>(D_MODEL))) {
                    mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                }
            }

            main_dma_done = true;
            if (active_dma_headed && active_dma_head >= 0 && active_dma_head < NUM_HEADS) {
                arb_release(active_dma_head);
                head_ctx[active_dma_head].dma_done = true;
            }
            active_dma_valid = false;
            g_state = State::IDLE;
            break;
        }
        case State::DMA_PREP: {
            if (!build_dma_piece_plan(active_dma_sel,
                                      active_piece_count, active_piece_bytes, active_piece_addr_off, active_piece_tag)) {
                mmu_set_invalid(ERR_MMU_UNSUPPORTED_REQ_DMA);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }
            if (active_piece_count == 0) {
                main_dma_done = true;
                if (active_dma_headed && active_dma_head >= 0 && active_dma_head < NUM_HEADS) {
                    head_ctx[active_dma_head].dma_done = true;
                    arb_release(active_dma_head);
                }
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            if (!calc_dma_base_addr(ctrl_mem, active_dma_sel, active_dma_layer, active_dma_head, active_dma_tile,
                                    active_dma_addr_base)) {
                mmu_set_invalid(ERR_MMU_BAD_DMA_ADDR);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }
            active_piece_idx = 0;
            g_state = State::DMA_ISSUE;
            break;
        }
        case State::DMA_ISSUE: {
            if (!dma_ready) break;
            const int piece_idx = static_cast<int>(active_piece_idx);
            const uint32_t sz = active_piece_bytes[piece_idx];
            if (sz > DMA_BUF_BYTES) {
                mmu_set_overflow(ERR_MMU_BAD_DMA_PLAN);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }
            dma_start = true;
            dma_is_write = false;
            dma_len = sz;
            if (active_dma_sel == DMASEL_LN0 && piece_idx == 1) {
                dma_addr = ctrl_mem.ln0_eps_base_addr
                         + static_cast<uint32_t>(active_dma_layer) * ctrl_mem.ln0_eps_stride;
            } else if (active_dma_sel == DMASEL_LN1 && piece_idx == 1) {
                dma_addr = ctrl_mem.ln1_eps_base_addr
                         + static_cast<uint32_t>(active_dma_layer) * ctrl_mem.ln1_eps_stride;
            } else {
                dma_addr = active_dma_addr_base + active_piece_addr_off[piece_idx];
            }
            g_state = State::DMA_WAIT;
            break;
        }
        case State::DMA_WAIT: {
            if (!dma_done) break;
            g_state = State::DMA_STORE;
            break;
        }
        case State::DMA_STORE: {
            const int piece_idx = static_cast<int>(active_piece_idx);
            const uint32_t sz = active_piece_bytes[piece_idx];
            const Tag tag = active_piece_tag[piece_idx];
            const int key_head = (tag == Tag::WQ_W || tag == Tag::WQ_B ||
                                  tag == Tag::WK_W || tag == Tag::WK_B ||
                                  tag == Tag::WV_W || tag == Tag::WV_B ||
                                  tag == Tag::CTX_K || tag == Tag::CTX_V)
                                 ? active_dma_head : -1;
            const int key_tile = (tag == Tag::WO_W || tag == Tag::WO_B ||
                                  tag == Tag::W1_W || tag == Tag::W1_B ||
                                  tag == Tag::W2_W || tag == Tag::W2_B)
                                 ? active_dma_tile : -1;

            const int idx = get_or_create_region(tag, active_dma_layer, key_head, key_tile,
                                                 sz, 1, sz, g_overflow);
            if (idx < 0) {
                mmu_set_overflow(ERR_MMU_REGION_OVERFLOW_DMA_STORE);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            if (!region_write_part(idx, 0, dma_rx_buf, sz)) {
                mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            active_piece_idx++;
            if (active_piece_idx < active_piece_count) {
                g_state = State::DMA_ISSUE;
            } else {
                main_dma_done = true;
                if (active_dma_headed && active_dma_head >= 0 && active_dma_head < NUM_HEADS) {
                    head_ctx[active_dma_head].dma_done = true;
                    arb_release(active_dma_head);
                }
                active_dma_valid = false;
                g_state = State::IDLE;
            }
            break;
        }
        case State::DMA_WRITEBACK_PREP: {
            // K/V writeback source comes from per-head K_OUT/V_OUT artifacts.
            const Tag src_tag = (active_dma_sel == DMASEL_K_WRITE) ? Tag::K_OUT : Tag::V_OUT;
            const int src_idx = find_region(src_tag, active_dma_layer, active_dma_head, -1);
            if (src_idx < 0 || !region_ready(regions[src_idx])) {
                mmu_set_invalid(ERR_MMU_WRITEBACK_SRC);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }
            const uint32_t wb_len = static_cast<uint32_t>(D_HEADS);
            if (wb_len > DMA_BUF_BYTES) {
                mmu_set_overflow(ERR_MMU_BAD_DMA_PLAN);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }
            if (!region_read_bytes(regions[src_idx], 0, dma_tx_buf, wb_len)) {
                mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }
            active_dma_addr_base = calc_kv_write_addr(ctrl_mem, active_dma_sel, active_dma_layer,
                                                      active_dma_head);
            active_piece_idx = 0;
            active_piece_count = 1;
            active_piece_bytes[0] = wb_len;
            g_state = State::DMA_WRITEBACK_ISSUE;
            break;
        }
        case State::DMA_WRITEBACK_ISSUE: {
            if (!dma_ready) break;
            dma_start = true;
            dma_is_write = true;
            dma_addr = active_dma_addr_base;
            dma_len = active_piece_bytes[0];
            g_state = State::DMA_WRITEBACK_WAIT;
            break;
        }
        case State::DMA_WRITEBACK_WAIT: {
            if (!dma_done) break;
            const Tag src_tag = (active_dma_sel == DMASEL_K_WRITE) ? Tag::K_OUT : Tag::V_OUT;
            const int src_idx = find_region(src_tag, active_dma_layer, active_dma_head, -1);
            if (src_idx >= 0 && should_consume(src_tag)) {
                maybe_consume(src_idx);
            }
            main_dma_done = true;
            if (active_dma_headed && active_dma_head >= 0 && active_dma_head < NUM_HEADS) {
                head_ctx[active_dma_head].dma_done = true;
                arb_release(active_dma_head);
            }
            active_dma_valid = false;
            g_state = State::IDLE;
            break;
        }
        case State::COMPUTE_POP: {
            ComputeQueueEntry q{};
            if (!active_compute_valid) {
                if (!compute_q_pop(q)) {
                    g_state = State::IDLE;
                    break;
                }
                active_compute_valid = true;
                active_compute_headed = q.headed;
                active_compute_type = q.type;
                unpack_compute(q.packed, active_compute_op, active_compute_layer, active_compute_head, active_compute_tile);
                on_layer_transition(active_compute_layer);
                if (active_compute_head < 0 && q.head < NUM_HEADS) {
                    active_compute_head = q.head;
                }
            }

            // No-op guard: ignore placeholder/no-request compute entries.
            if (active_compute_op == ComputeOp::CMP_NONE) {
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }

            // These ops are intentionally disabled in MMU compute path.
            // Reformat/concat is done by DMASEL_CONCAT internal DMA flow.
            if (is_disabled_compute_op(active_compute_op)) {
                if (active_compute_headed && active_compute_head >= 0 && active_compute_head < NUM_HEADS) {
                    signal_head_compute_done(head_compute_ctx, active_compute_head);
                } else {
                    mem_transfer_done = true;
                }
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }

            if (active_compute_headed && active_compute_head >= 0 && active_compute_head < NUM_HEADS) {
                arb_request(active_compute_head);
                arb_step();
                if (!arb_is_granted(active_compute_head)) break;
            }

            if (active_compute_type == ComputeReqType::READ) {
                g_state = State::COMPUTE_READ_PREP;
            } else if (active_compute_type == ComputeReqType::WRITE) {
                g_state = State::COMPUTE_WRITE_PREP;
            } else {
                mmu_set_invalid(active_compute_headed
                    ? ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED
                    : ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED);
                active_compute_valid = false;
                g_state = State::IDLE;
            }
            break;
        }
        case State::COMPUTE_READ_PREP: {
            bool ok = false;
            if (active_compute_headed) {
                const int lane = head_to_lane(active_compute_head);
                ok = build_head_in_buf(active_compute_op, active_compute_layer, active_compute_head,
                                       head_in_buf[lane], g_invalid);
            } else {
                ok = build_main_in_buf(active_compute_op, active_compute_layer, active_compute_tile,
                                       in_buf, g_invalid);
            }
            if (!ok) {
                if (g_error_code == ERR_NONE) {
                    mmu_set_invalid(ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP);
                }
                active_compute_valid = false;
                if (active_compute_headed) arb_release(active_compute_head);
                g_state = State::IDLE;
                break;
            }
            g_state = State::COMPUTE_READ_DONE;
            break;
        }
        case State::COMPUTE_READ_DONE: {
            if (active_compute_headed && active_compute_head >= 0 && active_compute_head < NUM_HEADS) {
                signal_head_compute_done(head_compute_ctx, active_compute_head);
                arb_release(active_compute_head);
            } else {
                mem_transfer_done = true;
            }
            active_compute_valid = false;
            g_state = State::IDLE;
            break;
        }
        case State::COMPUTE_WRITE_PREP: {
            const bool headed = active_compute_headed;
            const WriteSpec spec = build_write_spec(active_compute_op, headed, active_compute_head, active_compute_tile);

            const int idx = get_or_create_region(
                spec.tag, active_compute_layer, spec.key_head, spec.key_tile,
                spec.total_bytes, spec.expected_parts, spec.part_bytes, g_overflow);
            if (idx < 0) {
                mmu_set_overflow(ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE);
                active_compute_valid = false;
                if (active_compute_headed) arb_release(active_compute_head);
                g_state = State::IDLE;
                break;
            }

            bool write_ok = false;
            if (headed) {
                const int lane = head_to_lane(active_compute_head);
                write_ok = region_write_part(idx, spec.part_idx, head_out_buf[lane], spec.part_bytes);
            } else {
                write_ok = region_write_part(idx, spec.part_idx, out_buf, spec.part_bytes);
            }

            if (!write_ok) {
                mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                active_compute_valid = false;
                if (active_compute_headed) arb_release(active_compute_head);
                g_state = State::IDLE;
                break;
            }

            g_state = State::COMPUTE_WRITE_DONE;
            break;
        }
        case State::COMPUTE_WRITE_DONE: {
            if (active_compute_headed && active_compute_head >= 0 && active_compute_head < NUM_HEADS) {
                signal_head_compute_done(head_compute_ctx, active_compute_head);
                arb_release(active_compute_head);
            } else {
                mem_transfer_done = true;
            }
            active_compute_valid = false;
            g_state = State::IDLE;
            break;
        }
        default:
            g_state = State::IDLE;
            break;
    }

    status.state = g_state;
    status.overflow = g_overflow;
    status.invalid = g_invalid;
    status.error_code = g_error_code;
    status.region_count = region_count;

}
