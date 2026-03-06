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
#include <sys/stat.h>

#include "top_no_debug.hpp"

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
    const char *log_dir = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs/top_no_debug";

    if (!ensure_dir_recursive(log_dir)) {
        std::fprintf(stderr, "ERROR: Failed to create log dir '%s': %s\n",
                     log_dir, std::strerror(errno));
        return false;
    }

    char stdout_path[512];
    char stderr_path[512];
    std::snprintf(stdout_path, sizeof(stdout_path), "%s/top_no_debug_tb_stdout.log", log_dir);
    std::snprintf(stderr_path, sizeof(stderr_path), "%s/top_no_debug_tb_stderr.log", log_dir);

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

    std::printf("[LOG] top_no_debug_tb stdout: %s\n", stdout_path);
    std::fprintf(stderr, "[LOG] top_no_debug_tb stderr: %s\n", stderr_path);
    return true;
}

constexpr uint64_t TB_BASE_WQ               = 0x00000ull;
constexpr uint64_t TB_BASE_WK               = 0x04000ull;
constexpr uint64_t TB_BASE_WV               = 0x08000ull;
constexpr uint64_t TB_BASE_WO               = 0x0C000ull;
constexpr uint64_t TB_BASE_W1               = 0x10000ull;
constexpr uint64_t TB_BASE_W2               = 0x16000ull;
constexpr uint64_t TB_BASE_K_CACHE          = 0x1C000ull;
constexpr uint64_t TB_BASE_V_CACHE          = 0x20000ull;
constexpr uint64_t TB_BASE_WQ_BIAS          = 0x24000ull;
constexpr uint64_t TB_BASE_WK_BIAS          = 0x28000ull;
constexpr uint64_t TB_BASE_WV_BIAS          = 0x2C000ull;
constexpr uint64_t TB_BASE_WO_BIAS          = 0x30000ull;
constexpr uint64_t TB_BASE_W1_BIAS          = 0x34000ull;
constexpr uint64_t TB_BASE_W2_BIAS          = 0x3A000ull;
constexpr uint64_t TB_BASE_WVOCAB           = 0x40000ull;
constexpr uint64_t TB_BASE_WVOCAB_BIAS      = 0x41000ull;
constexpr uint64_t TB_BASE_LN0_GAMMA        = 0x42000ull;
constexpr uint64_t TB_BASE_LN1_GAMMA        = 0x42400ull;
constexpr uint64_t TB_BASE_FINAL_NORM_GAMMA = 0x42800ull;
constexpr uint64_t TB_BASE_LN0_EPS          = 0x42C00ull;
constexpr uint64_t TB_BASE_LN1_EPS          = 0x42C40ull;
constexpr uint64_t TB_BASE_FINAL_NORM_EPS   = 0x42C80ull;
constexpr uint64_t TB_DDR_IMAGE_BYTES       = 0x43000ull;
constexpr uint64_t TB_DDR_IMAGE_WORDS       = TB_DDR_IMAGE_BYTES / AXI_GMEM_WORD_BYTES;
constexpr size_t   TB_CTRL_MEM_WORDS        = 56u;
constexpr size_t   TB_CTRL_MEM_BYTES        = TB_CTRL_MEM_WORDS * sizeof(uint32_t);

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

static bool load_shared_ddr_image(axi_gmem_word_t *ddr_mem, uint64_t word_count) {
    for (uint64_t i = 0; i < word_count; ++i) {
        ddr_mem[i] = 0;
    }

    const std::string image_path = tb_source_dir() + "/test_data/ddr_image.bin";
    std::ifstream in(image_path.c_str(), std::ios::binary);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to open shared DDR image '%s'\n", image_path.c_str());
        return false;
    }

    for (uint64_t i = 0; i < word_count; ++i) {
        uint8_t bytes[AXI_GMEM_WORD_BYTES] = {};
        in.read(reinterpret_cast<char *>(bytes), AXI_GMEM_WORD_BYTES);
        const std::streamsize got = in.gcount();
        if (got <= 0) {
            break;
        }
        axi_gmem_word_t word = 0;
        for (int b = 0; b < AXI_GMEM_WORD_BYTES; ++b) {
            const uint8_t byte = (b < got) ? bytes[b] : 0;
            word.range(((b + 1) * 8) - 1, b * 8) = static_cast<ap_uint<8> >(byte);
        }
        ddr_mem[i] = word;
        if (got < AXI_GMEM_WORD_BYTES) {
            break;
        }
    }

    return true;
}

static bool load_shared_ctrl_mem(ControlMemSpace &ctrl_mem) {
    const std::string ctrl_path = tb_source_dir() + "/test_data/ctrl_mem.bin";
    std::ifstream in(ctrl_path.c_str(), std::ios::binary);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to open shared ctrl image '%s'\n", ctrl_path.c_str());
        return false;
    }

    uint8_t raw[TB_CTRL_MEM_BYTES] = {};
    in.read(reinterpret_cast<char *>(raw), static_cast<std::streamsize>(TB_CTRL_MEM_BYTES));
    if (in.gcount() != static_cast<std::streamsize>(TB_CTRL_MEM_BYTES)) {
        std::fprintf(stderr, "ERROR: Failed to read full shared ctrl image '%s' (got %lld bytes)\n",
                     ctrl_path.c_str(),
                     static_cast<long long>(in.gcount()));
        return false;
    }

    auto read_u32 = [&](size_t word_idx) -> uint32_t {
        const size_t off = word_idx * sizeof(uint32_t);
        return static_cast<uint32_t>(raw[off + 0]) |
               (static_cast<uint32_t>(raw[off + 1]) << 8) |
               (static_cast<uint32_t>(raw[off + 2]) << 16) |
               (static_cast<uint32_t>(raw[off + 3]) << 24);
    };

    ControlMemSpace tmp{};
    tmp.control = read_u32(0);
    tmp.irq_mask = read_u32(1);
    tmp.irq_clear = read_u32(2);
    tmp.dma_layer_len = read_u32(3);
    tmp.dma_head_len = read_u32(4);
    tmp.dma_tile_len = read_u32(5);
    tmp.layer_stride = read_u32(6);
    tmp.wq_head_stride = read_u32(7);
    tmp.wk_head_stride = read_u32(8);
    tmp.wv_head_stride = read_u32(9);
    tmp.k_cache_stride = read_u32(10);
    tmp.v_cache_stride = read_u32(11);
    tmp.wo_tile_stride = read_u32(12);
    tmp.w1_tile_stride = read_u32(13);
    tmp.w2_tile_stride = read_u32(14);
    tmp.wq_bias_head_stride = read_u32(15);
    tmp.wk_bias_head_stride = read_u32(16);
    tmp.wv_bias_head_stride = read_u32(17);
    tmp.wo_bias_tile_stride = read_u32(18);
    tmp.w1_bias_tile_stride = read_u32(19);
    tmp.w2_bias_tile_stride = read_u32(20);
    tmp.wlogit_tile_stride = read_u32(21);
    tmp.ln0_gamma_stride = read_u32(22);
    tmp.ln1_gamma_stride = read_u32(23);
    tmp.final_norm_gamma_stride = read_u32(24);
    tmp.ln0_eps_stride = read_u32(25);
    tmp.ln1_eps_stride = read_u32(26);
    tmp.final_norm_eps_stride = read_u32(27);
    tmp.wq_offset = read_u32(28);
    tmp.wk_offset = read_u32(29);
    tmp.wv_offset = read_u32(30);
    tmp.wo_offset = read_u32(31);
    tmp.w1_offset = read_u32(32);
    tmp.w2_offset = read_u32(33);
    tmp.k_cache_offset = read_u32(34);
    tmp.v_cache_offset = read_u32(35);
    tmp.wq_bias_offset = read_u32(36);
    tmp.wk_bias_offset = read_u32(37);
    tmp.wv_bias_offset = read_u32(38);
    tmp.wo_bias_offset = read_u32(39);
    tmp.w1_bias_offset = read_u32(40);
    tmp.w2_bias_offset = read_u32(41);
    tmp.ln0_gamma_offset = read_u32(42);
    tmp.ln1_gamma_offset = read_u32(43);
    tmp.final_norm_gamma_offset = read_u32(44);
    tmp.ln0_eps_offset = read_u32(45);
    tmp.ln1_eps_offset = read_u32(46);
    tmp.final_norm_eps_offset = read_u32(47);
    tmp.wlogit_offset = read_u32(48);

    ctrl_mem = tmp;
    return true;
}

static bool load_shared_stream_in(uint8_t *stream_in_buf, size_t num_bytes, size_t &bytes_read) {
    const std::string stream_path = tb_source_dir() + "/test_data/stream_in.bin";
    std::ifstream in(stream_path.c_str(), std::ios::binary);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to open shared stream image '%s'\n", stream_path.c_str());
        return false;
    }

    std::memset(stream_in_buf, 0, num_bytes);
    in.read(reinterpret_cast<char *>(stream_in_buf), static_cast<std::streamsize>(num_bytes));
    const std::streamsize got = in.gcount();
    bytes_read = static_cast<size_t>(got);
    if (got <= 0) {
        std::fprintf(stderr, "ERROR: Failed to read shared stream image '%s'\n", stream_path.c_str());
        return false;
    }
    return true;
}

static const char *status_name(uint32_t status) {
    if (status & STATUS_ERROR)    return "ERROR";
    if (status & STATUS_BUSY_BIT) return "BUSY";
    if (status & STATUS_IDLE)     return "IDLE";
    return "-";
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
    if (err & ERR_DMA_ZERO_LEN)    emit("ERR_DMA_ZERO_LEN");
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
        case MMU_ERR_SUBCODE_MISSING_RESID0_OUT: return "MISSING_RESID0_OUT";
        case MMU_ERR_SUBCODE_MISSING_LN1_OUT: return "MISSING_LN1_OUT";
        case MMU_ERR_SUBCODE_MISSING_W1_W: return "MISSING_W1_W";
        case MMU_ERR_SUBCODE_MISSING_W1_B: return "MISSING_W1_B";
        case MMU_ERR_SUBCODE_MISSING_FFN_W1_PACKED: return "MISSING_FFN_W1_PACKED";
        case MMU_ERR_SUBCODE_MISSING_FFN_ACT_OUT: return "MISSING_FFN_ACT_OUT";
        case MMU_ERR_SUBCODE_MISSING_W2_W: return "MISSING_W2_W";
        case MMU_ERR_SUBCODE_MISSING_W2_B: return "MISSING_W2_B";
        case MMU_ERR_SUBCODE_MISSING_FFN_W2_PACKED: return "MISSING_FFN_W2_PACKED";
        case MMU_ERR_SUBCODE_MISSING_RESID1_OUT: return "MISSING_RESID1_OUT";
        case MMU_ERR_SUBCODE_MISSING_LOGITS_W: return "MISSING_LOGITS_W";
        case MMU_ERR_SUBCODE_MISSING_LOGITS_PACKED: return "MISSING_LOGITS_PACKED";
        case MMU_ERR_SUBCODE_MISSING_ARGMAX_OUT: return "MISSING_ARGMAX_OUT";
        case MMU_ERR_SUBCODE_MISSING_LN0_GAMMA: return "MISSING_LN0_GAMMA";
        case MMU_ERR_SUBCODE_MISSING_LN0_EPS: return "MISSING_LN0_EPS";
        case MMU_ERR_SUBCODE_MISSING_LN1_GAMMA: return "MISSING_LN1_GAMMA";
        case MMU_ERR_SUBCODE_MISSING_LN1_EPS: return "MISSING_LN1_EPS";
        default: return "UNKNOWN_SUBCODE";
    }
}

ControlMemSpace ctrl_mem_init(bool init) {
    ControlMemSpace ctrl_mem{};
    if(init) {
        if (g_loaded_ctrl_mem_valid) {
            return g_loaded_ctrl_mem;
        }
        ctrl_mem.control = CTRL_RESETN_BIT;
        ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
        ctrl_mem.irq_clear = 0;
        ctrl_mem.dma_layer_len = 0x00000100;
        ctrl_mem.dma_head_len  = 0x00000040;
        ctrl_mem.dma_tile_len  = 0x00000020;
        ctrl_mem.layer_stride    = 0x00001000;
        ctrl_mem.wq_head_stride  = 0x00000100;
        ctrl_mem.wk_head_stride  = 0x00000100;
        ctrl_mem.wv_head_stride  = 0x00000100;
        ctrl_mem.k_cache_stride  = 0x00000100;
        ctrl_mem.v_cache_stride  = 0x00000100;
        ctrl_mem.wo_tile_stride  = 0x00000020;
        ctrl_mem.w1_tile_stride  = 0x00000040;
        ctrl_mem.w2_tile_stride  = 0x00000020;
        ctrl_mem.wq_bias_head_stride = 0x00000100;
        ctrl_mem.wk_bias_head_stride = 0x00000100;
        ctrl_mem.wv_bias_head_stride = 0x00000100;
        ctrl_mem.wo_bias_tile_stride = 0x00000020;
        ctrl_mem.w1_bias_tile_stride = 0x00000040;
        ctrl_mem.w2_bias_tile_stride = 0x00000020;
        ctrl_mem.ln0_gamma_stride = 0x00000004;
        ctrl_mem.ln1_gamma_stride = 0x00000004;
        ctrl_mem.final_norm_gamma_stride = 0x00000004;
        ctrl_mem.ln0_eps_stride = 0x00000004;
        ctrl_mem.ln1_eps_stride = 0x00000004;
        ctrl_mem.final_norm_eps_stride = 0x00000004;
        ctrl_mem.wq_offset = static_cast<uint32_t>(TB_BASE_WQ);
        ctrl_mem.wk_offset = static_cast<uint32_t>(TB_BASE_WK);
        ctrl_mem.wv_offset = static_cast<uint32_t>(TB_BASE_WV);
        ctrl_mem.wo_offset = static_cast<uint32_t>(TB_BASE_WO);
        ctrl_mem.w1_offset = static_cast<uint32_t>(TB_BASE_W1);
        ctrl_mem.w2_offset = static_cast<uint32_t>(TB_BASE_W2);
        ctrl_mem.k_cache_offset = static_cast<uint32_t>(TB_BASE_K_CACHE);
        ctrl_mem.v_cache_offset = static_cast<uint32_t>(TB_BASE_V_CACHE);
        ctrl_mem.wq_bias_offset = static_cast<uint32_t>(TB_BASE_WQ_BIAS);
        ctrl_mem.wk_bias_offset = static_cast<uint32_t>(TB_BASE_WK_BIAS);
        ctrl_mem.wv_bias_offset = static_cast<uint32_t>(TB_BASE_WV_BIAS);
        ctrl_mem.wo_bias_offset = static_cast<uint32_t>(TB_BASE_WO_BIAS);
        ctrl_mem.w1_bias_offset = static_cast<uint32_t>(TB_BASE_W1_BIAS);
        ctrl_mem.w2_bias_offset = static_cast<uint32_t>(TB_BASE_W2_BIAS);
        ctrl_mem.ln0_gamma_offset = static_cast<uint32_t>(TB_BASE_LN0_GAMMA);
        ctrl_mem.ln1_gamma_offset = static_cast<uint32_t>(TB_BASE_LN1_GAMMA);
        ctrl_mem.final_norm_gamma_offset = static_cast<uint32_t>(TB_BASE_FINAL_NORM_GAMMA);
        ctrl_mem.ln0_eps_offset = static_cast<uint32_t>(TB_BASE_LN0_EPS);
        ctrl_mem.ln1_eps_offset = static_cast<uint32_t>(TB_BASE_LN1_EPS);
        ctrl_mem.final_norm_eps_offset = static_cast<uint32_t>(TB_BASE_FINAL_NORM_EPS);
        ctrl_mem.wlogit_tile_stride = 0x00000080;
        ctrl_mem.wlogit_offset = static_cast<uint32_t>(TB_BASE_WVOCAB);
    }
    return ctrl_mem;
}

int main() {
    if (!init_tb_logs()) {
        return 1;
    }

    const int MAX_CYCLES = 10000;
    const int STREAM_TOKEN_BYTES = STREAM_IN_BUF_BYTES;
    const int AXIS_BEATS = STREAM_TOKEN_BYTES;
    const size_t selected_stream_token = 0;

    axi_gmem_word_t ddr_mem[TB_DDR_IMAGE_WORDS] = {};

    hls::stream<axis8_t> s_axis_in("s_axis_in");
    hls::stream<axis8_t> m_axis_out("m_axis_out");

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;
    int  axis_gap_countdown = 0;
    uint8_t axis_in_data = 0;
    size_t stream_in_bytes_read = 0;

    uint8_t stream_in_buf[STREAM_IN_BUF_BYTES] = {};
    uint8_t stream_out_buf[STREAM_OUT_BUF_BYTES] = {};
    int stream_in_token_index = 0;
    int stream_in_token_byte_idx = 0;
    uint32_t stream_in_token_accum = 0;
    int stream_out_count = 0;
    int stream_out_token_index = 0;

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
    int  base_assign_step = 0;

    if (!load_shared_ctrl_mem(g_loaded_ctrl_mem)) {
        return 1;
    }
    g_loaded_ctrl_mem_valid = true;
    if (!load_shared_ddr_image(ddr_mem, TB_DDR_IMAGE_WORDS)) {
        return 1;
    }
    if (!load_shared_stream_in(stream_in_buf, STREAM_IN_BUF_BYTES, stream_in_bytes_read)) {
        return 1;
    }
    if (stream_in_bytes_read < static_cast<size_t>(STREAM_TOKEN_BYTES)) {
        std::fprintf(stderr, "ERROR: stream_in.bin must contain at least %d bytes (one token)\n", STREAM_TOKEN_BYTES);
        return 1;
    }
    if (stream_in_bytes_read % STREAM_TOKEN_BYTES != 0) {
        std::printf("WARN: stream_in.bin size is not token aligned (%zu bytes). Trailing bytes will be truncated.\n", stream_in_bytes_read);
        stream_in_bytes_read -= (stream_in_bytes_read % STREAM_TOKEN_BYTES);
    }
    const size_t total_stream_tokens = stream_in_bytes_read / static_cast<size_t>(STREAM_TOKEN_BYTES);
    std::printf("[TEST] stream_in.bin contains %zu token(s), sending token 0 only.\n", total_stream_tokens);
    if (selected_stream_token >= total_stream_tokens) {
        std::fprintf(stderr, "ERROR: selected stream token %zu out of range (total=%zu)\n",
                     selected_stream_token, total_stream_tokens);
        return 1;
    }

    enum class CtrlInitStage {
        TestCtrlInit,
        TestDmaZeroLen,
        TestDmaZeroLenCheck,
        TestDmaZeroLenClear,
        TestZeroStride,
        TestZeroStrideCheck,
        TestZeroStrideClear,
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

    uint32_t ctrl_shadow_control = 0;
    int ctrl_gap_cycles = 0;
    bool seen_irq_done = false;

    ControlMemSpace ctrl_mem{};
    StatusMemSpace status_mem{};
    SchedState dbg_state = S_IDLE;
    ControlMemSpace dbg_ctrl_mem{};
    uint32_t control_reg = 0;
    bool dbg_error = false;
    uint32_t dbg_error_code = 0;

    // Tracking previous status for change-based logging
    uint32_t prev_status = 0;
    uint32_t prev_irq_status = 0;
    uint32_t prev_error_code = 0;
    uint32_t prev_layer_index = 0;
    uint32_t prev_dbg_state = 0;

    std::printf("%8s | %12s | %8s | %10s | %8s | %8s | %12s | %6s | %6s\n",
                "cycle",
                "status",
                "irq_stat",
                "error_code",
                "layer",
                "head",
                "dbg_state",
                "irq_ps",
                "ax_fed");
    std::printf("-----------------------------------------------------------------------------------------------\n");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Space out control transactions to model multi-cycle AXI-lite access
        if (ctrl_gap_cycles > 0) {
            ctrl_gap_cycles--;
        } else if (ctrl_stage == CtrlInitStage::TestCtrlInit) {
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            std::printf("[TEST] Starting ControlMemInterface error tests...\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLen;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLen) {
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.dma_layer_len = 0;
            std::printf("[TEST 1] Injecting dma_layer_len=0 (expect ERR_DMA_ZERO_LEN)\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLenCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ZERO_LEN) {
                std::printf("[TEST 1] PASS: ERR_DMA_ZERO_LEN detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 1] FAIL: Expected ERR_DMA_ZERO_LEN (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestDmaZeroLenClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenClear) {
            ctrl_mem.irq_clear = 0;
            ctrl_mem = ctrl_mem_init(true);
            ctrl_stage = CtrlInitStage::TestZeroStride;
            ctrl_gap_cycles = 1;

        } else if (ctrl_stage == CtrlInitStage::TestZeroStride) {
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.layer_stride = 0;
            std::printf("[TEST 2] Injecting layer_stride=0 (expect ERR_DMA_ZERO_LEN)\n");
            ctrl_stage = CtrlInitStage::TestZeroStrideCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestZeroStrideCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ZERO_LEN) {
                std::printf("[TEST 2] PASS: Zero stride error detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 2] FAIL: Expected zero stride error (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestZeroStrideClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestZeroStrideClear) {
            ctrl_mem.irq_clear = 0;
            ctrl_mem = ctrl_mem_init(true);
            ctrl_stage = CtrlInitStage::TestAlignment;
            ctrl_gap_cycles = 1;

        } else if (ctrl_stage == CtrlInitStage::TestAlignment) {
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.wq_offset = 0x00000001u;
            std::printf("[TEST 3] Injecting wq_offset=0x00000001 (expect ERR_DMA_ALIGNMENT)\n");
            ctrl_stage = CtrlInitStage::TestAlignmentCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestAlignmentCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ALIGNMENT) {
                std::printf("[TEST 3] PASS: ERR_DMA_ALIGNMENT detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 3] FAIL: Expected ERR_DMA_ALIGNMENT (irq=0x%X, err=0x%X)\n",
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
            ctrl_mem.control = 0x00000000;
            ctrl_shadow_control = 0x00000000;
            ctrl_stage = CtrlInitStage::DeassertReset;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::DeassertReset) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
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
            ctrl_mem.control = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT | CTRL_START_BIT;
            reset_released = true;
            start_pulsed   = true;
            pending_start_clear = true;
            ctrl_stage = CtrlInitStage::ClearStart;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ClearStart) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
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

        // Drive AXIS ingress beats
        axis_in_valid = false;
        axis_in_last = false;
        axis_in_data = 0;
        if (!axis_feed_done && !axis_drive && (dbg_state == S_STREAM_IN)) {
            axis_drive = true;
            axis_gap_countdown = 0;
        }
        if (!axis_feed_done && axis_drive) {
            if (axis_gap_countdown > 0) {
                axis_gap_countdown--;
            }
            if (axis_sent < AXIS_BEATS) {
                if (axis_gap_countdown == 0) {
                    axis8_t beat{};
                    const size_t token_byte_offset = selected_stream_token * static_cast<size_t>(STREAM_TOKEN_BYTES);
                    beat.data = stream_in_buf[token_byte_offset + static_cast<size_t>(axis_sent)];
                    beat.keep = 1;
                    beat.strb = 1;
                    beat.last = (axis_sent == AXIS_BEATS - 1) ? 1 : 0;
                    if (s_axis_in.write_nb(beat)) {
                        axis_in_valid = true;
                        axis_in_last = (beat.last != 0);
                        axis_in_data = static_cast<uint8_t>(beat.data);
                        stream_in_token_accum |= (static_cast<uint32_t>(axis_in_data) << (8 * stream_in_token_byte_idx));
                        std::printf("[CYCLE %d] Stream in beat: byte_idx=%d token_byte_idx=%d data=0x%02X last=%d\n",
                                    cycle,
                                    axis_sent,
                                    stream_in_token_byte_idx,
                                    static_cast<unsigned>(axis_in_data),
                                    axis_in_last ? 1 : 0);
                        stream_in_token_byte_idx++;
                        if (stream_in_token_byte_idx == 4) {
                            const int32_t token_id = static_cast<int32_t>(stream_in_token_accum);
                            std::printf("[CYCLE %d] Stream in token %d = %d (0x%08X)\n",
                                        cycle,
                                        stream_in_token_index,
                                        token_id,
                                        static_cast<unsigned>(stream_in_token_accum));
                            stream_in_token_index++;
                            stream_in_token_byte_idx = 0;
                            stream_in_token_accum = 0;
                        }
                        axis_sent++;
                        if (axis_in_last) {
                            if (stream_in_token_byte_idx != 0) {
                                const int32_t token_id = static_cast<int32_t>(stream_in_token_accum);
                                std::printf("[CYCLE %d] Stream in partial token %d = %d (0x%08X, bytes=%d)\n",
                                            cycle,
                                            stream_in_token_index,
                                            token_id,
                                            static_cast<unsigned>(stream_in_token_accum),
                                            stream_in_token_byte_idx);
                                stream_in_token_index++;
                            }
                            axis_feed_done = true;
                            axis_drive = false;
                            axis_gap_countdown = 0;
                        } else {
                            axis_gap_countdown = 5;
                        }
                    }
                }
            }
        }

        // Call the production (no-debug) transformer_top
        transformer_top(
            s_axis_in,
            m_axis_out,
            ddr_mem,
            ctrl_mem,
            status_mem,
            irq_ps,
            dbg_state,
            dbg_ctrl_mem,
            control_reg,
            dbg_error,
            dbg_error_code
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
                stream_out_count = 0;
                stream_out_token_index++;
            }
        }

        // Log status changes
        const bool status_changed = (status_mem.status != prev_status) ||
                                    (status_mem.irq_status != prev_irq_status) ||
                                    (status_mem.error_code != prev_error_code) ||
                                    (status_mem.layer_index != prev_layer_index) ||
                                    (status_mem.dbg_state != prev_dbg_state);
        if (status_changed || (cycle % 100 == 0)) {
            std::printf("%8d | %12s | %8s | 0x%08X | %8u | %8u | %12s | %6d | %6d\n",
                        cycle,
                        status_name(status_mem.status),
                        irq_name(status_mem.irq_status),
                        status_mem.error_code,
                        status_mem.layer_index,
                        status_mem.head_index,
                        sched_state_name(status_mem.dbg_state),
                        irq_ps ? 1 : 0,
                        axis_feed_done ? 1 : 0);
            prev_status = status_mem.status;
            prev_irq_status = status_mem.irq_status;
            prev_error_code = status_mem.error_code;
            prev_layer_index = status_mem.layer_index;
            prev_dbg_state = status_mem.dbg_state;
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
        if (status_mem.status & STATUS_BUSY_BIT) {
            seen_stream_out = false; // reset until we see idle again
        }
        if ((status_mem.irq_status & IRQ_INFER_DONE_BIT) && !seen_done) {
            seen_stream_out = true;
        }
        if (seen_stream_out && (status_mem.status & STATUS_IDLE)) {
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

    bool ok = !aborted_on_error && seen_stream_out && (idle_after_stream >= 4);

    if (!ok) {
        if (!seen_stream_out) std::fprintf(stderr, "ERROR: Inference done never reached\n");
        if (idle_after_stream < 4) std::fprintf(stderr, "ERROR: Did not remain in IDLE for 4 cycles after done\n");
        return 1;
    }

    std::printf("PASS: Inference complete, FSM stayed IDLE for %d cycles after.\n",
                idle_after_stream);
    return 0;
}
