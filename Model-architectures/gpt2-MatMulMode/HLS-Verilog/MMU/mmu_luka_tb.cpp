#include <cstdio>
#include <cstdint>
#include <cstring>
#include <cerrno>
#include <vector>
#include <string>
#include <sys/stat.h>

#include "../tb_paths.hpp"
#include "mmu_luka.hpp"

namespace {

static inline uint64_t pack_dma(DmaSel sel, int layer, int head, int tile) {
    const uint64_t op_field    = static_cast<uint64_t>(static_cast<uint8_t>(sel));
    const uint64_t layer_field = static_cast<uint64_t>(static_cast<uint8_t>(layer));
    const uint64_t head_field  = static_cast<uint64_t>(static_cast<uint8_t>(head));
    const uint64_t tile_field  = static_cast<uint64_t>(static_cast<uint32_t>(tile));
    return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}

static inline uint64_t pack_compute(ComputeOp op, int layer, int head, int tile) {
    const uint64_t op_field    = static_cast<uint64_t>(static_cast<uint8_t>(op));
    const uint64_t layer_field = static_cast<uint64_t>(static_cast<uint8_t>(layer));
    const uint64_t head_field  = static_cast<uint64_t>(static_cast<uint8_t>(head));
    const uint64_t tile_field  = static_cast<uint64_t>(static_cast<uint32_t>(tile));
    return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
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
        case DMASEL_LN0: return "DMASEL_LN0";
        case DMASEL_LN1: return "DMASEL_LN1";
        case DMASEL_FINAL_NORM: return "DMASEL_FINAL_NORM";
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
        case CMP_REQUANT_POST_OUTPROJ: return "CMP_REQUANT_POST_OUTPROJ";
        case CMP_RESID1: return "CMP_RESID1";
        case CMP_LN1: return "CMP_LN1";
        case CMP_REQUANT_POST_LN1: return "CMP_REQUANT_POST_LN1";
        case CMP_FFN_W1: return "CMP_FFN_W1";
        case CMP_FFN_ACT: return "CMP_FFN_ACT";
        case CMP_FFN_W2: return "CMP_FFN_W2";
        case CMP_REQUANT_POST_FFN: return "CMP_REQUANT_POST_FFN";
        case CMP_RESID2: return "CMP_RESID2";
        case CMP_FINAL_NORM: return "CMP_FINAL_NORM";
        case CMP_REQUANT_POST_LN0: return "CMP_REQUANT_POST_LN0";
        case CMP_REQUANT_Q: return "CMP_REQUANT_Q";
        default: return "CMP?";
    }
}

static void dump_bytes(const char *label, const uint8_t *buf, int n) {
    std::printf("%s", label);
    for (int i = 0; i < n; ++i) {
        std::printf("%02x%s", static_cast<unsigned>(buf[i]), (i + 1 == n) ? "\n" : " ");
    }
}

static inline uint8_t dma_word_get_byte(const uint32_t *buf, uint32_t byte_idx) {
    const uint32_t word = buf[byte_idx >> 2];
    const uint32_t shift = (byte_idx & 0x3u) << 3;
    return static_cast<uint8_t>((word >> shift) & 0xFFu);
}

static inline void dma_word_set_byte(uint32_t *buf, uint32_t byte_idx, uint8_t value) {
    const uint32_t word_idx = byte_idx >> 2;
    const uint32_t shift = (byte_idx & 0x3u) << 3;
    uint32_t word = buf[word_idx];
    word &= ~(0xFFu << shift);
    word |= (static_cast<uint32_t>(value) << shift);
    buf[word_idx] = word;
}

static void dump_dma_bytes(const char *label, const uint32_t *buf, int n) {
    std::printf("%s", label);
    for (int i = 0; i < n; ++i) {
        std::printf("%02x%s",
                    static_cast<unsigned>(dma_word_get_byte(buf, static_cast<uint32_t>(i))),
                    (i + 1 == n) ? "\n" : " ");
    }
}

static void prep_main_out(uint8_t *out_buf, int step_id) {
    for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
        out_buf[i] = static_cast<uint8_t>((0x30 + step_id + i) & 0xFF);
    }
}

struct Step {
    enum class Kind : uint8_t { IDLE, DMA_REQ, CMP_REQ } kind = Kind::IDLE;
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
    std::printf("\n[CTRL_MEM] strides:\n");
    std::printf("  wq_layer_stride=%u\n", static_cast<unsigned>(STRIDE_WQ_LAYER));
    std::printf("  qkv_head_stride=%u\n", static_cast<unsigned>(STRIDE_QKV_HEAD));
    std::printf("  kv_layer_stride=%u\n", static_cast<unsigned>(STRIDE_KV_LAYER));
    std::printf("  kv_head_stride=%u\n", static_cast<unsigned>(STRIDE_KV_HEAD));
    std::printf("  wo_tile_stride=%u\n", static_cast<unsigned>(STRIDE_WO_TILE));
    std::printf("  w1_tile_stride=%u\n", static_cast<unsigned>(STRIDE_W1_TILE));
    std::printf("  w2_tile_stride=%u\n", static_cast<unsigned>(STRIDE_W2_TILE));
    std::printf("  wo_bias_tile_stride=%u\n", static_cast<unsigned>(STRIDE_WO_BIAS_TILE));
    std::printf("  w1_bias_tile_stride=%u\n", static_cast<unsigned>(STRIDE_W1_BIAS_TILE));
    std::printf("  w2_bias_tile_stride=%u\n", static_cast<unsigned>(STRIDE_W2_BIAS_TILE));
    std::printf("  wlogit_tile_stride=%u\n", static_cast<unsigned>(STRIDE_WLOGIT_TILE));
    std::printf("  ln0_gamma_stride=%u\n", static_cast<unsigned>(STRIDE_LN0_GAMMA));
    std::printf("  ln1_gamma_stride=%u\n", static_cast<unsigned>(STRIDE_LN1_GAMMA));
    std::printf("  final_norm_gamma_stride=%u\n", static_cast<unsigned>(STRIDE_FINAL_NORM_GAMMA));
    std::printf("  ln0_eps_stride=%u\n", static_cast<unsigned>(STRIDE_LN0_EPS));
    std::printf("  ln1_eps_stride=%u\n", static_cast<unsigned>(STRIDE_LN1_EPS));
    std::printf("  final_norm_eps_stride=%u\n", static_cast<unsigned>(STRIDE_FINAL_NORM_EPS));

    std::printf("[CTRL_MEM] base addresses:\n");
    std::printf("  wq_offset=0x%x\n", static_cast<unsigned>(ctrl.wq_offset));
    std::printf("  wk_offset=0x%x\n", static_cast<unsigned>(ctrl.wk_offset));
    std::printf("  wv_offset=0x%x\n", static_cast<unsigned>(ctrl.wv_offset));
    std::printf("  wo_offset=0x%x\n", static_cast<unsigned>(ctrl.wo_offset));
    std::printf("  w1_offset=0x%x\n", static_cast<unsigned>(ctrl.w1_offset));
    std::printf("  w2_offset=0x%x\n", static_cast<unsigned>(ctrl.w2_offset));
    std::printf("  k_cache_offset=0x%x\n", static_cast<unsigned>(ctrl.k_cache_offset));
    std::printf("  v_cache_offset=0x%x\n", static_cast<unsigned>(ctrl.v_cache_offset));
    std::printf("  wq_bias_offset=0x%x\n", static_cast<unsigned>(ctrl.wq_bias_offset));
    std::printf("  wk_bias_offset=0x%x\n", static_cast<unsigned>(ctrl.wk_bias_offset));
    std::printf("  wv_bias_offset=0x%x\n", static_cast<unsigned>(ctrl.wv_bias_offset));
    std::printf("  wo_bias_offset=0x%x\n", static_cast<unsigned>(ctrl.wo_bias_offset));
    std::printf("  w1_bias_offset=0x%x\n", static_cast<unsigned>(ctrl.w1_bias_offset));
    std::printf("  w2_bias_offset=0x%x\n", static_cast<unsigned>(ctrl.w2_bias_offset));
    std::printf("  ln0_gamma_offset=0x%x\n", static_cast<unsigned>(ctrl.ln0_gamma_offset));
    std::printf("  ln1_gamma_offset=0x%x\n", static_cast<unsigned>(ctrl.ln1_gamma_offset));
    std::printf("  final_norm_gamma_offset=0x%x\n", static_cast<unsigned>(ctrl.final_norm_gamma_offset));
    std::printf("  ln0_eps_offset=0x%x\n", static_cast<unsigned>(ctrl.ln0_eps_offset));
    std::printf("  ln1_eps_offset=0x%x\n", static_cast<unsigned>(ctrl.ln1_eps_offset));
    std::printf("  final_norm_eps_offset=0x%x\n", static_cast<unsigned>(ctrl.final_norm_eps_offset));
}

static void print_error_code_bits(uint32_t err) {
    if (err == ERR_NONE) {
        std::printf("ERR_NONE");
        return;
    }

    bool first = true;
    auto emit = [&](const char *name) {
        if (!first) {
            std::printf("|");
        }
        std::printf("%s", name);
        first = false;
    };

    if (err & ERR_DMA_ALIGNMENT) emit("ERR_DMA_ALIGNMENT");
    if (err & ERR_DMA_ZERO_LEN) emit("ERR_DMA_ZERO_LEN");
    if (err & ERR_DMA_ZERO_STRIDE) emit("ERR_DMA_ZERO_STRIDE");
    if (err & ERR_SCHEDULER_ERROR) emit("ERR_SCHEDULER_ERROR");
    if (err & ERR_COMPUTE_ERROR) emit("ERR_COMPUTE_ERROR");
    if (err & ERR_MMU_INVALID) emit("ERR_MMU_INVALID");
    if (err & ERR_MMU_OVERFLOW) emit("ERR_MMU_OVERFLOW");
    if (err & ERR_MMU_UNSUPPORTED_REQ_DMA) emit("ERR_MMU_UNSUPPORTED_REQ_DMA");
    if (err & ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED) emit("ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED");
    if (err & ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED) emit("ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED");
    if (err & ERR_MMU_BAD_DMA_PLAN) emit("ERR_MMU_BAD_DMA_PLAN");
    if (err & ERR_MMU_BAD_DMA_ADDR) emit("ERR_MMU_BAD_DMA_ADDR");
    if (err & ERR_MMU_REGION_ACCESS) emit("ERR_MMU_REGION_ACCESS");
    if (err & ERR_MMU_CONCAT_SOURCE) emit("ERR_MMU_CONCAT_SOURCE");
    if (err & ERR_MMU_WRITEBACK_SRC) emit("ERR_MMU_WRITEBACK_SRC");
    if (err & ERR_MMU_QUEUE_OVERFLOW) emit("ERR_MMU_QUEUE_OVERFLOW");
    if (err & ERR_MMU_REGION_OVERFLOW) emit("ERR_MMU_REGION_OVERFLOW");
    if (err & ERR_MMU_STREAM_OUTPUT_MISSING) emit("ERR_MMU_STREAM_OUTPUT_MISSING");
    if (err & ERR_MMU_MISSING_REGION_FULL_READ) emit("ERR_MMU_MISSING_REGION_FULL_READ");
    if (err & ERR_MMU_MISSING_REGION_PARTIAL_READ) emit("ERR_MMU_MISSING_REGION_PARTIAL_READ");
    if (err & ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP) emit("ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP");
    if (err & ERR_MMU_REGION_OVERFLOW_STREAM_IN) emit("ERR_MMU_REGION_OVERFLOW_STREAM_IN");
    if (err & ERR_MMU_REGION_OVERFLOW_DMA_CONCAT) emit("ERR_MMU_REGION_OVERFLOW_DMA_CONCAT");
    if (err & ERR_MMU_REGION_OVERFLOW_DMA_STORE) emit("ERR_MMU_REGION_OVERFLOW_DMA_STORE");
    if (err & ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE) emit("ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE");
    if (err & ERR_MMU_REGION_TABLE_FULL) emit("ERR_MMU_REGION_TABLE_FULL");
    if (err & ERR_MMU_URAM_CHUNK_ALLOC_FAIL) emit("ERR_MMU_URAM_CHUNK_ALLOC_FAIL");
    if (err & ERR_MMU_REGION_TOO_LARGE) emit("ERR_MMU_REGION_TOO_LARGE");
    if (err & ERR_TOKEN_MAX) emit("ERR_TOKEN_MAX");
}

static const char *mmu_subcode_name(uint32_t subcode) {
    switch (subcode) {
        case MMU_ERR_SUBCODE_NONE: return "NONE";
        case MMU_ERR_SUBCODE_UNSUPPORTED_REQ_DMA: return "UNSUPPORTED_REQ_DMA";
        case MMU_ERR_SUBCODE_UNSUPPORTED_REQ_COMPUTE_HEADED: return "UNSUPPORTED_REQ_COMPUTE_HEADED";
        case MMU_ERR_SUBCODE_UNSUPPORTED_REQ_COMPUTE_NONHEADED: return "UNSUPPORTED_REQ_COMPUTE_NONHEADED";
        case MMU_ERR_SUBCODE_BAD_DMA_PLAN: return "BAD_DMA_PLAN";
        case MMU_ERR_SUBCODE_BAD_DMA_ADDR: return "BAD_DMA_ADDR";
        case MMU_ERR_SUBCODE_REGION_ACCESS: return "REGION_ACCESS";
        case MMU_ERR_SUBCODE_CONCAT_SOURCE: return "CONCAT_SOURCE";
        case MMU_ERR_SUBCODE_WRITEBACK_SRC: return "WRITEBACK_SRC";
        case MMU_ERR_SUBCODE_QUEUE_OVERFLOW: return "QUEUE_OVERFLOW";
        case MMU_ERR_SUBCODE_STREAM_OUTPUT_MISSING: return "STREAM_OUTPUT_MISSING";
        case MMU_ERR_SUBCODE_MISSING_REGION_FULL_READ: return "MISSING_REGION_FULL_READ";
        case MMU_ERR_SUBCODE_MISSING_REGION_PARTIAL_READ: return "MISSING_REGION_PARTIAL_READ";
        case MMU_ERR_SUBCODE_MISSING_REGION_COMPUTE_READ_PREP: return "MISSING_REGION_COMPUTE_READ_PREP";
        case MMU_ERR_SUBCODE_REGION_OVERFLOW_STREAM_IN: return "REGION_OVERFLOW_STREAM_IN";
        case MMU_ERR_SUBCODE_REGION_OVERFLOW_DMA_CONCAT: return "REGION_OVERFLOW_DMA_CONCAT";
        case MMU_ERR_SUBCODE_REGION_OVERFLOW_DMA_STORE: return "REGION_OVERFLOW_DMA_STORE";
        case MMU_ERR_SUBCODE_REGION_OVERFLOW_COMPUTE_WRITE: return "REGION_OVERFLOW_COMPUTE_WRITE";
        case MMU_ERR_SUBCODE_REGION_TABLE_FULL: return "REGION_TABLE_FULL";
        case MMU_ERR_SUBCODE_URAM_CHUNK_ALLOC_FAIL: return "URAM_CHUNK_ALLOC_FAIL";
        case MMU_ERR_SUBCODE_REGION_TOO_LARGE: return "REGION_TOO_LARGE";
        case MMU_ERR_SUBCODE_REGION_OVERFLOW_GENERIC: return "REGION_OVERFLOW_GENERIC";
        case MMU_ERR_SUBCODE_MISSING_STREAM_IN_TOKEN: return "MISSING_STREAM_IN_TOKEN";
        case MMU_ERR_SUBCODE_MISSING_LN0_OUT: return "MISSING_LN0_OUT";
        case MMU_ERR_SUBCODE_MISSING_WQ_W: return "MISSING_WQ_W";
        case MMU_ERR_SUBCODE_MISSING_WQ_B: return "MISSING_WQ_B";
        case MMU_ERR_SUBCODE_MISSING_WK_W: return "MISSING_WK_W";
        case MMU_ERR_SUBCODE_MISSING_WK_B: return "MISSING_WK_B";
        case MMU_ERR_SUBCODE_MISSING_WV_W: return "MISSING_WV_W";
        case MMU_ERR_SUBCODE_MISSING_WV_B: return "MISSING_WV_B";
        case MMU_ERR_SUBCODE_MISSING_Q_OUT: return "MISSING_Q_OUT";
        case MMU_ERR_SUBCODE_MISSING_CTX_K: return "MISSING_CTX_K";
        case MMU_ERR_SUBCODE_MISSING_ATT_SCORES_OUT: return "MISSING_ATT_SCORES_OUT";
        case MMU_ERR_SUBCODE_MISSING_VALUE_SCALE_OUT: return "MISSING_VALUE_SCALE_OUT";
        case MMU_ERR_SUBCODE_MISSING_SOFTMAX_OUT: return "MISSING_SOFTMAX_OUT";
        case MMU_ERR_SUBCODE_MISSING_CTX_V: return "MISSING_CTX_V";
        case MMU_ERR_SUBCODE_MISSING_ATT_VALUE_OUT: return "MISSING_ATT_VALUE_OUT";
        case MMU_ERR_SUBCODE_MISSING_HEAD_REQUANT_PACKED: return "MISSING_HEAD_REQUANT_PACKED";
        case MMU_ERR_SUBCODE_MISSING_CONCAT_OUT: return "MISSING_CONCAT_OUT";
        case MMU_ERR_SUBCODE_MISSING_WO_W: return "MISSING_WO_W";
        case MMU_ERR_SUBCODE_MISSING_WO_B: return "MISSING_WO_B";
        case MMU_ERR_SUBCODE_MISSING_OUT_PROJ_PACKED: return "MISSING_OUT_PROJ_PACKED";
        case MMU_ERR_SUBCODE_MISSING_RESID1_OUT: return "MISSING_RESID1_OUT";
        case MMU_ERR_SUBCODE_MISSING_LN1_OUT: return "MISSING_LN1_OUT";
        case MMU_ERR_SUBCODE_MISSING_W1_W: return "MISSING_W1_W";
        case MMU_ERR_SUBCODE_MISSING_W1_B: return "MISSING_W1_B";
        case MMU_ERR_SUBCODE_MISSING_FFN_W1_PACKED: return "MISSING_FFN_W1_PACKED";
        case MMU_ERR_SUBCODE_MISSING_FFN_ACT_OUT: return "MISSING_FFN_ACT_OUT";
        case MMU_ERR_SUBCODE_MISSING_W2_W: return "MISSING_W2_W";
        case MMU_ERR_SUBCODE_MISSING_W2_B: return "MISSING_W2_B";
        case MMU_ERR_SUBCODE_MISSING_FFN_W2_PACKED: return "MISSING_FFN_W2_PACKED";
        case MMU_ERR_SUBCODE_MISSING_RESID2_OUT: return "MISSING_RESID2_OUT";
        case MMU_ERR_SUBCODE_MISSING_LN0_GAMMA: return "MISSING_LN0_GAMMA";
        case MMU_ERR_SUBCODE_MISSING_LN0_EPS: return "MISSING_LN0_EPS";
        case MMU_ERR_SUBCODE_MISSING_LN1_GAMMA: return "MISSING_LN1_GAMMA";
        case MMU_ERR_SUBCODE_MISSING_LN1_EPS: return "MISSING_LN1_EPS";
        default: return "UNKNOWN_SUBCODE";
    }
}

static bool ensure_dir(const char *path) {
    if (mkdir(path, 0777) == 0) {
        return true;
    }
    return (errno == EEXIST);
}

static bool init_tb_logs() {
    const std::string base_dir = tb_paths::log_root_from_file(__FILE__);
    const std::string tb_dir = base_dir + "/mmu_luka_tb";
    const std::string stdout_path = tb_dir + "/mmu_luka_tb_stdout.log";
    const std::string stderr_path = tb_dir + "/mmu_luka_tb_stderr.log";

    if (!ensure_dir(base_dir.c_str()) || !ensure_dir(tb_dir.c_str())) {
        std::fprintf(stderr, "[TB][ERROR] failed to create log directories\n");
        return false;
    }
    if (std::freopen(stdout_path.c_str(), "w", stdout) == nullptr) {
        std::fprintf(stderr, "[TB][ERROR] failed to open stdout log: %s\n", stdout_path.c_str());
        return false;
    }
    if (std::freopen(stderr_path.c_str(), "w", stderr) == nullptr) {
        std::fprintf(stdout, "[TB][ERROR] failed to open stderr log: %s\n", stderr_path.c_str());
        return false;
    }
    setvbuf(stdout, nullptr, _IOLBF, 0);
    setvbuf(stderr, nullptr, _IOLBF, 0);
    return true;
}

} // namespace

int main() {
    if (!init_tb_logs()) {
        return 1;
    }
    constexpr int MAX_CYCLES = 5000;
    constexpr int DMA_LATENCY = 3;

    ControlMemSpace ctrl{};

    ctrl.wq_offset = 0x10000000u;
    ctrl.wk_offset = 0x11000000u;
    ctrl.wv_offset = 0x12000000u;
    ctrl.wo_offset = 0x13000000u;
    ctrl.w1_offset = 0x14000000u;
    ctrl.w2_offset = 0x15000000u;
    ctrl.k_cache_offset = 0x20000000u;
    ctrl.v_cache_offset = 0x21000000u;

    static uint32_t dma_rx_buf[DMA_BUF_WORDS];
    static uint32_t dma_tx_buf[DMA_BUF_WORDS];
    static uint8_t in_buf[compute_buf::IN_BUF_BYTES];
    static uint8_t out_buf[compute_buf::OUT_BUF_BYTES];
    static uint8_t stream_in_buf[STREAM_IN_BUF_BYTES];
    static uint8_t stream_out_buf[STREAM_OUT_BUF_BYTES];

    std::memset(dma_rx_buf, 0, sizeof(dma_rx_buf));
    std::memset(dma_tx_buf, 0, sizeof(dma_tx_buf));
    std::memset(in_buf, 0, sizeof(in_buf));
    std::memset(out_buf, 0, sizeof(out_buf));
    std::memset(stream_in_buf, 0, sizeof(stream_in_buf));
    std::memset(stream_out_buf, 0, sizeof(stream_out_buf));
    for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
        stream_in_buf[i] = static_cast<uint8_t>((i * 5 + 1) & 0x7F);
    }

    bool dma_ready = true;
    bool dma_done = false;
    bool dma_start = false;
    uint64_t dma_addr = 0;
    uint32_t dma_len = 0;
    bool dma_is_write = false;
    bool dma_use_kv_cache = false;

    bool mmu_dma_req_start = false;
    uint64_t mmu_dma_instruction = 0;
    bool mmu_req_ready = false;
    bool main_wl_accept = false;
    bool main_dma_done = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    uint64_t mem_op = 0;
    bool mem_transfer_done = false;
    bool axis_in_valid = false;
    bool axis_in_last = false;
    bool axis_in_ready = false;
    bool stream_start = false;

    Status status{};

    bool dma_inflight = false;
    int dma_ctr = 0;
    uint32_t dma_len_latched = 0;
    bool dma_is_write_latched = false;
    uint64_t dma_addr_latched = 0;

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

    // 1) IDLE first.
    add_idle(12, "Observe IDLE/GC before traffic");

    // 2) Single-request phase for NON-HEADED path first.
    add_dma(DMASEL_W1, 0, -1, 0, "Load W1 tile0 + B1 tile0");
    add_dma(DMASEL_W2, 0, -1, 0, "Load W2 tile0 + B2 tile0");

    add_cmp(CMP_LN0, ComputeReqType::WRITE, 0, -1, -1, "Single: write LN0_OUT");
    for (int t = 0; t < NUM_WO_TILES; ++t) {
        add_cmp(CMP_OUT_PROJ, ComputeReqType::WRITE, 0, -1, t, "Single: write OUT_PROJ tile");
    }
    add_cmp(CMP_RESID1, ComputeReqType::WRITE, 0, -1, -1, "Single: write RESID1_OUT");
    add_cmp(CMP_LN1, ComputeReqType::WRITE, 0, -1, -1, "Single: write LN1_OUT");
    add_cmp(CMP_FFN_W1, ComputeReqType::READ, 0, -1, 0, "Consume W1/B1 via CMP_FFN_W1 READ tile0");

    for (int t = 0; t < NUM_W1_TILES; ++t) {
        add_cmp(CMP_FFN_W1, ComputeReqType::WRITE, 0, -1, t, "Single: write FFN_W1 tile");
    }
    add_cmp(CMP_FFN_ACT, ComputeReqType::READ, 0, -1, -1, "Single: read FFN_ACT input");
    add_cmp(CMP_FFN_ACT, ComputeReqType::WRITE, 0, -1, -1, "Single: write FFN_ACT_OUT");

    add_cmp(CMP_FFN_W2, ComputeReqType::READ, 0, -1, 0, "Single: read FFN_W2 input");
    for (int t = 0; t < NUM_W2_TILES; ++t) {
        add_cmp(CMP_FFN_W2, ComputeReqType::WRITE, 0, -1, t, "Single: write FFN_W2 tile");
    }
    add_cmp(CMP_RESID2, ComputeReqType::WRITE, 0, -1, -1, "Single: write RESID2_OUT");
    add_cmp(CMP_FINAL_NORM, ComputeReqType::WRITE, 0, -1, -1, "Single: write FINAL_NORM_OUT");

    size_t step_idx = 0;
    bool step_issued = false;
    int idle_left = 0;
    int issued_cycle = -1;

    uint16_t prev_regions = 0;

    std::printf("%6s | %5s | %-12s | %6s | %8s | %8s | %7s | %9s | %9s | %7s | %7s | %7s\n",
                "cycle", "rst_n", "mmu_state", "step", "dma_req", "cmp_req", "dma_st",
                "dma_done", "main_done", "cmp_done", "regions", "suberr");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        const bool reset_n = (cycle >= 2);

        mmu_dma_req_start = false;
        mem_read_request = false;
        mem_write_request = false;
        dma_done = false;

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
                        mmu_dma_req_start = true;
                        mmu_dma_instruction = pack_dma(s.dma_sel, s.dma_layer, s.dma_head, s.dma_tile);
                        step_issued = true;
                        issued_cycle = cycle;
                        std::printf("\n[STEP %zu] ISSUE DMA  %-14s L=%d H=%d T=%d : %s\n",
                                    step_idx, dma_name(s.dma_sel), s.dma_layer, s.dma_head, s.dma_tile, s.note);
                    }
                } else if (s.kind == Step::Kind::CMP_REQ) {
                    {
                        const uint64_t packed = pack_compute(s.cmp_op, s.cmp_layer, s.cmp_head, s.cmp_tile);
                        mem_op = packed;
                        mem_read_request = (s.cmp_type == ComputeReqType::READ);
                        mem_write_request = (s.cmp_type == ComputeReqType::WRITE);

                        if (s.cmp_type == ComputeReqType::WRITE) {
                            prep_main_out(out_buf, static_cast<int>(step_idx));
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
                }
            }
        }

        mmu_fsm(
            reset_n,
            ctrl,
            static_cast<uint16_t>(0),
            dma_ready,
            dma_done,
            dma_rx_buf,
            dma_tx_buf,
            dma_start,
            dma_addr,
            dma_len,
            dma_is_write,
            dma_use_kv_cache,
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            stream_start,
            stream_in_buf,
            stream_out_buf,
            mmu_dma_req_start,
            mmu_dma_instruction,
            mmu_req_ready,
            main_wl_accept,
            main_dma_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            mem_transfer_done,
            in_buf,
            out_buf,
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
                    dma_word_set_byte(dma_rx_buf, i,
                                      static_cast<uint8_t>((dma_addr_latched + i + static_cast<uint32_t>(step_idx) * 17u) & 0xFFu));
                }
            }

            std::printf("  [DMA_CMD] start=%d write=%d addr=0x%016llx len=%u\n",
                        static_cast<int>(dma_start),
                        static_cast<int>(dma_is_write),
                        static_cast<unsigned long long>(dma_addr),
                        static_cast<unsigned>(dma_len));
        }

        if (status.region_count != prev_regions) {
            std::printf("  [REGION] count %u -> %u (state=%s)\n",
                        static_cast<unsigned>(prev_regions),
                        static_cast<unsigned>(status.region_count),
                        state_name(status.state));
            prev_regions = status.region_count;
        }

        std::printf("%6d | %5d | %-12s | %6u | %8d | %8d | %7d | %9d | %9d | %7d | %7u | %7u\n",
                    cycle,
                    reset_n ? 1 : 0,
                    state_name(status.state),
                    static_cast<unsigned>(step_idx),
                    mmu_dma_req_start ? 1 : 0,
                    (mem_read_request || mem_write_request) ? 1 : 0,
                    dma_start ? 1 : 0,
                    dma_done ? 1 : 0,
                    main_dma_done ? 1 : 0,
                    mem_transfer_done ? 1 : 0,
                    static_cast<unsigned>(status.region_count),
                    status.error_subcode);

        if (step_idx < steps.size() && step_issued) {
            Step &s = steps[step_idx];
            bool done = false;

            if (s.kind == Step::Kind::IDLE) {
                idle_left--;
                done = (idle_left <= 0);
            } else if (s.kind == Step::Kind::DMA_REQ) {
                done = main_dma_done;
            } else if (s.kind == Step::Kind::CMP_REQ) {
                done = mem_transfer_done;
            }

            if (done) {
                const int lat = cycle - issued_cycle + 1;
                std::printf("[STEP %zu] DONE in %d cycles\n", step_idx, lat);

                if (s.kind == Step::Kind::DMA_REQ && dma_is_write_latched) {
                    dump_dma_bytes("  dma_tx_buf[0:16] = ", dma_tx_buf, 16);
                }
                if (s.kind == Step::Kind::CMP_REQ && s.cmp_type == ComputeReqType::READ) {
                    dump_bytes("  in_buf[0:16] = ", in_buf, 16);
                }

                step_idx++;
                step_issued = false;
                issued_cycle = -1;
            }
        }

        if (status.overflow || status.invalid) {
            std::printf("\n[TB] stopping on MMU error: overflow=%d invalid=%d cycle=%d code=0x%08X suberr=0x%08X(%s) : ",
                        static_cast<int>(status.overflow),
                        static_cast<int>(status.invalid),
                        cycle,
                        status.error_code,
                        status.error_subcode,
                        mmu_subcode_name(status.error_subcode));
            print_error_code_bits(status.error_code);
            std::printf("\n");
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
