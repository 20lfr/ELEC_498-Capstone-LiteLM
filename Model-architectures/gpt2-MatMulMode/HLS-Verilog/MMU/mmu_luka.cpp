#include "mmu_luka.hpp"
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

namespace {

constexpr int MAX_DMA_PIECES = 3;

struct DmaQueueEntry {
    bool valid = false;
    uint64_t packed = 0;
    bool headed = false;
    int8_t lane = -1;
};

struct ComputeQueueEntry {
    bool valid = false;
    uint64_t packed = 0;
    ComputeReqType type = ComputeReqType::NONE;
    bool headed = false;
    uint8_t head = 0;
    int8_t lane = -1;
};

constexpr int MAX_FREE_SPANS_PER_BANK = MAX_REGIONS;

struct FreeSpan {
    uint32_t offset = 0;
    uint32_t size = 0;
};

// ---------------------------------------------------------------------------
// Static memory resources
// ---------------------------------------------------------------------------
static axi_gmem_word_t uram_banks[URAM_BANKS][URAM_BANK_WORDS];

static uint32_t bank_offsets[URAM_BANKS];
static FreeSpan free_spans[URAM_BANKS][MAX_FREE_SPANS_PER_BANK];
static uint16_t free_span_count[URAM_BANKS];
static uint8_t main_x_slot[STREAM_IN_BUF_BYTES];
static bool main_x_slot_valid = false;

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

static State g_state = State::IDLE;
static bool g_overflow = false;
static bool g_invalid = false;
static uint32_t g_error_code = ERR_NONE;
static uint32_t g_error_subcode = MMU_ERR_SUBCODE_NONE;
static uint8_t g_active_bank = 0;

// Active DMA request context
static bool active_dma_valid = false;
static bool active_dma_headed = false;
static DmaSel active_dma_sel = DMASEL_NONE;
static int active_dma_layer = 0;
static int active_dma_head = -1;
static int active_dma_lane = -1;
static int active_dma_tile = -1;
static uint64_t active_dma_addr_base = 0;
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
static int active_compute_lane = -1;
static int active_compute_tile = -1;

// Edge-detect latches so level-style requests do not enqueue repeatedly.
static bool main_wl_accepted = false;
static bool prev_main_mem_req = false;
static uint64_t prev_main_mem_op = 0;
static bool stream_in_capturing = false;
static uint16_t stream_in_write_idx = 0;
static uint8_t stream_in_capture_buf[STREAM_IN_BUF_BYTES];
static bool prev_stream_start = false;
static bool prev_ctrl_start = false;
static int g_current_layer = -1;

// Scratch buffer for region copy/construction
static uint8_t scratch[DMA_BUF_BYTES];
static uint32_t active_piece_bytes_done = 0;
static uint32_t active_chunk_bytes = 0;
static bool active_dma_pad_zero = false;

#ifndef __SYNTHESIS__
// C-sim-only trace budget for verbose strided CTX_V DMA issue addresses.
// Reset on each DMA_PREP of a CTX_V request to avoid log explosion.
static uint8_t trace_ctx_v_issue_budget = 0;
#endif

// ---------------------------------------------------------------------------
// Utility
// ---------------------------------------------------------------------------
static inline int decode_s8(uint32_t v) {
    return static_cast<int>(static_cast<int8_t>(v & 0xFFu));
}

// Instruction packing format (64 bits):
//   bits [7:0]   = op    (8-bit unsigned)
//   bits [15:8]  = layer (8-bit signed via decode_s8, covers -1..11)
//   bits [23:16] = head  (8-bit signed via decode_s8, covers -1..11)
//   bits [55:24] = tile  (32-bit unsigned, covers 0..12799 and beyond)

static inline uint8_t dma_word_get_byte(const uint32_t *buf, uint32_t byte_idx) {
#pragma HLS INLINE
    const uint32_t word = buf[byte_idx / static_cast<uint32_t>(AXI_GMEM_WORD_BYTES)];
    const uint32_t shift = (byte_idx % static_cast<uint32_t>(AXI_GMEM_WORD_BYTES)) << 3;
    return static_cast<uint8_t>((word >> shift) & 0xFFu);
}

static inline void dma_word_set_byte(uint32_t *buf, uint32_t byte_idx, uint8_t value) {
#pragma HLS INLINE
    const uint32_t word_idx = byte_idx / static_cast<uint32_t>(AXI_GMEM_WORD_BYTES);
    const uint32_t shift = (byte_idx % static_cast<uint32_t>(AXI_GMEM_WORD_BYTES)) << 3;
    uint32_t word = buf[word_idx];
    word &= ~(0xFFu << shift);
    word |= (static_cast<uint32_t>(value) << shift);
    buf[word_idx] = word;
}

static inline void dma_word_clear_bytes(uint32_t *buf, uint32_t bytes) {
    const uint32_t words =
        (bytes + static_cast<uint32_t>(AXI_GMEM_WORD_BYTES - 1))
        / static_cast<uint32_t>(AXI_GMEM_WORD_BYTES);
    for (uint32_t i = 0; i < words; ++i) {
// #pragma HLS PIPELINE II=1
        buf[i] = 0;
    }
}

static inline uint32_t mmu_subcode_from_errbit(uint32_t err_bit) {
#pragma HLS INLINE
    switch (err_bit) {
        case ERR_MMU_UNSUPPORTED_REQ_DMA: return MMU_ERR_SUBCODE_UNSUPPORTED_REQ_DMA;
        case ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED: return MMU_ERR_SUBCODE_UNSUPPORTED_REQ_COMPUTE_HEADED;
        case ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED: return MMU_ERR_SUBCODE_UNSUPPORTED_REQ_COMPUTE_NONHEADED;
        case ERR_MMU_BAD_DMA_PLAN: return MMU_ERR_SUBCODE_BAD_DMA_PLAN;
        case ERR_MMU_BAD_DMA_ADDR: return MMU_ERR_SUBCODE_BAD_DMA_ADDR;
        case ERR_MMU_REGION_ACCESS: return MMU_ERR_SUBCODE_REGION_ACCESS;
        case ERR_MMU_CONCAT_SOURCE: return MMU_ERR_SUBCODE_CONCAT_SOURCE;
        case ERR_MMU_WRITEBACK_SRC: return MMU_ERR_SUBCODE_WRITEBACK_SRC;
        case ERR_MMU_QUEUE_OVERFLOW: return MMU_ERR_SUBCODE_QUEUE_OVERFLOW;
        case ERR_MMU_STREAM_OUTPUT_MISSING: return MMU_ERR_SUBCODE_STREAM_OUTPUT_MISSING;
        case ERR_MMU_MISSING_REGION_FULL_READ: return MMU_ERR_SUBCODE_MISSING_REGION_FULL_READ;
        case ERR_MMU_MISSING_REGION_PARTIAL_READ: return MMU_ERR_SUBCODE_MISSING_REGION_PARTIAL_READ;
        case ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP: return MMU_ERR_SUBCODE_MISSING_REGION_COMPUTE_READ_PREP;
        case ERR_MMU_REGION_OVERFLOW_STREAM_IN: return MMU_ERR_SUBCODE_REGION_OVERFLOW_STREAM_IN;
        case ERR_MMU_REGION_OVERFLOW_DMA_CONCAT: return MMU_ERR_SUBCODE_REGION_OVERFLOW_DMA_CONCAT;
        case ERR_MMU_REGION_OVERFLOW_DMA_STORE: return MMU_ERR_SUBCODE_REGION_OVERFLOW_DMA_STORE;
        case ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE: return MMU_ERR_SUBCODE_REGION_OVERFLOW_COMPUTE_WRITE;
        case ERR_MMU_REGION_TABLE_FULL: return MMU_ERR_SUBCODE_REGION_TABLE_FULL;
        case ERR_MMU_URAM_CHUNK_ALLOC_FAIL: return MMU_ERR_SUBCODE_URAM_CHUNK_ALLOC_FAIL;
        case ERR_MMU_REGION_TOO_LARGE: return MMU_ERR_SUBCODE_REGION_TOO_LARGE;
        case ERR_MMU_REGION_OVERFLOW: return MMU_ERR_SUBCODE_REGION_OVERFLOW_GENERIC;
        default: return MMU_ERR_SUBCODE_NONE;
    }
}

static inline uint32_t mmu_missing_subcode_from_tag(Tag tag) {
#pragma HLS INLINE
    switch (tag) {
        case Tag::STREAM_IN_TOKEN: return MMU_ERR_SUBCODE_MISSING_STREAM_IN_TOKEN;
        case Tag::LN0_OUT: return MMU_ERR_SUBCODE_MISSING_LN0_OUT;
        case Tag::WQ_W: return MMU_ERR_SUBCODE_MISSING_WQ_W;
        case Tag::WQ_B: return MMU_ERR_SUBCODE_MISSING_WQ_B;
        case Tag::WK_W: return MMU_ERR_SUBCODE_MISSING_WK_W;
        case Tag::WK_B: return MMU_ERR_SUBCODE_MISSING_WK_B;
        case Tag::WV_W: return MMU_ERR_SUBCODE_MISSING_WV_W;
        case Tag::WV_B: return MMU_ERR_SUBCODE_MISSING_WV_B;
        case Tag::Q_OUT: return MMU_ERR_SUBCODE_MISSING_Q_OUT;
        case Tag::CTX_K: return MMU_ERR_SUBCODE_MISSING_CTX_K;
        case Tag::ATT_SCORES_OUT: return MMU_ERR_SUBCODE_MISSING_ATT_SCORES_OUT;
        case Tag::VALUE_SCALE_OUT: return MMU_ERR_SUBCODE_MISSING_VALUE_SCALE_OUT;
        case Tag::SOFTMAX_OUT: return MMU_ERR_SUBCODE_MISSING_SOFTMAX_OUT;
        case Tag::CTX_V: return MMU_ERR_SUBCODE_MISSING_CTX_V;
        case Tag::ATT_VALUE_OUT: return MMU_ERR_SUBCODE_MISSING_ATT_VALUE_OUT;
        case Tag::HEAD_REQUANT_PACKED: return MMU_ERR_SUBCODE_MISSING_HEAD_REQUANT_PACKED;
        case Tag::CONCAT_OUT: return MMU_ERR_SUBCODE_MISSING_CONCAT_OUT;
        case Tag::WO_W: return MMU_ERR_SUBCODE_MISSING_WO_W;
        case Tag::WO_B: return MMU_ERR_SUBCODE_MISSING_WO_B;
        case Tag::OUT_PROJ_PACKED: return MMU_ERR_SUBCODE_MISSING_OUT_PROJ_PACKED;
        case Tag::RESID1_OUT: return MMU_ERR_SUBCODE_MISSING_RESID1_OUT;
        case Tag::LN1_OUT: return MMU_ERR_SUBCODE_MISSING_LN1_OUT;
        case Tag::W1_W: return MMU_ERR_SUBCODE_MISSING_W1_W;
        case Tag::W1_B: return MMU_ERR_SUBCODE_MISSING_W1_B;
        case Tag::FFN_W1_PACKED: return MMU_ERR_SUBCODE_MISSING_FFN_W1_PACKED;
        case Tag::FFN_ACT_OUT: return MMU_ERR_SUBCODE_MISSING_FFN_ACT_OUT;
        case Tag::W2_W: return MMU_ERR_SUBCODE_MISSING_W2_W;
        case Tag::W2_B: return MMU_ERR_SUBCODE_MISSING_W2_B;
        case Tag::FFN_W2_PACKED: return MMU_ERR_SUBCODE_MISSING_FFN_W2_PACKED;
        case Tag::RESID2_OUT: return MMU_ERR_SUBCODE_MISSING_RESID2_OUT;
        case Tag::LOGITS_W: return MMU_ERR_SUBCODE_MISSING_LOGITS_W;
        case Tag::LOGITS_PACKED: return MMU_ERR_SUBCODE_MISSING_LOGITS_PACKED;
        case Tag::ARGMAX_OUT: return MMU_ERR_SUBCODE_MISSING_ARGMAX_OUT;
        case Tag::LN0_GAMMA: return MMU_ERR_SUBCODE_MISSING_LN0_GAMMA;
        case Tag::LN0_BETA: return MMU_ERR_SUBCODE_MISSING_LN0_BETA;
        case Tag::LN0_EPS: return MMU_ERR_SUBCODE_MISSING_LN0_EPS;
        case Tag::LN1_GAMMA: return MMU_ERR_SUBCODE_MISSING_LN1_GAMMA;
        case Tag::LN1_BETA: return MMU_ERR_SUBCODE_MISSING_LN1_BETA;
        case Tag::LN1_EPS: return MMU_ERR_SUBCODE_MISSING_LN1_EPS;
        case Tag::FINAL_NORM_GAMMA: return MMU_ERR_SUBCODE_MISSING_FINAL_NORM_GAMMA;
        case Tag::FINAL_NORM_BETA: return MMU_ERR_SUBCODE_MISSING_FINAL_NORM_BETA;
        case Tag::FINAL_NORM_EPS: return MMU_ERR_SUBCODE_MISSING_FINAL_NORM_EPS;
        default: return MMU_ERR_SUBCODE_NONE;
    }
}

static inline void mmu_latch_subcode(uint32_t err_subcode) {
#pragma HLS INLINE
    if (g_error_subcode == MMU_ERR_SUBCODE_NONE && err_subcode != MMU_ERR_SUBCODE_NONE) {
        g_error_subcode = err_subcode;
    }
}

static inline void mmu_set_invalid(uint32_t err_bit, uint32_t err_subcode = MMU_ERR_SUBCODE_NONE) {
#pragma HLS INLINE
    g_invalid = true;
    g_error_code |= err_bit;
    if (err_subcode == MMU_ERR_SUBCODE_NONE) {
        err_subcode = mmu_subcode_from_errbit(err_bit);
    }
    mmu_latch_subcode(err_subcode);
}

static inline void mmu_set_overflow(uint32_t err_bit, uint32_t err_subcode = MMU_ERR_SUBCODE_NONE) {
#pragma HLS INLINE
    g_overflow = true;
    g_error_code |= err_bit;
    if (err_subcode == MMU_ERR_SUBCODE_NONE) {
        err_subcode = mmu_subcode_from_errbit(err_bit);
    }
    mmu_latch_subcode(err_subcode);
}

static inline void unpack_dma(uint64_t packed, DmaSel &sel, int &layer, int &head, int &tile) {
#pragma HLS INLINE
    sel   = static_cast<DmaSel>(packed & 0xFFu);
    layer = decode_s8((packed >> 8)  & 0xFFu);
    head  = decode_s8((packed >> 16) & 0xFFu);
    tile  = static_cast<int>((packed >> 24) & 0xFFFFFFFFull);
}

static inline void unpack_compute(uint64_t packed, ComputeOp &op, int &layer, int &head, int &tile) {
#pragma HLS INLINE
    op    = static_cast<ComputeOp>(packed & 0xFFu);
    layer = decode_s8((packed >> 8)  & 0xFFu);
    head  = decode_s8((packed >> 16) & 0xFFu);
    tile  = static_cast<int>((packed >> 24) & 0xFFFFFFFFull);
}

static inline bool is_disabled_compute_op(ComputeOp /*op*/) {
#pragma HLS INLINE
    return false;
}

static inline bool dma_uses_kv_cache(DmaSel sel) {
#pragma HLS INLINE
    return (sel == DMASEL_CTX_K) ||
           (sel == DMASEL_CTX_V);
}

static inline uint32_t main_op_out_bytes(ComputeOp op) {
#pragma HLS INLINE off
    switch (op) {
        case CMP_OUT_PROJ: {
            return compute_buf::OUTOutProjLayout::TOTAL_BYTES;
        }
        case CMP_FFN_W1: {
            return compute_buf::OUTFfnW1Layout::TOTAL_BYTES;
        }
        case CMP_FFN_W2: {
            return compute_buf::OUTFfnW2Layout::TOTAL_BYTES;
        }
        case CMP_LOGITS: {
            return compute_buf::OUTLogitsLayout::TOTAL_BYTES;
        }
        default: {
            return compute_buf::OUT_BUF_BYTES;
        }
    }
}

static inline uint8_t default_retain(Tag tag) {
#pragma HLS INLINE off
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
        case Tag::LOGITS_W:
        case Tag::CTX_K:
        case Tag::CTX_V:
        case Tag::LN1_GAMMA:
        case Tag::LN1_BETA:
        case Tag::LN1_EPS: {
            return 1; // single-use DMA payloads
        }
        case Tag::FINAL_NORM_GAMMA:
        case Tag::FINAL_NORM_BETA:
        case Tag::FINAL_NORM_EPS: {
            return 1; // single-use terminal norm params
        }
        case Tag::LN0_GAMMA:
        case Tag::LN0_BETA:
        case Tag::LN0_EPS: {
            return 1; // single-use LN0 params
        }
        case Tag::STREAM_IN_TOKEN:
        case Tag::RESID2_OUT: {
            return 1; // fixed-slot artifacts are not expected to persist as dynamic regions
        }
        case Tag::RESID1_OUT:
        case Tag::LN0_OUT:
        case Tag::LN1_OUT:
        case Tag::OUT_PROJ_PACKED:
        case Tag::FFN_W1_PACKED:
        case Tag::FFN_ACT_OUT:
        case Tag::FFN_W2_PACKED:
        case Tag::LOGITS_PACKED:
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
#pragma HLS INLINE off
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
        case Tag::LOGITS_W:
        case Tag::CTX_K:
        case Tag::CTX_V:
        case Tag::LN0_GAMMA:
        case Tag::LN0_BETA:
        case Tag::LN0_EPS:
        case Tag::LN1_GAMMA:
        case Tag::LN1_BETA:
        case Tag::LN1_EPS:
        case Tag::FINAL_NORM_GAMMA:
        case Tag::FINAL_NORM_BETA:
        case Tag::FINAL_NORM_EPS:
        case Tag::HEAD_REQUANT_PACKED:
        case Tag::CONCAT_OUT:
        case Tag::OUT_PROJ_PACKED:
        case Tag::FFN_W1_PACKED:
        case Tag::FFN_ACT_OUT:
        case Tag::FFN_W2_PACKED:
        case Tag::LOGITS_PACKED:
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

static inline void clear_chunk(Chunk &ck) {
#pragma HLS INLINE
    ck.bank = 0;
    ck.offset = 0;
    ck.size = 0;
}

static void free_span_remove(uint8_t bank, int idx) {
#pragma HLS INLINE
    const int bank_i = static_cast<int>(bank);
    if (idx < 0 || idx >= free_span_count[bank_i]) return;
    for (int i = idx; i < (free_span_count[bank_i] - 1); ++i) {
        free_spans[bank_i][i] = free_spans[bank_i][i + 1];
    }
    free_spans[bank_i][free_span_count[bank_i] - 1] = FreeSpan{};
    free_span_count[bank_i]--;
}

static void free_span_compact_and_coalesce(uint8_t bank) {
#pragma HLS INLINE off
    const int bank_i = static_cast<int>(bank);
    const int count = free_span_count[bank_i];
    if (count <= 1) return;

    FreeSpan merged_spans[MAX_FREE_SPANS_PER_BANK];

    for (int i = 1; i < count; ++i) {
        const FreeSpan cur = free_spans[bank_i][i];
        int j = i - 1;
        while (j >= 0 && free_spans[bank_i][j].offset > cur.offset) {
            free_spans[bank_i][j + 1] = free_spans[bank_i][j];
            --j;
        }
        free_spans[bank_i][j + 1] = cur;
    }

    int write_idx = 0;
    for (int i = 0; i < count; ++i) {
        const FreeSpan cur = free_spans[bank_i][i];
        if (cur.size == 0) continue;
        if (write_idx == 0) {
            merged_spans[write_idx++] = cur;
            continue;
        }
        FreeSpan &prev = merged_spans[write_idx - 1];
        const uint32_t prev_end = prev.offset + prev.size;
        const uint32_t cur_end = cur.offset + cur.size;
        if (cur.offset <= prev_end) {
            if (cur_end > prev_end) {
                prev.size = cur_end - prev.offset;
            }
        } else {
            merged_spans[write_idx++] = cur;
        }
    }

    for (int i = 0; i < write_idx; ++i) {
        free_spans[bank_i][i] = merged_spans[i];
    }
    for (int i = write_idx; i < count; ++i) {
        free_spans[bank_i][i] = FreeSpan{};
    }
    free_span_count[bank_i] = static_cast<uint16_t>(write_idx);
}

static bool free_span_add(uint8_t bank, uint32_t offset, uint32_t size) {
#pragma HLS INLINE off
    if (size == 0) return true;
    const int bank_i = static_cast<int>(bank);
    if (free_span_count[bank_i] >= MAX_FREE_SPANS_PER_BANK) {
        return false;
    }
    free_spans[bank_i][free_span_count[bank_i]].offset = offset;
    free_spans[bank_i][free_span_count[bank_i]].size = size;
    free_span_count[bank_i]++;
    free_span_compact_and_coalesce(bank);
    return true;
}

static bool reclaim_chunk(const Chunk &ck) {
#pragma HLS INLINE
    if (ck.size == 0) return true;
    return free_span_add(ck.bank, ck.offset, ck.size);
}

static bool reclaim_region_chunks(Region &r) {
#pragma HLS INLINE off
    for (int i = 0; i < MAX_CHUNKS; ++i) {
        if (i >= r.num_chunks) break;
        if (!reclaim_chunk(r.chunks[i])) {
            return false;
        }
        clear_chunk(r.chunks[i]);
    }
    r.num_chunks = 0;
    return true;
}

static int free_span_find_first_fit(uint8_t bank, uint32_t need_bytes) {
#pragma HLS INLINE
    const int bank_i = static_cast<int>(bank);
    for (int i = 0; i < free_span_count[bank_i]; ++i) {
        if (free_spans[bank_i][i].size >= need_bytes) {
            return i;
        }
    }
    return -1;
}

static bool allocate_from_free_span(uint8_t bank, int span_idx, uint32_t bytes, Chunk &chunk) {
#pragma HLS INLINE
    const int bank_i = static_cast<int>(bank);
    if (span_idx < 0 || span_idx >= free_span_count[bank_i]) return false;
    if (bytes == 0 || free_spans[bank_i][span_idx].size < bytes) return false;
    chunk.bank = bank;
    chunk.offset = free_spans[bank_i][span_idx].offset;
    chunk.size = bytes;
    free_spans[bank_i][span_idx].offset += bytes;
    free_spans[bank_i][span_idx].size -= bytes;
    if (free_spans[bank_i][span_idx].size == 0) {
        free_span_remove(bank, span_idx);
    }
    return true;
}

static bool allocate_from_bank_tail(uint8_t bank, uint32_t bytes, Chunk &chunk) {
#pragma HLS INLINE
    const int bank_i = static_cast<int>(bank);
    const uint32_t off = bank_offsets[bank_i];
    if (bytes == 0 || off >= URAM_BANK_BYTES) return false;
    const uint32_t space = URAM_BANK_BYTES - off;
    if (space < bytes) return false;
    chunk.bank = bank;
    chunk.offset = off;
    chunk.size = bytes;
    bank_offsets[bank_i] = off + bytes;
    return true;
}

static bool allocate_chunk_first_fit(uint32_t remaining, Chunk &chunk) {
#pragma HLS INLINE off
    if (remaining == 0) return false;

    for (int pass = 0; pass < 2; ++pass) {
        for (int i = 0; i < URAM_BANKS; ++i) {
            const uint8_t bank = static_cast<uint8_t>((g_active_bank + i) % URAM_BANKS);
            const int bank_i = static_cast<int>(bank);
            const int fit_idx = free_span_find_first_fit(bank, remaining);
            if (fit_idx >= 0) {
                if (allocate_from_free_span(bank, fit_idx, remaining, chunk)) {
                    g_active_bank = static_cast<uint8_t>((bank + 1) % URAM_BANKS);
                    return true;
                }
            }

            if (bank_offsets[bank_i] < URAM_BANK_BYTES) {
                const uint32_t tail_space = URAM_BANK_BYTES - bank_offsets[bank_i];
                if (tail_space >= remaining && allocate_from_bank_tail(bank, remaining, chunk)) {
                    g_active_bank = static_cast<uint8_t>((bank + 1) % URAM_BANKS);
                    return true;
                }
            }
        }

        if (pass == 0) {
            for (int i = 0; i < URAM_BANKS; ++i) {
                const uint8_t bank = static_cast<uint8_t>((g_active_bank + i) % URAM_BANKS);
                const int bank_i = static_cast<int>(bank);
                if (free_span_count[bank_i] > 0) {
                    const uint32_t take = (remaining < free_spans[bank_i][0].size)
                                            ? remaining
                                            : free_spans[bank_i][0].size;
                    if (take > 0 && allocate_from_free_span(bank, 0, take, chunk)) {
                        g_active_bank = static_cast<uint8_t>((bank + 1) % URAM_BANKS);
                        return true;
                    }
                }
                if (bank_offsets[bank_i] < URAM_BANK_BYTES) {
                    const uint32_t tail_space = URAM_BANK_BYTES - bank_offsets[bank_i];
                    const uint32_t take = (remaining < tail_space) ? remaining : tail_space;
                    if (take > 0 && allocate_from_bank_tail(bank, take, chunk)) {
                        g_active_bank = static_cast<uint8_t>((bank + 1) % URAM_BANKS);
                        return true;
                    }
                }
            }
        }
    }

    return false;
}

static void release_allocated_chunks(const Chunk chunks[MAX_CHUNKS], uint8_t num_chunks) {
#pragma HLS INLINE off
    for (int i = 0; i < MAX_CHUNKS; ++i) {
        if (i >= num_chunks) break;
        reclaim_chunk(chunks[i]);
    }
}

static bool load_main_x_slot_to_buf(
    uint8_t *dst,
    int dst_off,
    uint32_t bytes,
    Tag missing_tag,
    bool &invalid_flag
) {
#pragma HLS INLINE
    if (!main_x_slot_valid) {
        mmu_set_invalid(ERR_MMU_MISSING_REGION_FULL_READ, mmu_missing_subcode_from_tag(missing_tag));
        invalid_flag = true;
        return false;
    }
    if (bytes == 0 || bytes > static_cast<uint32_t>(STREAM_IN_BUF_BYTES)) {
        mmu_set_invalid(ERR_MMU_REGION_ACCESS);
        invalid_flag = true;
        return false;
    }
    for (uint32_t i = 0; i < bytes; ++i) {
        dst[dst_off + static_cast<int>(i)] = main_x_slot[i];
    }
    return true;
}

static bool load_main_x_slot_slice_to_buf(
    uint8_t *dst,
    int dst_off,
    uint32_t src_off,
    uint32_t bytes,
    Tag missing_tag,
    bool &invalid_flag
) {
#pragma HLS INLINE
    if (!main_x_slot_valid) {
        mmu_set_invalid(ERR_MMU_MISSING_REGION_FULL_READ, mmu_missing_subcode_from_tag(missing_tag));
        invalid_flag = true;
        return false;
    }
    if (bytes == 0 || bytes > static_cast<uint32_t>(STREAM_IN_BUF_BYTES)) {
        mmu_set_invalid(ERR_MMU_REGION_ACCESS);
        invalid_flag = true;
        return false;
    }
    if ((src_off + bytes) > static_cast<uint32_t>(STREAM_IN_BUF_BYTES)) {
        mmu_set_invalid(ERR_MMU_REGION_ACCESS);
        invalid_flag = true;
        return false;
    }
    for (uint32_t i = 0; i < bytes; ++i) {
        dst[dst_off + static_cast<int>(i)] = main_x_slot[src_off + i];
    }
    return true;
}

static bool write_main_x_slot_from_buf(const uint8_t *src, uint32_t bytes) {
#pragma HLS INLINE
    if (bytes == 0 || bytes > static_cast<uint32_t>(STREAM_IN_BUF_BYTES)) {
        return false;
    }
    for (uint32_t i = 0; i < bytes; ++i) {
        main_x_slot[i] = src[i];
    }
    main_x_slot_valid = true;
    return true;
}

// ---------------------------------------------------------------------------
// Queue helpers
// ---------------------------------------------------------------------------
static inline bool dma_q_push(uint64_t packed, bool headed, int8_t lane) {
#pragma HLS INLINE
    if (dma_q_count >= DMA_QUEUE_DEPTH) return false;
    dma_q[dma_q_tail].valid = true;
    dma_q[dma_q_tail].packed = packed;
    dma_q[dma_q_tail].headed = headed;
    dma_q[dma_q_tail].lane = lane;
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

static inline bool compute_q_push(uint64_t packed, ComputeReqType type, bool headed, uint8_t head, int8_t lane) {
#pragma HLS INLINE
    if (compute_q_count >= COMPUTE_QUEUE_DEPTH) return false;
    compute_q[compute_q_tail].valid = true;
    compute_q[compute_q_tail].packed = packed;
    compute_q[compute_q_tail].type = type;
    compute_q[compute_q_tail].headed = headed;
    compute_q[compute_q_tail].head = head;
    compute_q[compute_q_tail].lane = lane;
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

static void clear_token_regions_and_slots() {
#pragma HLS INLINE off
    region_count = 0;
    g_active_bank = 0;
    g_current_layer = -1;
    main_x_slot_valid = false;

    for (int b = 0; b < URAM_BANKS; ++b) {
        bank_offsets[b] = 0;
        free_span_count[b] = 0;
        for (int s = 0; s < MAX_FREE_SPANS_PER_BANK; ++s) {
            free_spans[b][s] = FreeSpan{};
        }
    }

    for (int i = 0; i < MAX_REGIONS; ++i) {
        regions[i] = Region{};
    }

    for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
        main_x_slot[i] = 0;
    }
}

static void begin_new_token_cleanup() {
#pragma HLS INLINE off
    clear_token_regions_and_slots();
    stream_in_capturing = false;
    stream_in_write_idx = 0;
    g_overflow = false;
    g_invalid = false;
    g_error_code = ERR_NONE;
    g_error_subcode = MMU_ERR_SUBCODE_NONE;
    g_state = State::IDLE;

    // Reset DMA and compute queues.
    for (int i = 0; i < DMA_QUEUE_DEPTH; ++i) {
        dma_q[i] = DmaQueueEntry{};
    }
    dma_q_head  = 0;
    dma_q_tail  = 0;
    dma_q_count = 0;
    for (int i = 0; i < COMPUTE_QUEUE_DEPTH; ++i) {
        compute_q[i] = ComputeQueueEntry{};
    }
    compute_q_head  = 0;
    compute_q_tail  = 0;
    compute_q_count = 0;

    // Clear active request state.
    active_dma_valid     = false;
    active_compute_valid = false;
    main_wl_accepted     = false;

    for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
        stream_in_capture_buf[i] = 0;
    }
}

// ---------------------------------------------------------------------------
// Region/URAM management
// ---------------------------------------------------------------------------
static bool allocate_chunks(uint32_t total_bytes, Chunk chunks[MAX_CHUNKS], uint8_t &num_chunks) {
#pragma HLS INLINE
    uint32_t remaining = total_bytes;
    num_chunks = 0;
    while (remaining > 0) {
#pragma HLS LOOP_TRIPCOUNT min=1 max=URAM_BANKS
        if (num_chunks >= MAX_CHUNKS) {
            release_allocated_chunks(chunks, num_chunks);
            num_chunks = 0;
            return false;
        }
        if (!allocate_chunk_first_fit(remaining, chunks[num_chunks])) {
            release_allocated_chunks(chunks, num_chunks);
            num_chunks = 0;
            return false;
        }
        remaining -= chunks[num_chunks].size;
        num_chunks++;
    }
    return true;
}

static void zero_region_chunks(const Chunk chunks[MAX_CHUNKS], uint8_t num_chunks);

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
            free_span_count[b] = 0;
            for (int s = 0; s < MAX_FREE_SPANS_PER_BANK; ++s) {
                free_spans[b][s] = FreeSpan{};
            }
        }
        for (int i = 0; i < MAX_REGIONS; ++i) {
            regions[i].valid = false;
            regions[i].used = false;
            regions[i].num_chunks = 0;
        }
        return;
    }

    for (int i = 0; i < MAX_REGIONS; ++i) {
        if (regions[i].valid && !regions[i].used) {
            if (!reclaim_region_chunks(regions[i])) {
                mmu_set_overflow(ERR_MMU_REGION_OVERFLOW, MMU_ERR_SUBCODE_REGION_OVERFLOW_GENERIC);
            }
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
    const uint32_t max_region_bytes = static_cast<uint32_t>(MAX_CHUNKS) * URAM_BANK_BYTES;
    if (total_bytes > max_region_bytes) {
        overflow_flag = true;
        mmu_set_overflow(ERR_MMU_REGION_TOO_LARGE);
        return -1;
    }

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
// #pragma HLS UNROLL
        if (i < num_chunks) {
            r.chunks[i] = chunks[i];
        } else {
            r.chunks[i] = Chunk{};
        }
    }
    // Ensure newly allocated region bytes start deterministic.
    zero_region_chunks(r.chunks, r.num_chunks);
    region_count++;
    return free_idx;
}

static int get_or_create_region(Tag tag, int layer, int head, int tile, uint32_t total_bytes,
                                uint16_t expected_parts, uint32_t part_bytes,
                                bool &overflow_flag) {
#pragma HLS INLINE
    const int idx = find_region(tag, layer, head, tile);
    if (idx >= 0) {
        // If a matching entry exists but has already been consumed (used=0),
        // treat it as dead and recreate it so retain/written bookkeeping resets.
        if (!regions[idx].used) {
            if (!reclaim_region_chunks(regions[idx])) {
                overflow_flag = true;
                mmu_set_overflow(ERR_MMU_REGION_OVERFLOW, MMU_ERR_SUBCODE_REGION_OVERFLOW_GENERIC);
                return -1;
            }
            regions[idx].valid = false;
            if (region_count > 0) {
                region_count--;
            }
        } else {
            return idx;
        }
    }
    return create_region(tag, layer, head, tile, total_bytes, expected_parts,
                         part_bytes, default_retain(tag), overflow_flag);
}

static inline uint8_t uram_read_byte(uint8_t bank, uint32_t byte_addr) {
#pragma HLS INLINE
    const uint32_t word_idx = byte_addr / URAM_BANK_WORD_BYTES;
    const uint32_t bit_off = (byte_addr % URAM_BANK_WORD_BYTES) * 8u;
    const axi_gmem_word_t word = uram_banks[bank][word_idx];
    return static_cast<uint8_t>((word >> bit_off) & axi_gmem_word_t(0xFFu));
}

static inline void uram_write_byte(uint8_t bank, uint32_t byte_addr, uint8_t value) {
#pragma HLS INLINE
    const uint32_t word_idx = byte_addr / URAM_BANK_WORD_BYTES;
    const uint32_t bit_off = (byte_addr % URAM_BANK_WORD_BYTES) * 8u;
    axi_gmem_word_t word = uram_banks[bank][word_idx];
    const axi_gmem_word_t mask = axi_gmem_word_t(0xFFu) << bit_off;
    word = (word & ~mask) | (axi_gmem_word_t(value) << bit_off);
    uram_banks[bank][word_idx] = word;
}

static inline axi_gmem_word_t pack_uram_word(const uint8_t *src, uint32_t byte_offset) {
#pragma HLS INLINE
    axi_gmem_word_t word = 0;
    for (uint32_t i = 0; i < URAM_BANK_WORD_BYTES; ++i) {
// #pragma HLS UNROLL
        word |= (axi_gmem_word_t(src[byte_offset + i]) << (i * 8u));
    }
    return word;
}

static inline void unpack_uram_word(axi_gmem_word_t word, uint8_t *dst, uint32_t byte_offset) {
#pragma HLS INLINE
    for (uint32_t i = 0; i < URAM_BANK_WORD_BYTES; ++i) {
// #pragma HLS UNROLL
        dst[byte_offset + i] =
            static_cast<uint8_t>((word >> (i * 8u)) & axi_gmem_word_t(0xFFu));
    }
}

static void zero_region_chunks(const Chunk chunks[MAX_CHUNKS], uint8_t num_chunks) {
#pragma HLS INLINE off
    for (int c = 0; c < MAX_CHUNKS; ++c) {
#pragma HLS LOOP_FLATTEN off
        if (c >= num_chunks) break;
        const Chunk &ck = chunks[c];
        uint32_t local = 0;
        while (local < ck.size) {
#pragma HLS LOOP_FLATTEN off
            const uint32_t bank_byte_addr = ck.offset + local;
            const bool word_aligned = ((bank_byte_addr % URAM_BANK_WORD_BYTES) == 0u) &&
                                      ((ck.size - local) >= URAM_BANK_WORD_BYTES);
            if (word_aligned) {
// #pragma HLS PIPELINE II=1
                uram_banks[ck.bank][bank_byte_addr / URAM_BANK_WORD_BYTES] = 0;
                local += URAM_BANK_WORD_BYTES;
            } else {
// #pragma HLS PIPELINE II=1
                uram_write_byte(ck.bank, bank_byte_addr, 0);
                local += 1;
            }
        }
    }
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
        uint32_t take = (remaining < room) ? remaining : room;
        while (take > 0) {
#pragma HLS LOOP_FLATTEN off
            const uint32_t bank_byte_addr = ck.offset + logical;
            const bool word_aligned = ((bank_byte_addr % URAM_BANK_WORD_BYTES) == 0u) &&
                                      ((written % URAM_BANK_WORD_BYTES) == 0u) &&
                                      (take >= URAM_BANK_WORD_BYTES);
            if (word_aligned) {
// #pragma HLS PIPELINE II=1
                uram_banks[ck.bank][bank_byte_addr / URAM_BANK_WORD_BYTES] =
                    pack_uram_word(src, written);
                written += URAM_BANK_WORD_BYTES;
                remaining -= URAM_BANK_WORD_BYTES;
                logical += URAM_BANK_WORD_BYTES;
                take -= URAM_BANK_WORD_BYTES;
            } else {
// #pragma HLS PIPELINE II=1
                uram_write_byte(ck.bank, bank_byte_addr, src[written]);
                written += 1;
                remaining -= 1;
                logical += 1;
                take -= 1;
            }
        }
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
        uint32_t take = (remaining < room) ? remaining : room;
        while (take > 0) {
#pragma HLS LOOP_FLATTEN off
            const uint32_t bank_byte_addr = ck.offset + logical;
            const bool word_aligned = ((bank_byte_addr % URAM_BANK_WORD_BYTES) == 0u) &&
                                      ((copied % URAM_BANK_WORD_BYTES) == 0u) &&
                                      (take >= URAM_BANK_WORD_BYTES);
            if (word_aligned) {
// #pragma HLS PIPELINE II=1
                unpack_uram_word(uram_banks[ck.bank][bank_byte_addr / URAM_BANK_WORD_BYTES],
                                 dst, copied);
                copied += URAM_BANK_WORD_BYTES;
                remaining -= URAM_BANK_WORD_BYTES;
                logical += URAM_BANK_WORD_BYTES;
                take -= URAM_BANK_WORD_BYTES;
            } else {
// #pragma HLS PIPELINE II=1
                dst[copied] = uram_read_byte(ck.bank, bank_byte_addr);
                copied += 1;
                remaining -= 1;
                logical += 1;
                take -= 1;
            }
        }
        logical = 0;
    }
    return (remaining == 0);
}

static bool region_write_segment(int idx, uint32_t dst_offset, const uint8_t *src, uint32_t bytes);
static bool region_mark_part_complete(int idx, int part_idx);

static bool region_write_part(int idx, int part_idx, const uint8_t *src, uint32_t bytes) {
#pragma HLS INLINE
    if (idx < 0 || idx >= MAX_REGIONS) return false;
    Region &r = regions[idx];
    if (!r.valid) return false;
    const uint32_t off = static_cast<uint32_t>(part_idx) * r.part_bytes;
    if (!region_write_bytes(r, off, src, bytes)) return false;

    return region_mark_part_complete(idx, part_idx);
}

static bool region_write_segment(int idx, uint32_t dst_offset, const uint8_t *src, uint32_t bytes) {
#pragma HLS INLINE
    if (idx < 0 || idx >= MAX_REGIONS) return false;
    Region &r = regions[idx];
    if (!r.valid) return false;
    return region_write_bytes(r, dst_offset, src, bytes);
}

static bool region_mark_part_complete(int idx, int part_idx) {
#pragma HLS INLINE
    if (idx < 0 || idx >= MAX_REGIONS) return false;
    Region &r = regions[idx];
    if (!r.valid) return false;

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
        mmu_set_invalid(ERR_MMU_MISSING_REGION_FULL_READ, mmu_missing_subcode_from_tag(tag));
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

static bool load_region_slice_to_buf(Tag tag, int layer, int head, int tile,
                                     uint32_t src_off,
                                     uint8_t *dst, int dst_off, uint32_t bytes,
                                     bool consume, bool &invalid_flag) {
#pragma HLS INLINE
    const int idx = find_region(tag, layer, head, tile);
    if (idx < 0 || !region_ready(regions[idx])) {
        mmu_set_invalid(ERR_MMU_MISSING_REGION_PARTIAL_READ, mmu_missing_subcode_from_tag(tag));
        invalid_flag = true;
        return false;
    }
    if (!region_read_bytes(regions[idx], src_off, &dst[dst_off], bytes)) {
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
        mmu_set_invalid(ERR_MMU_MISSING_REGION_PARTIAL_READ, mmu_missing_subcode_from_tag(tag));
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

static bool load_region_segment_to_buf(Tag tag, int layer, int head, int tile,
                                       uint32_t src_off,
                                       uint8_t *dst, int dst_off, uint32_t bytes,
                                       bool consume, bool &invalid_flag) {
#pragma HLS INLINE
    const int idx = find_region(tag, layer, head, tile);
    if (idx < 0 || !region_ready(regions[idx])) {
        mmu_set_invalid(ERR_MMU_MISSING_REGION_PARTIAL_READ, mmu_missing_subcode_from_tag(tag));
        invalid_flag = true;
        return false;
    }
    if (!region_read_bytes(regions[idx], src_off, &dst[dst_off], bytes)) {
        mmu_set_invalid(ERR_MMU_REGION_ACCESS);
        invalid_flag = true;
        return false;
    }
    if (consume && should_consume(tag)) {
        maybe_consume(idx);
    }
    return true;
}

static bool load_ctx_v_tile_to_buf(int layer, int head, int tile,
                                   uint8_t *dst, int dst_off,
                                   bool consume, bool &invalid_flag) {
#pragma HLS INLINE off
    const int idx = find_region(Tag::CTX_V, layer, head, tile);
    if (idx < 0 || !region_ready(regions[idx])) {
        mmu_set_invalid(ERR_MMU_MISSING_REGION_PARTIAL_READ, mmu_missing_subcode_from_tag(Tag::CTX_V));
        invalid_flag = true;
        return false;
    }

    uint8_t row[D_HEAD_TILE_ATT_VALUE];
// #pragma HLS ARRAY_PARTITION variable=row complete dim=1
#pragma HLS BIND_STORAGE variable=row type=ram_t2p impl=bram

    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        const uint32_t src_off = static_cast<uint32_t>(t) * static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
        if (!region_read_bytes(regions[idx], src_off, row, D_HEAD_TILE_ATT_VALUE)) {
            mmu_set_invalid(ERR_MMU_REGION_ACCESS);
            invalid_flag = true;
            return false;
        }
        for (int h = 0; h < D_HEAD_TILE_ATT_VALUE; ++h) {
// #pragma HLS UNROLL
            dst[dst_off + (h * CONTEXT_LENGTH) + t] = row[h];
        }
    }

    if (consume && should_consume(Tag::CTX_V)) {
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

static bool validate_write_spec(const WriteSpec &s) {
#pragma HLS INLINE
    if (s.tag == Tag::NONE) return false;
    // `expected_parts` is used for multiple different packing schemes (logit tiles, FFN tiles, head packs, etc.).
    // The upper bound should cover the maximum number of parts any op can produce for the configured model.
    constexpr uint16_t MAX_EXPECTED_PARTS =
        static_cast<uint16_t>(max2_constexpr(
            NUM_LOGIT_TILES,
            max2_constexpr(
                NUM_HEADS,
                max2_constexpr(
                    max2_constexpr(NUM_WO_TILES, NUM_W1_TILES),
                    max2_constexpr(
                        max2_constexpr(NUM_W2_TILES, NUM_QKV_HEAD_TILES),
                        max2_constexpr(NUM_ATT_CTX_BLOCKS, NUM_ATT_VALUE_HEAD_TILES))))));
    if (s.expected_parts == 0 || s.expected_parts > MAX_EXPECTED_PARTS) return false;
    if (s.part_idx < 0 || s.part_idx >= static_cast<int>(s.expected_parts)) return false;
    if (s.part_bytes == 0 || s.total_bytes == 0) return false;

    const uint64_t packed_total =
        static_cast<uint64_t>(s.part_bytes) * static_cast<uint64_t>(s.expected_parts);
    return packed_total == static_cast<uint64_t>(s.total_bytes);
}

static WriteSpec build_write_spec(ComputeOp op, int tile) {
#pragma HLS INLINE off
    WriteSpec s;
    s.part_bytes = main_op_out_bytes(op);
    s.total_bytes = s.part_bytes;

    s.key_tile = tile;
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
        case CMP_ATT_VALUE: {
            s.tag = Tag::ATT_VALUE_OUT;
            break;
        }
        case CMP_OUT_PROJ: {
            s.tag = Tag::OUT_PROJ_PACKED;
            s.key_tile = -1;
            s.expected_parts = NUM_WO_TILES;
            s.part_idx = (tile >= 0) ? tile : 0;
            s.total_bytes = static_cast<uint32_t>(NUM_WO_TILES) * s.part_bytes;
            break;
        }
        case CMP_FFN_W1: {
            s.tag = Tag::FFN_W1_PACKED;
            s.key_tile = -1;
            s.expected_parts = NUM_W1_TILES;
            s.part_idx = (tile >= 0) ? tile : 0;
            s.total_bytes = static_cast<uint32_t>(NUM_W1_TILES) * s.part_bytes;
            break;
        }
        case CMP_FFN_W2: {
            s.tag = Tag::FFN_W2_PACKED;
            s.key_tile = -1;
            s.expected_parts = NUM_W2_TILES;
            s.part_idx = (tile >= 0) ? tile : 0;
            s.total_bytes = static_cast<uint32_t>(NUM_W2_TILES) * s.part_bytes;
            break;
        }
        case CMP_LOGITS: {
            s.tag = Tag::LOGITS_PACKED;
            s.key_tile = -1;
            s.expected_parts = NUM_LOGIT_TILES;
            s.part_idx = (tile >= 0) ? tile : 0;
            s.total_bytes = static_cast<uint32_t>(NUM_LOGIT_TILES) * s.part_bytes;
            break;
        }
        default: {
            s.tag = Tag::NONE;
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
// #pragma HLS UNROLL
        piece_bytes[i] = 0;
        piece_addr_off[i] = 0;
        piece_tag[i] = Tag::NONE;
    }

    switch (sel) {
        case DMASEL_WQ: {
            piece_count = 2;
            piece_bytes[0] = mm_buf::QKV_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::WQ_W;
            piece_bytes[1] = STRIDE_QKV_HEAD_TILE_BIAS;
            piece_addr_off[1] = 0;
            piece_tag[1] = Tag::WQ_B;
            return true;
        }
        case DMASEL_WK: {
            piece_count = 2;
            piece_bytes[0] = mm_buf::QKV_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::WK_W;
            piece_bytes[1] = STRIDE_QKV_HEAD_TILE_BIAS;
            piece_addr_off[1] = 0;
            piece_tag[1] = Tag::WK_B;
            return true;
        }
        case DMASEL_WV: {
            piece_count = 2;
            piece_bytes[0] = mm_buf::QKV_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::WV_W;
            piece_bytes[1] = STRIDE_QKV_HEAD_TILE_BIAS;
            piece_addr_off[1] = 0;
            piece_tag[1] = Tag::WV_B;
            return true;
        }
        case DMASEL_WO: {
            piece_count = 2;
            piece_bytes[0] = mm_buf::OUT_PROJ_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::WO_W;
            piece_bytes[1] = STRIDE_WO_BIAS_TILE;
            piece_addr_off[1] = 0;
            piece_tag[1] = Tag::WO_B;
            return true;
        }
        case DMASEL_W1: {
            piece_count = 2;
            piece_bytes[0] = mm_buf::W1_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::W1_W;
            piece_bytes[1] = STRIDE_W1_BIAS_TILE;
            piece_addr_off[1] = 0;
            piece_tag[1] = Tag::W1_B;
            return true;
        }
        case DMASEL_W2: {
            piece_count = 2;
            piece_bytes[0] = mm_buf::W2_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::W2_W;
            piece_bytes[1] = STRIDE_W2_BIAS_TILE;
            piece_addr_off[1] = 0;
            piece_tag[1] = Tag::W2_B;
            return true;
        }
        case DMASEL_CTX_K: {
            piece_count = 1;
            piece_bytes[0] = mm_buf::ATT_SCORES_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::CTX_K;
            return true;
        }
        case DMASEL_CTX_V: {
            piece_count = 1;
            piece_bytes[0] = static_cast<uint32_t>(CONTEXT_LENGTH) * static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::CTX_V;
            return true;
        }
        case DMASEL_WLOGIT: {
            piece_count = 1;
            piece_bytes[0] = mm_buf::LOGITS_W_BYTES;
            piece_addr_off[0] = 0;
            piece_tag[0] = Tag::LOGITS_W;
            return true;
        }
        case DMASEL_NONE: {
            piece_count = 0;
            return true;
        }
        default: {
            return false;
        }
    }
}

static bool calc_dma_base_addr(ControlMemSpace ctrl_mem, DmaSel sel, int layer, int head, int tile,
                               uint64_t &addr_out) {
#pragma HLS INLINE off
    if (layer < 0) return false;
    switch (sel) {
        case DmaSel::DMASEL_WQ: {
            if (head < 0 || tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.wq_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WQ_LAYER
                     + static_cast<uint32_t>(head) * STRIDE_QKV_HEAD
                     + static_cast<uint32_t>(tile) * STRIDE_QKV_HEAD_TILE;
            return true;
        }
        case DmaSel::DMASEL_WK: {
            if (head < 0 || tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.wk_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WK_LAYER
                     + static_cast<uint32_t>(head) * STRIDE_QKV_HEAD
                     + static_cast<uint32_t>(tile) * STRIDE_QKV_HEAD_TILE;
            return true;
        }
        case DmaSel::DMASEL_WV: {
            if (head < 0 || tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.wv_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WV_LAYER
                     + static_cast<uint32_t>(head) * STRIDE_QKV_HEAD
                     + static_cast<uint32_t>(tile) * STRIDE_QKV_HEAD_TILE;
            return true;
        }
        case DmaSel::DMASEL_CTX_K: {
            if (head < 0 || tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.k_cache_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_KV_LAYER
                     + static_cast<uint32_t>(head) * STRIDE_KV_HEAD
                     + static_cast<uint32_t>(tile) * STRIDE_KV_CTX_BLOCK;
            return true;
        }
        case DmaSel::DMASEL_CTX_V: {
            if (head < 0 || tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.v_cache_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_KV_LAYER
                     + static_cast<uint32_t>(head) * STRIDE_KV_HEAD
                     + static_cast<uint32_t>(tile) * static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
            return true;
        }
        case DmaSel::DMASEL_WO: {
            if (tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.wo_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WO_LAYER
                     + static_cast<uint32_t>(tile) * STRIDE_WO_TILE;
            return true;
        }
        case DmaSel::DMASEL_W1: {
            if (tile < 0) return false;
            // GPT-2: single W1 (no gate/up split). Tile covers contiguous output rows.
            addr_out = static_cast<uint64_t>(ctrl_mem.w1_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_W1_GATE_LAYER
                     + static_cast<uint32_t>(tile) * STRIDE_W1_TILE;
            return true;
        }
        case DmaSel::DMASEL_W2: {
            if (tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.w2_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_W2_LAYER
                     + static_cast<uint32_t>(tile) * STRIDE_W2_TILE;
            return true;
        }
        case DmaSel::DMASEL_WLOGIT: {
            if (tile < 0) return false;
            // Logits projection weights are shared across layers in this design.
            // Do not apply layer_stride here, otherwise layer>0 reads can go out-of-range
            // of the compact DDR image and become nondeterministic in C-sim.
            addr_out = static_cast<uint64_t>(ctrl_mem.wlogit_offset)
                     + static_cast<uint32_t>(tile) * STRIDE_WLOGIT_TILE;
            return true;
        }
        case DmaSel::DMASEL_NONE: {
            addr_out = 0;
            return true;
        }
        default: {
            return false;
        }
    }
}

static bool calc_dma_piece_addr(ControlMemSpace ctrl_mem, DmaSel sel, int layer, int head, int tile,
                                uint64_t dma_base_addr, uint8_t piece_idx, uint32_t piece_addr_off,
                                uint64_t &addr_out) {
#pragma HLS INLINE off
    if (piece_idx == 0) {
        if (sel == DMASEL_CTX_V && tile >= 0) {
            // Strided V cache: piece is CTX_LEN * D_HEAD_TILE_ATT_VALUE bytes
            // laid out in DDR with D_HEADS stride between rows.
            // piece_addr_off is the sequential byte position within the tile.
            const uint32_t row = piece_addr_off / static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
            const uint32_t col = piece_addr_off % static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
            addr_out = dma_base_addr
                     + static_cast<uint64_t>(row) * static_cast<uint64_t>(D_HEADS)
                     + static_cast<uint64_t>(col);
            return true;
        }
        addr_out = dma_base_addr + piece_addr_off;
        return true;
    }

    switch (sel) {
        case DMASEL_WQ: {
            const int head_idx = (head < 0) ? 0 : head;
            const int tile_idx = (tile < 0) ? 0 : tile;
            addr_out = static_cast<uint64_t>(ctrl_mem.wq_bias_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WQ_BIAS_LAYER
                     + static_cast<uint32_t>(head_idx) * STRIDE_QKV_HEAD_BIAS
                     + static_cast<uint32_t>(tile_idx) * STRIDE_QKV_HEAD_TILE_BIAS
                     + piece_addr_off;
            return true;
        }
        case DMASEL_WK: {
            const int head_idx = (head < 0) ? 0 : head;
            const int tile_idx = (tile < 0) ? 0 : tile;
            addr_out = static_cast<uint64_t>(ctrl_mem.wk_bias_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WK_BIAS_LAYER
                     + static_cast<uint32_t>(head_idx) * STRIDE_QKV_HEAD_BIAS
                     + static_cast<uint32_t>(tile_idx) * STRIDE_QKV_HEAD_TILE_BIAS
                     + piece_addr_off;
            return true;
        }
        case DMASEL_WV: {
            const int head_idx = (head < 0) ? 0 : head;
            const int tile_idx = (tile < 0) ? 0 : tile;
            addr_out = static_cast<uint64_t>(ctrl_mem.wv_bias_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WV_BIAS_LAYER
                     + static_cast<uint32_t>(head_idx) * STRIDE_QKV_HEAD_BIAS
                     + static_cast<uint32_t>(tile_idx) * STRIDE_QKV_HEAD_TILE_BIAS
                     + piece_addr_off;
            return true;
        }
        case DMASEL_WO: {
            if (tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.wo_bias_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_WO_BIAS_LAYER
                     + static_cast<uint32_t>(tile) * STRIDE_WO_BIAS_TILE;
            return true;
        }
        case DMASEL_W1: {
            if (tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.w1_bias_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_W1_BIAS_LAYER
                     + static_cast<uint32_t>(tile) * STRIDE_W1_BIAS_TILE;
            return true;
        }
        case DMASEL_W2: {
            if (tile < 0) return false;
            addr_out = static_cast<uint64_t>(ctrl_mem.w2_bias_offset)
                     + static_cast<uint32_t>(layer) * STRIDE_W2_BIAS_LAYER
                     + static_cast<uint32_t>(tile) * STRIDE_W2_BIAS_TILE;
            return true;
        }
        default: {
            addr_out = dma_base_addr + piece_addr_off;
            return true;
        }
    }
}

#ifndef __SYNTHESIS__
static const char *dma_sel_name(DmaSel sel) {
    switch (sel) {
        case DMASEL_NONE: return "DMASEL_NONE";
        case DMASEL_WQ: return "DMASEL_WQ";
        case DMASEL_WK: return "DMASEL_WK";
        case DMASEL_WV: return "DMASEL_WV";
        case DMASEL_WO: return "DMASEL_WO";
        case DMASEL_W1: return "DMASEL_W1";
        case DMASEL_W2: return "DMASEL_W2";
        case DMASEL_CTX_K: return "DMASEL_CTX_K";
        case DMASEL_CTX_V: return "DMASEL_CTX_V";
        case DMASEL_WLOGIT: return "DMASEL_WLOGIT";
        default: return "DMASEL_UNKNOWN";
    }
}

static void trace_ddr_fetch_plan(ControlMemSpace ctrl_mem,
                                 DmaSel sel,
                                 int layer,
                                 int head,
                                 int tile,
                                 uint64_t dma_base_addr,
                                 uint8_t piece_count,
                                 const uint32_t piece_bytes[MAX_DMA_PIECES],
                                 const uint32_t piece_addr_off[MAX_DMA_PIECES]) {
    // By default we suppress most KV-cache traffic because it can be extremely
    // verbose; CTX_K/CTX_V are the exceptions we want to see for debugging.
    if ((dma_uses_kv_cache(sel) && sel != DMASEL_CTX_K && sel != DMASEL_CTX_V) ||
        sel == DMASEL_NONE) {
        return;
    }

    std::printf("[MMU DDR FETCH] sel=%s layer=%d head=%d tile=%d base=0x%08llX pieces=%u\n",
                dma_sel_name(sel),
                layer,
                head,
                tile,
                static_cast<unsigned long long>(dma_base_addr),
                static_cast<unsigned>(piece_count));

    for (uint8_t piece_idx = 0; piece_idx < piece_count; ++piece_idx) {
        uint64_t piece_addr = 0;
        const bool ok = calc_dma_piece_addr(ctrl_mem, sel, layer, head, tile, dma_base_addr,
                                            piece_idx, piece_addr_off[piece_idx], piece_addr);
        if (ok) {
            std::printf("  piece[%u] off=0x%08X addr=0x%08llX bytes=%u\n",
                        static_cast<unsigned>(piece_idx),
                        piece_addr_off[piece_idx],
                        static_cast<unsigned long long>(piece_addr),
                        static_cast<unsigned>(piece_bytes[piece_idx]));
        } else {
            std::printf("  piece[%u] off=0x%08X addr=<invalid> bytes=%u\n",
                        static_cast<unsigned>(piece_idx),
                        piece_addr_off[piece_idx],
                        static_cast<unsigned>(piece_bytes[piece_idx]));
        }
    }
}
#endif

// ---------------------------------------------------------------------------
// Compute read population
// ---------------------------------------------------------------------------
static void zero_buf(uint8_t *buf, int n) {
    for (int i = 0; i < n; ++i) {
// #pragma HLS PIPELINE II=1
        buf[i] = 0;
    }
}

static bool build_main_in_buf(ComputeOp op, int layer, int head, int tile,
                              uint8_t buf[compute_buf::IN_BUF_BYTES], bool &invalid_flag) {
#pragma HLS INLINE off
    zero_buf(buf, compute_buf::IN_BUF_BYTES);
    switch (op) {
        // --- MatMul mode: Q projection tile ---
        case CMP_Q: {
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INQkvLayout::ACT, mm_buf::QKV_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WQ_W, layer, head, tile,
                                    buf, mm_buf::INQkvLayout::W, mm_buf::QKV_W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WQ_B, layer, head, tile,
                                      buf, mm_buf::INQkvLayout::B, mm_buf::QKV_B_BYTES,
                                      true, invalid_flag);
        }
        // --- MatMul mode: K projection tile ---
        case CMP_K: {
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INQkvLayout::ACT, mm_buf::QKV_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WK_W, layer, head, tile,
                                    buf, mm_buf::INQkvLayout::W, mm_buf::QKV_W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WK_B, layer, head, tile,
                                      buf, mm_buf::INQkvLayout::B, mm_buf::QKV_B_BYTES,
                                      true, invalid_flag);
        }
        // --- MatMul mode: V projection tile ---
        case CMP_V: {
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INQkvLayout::ACT, mm_buf::QKV_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WV_W, layer, head, tile,
                                    buf, mm_buf::INQkvLayout::W, mm_buf::QKV_W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WV_B, layer, head, tile,
                                      buf, mm_buf::INQkvLayout::B, mm_buf::QKV_B_BYTES,
                                      true, invalid_flag);
        }
        // --- MatMul mode: Attention scores tile ---
        case CMP_ATT_SCORES: {
            // Stream-in: int8[D_HEADS] Q vector; DMA: K-cache ctx block
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INAttScoresLayout::ACT, mm_buf::ATT_SCORES_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::CTX_K, layer, head, tile,
                                      buf, mm_buf::INAttScoresLayout::W, mm_buf::ATT_SCORES_W_BYTES,
                                      true, invalid_flag);
        }
        // --- MatMul mode: Attention value tile ---
        case CMP_ATT_VALUE: {
            // No context chunking:
            //   - Stream-in provides int16[CONTEXT_LENGTH] softmax weights (little-endian).
            //   - DMASEL_CTX_V stages a full-context V-cache slice for one d_tile:
            //       CTX_V region bytes = CONTEXT_LENGTH * D_HEAD_TILE_ATT_VALUE
            //   - tile is d_tile_idx (0..NUM_ATT_VALUE_HEAD_TILES-1).
            const int d_tile_idx = (tile < 0) ? 0 : tile;

            bool ok = load_main_x_slot_slice_to_buf(buf, mm_buf::INAttValueLayout::ACT,
                                                    0u,
                                                    mm_buf::ATT_VALUE_ACT_BYTES,
                                                    Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::CTX_V, layer, head, d_tile_idx,
                                      buf, mm_buf::INAttValueLayout::W, mm_buf::ATT_VALUE_W_BYTES,
                                      true, invalid_flag);
        }
        // --- MatMul mode: Output projection tile ---
        case CMP_OUT_PROJ: {
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INOutProjLayout::ACT, mm_buf::OUT_PROJ_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::WO_W, layer, -1, tile,
                                    buf, mm_buf::INOutProjLayout::W, mm_buf::OUT_PROJ_W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::WO_B, layer, -1, tile,
                                      buf, mm_buf::INOutProjLayout::B, mm_buf::OUT_PROJ_B_BYTES,
                                      true, invalid_flag);
        }
        case CMP_FFN_W1: {
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INW1Layout::ACT, mm_buf::W1_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::W1_W, layer, -1, tile,
                                    buf, mm_buf::INW1Layout::W, mm_buf::W1_W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::W1_B, layer, -1, tile,
                                      buf, mm_buf::INW1Layout::B, mm_buf::W1_B_BYTES,
                                      true, invalid_flag);
        }
        case CMP_FFN_W2: {
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INW2Layout::ACT, mm_buf::W2_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            ok = load_region_to_buf(Tag::W2_W, layer, -1, tile,
                                    buf, mm_buf::INW2Layout::W, mm_buf::W2_W_BYTES,
                                    true, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::W2_B, layer, -1, tile,
                                      buf, mm_buf::INW2Layout::B, mm_buf::W2_B_BYTES,
                                      true, invalid_flag);
        }
        case CMP_LOGITS: {
            bool ok = load_main_x_slot_to_buf(buf, mm_buf::INLogitsLayout::ACT, mm_buf::LOGITS_ACT_BYTES,
                                              Tag::STREAM_IN_TOKEN, invalid_flag);
            if (!ok) return false;
            return load_region_to_buf(Tag::LOGITS_W, layer, -1, tile,
                                      buf, mm_buf::INLogitsLayout::W,
                                      mm_buf::LOGITS_W_BYTES, true, invalid_flag);
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
    uint16_t        token_pos,                      // [INPUT] Current token position for KV cache slotting

    // External DMA control/payload
    bool            dma_ready,                      // [INPUT] DMA command interface ready
    bool            dma_done,                       // [INPUT] DMA completion pulse
    const uint32_t  dma_rx_buf[DMA_BUF_WORDS],      // [INPUT] DMA read payload words into MMU
    uint32_t        dma_tx_buf[DMA_BUF_WORDS],      // [OUTPUT] DMA write payload words from MMU
    bool            &dma_start,                     // [OUTPUT] Start DMA transfer
    uint64_t        &dma_addr,                      // [OUTPUT] DMA address
    uint32_t        &dma_len,                       // [OUTPUT] DMA transfer length
    bool            &dma_is_write,                  // [OUTPUT] DMA direction (1=MMU->DDR)
    bool            &dma_use_kv_cache,              // [OUTPUT] Select KV-cache AXI interface

    // Stream ingress/egress interfaces
    bool            axis_in_valid,                  // [INPUT] AXIS ingress valid
    bool            axis_in_last,                   // [INPUT] AXIS ingress TLAST
    bool            axis_in_ready,                  // [INPUT] Scheduler AXIS ingress ready flag
    bool            stream_start,                   // [INPUT] Scheduler pulse: begin stream-out payload
    const uint8_t   stream_in_buf[STREAM_IN_BUF_BYTES], // [INPUT] Constructed stream-in payload
    uint8_t         stream_out_buf[STREAM_OUT_BUF_BYTES], // [OUTPUT] Stream-out payload produced by MMU

    // Main scheduler DMA request (non-headed path)
    bool            mmu_dma_req_start,              // [INPUT] Main scheduler DMA request valid
    uint64_t        mmu_dma_instruction,            // [INPUT] Packed request [sel|layer|head|tile]
    bool            &mmu_req_ready,                 // [OUTPUT] MMU can accept new DMA request
    bool            &main_wl_accept,                // [OUTPUT] Main scheduler request accepted/captured
    bool            &main_dma_done,                 // [OUTPUT] Main scheduler DMA done pulse

    // Main compute request (non-headed path)
    bool            mem_read_request,               // [INPUT] Main compute read request
    bool            mem_write_request,              // [INPUT] Main compute write request
    uint64_t        mem_op,                         // [INPUT] Packed request [op|layer|head|tile]
    bool            &mem_transfer_done,             // [OUTPUT] Main compute transfer done pulse

    // BRAM compute buffers
    uint8_t in_buf[compute_buf::IN_BUF_BYTES],                              // [OUTPUT] MMU fills for main compute
    const uint8_t out_buf[compute_buf::OUT_BUF_BYTES],                      // [INPUT] MMU reads for main writeback

    // Status
    Status &status                      // [OUTPUT] MMU internal state and errors
) {
#pragma HLS INLINE off

// #pragma HLS ARRAY_PARTITION variable=uram_banks complete dim=1
#pragma HLS BIND_STORAGE variable=uram_banks type=ram_t2p impl=uram

#pragma HLS BIND_STORAGE variable=bank_offsets  type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=free_spans    type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=dma_q         type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=compute_q     type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=regions       type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=main_x_slot   type=ram_1p impl=bram
#pragma HLS BIND_STORAGE variable=scratch       type=ram_1p impl=uram

    // Default outputs
    dma_start = false;
    dma_addr = 0;
    dma_len = 0;
    dma_is_write = false;
    dma_use_kv_cache = false;
    main_dma_done = false;
    mem_transfer_done = false;
    mmu_req_ready = (dma_q_count < DMA_QUEUE_DEPTH);
    if (!mmu_dma_req_start) {
        main_wl_accepted = false;
    }
    main_wl_accept = main_wl_accepted;

    if (!reset_n) {
        g_state = State::IDLE;
        g_overflow = false;
        g_invalid = false;
        g_error_code = ERR_NONE;
        g_error_subcode = MMU_ERR_SUBCODE_NONE;
        g_active_bank = 0;
        region_count = 0;
        g_current_layer = -1;

        active_dma_valid = false;
        active_dma_lane = -1;
        active_piece_bytes_done = 0;
        active_chunk_bytes = 0;
#ifndef __SYNTHESIS__
        trace_ctx_v_issue_budget = 0;
#endif
        active_compute_valid = false;
        active_compute_lane = -1;
        dma_q_head = dma_q_tail = dma_q_count = 0;
        compute_q_head = compute_q_tail = compute_q_count = 0;

        main_wl_accepted = false;
        prev_main_mem_req = false;
        prev_main_mem_op = 0;
        stream_in_capturing = false;
        stream_in_write_idx = 0;
        main_x_slot_valid = false;
        for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
// #pragma HLS PIPELINE II=1
            stream_in_capture_buf[i] = 0;
        }
        for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
// #pragma HLS PIPELINE II=1
            main_x_slot[i] = 0;
        }
        prev_stream_start = false;
        prev_ctrl_start = false;
        for (int i = 0; i < URAM_BANKS; ++i) {
            bank_offsets[i] = 0;
            free_span_count[i] = 0;
            for (int s = 0; s < MAX_FREE_SPANS_PER_BANK; ++s) {
                free_spans[i][s] = FreeSpan{};
            }
        }
#ifndef __SYNTHESIS__
        // C-sim determinism: clear URAM model contents on reset.
        // This avoids cross-run/static-state residue affecting software simulation results.
        for (int b = 0; b < URAM_BANKS; ++b) {
            for (uint32_t w = 0; w < URAM_BANK_WORDS; ++w) {
                uram_banks[b][w] = 0;
            }
        }
#endif
        for (int i = 0; i < DMA_QUEUE_DEPTH; ++i) {
            dma_q[i] = DmaQueueEntry{};
        }
        for (int i = 0; i < COMPUTE_QUEUE_DEPTH; ++i) {
            compute_q[i] = ComputeQueueEntry{};
        }
        for (int i = 0; i < MAX_REGIONS; ++i) {
            regions[i] = Region{};
        }

        status.state = g_state;
        status.overflow = g_overflow;
        status.invalid = g_invalid;
        status.error_code = g_error_code;
        status.error_subcode = g_error_subcode;
        status.region_count = region_count;
        return;
    }

    const bool ctrl_start = (ctrl_mem.control & CTRL_START_BIT) != 0u;
    const bool ctrl_start_edge = reset_n && ctrl_start && !prev_ctrl_start;
    if (ctrl_start_edge) {
        begin_new_token_cleanup();
    }
    prev_ctrl_start = ctrl_start;

    const bool axis_in_handshake = reset_n && axis_in_ready && axis_in_valid;
    if (axis_in_handshake) {
        if (!stream_in_capturing) {
            stream_in_capturing = true;
            stream_in_write_idx = 0;
        }

        if (stream_in_write_idx < STREAM_IN_BUF_BYTES) {
            stream_in_capture_buf[stream_in_write_idx] = stream_in_buf[stream_in_write_idx];
            ++stream_in_write_idx;
        } else {
            mmu_set_invalid(ERR_MMU_INVALID);
            stream_in_capturing = false;
            stream_in_write_idx = 0;
        }

        if (axis_in_last) {
            if (stream_in_write_idx == STREAM_IN_BUF_BYTES) {
                if (!write_main_x_slot_from_buf(
                        stream_in_capture_buf,
                        static_cast<uint32_t>(STREAM_IN_BUF_BYTES))) {
                    mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                }
            } else {
                // Early TLAST before full token payload is assembled.
                mmu_set_invalid(ERR_MMU_INVALID);
            }
            stream_in_capturing = false;
            stream_in_write_idx = 0;
        }
    }

    const bool stream_start_edge = reset_n && stream_start && !prev_stream_start;
    if (stream_start_edge) {
        // MatMul mode: stream-out copies the raw int32 accumulator results
        // directly from out_buf. The compute controller wrote them there
        // in MEM_WRITEBACK. STREAM_OUT_BUF_BYTES = ATT_CTX_BLOCK*4 = 256
        // bytes covers the largest op (ATT_SCORES). Ops that produce fewer
        // bytes write only to lower offsets; the PS reads exactly as many
        // bytes as the issued instruction requires.
        for (int i = 0; i < STREAM_OUT_BUF_BYTES; ++i) {
#pragma HLS UNROLL factor=8
            stream_out_buf[i] = out_buf[i];
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
            if (dma_q_push(mmu_dma_instruction, false, -1)) {
                main_wl_accepted = true;
                main_wl_accept = true;
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
        uint8_t req_head = 0;
        if (head >= 0 && head < NUM_HEADS) req_head = static_cast<uint8_t>(head);
        const ComputeReqType req_type = mem_read_request ? ComputeReqType::READ : ComputeReqType::WRITE;
        if (!compute_q_push(mem_op, req_type, false, req_head, -1)) {
            mmu_set_overflow(ERR_MMU_QUEUE_OVERFLOW);
        }
        }
    }

    // Update edge-detect latches.
    prev_main_mem_req = main_mem_req;
    prev_main_mem_op = mem_op;

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
                unpack_dma(q.packed, active_dma_sel, active_dma_layer, active_dma_head, active_dma_tile);
                on_layer_transition(active_dma_layer);
            }

            // No-op guard: ignore placeholder/no-request DMA entries.
            if (active_dma_sel == DMASEL_NONE) {
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            g_state = State::DMA_PREP;
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
#ifndef __SYNTHESIS__
	            trace_ddr_fetch_plan(ctrl_mem, active_dma_sel, active_dma_layer, active_dma_head,
	                                 active_dma_tile, active_dma_addr_base, active_piece_count,
	                                 active_piece_bytes, active_piece_addr_off);
	            trace_ctx_v_issue_budget =
	                (active_dma_sel == DMASEL_CTX_V && active_dma_tile >= 0) ? static_cast<uint8_t>(6u) : 0u;
#endif
            active_piece_idx = 0;
            active_piece_bytes_done = 0;
            active_chunk_bytes = 0;
            active_dma_pad_zero = false;
            g_state = State::DMA_ISSUE;
            break;
        }
        case State::DMA_ISSUE: {
            const int piece_idx = static_cast<int>(active_piece_idx);
            const uint32_t piece_total = active_piece_bytes[piece_idx];
            if (active_piece_bytes_done >= piece_total) {
                active_piece_bytes_done = 0;
            }
            const uint32_t remaining = piece_total - active_piece_bytes_done;
            uint32_t sz = (remaining < static_cast<uint32_t>(DMA_BUF_BYTES))
                              ? remaining
                              : static_cast<uint32_t>(DMA_BUF_BYTES);
            const uint32_t desired_sz = sz;
            // Strided V cache: limit burst to one context row's d_head tile portion
            if (active_dma_sel == DMASEL_CTX_V && active_dma_tile >= 0) {
                const uint32_t col = active_piece_bytes_done % static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
                const uint32_t row_remaining = static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE) - col;
                if (sz > row_remaining) sz = row_remaining;
            }
            uint64_t piece_addr = 0;
	            if (!calc_dma_piece_addr(ctrl_mem, active_dma_sel, active_dma_layer, active_dma_head, active_dma_tile,
	                                     active_dma_addr_base, active_piece_idx,
	                                     active_piece_addr_off[piece_idx] + active_piece_bytes_done,
	                                     piece_addr)) {
	                mmu_set_invalid(ERR_MMU_BAD_DMA_ADDR);
	                active_dma_valid = false;
	                g_state = State::IDLE;
	                break;
	            }

            // Logits weights tiling can require padding when D_VOCAB is not divisible by NUM_LOGIT_TILES.
            // Guard against overreading past the end of the wlogit region: clamp reads to [wlogit_start, wlogit_end)
            // and synthesize any out-of-range bytes as zeros.
            if (active_dma_sel == DMASEL_WLOGIT) {
                const uint64_t wlogit_start = static_cast<uint64_t>(ctrl_mem.wlogit_offset);
                const uint64_t wlogit_end =
                    wlogit_start + static_cast<uint64_t>(MEM_WLOGIT);

                if (piece_addr >= wlogit_end) {
                    // Entire chunk is past end-of-wlogit: skip external DMA and pad zeros into the region.
                    active_dma_pad_zero = true;
                    active_chunk_bytes = desired_sz;
                    g_state = State::DMA_STORE;
                    break;
                }

                const uint64_t avail = wlogit_end - piece_addr;
                if (static_cast<uint64_t>(sz) > avail) {
                    sz = static_cast<uint32_t>(avail);
                    if (sz == 0) {
                        active_dma_pad_zero = true;
                        active_chunk_bytes = desired_sz;
                        g_state = State::DMA_STORE;
                        break;
                    }
                }
            }

            if (!dma_ready) break;
#ifndef __SYNTHESIS__
	            if (active_dma_sel == DMASEL_CTX_V && active_dma_tile >= 0 && trace_ctx_v_issue_budget > 0) {
	                const uint32_t off = active_piece_addr_off[piece_idx] + active_piece_bytes_done;
	                const uint32_t row = off / static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
	                const uint32_t col = off % static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
	                const uint64_t expected =
	                    active_dma_addr_base + (static_cast<uint64_t>(row) * static_cast<uint64_t>(D_HEADS)) + col;
	                std::printf(
	                    "[MMU CTX_V ISSUE] layer=%d head=%d tile=%d off=%u row=%u col=%u base=0x%08llX addr=0x%08llX exp=0x%08llX len=%u\n",
	                    active_dma_layer,
	                    active_dma_head,
	                    active_dma_tile,
	                    static_cast<unsigned>(off),
	                    static_cast<unsigned>(row),
	                    static_cast<unsigned>(col),
	                    static_cast<unsigned long long>(active_dma_addr_base),
	                    static_cast<unsigned long long>(piece_addr),
	                    static_cast<unsigned long long>(expected),
	                    static_cast<unsigned>(sz));
	                --trace_ctx_v_issue_budget;
	            }
#endif
	            active_dma_pad_zero = false;
	            dma_start = true;
	            dma_is_write = false;
	            dma_use_kv_cache = dma_uses_kv_cache(active_dma_sel);
	            dma_len = sz;
            dma_addr = piece_addr;
            active_chunk_bytes = sz;
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
            const uint32_t piece_total = active_piece_bytes[piece_idx];
            const uint32_t chunk_bytes = active_chunk_bytes;
            const Tag tag = active_piece_tag[piece_idx];
            const int key_head = (tag == Tag::WQ_W ||
                                  tag == Tag::WQ_B ||
                                  tag == Tag::WK_W ||
                                  tag == Tag::WK_B ||
                                  tag == Tag::WV_W ||
                                  tag == Tag::WV_B ||
                                  tag == Tag::CTX_K || tag == Tag::CTX_V)
                                 ? active_dma_head : -1;
            const int key_tile = (tag == Tag::WO_W || tag == Tag::WO_B ||
                                  tag == Tag::W1_W || tag == Tag::W1_B ||
                                  tag == Tag::W2_W || tag == Tag::W2_B ||
                                  tag == Tag::LOGITS_W ||
                                  tag == Tag::CTX_K || tag == Tag::CTX_V ||
                                  tag == Tag::WQ_W || tag == Tag::WK_W ||
                                  tag == Tag::WV_W ||
                                  tag == Tag::WQ_B || tag == Tag::WK_B ||
                                  tag == Tag::WV_B)
                                 ? active_dma_tile : -1;

            const int idx = get_or_create_region(tag, active_dma_layer, key_head, key_tile,
                                                 piece_total, 1, piece_total, g_overflow);
            if (idx < 0) {
                mmu_set_overflow(ERR_MMU_REGION_OVERFLOW_DMA_STORE);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            if (active_dma_pad_zero) {
                for (uint32_t i = 0; i < chunk_bytes; ++i) {
// #pragma HLS PIPELINE II=1
                    scratch[i] = 0;
                }
                active_dma_pad_zero = false;
            } else {
                for (uint32_t i = 0; i < chunk_bytes; ++i) {
// #pragma HLS PIPELINE II=1
                    scratch[i] = dma_word_get_byte(dma_rx_buf, i);
                }
            }

            if (!region_write_segment(idx, active_piece_bytes_done, scratch, chunk_bytes)) {
                mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                active_dma_valid = false;
                g_state = State::IDLE;
                break;
            }

            active_piece_bytes_done += chunk_bytes;
            if (active_piece_bytes_done < piece_total) {
                g_state = State::DMA_ISSUE;
            } else {
                if (!region_mark_part_complete(idx, 0)) {
                    mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                    active_dma_valid = false;
                    g_state = State::IDLE;
                    break;
                }
                active_piece_bytes_done = 0;
                active_chunk_bytes = 0;
                active_piece_idx++;
                if (active_piece_idx < active_piece_count) {
                    g_state = State::DMA_ISSUE;
                } else {
                    main_dma_done = true;
                    active_dma_valid = false;
                    g_state = State::IDLE;
                }
            }
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
                active_compute_lane = q.lane;
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
            if (is_disabled_compute_op(active_compute_op)) {
                mem_transfer_done = true;
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }

            if (active_compute_type == ComputeReqType::READ) {
                g_state = State::COMPUTE_READ_PREP;
            } else if (active_compute_type == ComputeReqType::WRITE) {
                g_state = State::COMPUTE_WRITE_PREP;
            } else {
                mmu_set_invalid(ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED);
                active_compute_valid = false;
                g_state = State::IDLE;
            }
            break;
        }
        case State::COMPUTE_READ_PREP: {
            const bool ok = build_main_in_buf(active_compute_op, active_compute_layer, active_compute_head, active_compute_tile,
                                              in_buf, g_invalid);
            if (!ok) {
                if (g_error_code == ERR_NONE) {
                    mmu_set_invalid(ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP);
                }
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }
            g_state = State::COMPUTE_READ_DONE;
            break;
        }
        case State::COMPUTE_READ_DONE: {
            mem_transfer_done = true;
            active_compute_valid = false;
            g_state = State::IDLE;
            break;
        }
        case State::COMPUTE_WRITE_PREP: {
            const bool is_streamed_matmul_op =
                (active_compute_op == CMP_Q) ||
                (active_compute_op == CMP_K) ||
                (active_compute_op == CMP_V) ||
                (active_compute_op == CMP_ATT_SCORES) ||
                (active_compute_op == CMP_ATT_VALUE) ||
                (active_compute_op == CMP_OUT_PROJ) ||
                (active_compute_op == CMP_FFN_W1) ||
                (active_compute_op == CMP_FFN_W2) ||
                (active_compute_op == CMP_LOGITS);
            if (is_streamed_matmul_op) {
                // Instruction-driven mode: stream-out pulls directly from out_buf,
                // so no region packing/writeback is required.
                mem_transfer_done = true;
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }

            const WriteSpec spec = build_write_spec(active_compute_op, active_compute_tile);
            if (!validate_write_spec(spec)) {
                mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }

            const int idx = get_or_create_region(
                spec.tag, active_compute_layer, spec.key_head, spec.key_tile,
                spec.total_bytes, spec.expected_parts, spec.part_bytes, g_overflow);
            if (idx < 0) {
                mmu_set_overflow(ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE);
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }

            const bool write_ok = region_write_part(idx, spec.part_idx, out_buf, spec.part_bytes);

            if (!write_ok) {
                mmu_set_invalid(ERR_MMU_REGION_ACCESS);
                active_compute_valid = false;
                g_state = State::IDLE;
                break;
            }

            g_state = State::COMPUTE_WRITE_DONE;
            break;
        }
        case State::COMPUTE_WRITE_DONE: {
            mem_transfer_done = true;
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
    status.error_subcode = g_error_subcode;
    status.region_count = region_count;

}
