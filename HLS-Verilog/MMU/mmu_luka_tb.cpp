#include <cstdio>
#include <cstdint>
#include <cstring>
#include <vector>
#include <string>

#include "mmu_luka.hpp"

namespace {

static inline uint32_t pack_dma(DmaSel sel, int layer, int head, int tile) {
    return static_cast<uint32_t>(sel)
        | (static_cast<uint32_t>(static_cast<uint8_t>(static_cast<int8_t>(layer))) << 8)
        | (static_cast<uint32_t>(static_cast<uint8_t>(static_cast<int8_t>(head))) << 16)
        | (static_cast<uint32_t>(static_cast<uint8_t>(static_cast<int8_t>(tile))) << 24);
}

static inline uint32_t pack_compute(ComputeOp op, int layer, int head, int tile) {
    return static_cast<uint32_t>(op)
        | (static_cast<uint32_t>(static_cast<uint8_t>(static_cast<int8_t>(layer))) << 8)
        | (static_cast<uint32_t>(static_cast<uint8_t>(static_cast<int8_t>(head))) << 16)
        | (static_cast<uint32_t>(static_cast<uint8_t>(static_cast<int8_t>(tile))) << 24);
}

static inline int head_to_lane(int head) {
    if (head < 0) return 0;
    return head % HEADS_PARALLEL;
}

static bool is_headed_dma(DmaSel sel) {
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

static bool is_headed_op(ComputeOp op) {
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V:
        case CMP_K_REQUANT:
        case CMP_V_REQUANT:
        case CMP_REQUANT_Q:
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

static const char *dma_name(DmaSel sel) {
    switch (sel) {
        case DMASEL_NONE: return "DMASEL_NONE";
        case DMASEL_WQ: return "DMASEL_WQ";
        case DMASEL_WK: return "DMASEL_WK";
        case DMASEL_K_WRITE: return "DMASEL_K_WRITE";
        case DMASEL_WV: return "DMASEL_WV";
        case DMASEL_V_WRITE: return "DMASEL_V_WRITE";
        case DMASEL_CTX_K: return "DMASEL_CTX_K";
        case DMASEL_CTX_V: return "DMASEL_CTX_V";
        case DMASEL_WO: return "DMASEL_WO";
        case DMASEL_W1: return "DMASEL_W1";
        case DMASEL_W2: return "DMASEL_W2";
        case DMASEL_WLOGIT: return "DMASEL_WLOGIT";
        case DMASEL_CONCAT: return "DMASEL_CONCAT";
        default: return "DMASEL?";
    }
}

static const char *op_name(ComputeOp op) {
    switch (op) {
        case CMP_NONE: return "CMP_NONE";
        case CMP_LN0: return "CMP_LN0";
        case CMP_Q: return "CMP_Q";
        case CMP_K: return "CMP_K";
        case CMP_K_REQUANT: return "CMP_K_REQUANT";
        case CMP_ATT_SCORES: return "CMP_ATT_SCORES";
        case CMP_VALUE_SCALE: return "CMP_VALUE_SCALE";
        case CMP_SOFTMAX: return "CMP_SOFTMAX";
        case CMP_V: return "CMP_V";
        case CMP_V_REQUANT: return "CMP_V_REQUANT";
        case CMP_ATT_VALUE: return "CMP_ATT_VALUE";
        case CMP_HEAD_REQUANT: return "CMP_HEAD_REQUANT";
        case CMP_CONCAT: return "CMP_CONCAT";
        case CMP_OUT_PROJ: return "CMP_OUT_PROJ";
        case CMP_REQUANT2: return "CMP_REQUANT2";
        case CMP_RESID0: return "CMP_RESID0";
        case CMP_LN1: return "CMP_LN1";
        case CMP_REQUANT3: return "CMP_REQUANT3";
        case CMP_FFN_W1: return "CMP_FFN_W1";
        case CMP_FFN_ACT: return "CMP_FFN_ACT";
        case CMP_FFN_W2: return "CMP_FFN_W2";
        case CMP_REQUANT4: return "CMP_REQUANT4";
        case CMP_RESID1: return "CMP_RESID1";
        case CMP_FINAL_NORM: return "CMP_FINAL_NORM";
        case CMP_REQUANT1: return "CMP_REQUANT1";
        case CMP_REQUANT_Q: return "CMP_REQUANT_Q";
        case CMP_DEQUANT: return "CMP_DEQUANT";
        case CMP_LOGITS: return "CMP_LOGITS";
        default: return "CMP?";
    }
}

static void dump_bytes(const char *label, const uint8_t *buf, int n) {
    std::printf("%s", label);
    for (int i = 0; i < n; ++i) {
        std::printf("%02x%s", static_cast<unsigned>(buf[i]), (i + 1 == n) ? "\n" : " ");
    }
}

static void prep_main_out(uint8_t *out_buf, int step_id) {
    for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
        out_buf[i] = static_cast<uint8_t>((0x30 + step_id + i) & 0xFF);
    }
}

static void prep_head_out(uint8_t head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES], int lane, int step_id) {
    for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
        head_out_buf[lane][i] = static_cast<uint8_t>((0x60 + (lane * 13) + step_id + i) & 0xFF);
    }
}

struct Step {
    enum class Kind : uint8_t { IDLE, DMA_REQ, CMP_REQ, HEAD_PARALLEL } kind = Kind::IDLE;
    int idle_cycles = 0;

    DmaSel dma_sel = DMASEL_NONE;
    int dma_layer = 0;
    int dma_head = -1;
    int dma_tile = -1;

    ComputeOp cmp_op = CMP_NONE;
    ComputeReqType cmp_type = ComputeReqType::NONE;
    int cmp_layer = 0;
    int cmp_head = -1;
    int cmp_tile = -1;

    const char *note = "";
};

static void dump_ctrl_mem(const ControlMemSpace &ctrl) {
    std::printf("\n[CTRL_MEM] lengths:\n");
    std::printf("  dma_layer_len=%u\n", static_cast<unsigned>(ctrl.dma_layer_len));
    std::printf("  dma_head_len=%u\n", static_cast<unsigned>(ctrl.dma_head_len));
    std::printf("  dma_tile_len=%u\n", static_cast<unsigned>(ctrl.dma_tile_len));

    std::printf("[CTRL_MEM] strides:\n");
    std::printf("  layer_stride=%u\n", static_cast<unsigned>(ctrl.layer_stride));
    std::printf("  wq_head_stride=%u\n", static_cast<unsigned>(ctrl.wq_head_stride));
    std::printf("  wk_head_stride=%u\n", static_cast<unsigned>(ctrl.wk_head_stride));
    std::printf("  wv_head_stride=%u\n", static_cast<unsigned>(ctrl.wv_head_stride));
    std::printf("  k_cache_stride=%u\n", static_cast<unsigned>(ctrl.k_cache_stride));
    std::printf("  v_cache_stride=%u\n", static_cast<unsigned>(ctrl.v_cache_stride));
    std::printf("  wo_tile_stride=%u\n", static_cast<unsigned>(ctrl.wo_tile_stride));
    std::printf("  w1_tile_stride=%u\n", static_cast<unsigned>(ctrl.w1_tile_stride));
    std::printf("  w2_tile_stride=%u\n", static_cast<unsigned>(ctrl.w2_tile_stride));
    std::printf("  wq_bias_head_stride=%u\n", static_cast<unsigned>(ctrl.wq_bias_head_stride));
    std::printf("  wk_bias_head_stride=%u\n", static_cast<unsigned>(ctrl.wk_bias_head_stride));
    std::printf("  wv_bias_head_stride=%u\n", static_cast<unsigned>(ctrl.wv_bias_head_stride));
    std::printf("  wo_bias_tile_stride=%u\n", static_cast<unsigned>(ctrl.wo_bias_tile_stride));
    std::printf("  w1_bias_tile_stride=%u\n", static_cast<unsigned>(ctrl.w1_bias_tile_stride));
    std::printf("  w2_bias_tile_stride=%u\n", static_cast<unsigned>(ctrl.w2_bias_tile_stride));
    std::printf("  ln0_gamma_stride=%u\n", static_cast<unsigned>(ctrl.ln0_gamma_stride));
    std::printf("  ln1_gamma_stride=%u\n", static_cast<unsigned>(ctrl.ln1_gamma_stride));
    std::printf("  final_norm_gamma_stride=%u\n", static_cast<unsigned>(ctrl.final_norm_gamma_stride));
    std::printf("  ln0_eps_stride=%u\n", static_cast<unsigned>(ctrl.ln0_eps_stride));
    std::printf("  ln1_eps_stride=%u\n", static_cast<unsigned>(ctrl.ln1_eps_stride));
    std::printf("  final_norm_eps_stride=%u\n", static_cast<unsigned>(ctrl.final_norm_eps_stride));

    std::printf("[CTRL_MEM] base addresses:\n");
    std::printf("  wq_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wq_base_addr));
    std::printf("  wk_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wk_base_addr));
    std::printf("  wv_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wv_base_addr));
    std::printf("  wo_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wo_base_addr));
    std::printf("  w1_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.w1_base_addr));
    std::printf("  w2_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.w2_base_addr));
    std::printf("  k_cache_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.k_cache_addr));
    std::printf("  v_cache_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.v_cache_addr));
    std::printf("  wq_bias_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wq_bias_base_addr));
    std::printf("  wk_bias_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wk_bias_base_addr));
    std::printf("  wv_bias_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wv_bias_base_addr));
    std::printf("  wo_bias_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.wo_bias_base_addr));
    std::printf("  w1_bias_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.w1_bias_base_addr));
    std::printf("  w2_bias_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.w2_bias_base_addr));
    std::printf("  ln0_gamma_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.ln0_gamma_base_addr));
    std::printf("  ln1_gamma_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.ln1_gamma_base_addr));
    std::printf("  final_norm_gamma_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.final_norm_gamma_base_addr));
    std::printf("  ln0_eps_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.ln0_eps_base_addr));
    std::printf("  ln1_eps_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.ln1_eps_base_addr));
    std::printf("  final_norm_eps_base_addr=0x%llx\n", static_cast<unsigned long long>(ctrl.final_norm_eps_base_addr));
}

} // namespace

int main() {
    constexpr int MAX_CYCLES = 5000;
    constexpr int DMA_LATENCY = 3;

    ControlMemSpace ctrl{};
    ctrl.layer_stride = 0x00100000;

    ctrl.wq_head_stride = head_buf::INQkvLayout::W_BYTES + head_buf::INQkvLayout::B_BYTES;
    ctrl.wk_head_stride = head_buf::INQkvLayout::W_BYTES + head_buf::INQkvLayout::B_BYTES;
    ctrl.wv_head_stride = head_buf::INQkvLayout::W_BYTES + head_buf::INQkvLayout::B_BYTES;

    ctrl.wo_tile_stride = compute_buf::INOutProjLayout::W_BYTES + compute_buf::INOutProjLayout::B_BYTES;
    ctrl.w1_tile_stride = compute_buf::INFfnW1Layout::W_BYTES + compute_buf::INFfnW1Layout::B_BYTES;
    ctrl.w2_tile_stride = compute_buf::INFfnW2Layout::W_BYTES + compute_buf::INFfnW2Layout::B_BYTES;

    ctrl.k_cache_stride = CONTEXT_LENGTH * D_HEADS;
    ctrl.v_cache_stride = CONTEXT_LENGTH * D_HEADS;

    ctrl.wq_base_addr = 0x10000000ULL;
    ctrl.wk_base_addr = 0x11000000ULL;
    ctrl.wv_base_addr = 0x12000000ULL;
    ctrl.wo_base_addr = 0x13000000ULL;
    ctrl.w1_base_addr = 0x14000000ULL;
    ctrl.w2_base_addr = 0x15000000ULL;
    ctrl.k_cache_addr = 0x20000000ULL;
    ctrl.v_cache_addr = 0x21000000ULL;

    static uint8_t dma_rx_buf[DMA_BUF_BYTES];
    static uint8_t dma_tx_buf[DMA_BUF_BYTES];
    static uint8_t in_buf[compute_buf::IN_BUF_BYTES];
    static uint8_t out_buf[compute_buf::OUT_BUF_BYTES];
    static uint8_t head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES];
    static uint8_t head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES];

    std::memset(dma_rx_buf, 0, sizeof(dma_rx_buf));
    std::memset(dma_tx_buf, 0, sizeof(dma_tx_buf));
    std::memset(in_buf, 0, sizeof(in_buf));
    std::memset(out_buf, 0, sizeof(out_buf));
    std::memset(head_in_buf, 0, sizeof(head_in_buf));
    std::memset(head_out_buf, 0, sizeof(head_out_buf));

    bool dma_ready = true;
    bool dma_done = false;
    bool dma_start = false;
    uint32_t dma_addr = 0;
    uint32_t dma_len = 0;
    bool dma_is_write = false;

    bool mmu_dma_req_start = false;
    uint32_t mmu_dma_instruction = 0;
    bool mmu_req_ready = false;
    bool main_dma_done = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    uint32_t mem_op = 0;
    bool mem_transfer_done = false;

    HeadCtx head_ctx[NUM_HEADS];
    ComputeHeadCtx head_compute_ctx[HEADS_PARALLEL];
    std::memset(head_ctx, 0, sizeof(head_ctx));
    std::memset(head_compute_ctx, 0, sizeof(head_compute_ctx));
    for (int h = 0; h < NUM_HEADS; ++h) {
        head_ctx[h].head_idx = h;
    }

    Status status{};

    bool dma_inflight = false;
    int dma_ctr = 0;
    uint32_t dma_len_latched = 0;
    bool dma_is_write_latched = false;
    uint32_t dma_addr_latched = 0;

    dump_ctrl_mem(ctrl);

    std::vector<Step> steps;
    auto add_idle = [&](int cycles, const char *note) {
        Step s{};
        s.kind = Step::Kind::IDLE;
        s.idle_cycles = cycles;
        s.note = note;
        steps.push_back(s);
    };
    auto add_dma = [&](DmaSel sel, int layer, int head, int tile, const char *note) {
        Step s{};
        s.kind = Step::Kind::DMA_REQ;
        s.dma_sel = sel;
        s.dma_layer = layer;
        s.dma_head = head;
        s.dma_tile = tile;
        s.note = note;
        steps.push_back(s);
    };
    auto add_cmp = [&](ComputeOp op, ComputeReqType type, int layer, int head, int tile, const char *note) {
        Step s{};
        s.kind = Step::Kind::CMP_REQ;
        s.cmp_op = op;
        s.cmp_type = type;
        s.cmp_layer = layer;
        s.cmp_head = head;
        s.cmp_tile = tile;
        s.note = note;
        steps.push_back(s);
    };
    auto add_parallel_head = [&](DmaSel dsel, int dlayer, int dhead, int dtile,
                                 ComputeOp cop, ComputeReqType ctype, int clayer, int chead, int ctile,
                                 const char *note) {
        Step s{};
        s.kind = Step::Kind::HEAD_PARALLEL;
        s.dma_sel = dsel;
        s.dma_layer = dlayer;
        s.dma_head = dhead;
        s.dma_tile = dtile;
        s.cmp_op = cop;
        s.cmp_type = ctype;
        s.cmp_layer = clayer;
        s.cmp_head = chead;
        s.cmp_tile = ctile;
        s.note = note;
        steps.push_back(s);
    };

    // 1) IDLE first.
    add_idle(12, "Observe IDLE/GC before traffic");

    // 2) Single-request phase for NON-HEADED path first.
    add_dma(DMASEL_WO, 0, -1, 0, "Load WO tile0 + BO tile0");
    add_dma(DMASEL_W1, 0, -1, 0, "Load W1 tile0 + B1 tile0");
    add_dma(DMASEL_W2, 0, -1, 0, "Load W2 tile0 + B2 tile0");

    add_cmp(CMP_LN0, ComputeReqType::WRITE, 0, -1, -1, "Single: write LN0_OUT");
    for (int t = 0; t < NUM_WO_TILES; ++t) {
        add_cmp(CMP_OUT_PROJ, ComputeReqType::WRITE, 0, -1, t, "Single: write OUT_PROJ tile");
    }
    add_cmp(CMP_RESID0, ComputeReqType::WRITE, 0, -1, -1, "Single: write RESID0_OUT");
    add_cmp(CMP_LN1, ComputeReqType::WRITE, 0, -1, -1, "Single: write LN1_OUT");

    for (int t = 0; t < NUM_W1_TILES; ++t) {
        add_cmp(CMP_FFN_W1, ComputeReqType::WRITE, 0, -1, t, "Single: write FFN_W1 tile");
    }
    add_cmp(CMP_FFN_ACT, ComputeReqType::READ, 0, -1, -1, "Single: read FFN_ACT input");
    add_cmp(CMP_FFN_ACT, ComputeReqType::WRITE, 0, -1, -1, "Single: write FFN_ACT_OUT");

    add_cmp(CMP_FFN_W2, ComputeReqType::READ, 0, -1, 0, "Single: read FFN_W2 input");
    for (int t = 0; t < NUM_W2_TILES; ++t) {
        add_cmp(CMP_FFN_W2, ComputeReqType::WRITE, 0, -1, t, "Single: write FFN_W2 tile");
    }
    add_cmp(CMP_RESID1, ComputeReqType::WRITE, 0, -1, -1, "Single: write RESID1_OUT");
    add_cmp(CMP_FINAL_NORM, ComputeReqType::WRITE, 0, -1, -1, "Single: write FINAL_NORM_OUT");

    // 3) Headed DMA preloads.
    add_dma(DMASEL_WQ, 0, 0, -1, "Headed preload WQ+BQ for head0");
    add_dma(DMASEL_WK, 0, 1, -1, "Headed preload WK+BK for head1");
    add_dma(DMASEL_WV, 0, 0, -1, "Headed preload WV+BV for head0");
    add_dma(DMASEL_CTX_K, 0, 0, -1, "Headed preload K cache for head0");
    add_dma(DMASEL_CTX_V, 0, 1, -1, "Headed preload V cache for head1");

    // 4) Headed parallel requests (DMA + compute in same cycle).
    add_parallel_head(DMASEL_CTX_K, 0, 0, -1, CMP_Q, ComputeReqType::WRITE, 0, 1, -1,
                      "Parallel #1: DMA CTX_K(h0) + CMP_Q WRITE(h1)");
    add_parallel_head(DMASEL_CTX_V, 0, 1, -1, CMP_K, ComputeReqType::WRITE, 0, 0, -1,
                      "Parallel #2: DMA CTX_V(h1) + CMP_K WRITE(h0)");
    add_parallel_head(DMASEL_WQ, 0, 1, -1, CMP_V, ComputeReqType::WRITE, 0, 1, -1,
                      "Parallel #3: DMA WQ(h1) + CMP_V WRITE(h1)");
    add_parallel_head(DMASEL_K_WRITE, 0, 0, -1, CMP_HEAD_REQUANT, ComputeReqType::WRITE, 0, 1, -1,
                      "Parallel #4: DMA K_WRITE(h0) + CMP_HEAD_REQUANT WRITE(h1)");
    for (int h = 0; h < NUM_HEADS; ++h) {
        add_cmp(CMP_HEAD_REQUANT, ComputeReqType::WRITE, 0, h, -1, "Build packed HEAD_REQUANT for concat");
    }
    add_dma(DMASEL_CONCAT, 0, -1, -1, "Internal concat/reformat HEAD_REQUANT_PACKED -> CONCAT_OUT");

    size_t step_idx = 0;
    bool step_issued = false;
    int idle_left = 0;
    int issued_cycle = -1;
    bool parallel_dma_done = false;
    bool parallel_cmp_done = false;

    uint16_t prev_regions = 0;

    std::printf("cycle state          step idx kind issued ready(d/c) done(m/h0) regions ov inv\n");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        const bool reset_n = (cycle >= 2);

        mmu_dma_req_start = false;
        mem_read_request = false;
        mem_write_request = false;
        dma_done = false;
        for (int h = 0; h < NUM_HEADS; ++h) {
            head_ctx[h].wl_start = false;
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            head_compute_ctx[lane].mem_read_request = false;
            head_compute_ctx[lane].mem_write_request = false;
        }

        if (dma_inflight) {
            if (dma_ctr > 0) {
                dma_ctr--;
            }
            if (dma_ctr == 0) {
                dma_done = true;
                dma_inflight = false;
            }
        }

        if (step_idx < steps.size()) {
            Step &s = steps[step_idx];

            if (!step_issued) {
                if (s.kind == Step::Kind::IDLE) {
                    step_issued = true;
                    idle_left = s.idle_cycles;
                    issued_cycle = cycle;
                    std::printf("\n[STEP %zu] IDLE %d cycles: %s\n", step_idx, s.idle_cycles, s.note);
                } else if (s.kind == Step::Kind::DMA_REQ) {
                    if (mmu_req_ready) {
                        if (is_headed_dma(s.dma_sel) && s.dma_head >= 0 && s.dma_head < NUM_HEADS) {
                            head_ctx[s.dma_head].wl_start = true;
                            head_ctx[s.dma_head].wl_instruction = pack_dma(s.dma_sel, s.dma_layer, s.dma_head, s.dma_tile);
                        } else {
                            mmu_dma_req_start = true;
                            mmu_dma_instruction = pack_dma(s.dma_sel, s.dma_layer, s.dma_head, s.dma_tile);
                        }
                        step_issued = true;
                        issued_cycle = cycle;
                        std::printf("\n[STEP %zu] ISSUE DMA  %-14s L=%d H=%d T=%d : %s\n",
                                    step_idx, dma_name(s.dma_sel), s.dma_layer, s.dma_head, s.dma_tile, s.note);
                    }
                } else if (s.kind == Step::Kind::CMP_REQ) {
                    {
                        const uint32_t packed = pack_compute(s.cmp_op, s.cmp_layer, s.cmp_head, s.cmp_tile);
                        if (is_headed_op(s.cmp_op) && s.cmp_head >= 0) {
                            const int lane = head_to_lane(s.cmp_head);
                            head_compute_ctx[lane].mem_op = packed;
                            head_compute_ctx[lane].mem_read_request = (s.cmp_type == ComputeReqType::READ);
                            head_compute_ctx[lane].mem_write_request = (s.cmp_type == ComputeReqType::WRITE);
                        } else {
                            mem_op = packed;
                            mem_read_request = (s.cmp_type == ComputeReqType::READ);
                            mem_write_request = (s.cmp_type == ComputeReqType::WRITE);
                        }

                        if (s.cmp_type == ComputeReqType::WRITE) {
                            if (is_headed_op(s.cmp_op)) {
                                const int lane = head_to_lane(s.cmp_head);
                                prep_head_out(head_out_buf, lane, static_cast<int>(step_idx));
                            } else {
                                prep_main_out(out_buf, static_cast<int>(step_idx));
                            }
                        }

                        step_issued = true;
                        issued_cycle = cycle;
                        std::printf("\n[STEP %zu] ISSUE CMP  %-14s %-5s L=%d H=%d T=%d : %s\n",
                                    step_idx,
                                    op_name(s.cmp_op),
                                    (s.cmp_type == ComputeReqType::READ) ? "READ" : "WRITE",
                                    s.cmp_layer,
                                    s.cmp_head,
                                    s.cmp_tile,
                                    s.note);
                    }
                } else { // HEAD_PARALLEL
                    if (mmu_req_ready) {
                        if (is_headed_dma(s.dma_sel) && s.dma_head >= 0 && s.dma_head < NUM_HEADS) {
                            head_ctx[s.dma_head].wl_start = true;
                            head_ctx[s.dma_head].wl_instruction = pack_dma(s.dma_sel, s.dma_layer, s.dma_head, s.dma_tile);
                        } else {
                            mmu_dma_req_start = true;
                            mmu_dma_instruction = pack_dma(s.dma_sel, s.dma_layer, s.dma_head, s.dma_tile);
                        }

                        const uint32_t packed = pack_compute(s.cmp_op, s.cmp_layer, s.cmp_head, s.cmp_tile);
                        if (is_headed_op(s.cmp_op) && s.cmp_head >= 0) {
                            const int lane = head_to_lane(s.cmp_head);
                            head_compute_ctx[lane].mem_op = packed;
                            head_compute_ctx[lane].mem_read_request = (s.cmp_type == ComputeReqType::READ);
                            head_compute_ctx[lane].mem_write_request = (s.cmp_type == ComputeReqType::WRITE);
                        } else {
                            mem_op = packed;
                            mem_read_request = (s.cmp_type == ComputeReqType::READ);
                            mem_write_request = (s.cmp_type == ComputeReqType::WRITE);
                        }

                        if (s.cmp_type == ComputeReqType::WRITE) {
                            if (is_headed_op(s.cmp_op)) {
                                const int lane = head_to_lane(s.cmp_head);
                                prep_head_out(head_out_buf, lane, static_cast<int>(step_idx));
                            } else {
                                prep_main_out(out_buf, static_cast<int>(step_idx));
                            }
                        }

                        parallel_dma_done = false;
                        parallel_cmp_done = false;
                        step_issued = true;
                        issued_cycle = cycle;
                        std::printf("\n[STEP %zu] ISSUE PAR DMA=%s(L=%d H=%d T=%d) + CMP=%s %s (L=%d H=%d T=%d) : %s\n",
                                    step_idx,
                                    dma_name(s.dma_sel), s.dma_layer, s.dma_head, s.dma_tile,
                                    op_name(s.cmp_op), (s.cmp_type == ComputeReqType::READ) ? "READ" : "WRITE",
                                    s.cmp_layer, s.cmp_head, s.cmp_tile,
                                    s.note);
                    }
                }
            }
        }

        mmu_fsm(
            reset_n,
            ctrl,
            dma_ready,
            dma_done,
            dma_rx_buf,
            dma_tx_buf,
            dma_start,
            dma_addr,
            dma_len,
            dma_is_write,
            mmu_dma_req_start,
            mmu_dma_instruction,
            mmu_req_ready,
            main_dma_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            mem_transfer_done,
            head_ctx,
            head_compute_ctx,
            in_buf,
            out_buf,
            head_in_buf,
            head_out_buf,
            status
        );

        if (dma_start) {
            dma_inflight = true;
            dma_ctr = DMA_LATENCY;
            dma_len_latched = dma_len;
            dma_is_write_latched = dma_is_write;
            dma_addr_latched = dma_addr;

            if (!dma_is_write_latched) {
                for (uint32_t i = 0; i < dma_len_latched && i < DMA_BUF_BYTES; ++i) {
                    dma_rx_buf[i] = static_cast<uint8_t>((dma_addr_latched + i + static_cast<uint32_t>(step_idx) * 17u) & 0xFFu);
                }
            }

            std::printf("  [DMA_CMD] start=%d write=%d addr=0x%08x len=%u\n",
                        static_cast<int>(dma_start),
                        static_cast<int>(dma_is_write),
                        static_cast<unsigned>(dma_addr),
                        static_cast<unsigned>(dma_len));
        }

        if (status.region_count != prev_regions) {
            std::printf("  [REGION] count %u -> %u (state=%s)\n",
                        static_cast<unsigned>(prev_regions),
                        static_cast<unsigned>(status.region_count),
                        state_name(status.state));
            prev_regions = status.region_count;
        }

        if (cycle < 30 || (cycle % 25) == 0) {
            std::printf("%5d %-14s step=%3zu issued=%d rdy=%d/%d done=%d/%d regions=%3u ov=%d inv=%d\n",
                        cycle,
                        state_name(status.state),
                        step_idx,
                        static_cast<int>(step_issued),
                        static_cast<int>(mmu_req_ready),
                        static_cast<int>(mmu_req_ready),
                        static_cast<int>(main_dma_done),
                        static_cast<int>(head_ctx[0].dma_done || head_compute_ctx[0].mem_transfer_done),
                        static_cast<unsigned>(status.region_count),
                        static_cast<int>(status.overflow),
                        static_cast<int>(status.invalid));
        }

        if (step_idx < steps.size() && step_issued) {
            Step &s = steps[step_idx];
            bool done = false;

            if (s.kind == Step::Kind::IDLE) {
                idle_left--;
                done = (idle_left <= 0);
            } else if (s.kind == Step::Kind::DMA_REQ) {
                if (is_headed_dma(s.dma_sel) && s.dma_head >= 0 && s.dma_head < NUM_HEADS) {
                    done = head_ctx[s.dma_head].dma_done;
                } else {
                    done = main_dma_done;
                }
            } else if (s.kind == Step::Kind::CMP_REQ) {
                if (is_headed_op(s.cmp_op) && s.cmp_head >= 0 && s.cmp_head < NUM_HEADS) {
                    const int lane = head_to_lane(s.cmp_head);
                    done = head_compute_ctx[lane].mem_transfer_done;
                } else {
                    done = mem_transfer_done;
                }
            } else {
                if (!parallel_dma_done) {
                    if (is_headed_dma(s.dma_sel) && s.dma_head >= 0 && s.dma_head < NUM_HEADS) {
                        parallel_dma_done = head_ctx[s.dma_head].dma_done;
                    } else {
                        parallel_dma_done = main_dma_done;
                    }
                }
                if (!parallel_cmp_done) {
                    if (is_headed_op(s.cmp_op) && s.cmp_head >= 0 && s.cmp_head < NUM_HEADS) {
                        const int lane = head_to_lane(s.cmp_head);
                        parallel_cmp_done = head_compute_ctx[lane].mem_transfer_done;
                    } else {
                        parallel_cmp_done = mem_transfer_done;
                    }
                }
                done = parallel_dma_done && parallel_cmp_done;
            }

            if (done) {
                const int lat = cycle - issued_cycle + 1;
                std::printf("[STEP %zu] DONE in %d cycles\n", step_idx, lat);

                if (s.kind == Step::Kind::DMA_REQ && dma_is_write_latched) {
                    dump_bytes("  dma_tx_buf[0:16] = ", dma_tx_buf, 16);
                }
                if ((s.kind == Step::Kind::CMP_REQ || s.kind == Step::Kind::HEAD_PARALLEL) &&
                    s.cmp_type == ComputeReqType::READ) {
                    if (is_headed_op(s.cmp_op)) {
                        const int lane = head_to_lane(s.cmp_head);
                        dump_bytes("  head_in_buf[lane][0:16] = ", head_in_buf[lane], 16);
                    } else {
                        dump_bytes("  in_buf[0:16] = ", in_buf, 16);
                    }
                }

                step_idx++;
                step_issued = false;
                issued_cycle = -1;
            }
        }

        if (status.overflow || status.invalid) {
            std::printf("\n[TB] stopping on MMU error: overflow=%d invalid=%d at cycle %d\n",
                        static_cast<int>(status.overflow),
                        static_cast<int>(status.invalid),
                        cycle);
            return 1;
        }

        if (step_idx >= steps.size()) {
            std::printf("\n[TB] all steps complete at cycle %d\n", cycle);
            break;
        }
    }

    std::printf("\n[TB] final region_count=%u\n", static_cast<unsigned>(status.region_count));
    return 0;
}
