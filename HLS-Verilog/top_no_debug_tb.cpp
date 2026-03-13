// Testbench for the production (no-debug) transformer top module.
// Mirrors the functional flow of top_DEBUG_tb.cpp but uses only the
// 6-port transformer_top interface (no debug mirror ports).
#include <cstdio>
#include <cstdint>
#include <cstdlib>
#include <cerrno>
#include <cstring>
#include <fstream>
#include <limits>
#include <string>
#include <ctime>
#include <vector>
#include <sys/stat.h>

#include "tb_model_bin_loader.hpp"
#include "top_no_debug.hpp"

#ifndef TOP_NO_DEBUG_TB_BASENAME
#define TOP_NO_DEBUG_TB_BASENAME "top_no_debug_tb"
#endif

#ifndef TOP_NO_DEBUG_TB_LOG_SUBDIR
#define TOP_NO_DEBUG_TB_LOG_SUBDIR "top_no_debug"
#endif

constexpr bool TB_DEBUG_MODE = false;

static bool ensure_dir_recursive(const char *dir) {
    char path[512];
    std::snprintf(path, sizeof(path), "%s", dir);
    const size_t n = std::strlen(path);
    if (n == 0) {
        return false;
    }
    if (path[n - 1] == '/') {
        path[n - 1] = '\0';
    }

    for (char *p = path + 1; *p != '\0'; ++p) {
        if (*p == '/') {
            *p = '\0';
            if (::mkdir(path, 0777) != 0 && errno != EEXIST) {
                return false;
            }
            *p = '/';
        }
    }
    return (::mkdir(path, 0777) == 0 || errno == EEXIST);
}

static bool init_tb_logs() {
    const char *log_root = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs";
    char log_dir[512];
    std::snprintf(log_dir, sizeof(log_dir), "%s/%s", log_root, TOP_NO_DEBUG_TB_LOG_SUBDIR);

    if (!ensure_dir_recursive(log_dir)) {
        std::fprintf(stderr, "ERROR: Failed to create log dir '%s': %s\n",
                     log_dir, std::strerror(errno));
        return false;
    }

    char stdout_path[512];
    char stderr_path[512];
    char timestamp[32];
    {
        const std::time_t now = std::time(nullptr);
        std::tm tm_now{};
#if defined(_WIN32)
        localtime_s(&tm_now, &now);
#else
        localtime_r(&now, &tm_now);
#endif
        std::strftime(timestamp, sizeof(timestamp), "%Y%m%d_%H%M%S", &tm_now);
    }
    std::snprintf(stdout_path, sizeof(stdout_path), "%s/%s_stdout_%s.log", log_dir, TOP_NO_DEBUG_TB_BASENAME, timestamp);
    std::snprintf(stderr_path, sizeof(stderr_path), "%s/%s_stderr_%s.log", log_dir, TOP_NO_DEBUG_TB_BASENAME, timestamp);

    if (std::freopen(stdout_path, "w", stdout) == nullptr) {
        std::fprintf(stderr, "ERROR: Failed to open stdout log '%s': %s\n",
                     stdout_path, std::strerror(errno));
        return false;
    }
    if (std::freopen(stderr_path, "w", stderr) == nullptr) {
        std::fprintf(stdout, "ERROR: Failed to open stderr log '%s': %s\n",
                     stderr_path, std::strerror(errno));
        return false;
    }

    std::printf("[LOG] %s stdout: %s\n", TOP_NO_DEBUG_TB_BASENAME, stdout_path);
    std::fprintf(stderr, "[LOG] %s stderr: %s\n", TOP_NO_DEBUG_TB_BASENAME, stderr_path);
    return true;
}

constexpr uint64_t TB_DDR_IMAGE_BYTES = static_cast<uint64_t>(WEIGHTS_SIZE);
constexpr uint64_t TB_DDR_IMAGE_WORDS       = TB_DDR_IMAGE_BYTES / AXI_GMEM_WORD_BYTES;
constexpr uint64_t TB_KV_IMAGE_BYTES  = static_cast<uint64_t>(KV_SIZE);
constexpr uint64_t TB_KV_IMAGE_WORDS        = TB_KV_IMAGE_BYTES / AXI_GMEM_WORD_BYTES;
constexpr size_t   TB_CTRL_MEM_WORDS        = 23u;

static ControlMemSpace g_loaded_ctrl_mem{};
static bool g_loaded_ctrl_mem_valid = false;

static std::string tb_source_dir() {
    std::string path(__FILE__);
    const std::string::size_type slash = path.find_last_of("/\\");
    if (slash == std::string::npos) {
        return ".";
    }
    return path.substr(0, slash);
}

static void zero_axi_mem(axi_gmem_word_t *mem, uint64_t word_count) {
    for (uint64_t i = 0; i < word_count; ++i) {
        mem[i] = 0;
    }
}

static bool load_shared_ddr_image(axi_gmem_word_t *ddr_mem, uint64_t word_count) {
    const std::string image_path =
        tb_model_bin_loader::default_generated_ddr_image_path(tb_source_dir());
    return tb_model_bin_loader::load_prebuilt_ddr_image(
        image_path, ddr_mem, word_count);
}

static ControlMemSpace make_default_ctrl_mem() {
    ControlMemSpace ctrl_mem{};
    ctrl_mem.control = CTRL_RESETN_BIT;
    ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
    ctrl_mem.irq_clear = 0;

    ctrl_mem.wq_offset = WQ_OFF;
    ctrl_mem.wk_offset = WK_OFF;
    ctrl_mem.wv_offset = WV_OFF;
    ctrl_mem.wo_offset = WO_OFF;
    ctrl_mem.w1_gate_offset = W1_OFF;
    ctrl_mem.w1_up_offset = W1_UP_OFF;
    ctrl_mem.w2_offset = W2_OFF;
    ctrl_mem.k_cache_offset = K_CACHE_OFF;
    ctrl_mem.v_cache_offset = V_CACHE_OFF;
    ctrl_mem.wo_bias_offset = WO_BIAS_OFF;
    ctrl_mem.w1_bias_offset = W1_BIAS_OFF;
    ctrl_mem.w2_bias_offset = W2_BIAS_OFF;
    ctrl_mem.ln0_gamma_offset = LN0_GAMMA_OFF;
    ctrl_mem.ln1_gamma_offset = LN1_GAMMA_OFF;
    ctrl_mem.final_norm_gamma_offset = FINAL_NORM_GAMMA_OFF;
    ctrl_mem.ln0_eps_offset = LN0_EPS_OFF;
    ctrl_mem.ln1_eps_offset = LN1_EPS_OFF;
    ctrl_mem.final_norm_eps_offset = FINAL_NORM_EPS_OFF;
    ctrl_mem.wlogit_offset = WLOGIT_OFF;
    ctrl_mem.token_position = 0;
    return ctrl_mem;
}

static void ensure_default_ctrl_mem_loaded() {
    if (!g_loaded_ctrl_mem_valid) {
        g_loaded_ctrl_mem = make_default_ctrl_mem();
        g_loaded_ctrl_mem_valid = true;
    }
}

static void dump_ctrl_mem_words(const ControlMemSpace &ctrl_mem) {
    const uint32_t words[TB_CTRL_MEM_WORDS] = {
        ctrl_mem.control,
        ctrl_mem.irq_mask,
        ctrl_mem.irq_clear,
        ctrl_mem.wq_offset,
        ctrl_mem.wk_offset,
        ctrl_mem.wv_offset,
        ctrl_mem.wo_offset,
        ctrl_mem.w1_gate_offset,
        ctrl_mem.w1_up_offset,
        ctrl_mem.w2_offset,
        ctrl_mem.k_cache_offset,
        ctrl_mem.v_cache_offset,
        ctrl_mem.wo_bias_offset,
        ctrl_mem.w1_bias_offset,
        ctrl_mem.w2_bias_offset,
        ctrl_mem.ln0_gamma_offset,
        ctrl_mem.ln1_gamma_offset,
        ctrl_mem.final_norm_gamma_offset,
        ctrl_mem.ln0_eps_offset,
        ctrl_mem.ln1_eps_offset,
        ctrl_mem.final_norm_eps_offset,
        ctrl_mem.wlogit_offset,
        ctrl_mem.token_position,
    };
    const char *names[TB_CTRL_MEM_WORDS] = {
        "control",
        "irq_mask",
        "irq_clear",
        "wq_offset",
        "wk_offset",
        "wv_offset",
        "wo_offset",
        "w1_gate_offset",
        "w1_up_offset",
        "w2_offset",
        "k_cache_offset",
        "v_cache_offset",
        "wo_bias_offset",
        "w1_bias_offset",
        "w2_bias_offset",
        "ln0_gamma_offset",
        "ln1_gamma_offset",
        "final_norm_gamma_offset",
        "ln0_eps_offset",
        "ln1_eps_offset",
        "final_norm_eps_offset",
        "wlogit_offset",
        "token_position",
    };

    std::printf("[TEST] ctrl_mem dump before first token load:\n");
    for (size_t i = 0; i < TB_CTRL_MEM_WORDS; ++i) {
        std::printf("[TEST]   ctrl_mem[%02zu] (%s) = 0x%08X\n", i, names[i], words[i]);
    }
}

static bool get_shared_stream_size(size_t &bytes_total) {
    const std::string stream_path = tb_source_dir() + "/test_data/stream_in.bin";
    std::ifstream in(stream_path.c_str(), std::ios::binary | std::ios::ate);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to open shared stream image '%s'\n", stream_path.c_str());
        return false;
    }
    const std::streamoff total = in.tellg();
    if (total <= 0) {
        std::fprintf(stderr, "ERROR: Failed to read shared stream image '%s'\n", stream_path.c_str());
        return false;
    }
    bytes_total = static_cast<size_t>(total);
    return true;
}

static bool load_shared_stream_token(uint8_t *stream_in_buf, size_t token_bytes,
                                     size_t selected_token, size_t &total_tokens) {
    const std::string stream_path = tb_source_dir() + "/test_data/stream_in.bin";
    size_t bytes_total = 0;
    if (!get_shared_stream_size(bytes_total)) {
        return false;
    }
    total_tokens = bytes_total / token_bytes;
    if (total_tokens == 0) {
        std::fprintf(stderr, "ERROR: stream_in.bin does not contain any full tokens\n");
        return false;
    }
    if (selected_token >= total_tokens) {
        std::fprintf(stderr, "ERROR: selected stream token %zu out of range (total=%zu)\n",
                     selected_token, total_tokens);
        return false;
    }

    std::ifstream in(stream_path.c_str(), std::ios::binary);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to open shared stream image '%s'\n", stream_path.c_str());
        return false;
    }

    const std::streamoff token_offset =
        static_cast<std::streamoff>(selected_token * token_bytes);
    in.seekg(token_offset, std::ios::beg);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to seek shared stream image '%s' to token %zu\n",
                     stream_path.c_str(), selected_token);
        return false;
    }

    std::memset(stream_in_buf, 0, token_bytes);
    in.read(reinterpret_cast<char *>(stream_in_buf), static_cast<std::streamsize>(token_bytes));
    const std::streamsize got = in.gcount();
    if (got != static_cast<std::streamsize>(token_bytes)) {
        std::fprintf(stderr,
                     "ERROR: Failed to read token %zu from shared stream image '%s' (got %lld bytes)\n",
                     selected_token, stream_path.c_str(), static_cast<long long>(got));
        return false;
    }
    return true;
}

static void print_token_vector(size_t token_idx, const uint8_t *token_bytes, size_t token_len) {
    std::printf("token %zu: {", token_idx);
    for (size_t i = 0; i < token_len; ++i) {
        if (i != 0) {
            std::printf(", ");
        }
        std::printf("%d", static_cast<int>(static_cast<int8_t>(token_bytes[i])));
    }
    std::printf("}\n");
}

static const char *status_name(uint32_t status) {
    switch (static_cast<SchedState>(status)) {
    case S_IDLE:
        return "S_IDLE";
    case S_STREAM_IN:
        return "S_STREAM_IN";
    case S_LAYER_COUNT:
        return "S_LAYER_COUNT";
    case S_LAYER_NORM_0:
        return "S_LAYER_NORM_0";
    case S_ATTENTION_HEADS:
        return "S_ATTENTION_HEADS";
    case S_HEAD_CONCAT:
        return "S_HEAD_CONCAT";
    case S_OUT_PROJECTION:
        return "S_OUT_PROJECTION";
    case S_RES_ADD_1:
        return "S_RES_ADD_1";
    case S_LAYER_NORM_1:
        return "S_LAYER_NORM_1";
    case S_FFN:
        return "S_FFN";
    case S_RES_ADD_2:
        return "S_RES_ADD_2";
    case S_LOOP_CHECK:
        return "S_LOOP_CHECK";
    case S_FINAL_NORM:
        return "S_FINAL_NORM";
    case S_LOGITS:
        return "S_LOGITS";
    case S_ARGMAX:
        return "S_ARGMAX";
    case S_STREAM_OUT:
        return "S_STREAM_OUT";
    case S_DEBUG:
        return "S_DEBUG";
    default:
        return "UNKNOWN";
    }
}

static const char *sched_state_name(uint32_t state) {
    switch (static_cast<SchedState>(state)) {
    case S_IDLE:
        return "S_IDLE";
    case S_STREAM_IN:
        return "S_STREAM_IN";
    case S_LAYER_COUNT:
        return "S_LAYER_COUNT";
    case S_LAYER_NORM_0:
        return "S_LAYER_NORM_0";
    case S_ATTENTION_HEADS:
        return "S_ATTENTION_HEADS";
    case S_HEAD_CONCAT:
        return "S_HEAD_CONCAT";
    case S_OUT_PROJECTION:
        return "S_OUT_PROJECTION";
    case S_RES_ADD_1:
        return "S_RES_ADD_1";
    case S_LAYER_NORM_1:
        return "S_LAYER_NORM_1";
    case S_FFN:
        return "S_FFN";
    case S_RES_ADD_2:
        return "S_RES_ADD_2";
    case S_LOOP_CHECK:
        return "S_LOOP_CHECK";
    case S_FINAL_NORM:
        return "S_FINAL_NORM";
    case S_LOGITS:
        return "S_LOGITS";
    case S_ARGMAX:
        return "S_ARGMAX";
    case S_STREAM_OUT:
        return "S_STREAM_OUT";
    case S_DEBUG:
        return "S_DEBUG";
    default:
        return "S_UNKNOWN";
    }
}

static const char *irq_name(uint32_t irq) {
    if (irq & IRQ_ERROR_BIT)        return "ERROR";
    if (irq & IRQ_INFER_DONE_BIT)   return "DONE";
    return "-";
}

static void print_error_code_bits(uint32_t err) {
    if (err == ERR_NONE) {
        std::fprintf(stderr, "ERR_NONE");
        return;
    }
    bool first = true;
    auto emit = [&](const char *name) {
        if (!first) {
            std::fprintf(stderr, "|");
        }
        std::fprintf(stderr, "%s", name);
        first = false;
    };
    if (err & ERR_DMA_ALIGNMENT)   emit("ERR_DMA_ALIGNMENT");
    if (err & ERR_DMA_ZERO_STRIDE) emit("ERR_DMA_ZERO_STRIDE");
    if (err & ERR_SCHEDULER_ERROR) emit("ERR_SCHEDULER_ERROR");
    if (err & ERR_COMPUTE_ERROR)   emit("ERR_COMPUTE_ERROR");
    if (err & ERR_MMU_INVALID)     emit("ERR_MMU_INVALID");
    if (err & ERR_MMU_OVERFLOW)    emit("ERR_MMU_OVERFLOW");
    if (err & ERR_MMU_UNSUPPORTED_REQ_DMA) emit("ERR_MMU_UNSUPPORTED_REQ_DMA");
    if (err & ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED) emit("ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED");
    if (err & ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED) emit("ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED");
    if (err & ERR_MMU_MISSING_REGION_FULL_READ) emit("ERR_MMU_MISSING_REGION_FULL_READ");
    if (err & ERR_MMU_MISSING_REGION_PARTIAL_READ) emit("ERR_MMU_MISSING_REGION_PARTIAL_READ");
    if (err & ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP) emit("ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP");
    if (err & ERR_MMU_BAD_DMA_PLAN)    emit("ERR_MMU_BAD_DMA_PLAN");
    if (err & ERR_MMU_BAD_DMA_ADDR)    emit("ERR_MMU_BAD_DMA_ADDR");
    if (err & ERR_MMU_REGION_ACCESS)   emit("ERR_MMU_REGION_ACCESS");
    if (err & ERR_MMU_CONCAT_SOURCE)   emit("ERR_MMU_CONCAT_SOURCE");
    if (err & ERR_MMU_WRITEBACK_SRC)   emit("ERR_MMU_WRITEBACK_SRC");
    if (err & ERR_MMU_QUEUE_OVERFLOW)  emit("ERR_MMU_QUEUE_OVERFLOW");
    if (err & ERR_MMU_REGION_OVERFLOW) emit("ERR_MMU_REGION_OVERFLOW");
    if (err & ERR_MMU_REGION_OVERFLOW_STREAM_IN) emit("ERR_MMU_REGION_OVERFLOW_STREAM_IN");
    if (err & ERR_MMU_REGION_OVERFLOW_DMA_CONCAT) emit("ERR_MMU_REGION_OVERFLOW_DMA_CONCAT");
    if (err & ERR_MMU_REGION_OVERFLOW_DMA_STORE) emit("ERR_MMU_REGION_OVERFLOW_DMA_STORE");
    if (err & ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE) emit("ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE");
    if (err & ERR_MMU_REGION_TABLE_FULL) emit("ERR_MMU_REGION_TABLE_FULL");
    if (err & ERR_MMU_URAM_CHUNK_ALLOC_FAIL) emit("ERR_MMU_URAM_CHUNK_ALLOC_FAIL");
    if (err & ERR_MMU_REGION_TOO_LARGE) emit("ERR_MMU_REGION_TOO_LARGE");
    if (err & ERR_TOKEN_MAX) emit("ERR_TOKEN_MAX");
    if (err & ERR_MMU_STREAM_OUTPUT_MISSING) emit("ERR_MMU_STREAM_OUTPUT_MISSING");
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
        case MMU_ERR_SUBCODE_MISSING_LOGITS_W: return "MISSING_LOGITS_W";
        case MMU_ERR_SUBCODE_MISSING_LOGITS_PACKED: return "MISSING_LOGITS_PACKED";
        case MMU_ERR_SUBCODE_MISSING_ARGMAX_OUT: return "MISSING_ARGMAX_OUT";
        case MMU_ERR_SUBCODE_MISSING_LN0_GAMMA: return "MISSING_LN0_GAMMA";
        case MMU_ERR_SUBCODE_MISSING_LN0_EPS: return "MISSING_LN0_EPS";
        case MMU_ERR_SUBCODE_MISSING_LN1_GAMMA: return "MISSING_LN1_GAMMA";
        case MMU_ERR_SUBCODE_MISSING_LN1_EPS: return "MISSING_LN1_EPS";
        case MMU_ERR_SUBCODE_MISSING_FINAL_NORM_GAMMA: return "MISSING_FINAL_NORM_GAMMA";
        case MMU_ERR_SUBCODE_MISSING_FINAL_NORM_EPS: return "MISSING_FINAL_NORM_EPS";
        default: return "UNKNOWN_SUBCODE";
    }
}

ControlMemSpace ctrl_mem_init(bool init) {
    ControlMemSpace ctrl_mem{};
    if(init) {
        ensure_default_ctrl_mem_loaded();
        return g_loaded_ctrl_mem;
    }
    return ctrl_mem;
}

static uint8_t kv_cache_get_byte(const axi_gmem_word_t *buf, uint64_t byte_addr) {
    const uint64_t word_idx = byte_addr / static_cast<uint64_t>(AXI_GMEM_WORD_BYTES);
    const uint32_t lane = static_cast<uint32_t>(byte_addr % static_cast<uint64_t>(AXI_GMEM_WORD_BYTES));
    const axi_gmem_word_t word = buf[word_idx];
    return static_cast<uint8_t>(word.range(((lane + 1u) * 8u) - 1u, lane * 8u));
}

static void print_kv_cache_upto_token(const ControlMemSpace &ctrl,
                                      const axi_gmem_word_t *kv_cache,
                                      size_t upto_token_idx) {
    const uint64_t layer_stride = static_cast<uint64_t>(STRIDE_KV_LAYER);
    const uint64_t k_head_stride = static_cast<uint64_t>(STRIDE_KV_HEAD);
    const uint64_t v_head_stride = static_cast<uint64_t>(STRIDE_KV_HEAD);
    const size_t max_token_idx = (upto_token_idx < static_cast<size_t>(CONTEXT_LENGTH))
                                     ? upto_token_idx
                                     : static_cast<size_t>(CONTEXT_LENGTH - 1);

    std::printf("[KV DUMP] K/V cache through token %zu\n", max_token_idx);
    for (int layer = 0; layer < NUM_LAYERS; ++layer) {
        for (int head = 0; head < NUM_HEADS; ++head) {
            for (size_t token = 0; token <= max_token_idx; ++token) {
                const uint64_t k_base = static_cast<uint64_t>(ctrl.k_cache_offset) +
                                        static_cast<uint64_t>(layer) * layer_stride +
                                        static_cast<uint64_t>(head) * k_head_stride +
                                        static_cast<uint64_t>(token) * static_cast<uint64_t>(D_HEADS);
                const uint64_t v_base = static_cast<uint64_t>(ctrl.v_cache_offset) +
                                        static_cast<uint64_t>(layer) * layer_stride +
                                        static_cast<uint64_t>(head) * v_head_stride +
                                        static_cast<uint64_t>(token) * static_cast<uint64_t>(D_HEADS);

                std::printf("[KV DUMP] L%d H%d T%zu K:", layer, head, token);
                for (int i = 0; i < D_HEADS; ++i) {
                    const int8_t value = static_cast<int8_t>(kv_cache_get_byte(
                        kv_cache, k_base + static_cast<uint64_t>(i)));
                    std::printf(" %d", static_cast<int>(value));
                }
                std::printf(" | V:");
                for (int i = 0; i < D_HEADS; ++i) {
                    const int8_t value = static_cast<int8_t>(kv_cache_get_byte(
                        kv_cache, v_base + static_cast<uint64_t>(i)));
                    std::printf(" %d", static_cast<int>(value));
                }
                std::printf("\n");
            }
        }
    }
}

static int run_top_no_debug_tb_single_token_with_mem(size_t selected_stream_token,
                                                     axi_gmem_word_t *ddr_mem,
                                                     axi_gmem_word_t *kv_cache) {
    const int MAX_CYCLES = 10000;
    const int STREAM_TOKEN_BYTES = STREAM_IN_BUF_BYTES;
    const int AXIS_BEATS = STREAM_TOKEN_BYTES;

    hls::stream<axis8_t> s_axis_in("s_axis_in");
    hls::stream<axis8_t> m_axis_out("m_axis_out");

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;
    uint8_t axis_in_data = 0;
    uint8_t stream_in_buf[STREAM_IN_BUF_BYTES] = {};
    uint8_t stream_out_buf[STREAM_OUT_BUF_BYTES] = {};
    int stream_in_token_index = static_cast<int>(selected_stream_token);
    uint8_t stream_in_token_bytes[STREAM_TOKEN_BYTES] = {};
    int stream_in_token_count = 0;
    int stream_out_count = 0;
    int stream_out_token_index = static_cast<int>(selected_stream_token);

    bool irq_ps              = false;
    bool irq_interupt_flagged = false;
    uint32_t interupt_data = 0;

    bool reset_released  = false;
    bool start_pulsed    = false;
    bool pending_start_clear = false;
    bool assign_base_addresses = false;
    bool seen_stream_out = false;
    int  idle_after_stream = 0;
    bool seen_done       = false;
    int  post_done_cycles= 0;
    bool seen_idle_after = false;
    bool aborted_on_error = false;
    bool debug_output_match = false;
    int  base_assign_step = 0;

    ensure_default_ctrl_mem_loaded();
    size_t total_stream_tokens = 0;
    if (!load_shared_stream_token(stream_in_buf, STREAM_IN_BUF_BYTES,
                                  selected_stream_token, total_stream_tokens)) {
        return 1;
    }
    std::printf("[TEST] stream_in.bin contains %zu token(s), sending token %zu only.\n",
                total_stream_tokens, selected_stream_token);
    {
        print_token_vector(selected_stream_token, stream_in_buf,
                           static_cast<size_t>(STREAM_TOKEN_BYTES));
    }
    int32_t expected_debug_sum = 0;
    if (TB_DEBUG_MODE) {
        for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
            expected_debug_sum += static_cast<int32_t>(static_cast<int8_t>(stream_in_buf[i]));
        }
        std::printf("[TEST] debug sum expected=%d (0x%08X)\n",
                    expected_debug_sum,
                    static_cast<unsigned>(static_cast<uint32_t>(expected_debug_sum)));
    }

    enum class CtrlInitStage {
        TestCtrlInit,
        TestAlignment,
        TestAlignmentCheck,
        TestAlignmentClear,
        AssertReset,
        DeassertReset,
        ProgramBases,
        AssertStart,
        ClearStart,
        Done
    };
    CtrlInitStage ctrl_stage = CtrlInitStage::AssertReset;
    bool test_error_detected = false;
    int  test_errors_passed = 0;
    int  test_errors_failed = 0;

    ControlMemSpace ctrl_mem{};
    StatusMemSpace status_mem{};
    SchedState dbg_state = S_IDLE;
    uint32_t control_reg = 0;
    uint32_t ctrl_shadow_control = 0;
    int ctrl_gap_cycles = 0;
    bool seen_irq_done = false;
    auto set_control = [&](uint32_t value) {
        const uint32_t control = value | (TB_DEBUG_MODE ? CTRL_DEBUG_MODE_BIT : 0u);
        ctrl_mem.control = control;
        ctrl_shadow_control = control;
    };
    // Tracking previous status for change-based logging
    uint32_t prev_status = 0;
    uint32_t prev_irq_status = 0;
    uint32_t prev_error_code = 0;
    uint32_t prev_layer_index = 0;
    std::printf("%8s | %12s | %8s | %10s | %8s | %8s | %6s | %6s\n",
                "cycle",
                "status",
                "irq_stat",
                "error_code",
                "layer",
                "head",
                "irq_ps",
                "ax_fed");
    std::printf("--------------------------------------------------------------------------------------------------\n");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Space out control transactions to model multi-cycle AXI-lite access
        if (ctrl_gap_cycles > 0) {
            ctrl_gap_cycles--;
        } else if (ctrl_stage == CtrlInitStage::TestCtrlInit) {
            ctrl_mem = ctrl_mem_init(true);
            set_control(CTRL_RESETN_BIT);
            std::printf("[TEST] Starting ControlMemInterface error tests...\n");
            ctrl_stage = CtrlInitStage::TestAlignment;
            ctrl_gap_cycles = 1;

        } else if (ctrl_stage == CtrlInitStage::TestAlignment) {
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.wq_offset = 0x00000001u;
            std::printf("[TEST 2] Injecting wq_offset=0x00000001 (expect ERR_DMA_ALIGNMENT)\n");
            ctrl_stage = CtrlInitStage::TestAlignmentCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestAlignmentCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ALIGNMENT) {
                std::printf("[TEST 2] PASS: ERR_DMA_ALIGNMENT detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 2] FAIL: Expected ERR_DMA_ALIGNMENT (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestAlignmentClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestAlignmentClear) {
            ctrl_mem.irq_clear = 0;
            ctrl_mem = ctrl_mem_init(false);
            std::printf("[TEST] Error tests complete: %d passed, %d failed\n",
                        test_errors_passed, test_errors_failed);
            ctrl_stage = CtrlInitStage::AssertReset;
            ctrl_gap_cycles = 1;

        } else if (ctrl_stage == CtrlInitStage::AssertReset) {
            ctrl_mem = ctrl_mem_init(false);
            set_control(0x00000000);
            ctrl_stage = CtrlInitStage::DeassertReset;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::DeassertReset) {
            set_control(CTRL_RESETN_BIT);
            ctrl_stage = CtrlInitStage::ProgramBases;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ProgramBases) {
            switch (base_assign_step) {
            case 0:
                ctrl_mem = ctrl_mem_init(true);
                break;
            case 1:
                ctrl_mem.irq_clear = IRQ_ERROR_BIT;
                break;
            case 2:
                ctrl_mem.irq_clear = 0;
                break;
            case 3:
                ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
                assign_base_addresses = true;
                ctrl_stage = CtrlInitStage::AssertStart;
                break;
            default:
                assign_base_addresses = true;
                ctrl_stage = CtrlInitStage::AssertStart;
                break;
            }
            if (!assign_base_addresses) {
                base_assign_step++;
            }
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::AssertStart) {
            ctrl_mem.token_position = static_cast<uint32_t>(selected_stream_token);
            if (ctrl_mem.token_position != static_cast<uint32_t>(selected_stream_token)) {
                std::fprintf(stderr,
                             "ERROR: ctrl_mem.token_position mismatch before start (expected=%zu got=%u)\n",
                             selected_stream_token,
                             ctrl_mem.token_position);
                return 1;
            }
            set_control(CTRL_RESETN_BIT | CTRL_START_BIT);
            reset_released = true;
            start_pulsed   = true;
            pending_start_clear = true;
            ctrl_stage = CtrlInitStage::ClearStart;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ClearStart) {
            set_control(CTRL_RESETN_BIT);
            pending_start_clear = false;
            ctrl_stage = CtrlInitStage::Done;
            ctrl_gap_cycles = 1;
        } else if(seen_irq_done){
            ctrl_mem.irq_clear = IRQ_INFER_DONE_BIT;
            ctrl_gap_cycles = 1;
            seen_irq_done = false;
        }
        else if(irq_ps){
            ctrl_gap_cycles = 1;
            irq_interupt_flagged = true;
            interupt_data = status_mem.irq_status;
        }

        // Drive AXIS ingress beats (match top_DEBUG_tb.cpp behavior: continuous, no inter-beat gaps).
        axis_in_valid = false;
        axis_in_last = false;
        axis_in_data = 0;
        if (!axis_feed_done && (axis_drive || (((ctrl_shadow_control & CTRL_RESETN_BIT) != 0) && start_pulsed))) {
            axis_drive = true;
            if (axis_sent < AXIS_BEATS) {
                axis8_t beat{};
                beat.data = stream_in_buf[static_cast<size_t>(axis_sent)];
                beat.keep = 1;
                beat.strb = 1;
                beat.last = (axis_sent == AXIS_BEATS - 1) ? 1 : 0;
                if (s_axis_in.write_nb(beat)) {
                    axis_in_valid = true;
                    axis_in_last = (beat.last != 0);
                    axis_in_data = static_cast<uint8_t>(beat.data);
                    if (stream_in_token_count < STREAM_TOKEN_BYTES) {
                        stream_in_token_bytes[stream_in_token_count] = axis_in_data;
                        stream_in_token_count++;
                    }
                    std::printf("[CYCLE %d] Stream in beat: byte_idx=%d token_byte_idx=%d data=0x%02X last=%d\n",
                                cycle,
                                axis_sent,
                                (stream_in_token_count > 0) ? (stream_in_token_count - 1) : 0,
                                static_cast<unsigned>(axis_in_data),
                                axis_in_last ? 1 : 0);
                    axis_sent++;
                    if (axis_in_last) {
                        uint32_t token_word = 0;
                        if (stream_in_token_count >= 4) {
                            token_word =
                                static_cast<uint32_t>(stream_in_token_bytes[0]) |
                                (static_cast<uint32_t>(stream_in_token_bytes[1]) << 8) |
                                (static_cast<uint32_t>(stream_in_token_bytes[2]) << 16) |
                                (static_cast<uint32_t>(stream_in_token_bytes[3]) << 24);
                        }
                        const int32_t token_id = static_cast<int32_t>(token_word);
                        std::printf("[CYCLE %d] Stream in token %d complete: bytes=%d first_word=%d (0x%08X)\n",
                                    cycle,
                                    stream_in_token_index,
                                    stream_in_token_count,
                                    token_id,
                                    static_cast<unsigned>(token_word));
                        stream_in_token_count = 0;
                        axis_feed_done = true;
                        axis_drive = false;
                    }
                }
            }
        }

        // Call the production (no-debug) transformer_top
        transformer_top(
            s_axis_in,
            m_axis_out,
            ddr_mem,
            kv_cache,
            ctrl_mem,
            status_mem,
            irq_ps,
            dbg_state
        );

        // Drain AXI stream output
        axis8_t axis_out_beat{};
        while (m_axis_out.read_nb(axis_out_beat)) {
            if (stream_out_count < STREAM_OUT_BUF_BYTES) {
                stream_out_buf[stream_out_count] = static_cast<uint8_t>(axis_out_beat.data);
                stream_out_count++;
            }
            if (axis_out_beat.last != 0) {
                std::printf("[CYCLE %d] Stream out token %d: ", cycle, stream_out_token_index);
                for (int i = 0; i < STREAM_OUT_BUF_BYTES; ++i) {
                    std::printf("%02X ", static_cast<unsigned>(stream_out_buf[i]));
                }
                // Decode as little-endian int32
                int32_t token_id = static_cast<int32_t>(
                    static_cast<uint32_t>(stream_out_buf[0]) |
                    (static_cast<uint32_t>(stream_out_buf[1]) << 8) |
                    (static_cast<uint32_t>(stream_out_buf[2]) << 16) |
                    (static_cast<uint32_t>(stream_out_buf[3]) << 24));
                std::printf("(index=%d)\n", token_id);
                if (TB_DEBUG_MODE) {
                    if (token_id != expected_debug_sum) {
                        std::fprintf(stderr,
                                     "ERROR: Debug sum mismatch for token %zu: expected=%d observed=%d\n",
                                     selected_stream_token, expected_debug_sum, token_id);
                        debug_output_match = false;
                    } else {
                        debug_output_match = true;
                    }
                }
                stream_out_count = 0;
            }
        }

        // Log status changes
        const bool status_changed = (status_mem.status != prev_status) ||
                                    (status_mem.irq_status != prev_irq_status) ||
                                    (status_mem.error_code != prev_error_code) ||
                                    (status_mem.layer_index != prev_layer_index);
        if (status_changed || (cycle % 100 == 0)) {
            std::printf("%8d | %12s | %8s | 0x%08X | %8u | %8u | %6d | %6d\n",
                        cycle,
                        status_name(status_mem.status),
                        irq_name(status_mem.irq_status),
                        status_mem.error_code,
                        status_mem.layer_index,
                        status_mem.head_index,
                        irq_ps ? 1 : 0,
                        axis_feed_done ? 1 : 0);
            prev_status = status_mem.status;
            prev_irq_status = status_mem.irq_status;
            prev_error_code = status_mem.error_code;
            prev_layer_index = status_mem.layer_index;
        }

        // Error detection via status_mem
        if (status_mem.error_code != ERR_NONE && ctrl_stage == CtrlInitStage::Done) {
            std::fprintf(stderr,
                         "\nERROR: transformer_top flagged error (cycle=%d, code=0x%08X, status=0x%08X, mmu_subcode=%u:%s) : ",
                         cycle, status_mem.error_code, status_mem.status,
                         status_mem.mmu_error_subcode, mmu_subcode_name(status_mem.mmu_error_subcode));
            print_error_code_bits(status_mem.error_code);
            std::fprintf(stderr, "\n");
            aborted_on_error = true;
            break;
        }

        // Track done via IRQ
        if (status_mem.status != static_cast<uint32_t>(S_IDLE)) {
            seen_stream_out = false; // reset until we see idle again
        }
        if ((status_mem.irq_status & IRQ_INFER_DONE_BIT) && !seen_done) {
            seen_stream_out = true;
        }
        if (seen_stream_out && (status_mem.status == static_cast<uint32_t>(S_IDLE))) {
            idle_after_stream++;
        } else if (seen_stream_out) {
            idle_after_stream = 0;
        }

        if (irq_interupt_flagged && (interupt_data & IRQ_INFER_DONE_BIT)) {
            seen_done = true;
            irq_interupt_flagged = false;
            interupt_data = 0;
            seen_irq_done = true;
        }
        else if (seen_done){
            post_done_cycles++;
            if (post_done_cycles >= 2) {
                seen_idle_after = true;
                seen_irq_done = false;
            }
        }

        const bool cntrl_start = ((ctrl_shadow_control & CTRL_START_BIT) != 0);
        if (!cntrl_start && seen_done && seen_idle_after && seen_stream_out && idle_after_stream >= 4) {
            break;
        }
    }

    bool ok = !aborted_on_error && seen_stream_out && (idle_after_stream >= 4) &&
              (!TB_DEBUG_MODE || debug_output_match);

    if (!ok) {
        if (!seen_stream_out) std::fprintf(stderr, "ERROR: Inference done never reached\n");
        if (idle_after_stream < 4) std::fprintf(stderr, "ERROR: Did not remain in IDLE for 4 cycles after done\n");
        if (!debug_output_match) std::fprintf(stderr, "ERROR: Debug output mismatch detected\n");
        return 1;
    }

    print_kv_cache_upto_token(ctrl_mem, kv_cache, selected_stream_token);
    std::printf("PASS: Token %zu inference complete, FSM stayed IDLE for %d cycles after.\n",
                selected_stream_token, idle_after_stream);
    return 0;
}

static int run_top_no_debug_tb_single_token(size_t selected_stream_token) {
    std::vector<axi_gmem_word_t> ddr_mem(static_cast<size_t>(TB_DDR_IMAGE_WORDS));
    std::vector<axi_gmem_word_t> kv_cache(static_cast<size_t>(TB_KV_IMAGE_WORDS));

    if (!load_shared_ddr_image(ddr_mem.data(), TB_DDR_IMAGE_WORDS)) {
        return 1;
    }
    zero_axi_mem(kv_cache.data(), TB_KV_IMAGE_WORDS);

    return run_top_no_debug_tb_single_token_with_mem(
        selected_stream_token, ddr_mem.data(), kv_cache.data());
}

int main() {
    if (!init_tb_logs()) {
        return 1;
    }
    return run_top_no_debug_tb_single_token(0);
}
