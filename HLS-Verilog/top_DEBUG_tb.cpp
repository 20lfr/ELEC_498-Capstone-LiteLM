// Minimal testbench for Simple_Scheduler_FSM.
// Mirrors the style of Scheduler_tb_minimal.cpp but against the simplified scheduler interface.
#include <cstdio>
#include <cstdint>
#include <cstdlib>
#include <cerrno>
#include <cstring>
#include <fstream>
#include <limits>
#include <string>
#include <ctime>
#include <sys/stat.h>

#include "top.hpp"

#ifndef TOP_DEBUG_TB_BASENAME
#define TOP_DEBUG_TB_BASENAME "top_DEBUG_tb"
#endif

#ifndef TOP_DEBUG_TB_LOG_SUBDIR
#define TOP_DEBUG_TB_LOG_SUBDIR "top_DEBUG"
#endif

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
    std::snprintf(log_dir, sizeof(log_dir), "%s/%s", log_root, TOP_DEBUG_TB_LOG_SUBDIR);

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
    std::snprintf(stdout_path, sizeof(stdout_path), "%s/%s_stdout_%s.log", log_dir, TOP_DEBUG_TB_BASENAME, timestamp);
    std::snprintf(stderr_path, sizeof(stderr_path), "%s/%s_stderr_%s.log", log_dir, TOP_DEBUG_TB_BASENAME, timestamp);

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

    std::printf("[LOG] %s stdout: %s\n", TOP_DEBUG_TB_BASENAME, stdout_path);
    std::fprintf(stderr, "[LOG] %s stderr: %s\n", TOP_DEBUG_TB_BASENAME, stderr_path);
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
    auto read_u64 = [&](size_t word_idx_lo) -> uint64_t {
        return static_cast<uint64_t>(read_u32(word_idx_lo)) |
               (static_cast<uint64_t>(read_u32(word_idx_lo + 1)) << 32);
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
    // ctrl_mem.bin still carries legacy words at indices 49..55. The current
    // ControlMemSpace no longer exposes those fields, so the debug TB ignores
    // them while keeping the shared image format unchanged.

    ctrl_mem = tmp;
    return true;
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

static const char *state_name(SchedState st) {
    switch (st) {
    case S_IDLE:            return "S_IDLE";
    case S_STREAM_IN:       return "S_STREAM_IN";
    case S_LAYER_COUNT:     return "S_LAYER_COUNT";
    case S_ATTENTION_HEADS: return "S_ATT_HEADS";
    case S_HEAD_CONCAT:     return "S_HEAD_CONCAT";
    case S_OUT_PROJECTION:  return "S_OUT_PROJ";
    case S_RES_ADD_1:       return "S_RES_ADD_1";
    case S_LAYER_NORM_0:    return "S_LN_0";
    case S_FFN:             return "S_FFN";
    case S_RES_ADD_2:       return "S_RES_ADD_2";
    case S_LAYER_NORM_1:    return "S_LN_1";
    case S_LOOP_CHECK:      return "S_LOOP_CHECK";
    case S_FINAL_NORM:      return "S_FINAL_NORM";
    case S_LOGITS:          return "S_LOGITS";
    case S_ARGMAX:          return "S_ARGMAX";
    case S_STREAM_OUT:      return "S_STREAM_OUT";
    default:                return "UNKNOWN";
    }
}

static const char *op_name(ComputeOp op) {
    switch (op) {
    case CMP_NONE:         return "-";
    case CMP_Q:            return "Q";
    case CMP_K:            return "K";
    case CMP_V:            return "V";
    case CMP_K_REQUANT:    return "K_RQ";
    case CMP_V_REQUANT:    return "V_RQ";
    case CMP_REQUANT_Q:    return "RQ_Q";
    case CMP_ATT_SCORES:   return "ATT_SCORES";
    case CMP_VALUE_SCALE:  return "VALUE_SCALE";
    case CMP_SOFTMAX:      return "SOFTMAX";
    case CMP_ATT_VALUE:    return "ATT_VALUE";
    case CMP_HEAD_REQUANT: return "HEAD_RQ";
    case CMP_CONCAT:       return "CONCAT";
    case CMP_OUT_PROJ:     return "OUT_PROJ";
    case CMP_REQUANT1:     return "RQ1";
    case CMP_RESID1:       return "RESID1";
    case CMP_LN0:          return "LN0";
    case CMP_REQUANT2:     return "RQ2";
    case CMP_FFN_W1:       return "FFN_W1";
    case CMP_FFN_ACT:      return "FFN_ACT";
    case CMP_FFN_W2:       return "FFN_W2";
    case CMP_REQUANT3:     return "RQ3";
    case CMP_RESID2:       return "RESID2";
    case CMP_LN1:          return "LN1";
    case CMP_REQUANT4:     return "RQ4";
    case CMP_FINAL_NORM:   return "FINAL_NORM";
    case CMP_LOGITS:       return "LOGITS";
    case CMP_ARGMAX:       return "ARGMAX";
    default:               return "UNK";
    }
}

static const char *compute_state_name(ComputeState st) {
    switch (st) {
    case ComputeState::IDLE: {
        return "IDLE";
    }
    case ComputeState::CAPTURE_INSTRUCTION: {
        return "CAPTURE_INSTR";
    }
    case ComputeState::WAIT_MEM: {
        return "WAIT_MEM";
    }
    case ComputeState::EXECUTE: {
        return "EXECUTE";
    }
    case ComputeState::MEM_WRITEBACK: {
        return "MEM_WRITEBACK";
    }
    case ComputeState::DONE: {
        return "DONE";
    }
    default: {
        return "UNKNOWN";
    }
    }
}

static inline ComputeOp decode_op(uint32_t packed_op) {
    return static_cast<ComputeOp>(packed_op & 0xFFu);
}

static const char *dma_name(DmaSel sel) {
    switch (sel) {
    case DMASEL_NONE:   return "-";
    case DMASEL_WQ:     return "WQ";
    case DMASEL_WK:     return "WK";
    case DMASEL_WV:     return "WV";
    case DMASEL_CTX_K:  return "CTX_K";
    case DMASEL_CTX_V:  return "CTX_V";
    case DMASEL_K_WRITE:return "K_WR";
    case DMASEL_V_WRITE:return "V_WR";
    case DMASEL_WO:     return "WO";
    case DMASEL_W1:     return "W1";
    case DMASEL_W2:     return "W2";
    case DMASEL_WLOGIT: return "WLOGIT";
    case DMASEL_CONCAT: return "CONCAT";
    case DMASEL_LN0:    return "LN0";
    case DMASEL_LN1:    return "LN1";
    case DMASEL_FINAL_NORM: return "FINAL_NORM";
    default:            return "UNK";
    }
}

static const char *phase_name(HeadPhase ph) {
    switch (ph) {
    case HeadPhase::IDLE:              return "IDLE";
    case HeadPhase::Q:                 return "Q";
    case HeadPhase::K:                 return "K";
    case HeadPhase::K_WRITEBACK:       return "K_WR";
    case HeadPhase::V:                 return "V";
    case HeadPhase::V_WRITEBACK:       return "V_WR";
    case HeadPhase::ATT_SCORES:        return "ATT";
    case HeadPhase::VALUE_SCALE_CLAMP: return "SCL";
    case HeadPhase::ATT_SOFTMAX:       return "SMX";
    case HeadPhase::ATT_VALUE:         return "VAL";
    case HeadPhase::HEAD_REQUANT:     return "HEAD_RQ";
    case HeadPhase::DONE:              return "DONE";
    default:                           return "UNK";
    }
}

enum class LayerInputProfile : int {
    NORMAL = 0,
    MIN_ONLY = 1,
    MAX_ONLY = 2,
    MIXED = 3
};

static inline LayerInputProfile layer_profile(int layer) {
    if (layer <= 0) return LayerInputProfile::NORMAL;
    if (layer == 1) return LayerInputProfile::MIN_ONLY;
    if (layer == 2) return LayerInputProfile::MAX_ONLY;
    return LayerInputProfile::MIXED;
}

static inline int clamp_layer(int layer) {
    if (layer < 0) return 0;
    if (layer >= NUM_LAYERS) return NUM_LAYERS - 1;
    return layer;
}

static inline int8_t stim_i8(int layer, int idx, int salt) {
    const LayerInputProfile p = layer_profile(layer);
    if (p == LayerInputProfile::MIN_ONLY) return std::numeric_limits<int8_t>::min();
    if (p == LayerInputProfile::MAX_ONLY) return std::numeric_limits<int8_t>::max();
    if (p == LayerInputProfile::MIXED) {
        switch ((idx + salt) & 3) {
            case 0: return std::numeric_limits<int8_t>::min();
            case 1: return std::numeric_limits<int8_t>::max();
            case 2: return static_cast<int8_t>(((idx * 11 + salt * 3 + layer) % 63) - 31);
            default:return static_cast<int8_t>(-(((idx * 7 + salt * 5 + layer) % 63) - 31));
        }
    }
    return static_cast<int8_t>(((idx * 13 + salt * 7 + layer * 5) % 95) - 47);
}

static inline int8_t stim_i8_mid(int layer, int idx, int salt) {
    // Mid-range signed values for attention-score inputs (avoid rail-only patterns).
    int v = ((idx * 17 + salt * 9 + layer * 5) % 97) - 48; // [-48, 48]
    if (((idx + salt + layer) & 7) == 0) v = 0;
    return static_cast<int8_t>(v);
}

static inline int16_t stim_i16(int layer, int idx, int salt) {
    const LayerInputProfile p = layer_profile(layer);
    if (p == LayerInputProfile::MIN_ONLY) return std::numeric_limits<int16_t>::min();
    if (p == LayerInputProfile::MAX_ONLY) return std::numeric_limits<int16_t>::max();
    if (p == LayerInputProfile::MIXED) {
        switch ((idx + salt) & 3) {
            case 0: return std::numeric_limits<int16_t>::min();
            case 1: return std::numeric_limits<int16_t>::max();
            case 2: return static_cast<int16_t>(((idx * 173 + salt * 19 + layer * 11) % 8191) - 4095);
            default:return static_cast<int16_t>(-(((idx * 131 + salt * 23 + layer * 7) % 8191) - 4095));
        }
    }
    return static_cast<int16_t>(((idx * 139 + salt * 17 + layer * 29) % 4095) - 2047);
}

static inline int32_t stim_i32(int layer, int idx, int salt) {
    const LayerInputProfile p = layer_profile(layer);
    if (p == LayerInputProfile::MIN_ONLY) return std::numeric_limits<int32_t>::min();
    if (p == LayerInputProfile::MAX_ONLY) return std::numeric_limits<int32_t>::max();
    if (p == LayerInputProfile::MIXED) {
        switch ((idx + salt) % 6) {
            case 0: return std::numeric_limits<int32_t>::max();
            case 1: return std::numeric_limits<int32_t>::min();
            case 2: return 2000000000;
            case 3: return -2000000000;
            case 4: return ((idx * 7919 + salt * 313 + layer * 97) % 500000) - 250000;
            default:return -(((idx * 6151 + salt * 271 + layer * 89) % 500000) - 250000);
        }
    }
    return ((idx * 3571 + salt * 173 + layer * 97) % 200000) - 100000;
}

static inline int4_t stim_i4(int layer, int idx, int salt) {
    const LayerInputProfile p = layer_profile(layer);
    int v = 0;
    if (p == LayerInputProfile::MIN_ONLY) {
        v = (((idx + salt) % 5) == 0) ? -7 : -8;
    } else if (p == LayerInputProfile::MAX_ONLY) {
        v = (((idx + salt) % 5) == 0) ? 6 : 7;
    } else if (p == LayerInputProfile::MIXED) {
        switch ((idx + salt) & 3) {
            case 0: v = -8; break;
            case 1: v = 7; break;
            case 2: v = ((idx + salt + layer) % 15) - 7; break;
            default:v = -(((idx * 3 + salt + layer) % 15) - 7); break;
        }
    } else {
        v = ((idx * 3 + salt + layer * 2) % 15) - 7;
    }
    if (v > 7) v = 7;
    if (v < -8) v = -8;
    return static_cast<int4_t>(v);
}

static inline int32_t stim_eps(int layer, int salt) {
    const LayerInputProfile p = layer_profile(layer);
    if (p == LayerInputProfile::MIN_ONLY) return 1;
    if (p == LayerInputProfile::MAX_ONLY) return 1024;
    if (p == LayerInputProfile::MIXED) return 7 + ((salt + layer) % 13);
    return 3 + ((salt + layer) % 5);
}

// Gamma stimulus in Q19.13 range, intentionally away from extreme int32 rails.
static inline int32_t stim_gamma_q19_13(int layer, int idx, int salt) {
    const LayerInputProfile p = layer_profile(layer);
    switch (p) {
        case LayerInputProfile::MIN_ONLY:
            return 4096 + ((idx * 17 + salt + layer) % 1024);   // ~[0.5, 0.625]
        case LayerInputProfile::MAX_ONLY:
            return 12288 + ((idx * 19 + salt + layer) % 2048);  // ~[1.5, 1.75]
        case LayerInputProfile::MIXED: {
            switch ((idx + salt) & 3) {
                case 0: return 2048;   // 0.25
                case 1: return 6144;   // 0.75
                case 2: return 8192;   // 1.0
                default:return 12288;  // 1.5
            }
        }
        case LayerInputProfile::NORMAL:
        default:
            return 8192 + (((idx * 37 + salt * 5 + layer * 11) % 2049) - 1024); // ~[0.875, 1.125]
    }
}

static inline void force_i8_i4_mm_corners(
    int8_t *act,
    int act_len,
    int4_t *weights,
    int rows,
    int cols
) {
    if (act_len < 4 || cols < 4 || rows <= 0) return;
    act[0] = std::numeric_limits<int8_t>::max();
    act[1] = std::numeric_limits<int8_t>::max();
    act[2] = std::numeric_limits<int8_t>::min();
    act[3] = std::numeric_limits<int8_t>::min();
    for (int r = 0; r < rows; ++r) {
        const int base = r * cols;
        weights[base + 0] = static_cast<int4_t>(7);   // max weight
        weights[base + 1] = static_cast<int4_t>(-8);  // min weight
        weights[base + 2] = static_cast<int4_t>(7);   // max weight
        weights[base + 3] = static_cast<int4_t>(-8);  // min weight
    }
}

static inline void force_i16_i4_mm_corners(
    int16_t *act,
    int act_len,
    int4_t *weights,
    int rows,
    int cols
) {
    if (act_len < 4 || cols < 4 || rows <= 0) return;
    act[0] = std::numeric_limits<int16_t>::max();
    act[1] = std::numeric_limits<int16_t>::max();
    act[2] = std::numeric_limits<int16_t>::min();
    act[3] = std::numeric_limits<int16_t>::min();
    for (int r = 0; r < rows; ++r) {
        const int base = r * cols;
        weights[base + 0] = static_cast<int4_t>(7);
        weights[base + 1] = static_cast<int4_t>(-8);
        weights[base + 2] = static_cast<int4_t>(7);
        weights[base + 3] = static_cast<int4_t>(-8);
    }
}

static inline void force_i8_i8_mm_corners(
    int8_t *act,
    int act_len,
    int8_t *weights,
    int rows,
    int cols
) {
    if (act_len < 4 || cols < 4 || rows <= 0) return;
    act[0] = std::numeric_limits<int8_t>::max();
    act[1] = std::numeric_limits<int8_t>::max();
    act[2] = std::numeric_limits<int8_t>::min();
    act[3] = std::numeric_limits<int8_t>::min();
    for (int r = 0; r < rows; ++r) {
        const int base = r * cols;
        weights[base + 0] = std::numeric_limits<int8_t>::max();
        weights[base + 1] = std::numeric_limits<int8_t>::min();
        weights[base + 2] = std::numeric_limits<int8_t>::max();
        weights[base + 3] = std::numeric_limits<int8_t>::min();
    }
}

static inline void force_i16_i8_mm_corners(
    int16_t *act,
    int act_len,
    int8_t *weights,
    int rows,
    int cols
) {
    if (act_len < 4 || cols < 4 || rows <= 0) return;
    act[0] = std::numeric_limits<int16_t>::max();
    act[1] = std::numeric_limits<int16_t>::max();
    act[2] = std::numeric_limits<int16_t>::min();
    act[3] = std::numeric_limits<int16_t>::min();
    for (int r = 0; r < rows; ++r) {
        const int base = r * cols;
        weights[base + 0] = std::numeric_limits<int8_t>::max();
        weights[base + 1] = std::numeric_limits<int8_t>::min();
        weights[base + 2] = std::numeric_limits<int8_t>::max();
        weights[base + 3] = std::numeric_limits<int8_t>::min();
    }
}

static inline void force_i8_i4stored_i8_mm_corners(
    int8_t *act,
    int act_len,
    int8_t *weights,
    int rows,
    int cols
) {
    if (act_len < 4 || cols < 4 || rows <= 0) return;
    act[0] = std::numeric_limits<int8_t>::max();
    act[1] = std::numeric_limits<int8_t>::max();
    act[2] = std::numeric_limits<int8_t>::min();
    act[3] = std::numeric_limits<int8_t>::min();
    for (int r = 0; r < rows; ++r) {
        const int base = r * cols;
        weights[base + 0] = 7;
        weights[base + 1] = -8;
        weights[base + 2] = 7;
        weights[base + 3] = -8;
    }
}

static inline void force_i16_i4stored_i8_mm_corners(
    int16_t *act,
    int act_len,
    int8_t *weights,
    int rows,
    int cols
) {
    if (act_len < 4 || cols < 4 || rows <= 0) return;
    act[0] = std::numeric_limits<int16_t>::max();
    act[1] = std::numeric_limits<int16_t>::max();
    act[2] = std::numeric_limits<int16_t>::min();
    act[3] = std::numeric_limits<int16_t>::min();
    for (int r = 0; r < rows; ++r) {
        const int base = r * cols;
        weights[base + 0] = 7;
        weights[base + 1] = -8;
        weights[base + 2] = 7;
        weights[base + 3] = -8;
    }
}

static void print_buffer(const char *label, const uint8_t *buf, int size) {
    std::printf("%s[%d]:\n", label, size);
    for (int i = 0; i < size; ++i) {
        if ((i % 16) == 0) {
            std::printf("  %04x:", i);
        }
        std::printf(" %02x", static_cast<unsigned>(buf[i]));
        if ((i % 16) == 15 || i == size - 1) {
            std::printf("\n");
        }
    }
}

static bool buffer_changed(const uint8_t *a, const uint8_t *b, int size) {
    for (int i = 0; i < size; ++i) {
        if (a[i] != b[i]) return true;
    }
    return false;
}

static void copy_buffer(uint8_t *dst, const uint8_t *src, int size) {
    for (int i = 0; i < size; ++i) {
        dst[i] = src[i];
    }
}

static void print_stream_in_buf_decoded(const uint8_t *buf) {
    std::printf("stream_in_buf (decoded int8):\n  X:");
    for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i8(buf, i)));
    }
    std::printf("\n");
}

static void print_stream_out_buf_decoded(const uint8_t *buf) {
    std::printf("stream_out_buf (decoded int32):\n  Y:");
    const int elems = STREAM_OUT_BUF_BYTES / 4;
    for (int i = 0; i < elems; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i32(buf, i * 4)));
    }
    std::printf("\n");
}

static void print_ln_in_buf(const uint8_t *in_buf) {
    std::printf("LN in_buf (decoded):\n  X:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i)));
    }
    std::printf("\n  GAMMA:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4))));
    }
    const int32_t eps = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::EPS);
    std::printf("\n  EPS: %d\n", static_cast<int>(eps));
}

static void print_ln_out_buf(const uint8_t *out_buf) {
    std::printf("LN out_buf (decoded):\n  Y:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, compute_buf::INLayerNormLayout::X + (i * 4))));
    }
    std::printf("\n");
}

static void print_in_buf_decoded(ComputeOp op, const uint8_t *in_buf) {
    switch (op) {
    case ComputeOp::CMP_OUT_PROJ: {
        std::printf("OUT_PROJ in_buf (decoded):\n  ACT:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INOutProjLayout::ACT + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::INOutProjLayout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INOutProjLayout::B + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_REQUANT1:
    case ComputeOp::CMP_REQUANT2:
    case ComputeOp::CMP_REQUANT3:
    case ComputeOp::CMP_REQUANT4: {
        std::printf("REQUANT in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4))));
        }
        int32_t M = 0;
        int32_t N = 0;
        switch (op) {
            case ComputeOp::CMP_REQUANT1:
                M = requant_params::REQUANT1_M;
                N = requant_params::REQUANT1_N;
                break;
            case ComputeOp::CMP_REQUANT2:
                M = requant_params::REQUANT2_M;
                N = requant_params::REQUANT2_N;
                break;
            case ComputeOp::CMP_REQUANT3:
                M = requant_params::REQUANT3_M;
                N = requant_params::REQUANT3_N;
                break;
            case ComputeOp::CMP_REQUANT4:
                M = requant_params::REQUANT4_M;
                N = requant_params::REQUANT4_N;
                break;
            default:
                break;
        }
        std::printf("\n  M: %d\n  N: %d\n", static_cast<int>(M), static_cast<int>(N));
        break;
    }
    case ComputeOp::CMP_RESID1:
    case ComputeOp::CMP_RESID2: {
        std::printf("RESID in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::X + i)));
        }
        std::printf("\n  R:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::R + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LN0:
    case ComputeOp::CMP_LN1:
    case ComputeOp::CMP_FINAL_NORM:
        print_ln_in_buf(in_buf);
        break;
    case ComputeOp::CMP_FFN_W1: {
        std::printf("FFN_W1 in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INFfnW1Layout::X + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::INFfnW1Layout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INFfnW1Layout::B + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_ACT: {
        std::printf("FFN_ACT in_buf (decoded):\n  GATE:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2))));
        }
        std::printf("\n  UP:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::UP + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_W2: {
        std::printf("FFN_W2 in_buf (decoded):\n  X:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnW2Layout::X + (i * 2))));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_FFN * D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::INFfnW2Layout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INFfnW2Layout::B + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LOGITS: {
        std::printf("LOGITS in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d",
                        static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INLogitsLayout::X + (i * 4))));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_TILE_LOGIT; ++i) {
            std::printf(" %d",
                        static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::INLogitsLayout::W * 2) + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ARGMAX: {
        std::printf("ARGMAX in_buf (decoded):\n  X:");
        for (int i = 0; i < D_VOCAB; ++i) {
            std::printf(" %d",
                        static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    default:
        std::printf("in_buf (decoded): <no decoder>\n");
        break;
    }
}

static void print_out_buf_decoded(ComputeOp op, const uint8_t *out_buf) {
    switch (op) {
    case ComputeOp::CMP_OUT_PROJ: {
        std::printf("OUT_PROJ out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_REQUANT1:
    case ComputeOp::CMP_REQUANT2:
    case ComputeOp::CMP_REQUANT3:
    case ComputeOp::CMP_REQUANT4: {
        std::printf("REQUANT out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, compute_buf::INRequantLayout::X + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_RESID1:
    case ComputeOp::CMP_RESID2: {
        std::printf("RESID out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, compute_buf::INResidLayout::X + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LN0:
    case ComputeOp::CMP_LN1: {
        std::printf("LN out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FINAL_NORM:
        print_ln_out_buf(out_buf);
        break;
    case ComputeOp::CMP_FFN_W1: {
        std::printf("FFN_W1 out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(out_buf, i * 2)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_ACT: {
        std::printf("FFN_ACT out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(out_buf, compute_buf::INFfnActLayout::OUT + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_W2: {
        std::printf("FFN_W2 out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LOGITS: {
        std::printf("LOGITS out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_TILE_LOGIT; ++i) {
            std::printf(" %d",
                        static_cast<int>(compute_buf::read_i32(out_buf, compute_buf::OUTLogitsLayout::Y + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ARGMAX: {
        std::printf("ARGMAX out_buf (decoded):\n  Y:");
        for (int i = 0; i < 1; ++i) {
            std::printf(" %d",
                        static_cast<int>(compute_buf::read_i32(out_buf, compute_buf::OUTArgmaxLayout::Y + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    default:
        std::printf("out_buf (decoded): <no decoder>\n");
        break;
    }
}

static void print_head_in_buf_decoded(ComputeOp op, const uint8_t *in_buf) {
    switch (op) {
    case ComputeOp::CMP_Q:
    case ComputeOp::CMP_K:
    case ComputeOp::CMP_V: {
        std::printf("HEAD QKV in_buf (decoded, tile-local):\n  ACT:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INQkvLayout::ACT + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_HEAD_TILE_QKV; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (head_buf::INQkvLayout::W * 2) + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_K_REQUANT:
    case ComputeOp::CMP_V_REQUANT:
    case ComputeOp::CMP_REQUANT_Q:
    case ComputeOp::CMP_HEAD_REQUANT: {
        std::printf("HEAD_REQUANT in_buf (decoded):\n  X:");
        for (int i = 0; i < D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, head_buf::INHeadRequantLayout::X + (i * 4))));
        }
        int32_t M = 0;
        int32_t N = 0;
        switch (op) {
            case ComputeOp::CMP_K_REQUANT:
                M = requant_params::REQUANT_K_M;
                N = requant_params::REQUANT_K_N;
                break;
            case ComputeOp::CMP_V_REQUANT:
                M = requant_params::REQUANT_V_M;
                N = requant_params::REQUANT_V_N;
                break;
            case ComputeOp::CMP_REQUANT_Q:
                M = requant_params::REQUANT_Q_M;
                N = requant_params::REQUANT_Q_N;
                break;
            case ComputeOp::CMP_HEAD_REQUANT:
                M = requant_params::REQUANT_HEAD_M;
                N = requant_params::REQUANT_HEAD_N;
                break;
            default:
                break;
        }
        std::printf("\n  M: %d\n  N: %d\n", static_cast<int>(M), static_cast<int>(N));
        break;
    }
    case ComputeOp::CMP_ATT_SCORES: {
        std::printf("ATT_SCORES in_buf (decoded, block-local):\n  Q:");
        for (int i = 0; i < D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::Q + i)));
        }
        std::printf("\n  K_CACHE:");
        for (int i = 0; i < ATT_CTX_BLOCK * D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::K_CACHE + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_VALUE_SCALE: {
        std::printf("VALUE_SCALE in_buf (decoded):\n  X:");
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, head_buf::INValueScaleLayout::X + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_SOFTMAX: {
        std::printf("SOFTMAX in_buf (decoded):\n  X:");
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ATT_VALUE: {
        std::printf("ATT_VALUE in_buf (decoded, tile-local):\n  W:");
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, head_buf::INAttValueLayout::WEIGHTS + (i * 2))));
        }
        std::printf("\n  V_CACHE:");
        for (int i = 0; i < CONTEXT_LENGTH * D_HEAD_TILE_ATT_VALUE; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INAttValueLayout::V_CACHE + i)));
        }
        std::printf("\n");
        break;
    }
    default:
        break;
    }
}

static void print_head_out_buf_decoded(ComputeOp op, const uint8_t *out_buf) {
    switch (op) {
    case ComputeOp::CMP_Q:
    case ComputeOp::CMP_K:
    case ComputeOp::CMP_V: {
        std::printf("HEAD_Q out_buf (decoded, tile-local):\n  Y:");
        for (int i = 0; i < D_HEAD_TILE_QKV; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ATT_VALUE: {
        std::printf("HEAD out_buf (decoded, tile-local):\n  Y:");
        for (int i = 0; i < D_HEAD_TILE_ATT_VALUE; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, i * 4)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_K_REQUANT:
    case ComputeOp::CMP_V_REQUANT:
    case ComputeOp::CMP_REQUANT_Q:
    case ComputeOp::CMP_HEAD_REQUANT: {
        std::printf("HEAD_REQUANT out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ATT_SCORES: {
        std::printf("ATT_SCORES out_buf (decoded, block-local):\n  Y:");
        for (int i = 0; i < ATT_CTX_BLOCK; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, i * 4)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_VALUE_SCALE:
    case ComputeOp::CMP_SOFTMAX: {
        std::printf("HEAD out_buf (decoded):\n  Y:");
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(out_buf, i * 2)));
        }
        std::printf("\n");
        break;
    }
    default:
        break;
    }
}

// ------------------------------------------------------------
// Headed attention test vectors (per lane)
// ------------------------------------------------------------
static int8_t g_q_act[HEADS_PARALLEL][D_MODEL] = {};
static int8_t g_k_act[HEADS_PARALLEL][D_MODEL] = {};
static int8_t g_v_act[HEADS_PARALLEL][D_MODEL] = {};
static int4_t g_wq[HEADS_PARALLEL][D_MODEL * D_HEADS] = {};
static int4_t g_wk[HEADS_PARALLEL][D_MODEL * D_HEADS] = {};
static int4_t g_wv[HEADS_PARALLEL][D_MODEL * D_HEADS] = {};
static int32_t g_bq[HEADS_PARALLEL][D_HEADS] = {};
static int32_t g_bk[HEADS_PARALLEL][D_HEADS] = {};
static int32_t g_bv[HEADS_PARALLEL][D_HEADS] = {};

static int32_t g_rq_k_x[HEADS_PARALLEL][D_HEADS] = {};
static int32_t g_rq_v_x[HEADS_PARALLEL][D_HEADS] = {};
static int32_t g_rq_q_x[HEADS_PARALLEL][D_HEADS] = {};
static int32_t g_rq_head_x[HEADS_PARALLEL][D_HEADS] = {};
static int32_t g_rq_k_M[HEADS_PARALLEL] = {};
static int32_t g_rq_k_N[HEADS_PARALLEL] = {};
static int32_t g_rq_v_M[HEADS_PARALLEL] = {};
static int32_t g_rq_v_N[HEADS_PARALLEL] = {};
static int32_t g_rq_q_M[HEADS_PARALLEL] = {};
static int32_t g_rq_q_N[HEADS_PARALLEL] = {};
static int32_t g_rq_head_M[HEADS_PARALLEL] = {};
static int32_t g_rq_head_N[HEADS_PARALLEL] = {};

static int8_t g_att_q[HEADS_PARALLEL][D_HEADS] = {};
static int8_t g_att_k_cache[HEADS_PARALLEL][CONTEXT_LENGTH * D_HEADS] = {};
static int32_t g_val_scale_in[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
static int16_t g_softmax_in[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
static int16_t g_att_weights[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
static int8_t g_att_v_cache[HEADS_PARALLEL][CONTEXT_LENGTH * D_HEADS] = {};

static void fill_head_lane_inputs(int lane, int layer) {
    layer = clamp_layer(layer);
    for (int i = 0; i < D_MODEL; ++i) {
        // Keep Q inputs in a mid-range to reduce artificial saturation.
        g_q_act[lane][i] = stim_i8_mid(layer, i, 11 + lane);
        g_k_act[lane][i] = stim_i8(layer, i, 21 + lane);
        g_v_act[lane][i] = stim_i8(layer, i, 31 + lane);
    }
    for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
        int q_w = static_cast<int>(stim_i4(layer, i, 41 + lane));
        if (q_w > 3) {
            q_w = 3;
        } else if (q_w < -3) {
            q_w = -3;
        }
        g_wq[lane][i] = static_cast<int4_t>(q_w);
        g_wk[lane][i] = stim_i4(layer, i, 51 + lane);
        g_wv[lane][i] = stim_i4(layer, i, 61 + lane);
    }
    for (int h = 0; h < D_HEADS; ++h) {
        g_bq[lane][h] = stim_i32(layer, h, 71 + lane);
        g_bk[lane][h] = stim_i32(layer, h, 81 + lane);
        g_bv[lane][h] = stim_i32(layer, h, 91 + lane);
        g_att_q[lane][h] = stim_i8_mid(layer, h, 101 + lane);
        g_rq_k_x[lane][h] = stim_i32(layer, h, 111 + lane);
        g_rq_v_x[lane][h] = stim_i32(layer, h, 121 + lane);
        g_rq_q_x[lane][h] = stim_i32(layer, h, 131 + lane);
        g_rq_head_x[lane][h] = stim_i32(layer, h, 141 + lane);
    }
    g_rq_k_M[lane] = 11 + lane;
    g_rq_k_N[lane] = 3 + lane;
    g_rq_v_M[lane] = 12 + lane;
    g_rq_v_N[lane] = 4 + lane;
    g_rq_q_M[lane] = 13 + lane;
    g_rq_q_N[lane] = 5 + lane;
    g_rq_head_M[lane] = 14 + lane;
    g_rq_head_N[lane] = 6 + lane;

    for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
        g_att_k_cache[lane][i] = stim_i8_mid(layer, i, 151 + lane);
        g_att_v_cache[lane][i] = stim_i8(layer, i, 161 + lane);
    }
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
        g_val_scale_in[lane][i] = stim_i32(layer, i, 171 + lane);
        g_softmax_in[lane][i] = stim_i16(layer, i, 181 + lane);
        g_att_weights[lane][i] = stim_i16(layer, i, 191 + lane);
    }

    // Force first MM lanes into explicit overflow corner cases:
    // +A*+W, +A*-W, -A*+W, -A*-W.
    force_i8_i4_mm_corners(g_k_act[lane], D_MODEL, g_wk[lane], D_HEADS, D_MODEL);
    force_i8_i4_mm_corners(g_v_act[lane], D_MODEL, g_wv[lane], D_HEADS, D_MODEL);
    force_i16_i8_mm_corners(g_att_weights[lane], CONTEXT_LENGTH, g_att_v_cache[lane], D_HEADS, CONTEXT_LENGTH);
}

static void build_head_in_buf(int lane, int layer, ComputeOp op, uint8_t head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES]) {
    fill_head_lane_inputs(lane, layer);
    uint8_t *buf = head_in_buf[lane];
    for (int i = 0; i < head_buf::IN_BUF_BYTES; ++i) {
        buf[i] = 0;
    }
    switch (op) {
    case ComputeOp::CMP_Q:
    case ComputeOp::CMP_K:
    case ComputeOp::CMP_V: {
        const int8_t *act = (op == ComputeOp::CMP_Q) ? g_q_act[lane]
                              : (op == ComputeOp::CMP_K) ? g_k_act[lane]
                              : g_v_act[lane];
        const int4_t *w = (op == ComputeOp::CMP_Q) ? g_wq[lane]
                          : (op == ComputeOp::CMP_K) ? g_wk[lane]
                          : g_wv[lane];
        for (int i = 0; i < D_MODEL; ++i) {
            compute_buf::write_i8(buf, head_buf::INQkvLayout::ACT + i, act[i]);
        }
        for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
            compute_buf::write_i4(buf, (head_buf::INQkvLayout::W * 2) + i, w[i]);
        }
        break;
    }
    case ComputeOp::CMP_K_REQUANT:
    case ComputeOp::CMP_V_REQUANT:
    case ComputeOp::CMP_REQUANT_Q:
    case ComputeOp::CMP_HEAD_REQUANT: {
        const int32_t *x = (op == ComputeOp::CMP_K_REQUANT) ? g_rq_k_x[lane]
                          : (op == ComputeOp::CMP_V_REQUANT) ? g_rq_v_x[lane]
                          : (op == ComputeOp::CMP_REQUANT_Q) ? g_rq_q_x[lane]
                          : g_rq_head_x[lane];
        for (int h = 0; h < D_HEADS; ++h) {
            compute_buf::write_i32(buf, head_buf::INHeadRequantLayout::X + (h * 4), x[h]);
        }
        break;
    }
    case ComputeOp::CMP_ATT_SCORES: {
        for (int h = 0; h < D_HEADS; ++h) {
            compute_buf::write_i8(buf, head_buf::INAttScoresLayout::Q + h, g_att_q[lane][h]);
        }
        for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
            compute_buf::write_i8(buf, head_buf::INAttScoresLayout::K_CACHE + i, g_att_k_cache[lane][i]);
        }
        break;
    }
    case ComputeOp::CMP_VALUE_SCALE: {
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            compute_buf::write_i32(buf, head_buf::INValueScaleLayout::X + (i * 4), g_val_scale_in[lane][i]);
        }
        break;
    }
    case ComputeOp::CMP_SOFTMAX: {
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            compute_buf::write_i16(buf, head_buf::INSoftmaxLayout::X + (i * 2), g_softmax_in[lane][i]);
        }
        break;
    }
    case ComputeOp::CMP_ATT_VALUE: {
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            compute_buf::write_i16(buf, head_buf::INAttValueLayout::WEIGHTS + (i * 2), g_att_weights[lane][i]);
        }
        for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
            compute_buf::write_i8(buf, head_buf::INAttValueLayout::V_CACHE + i, g_att_v_cache[lane][i]);
        }
        break;
    }
    default:
        break;
    }
}

struct DmaFields {
    DmaSel sel;
    int layer;
    int head;
    int tile;
};

static inline DmaFields decode_wl_instruction(uint32_t instr) {
    DmaFields f;
    f.sel = static_cast<DmaSel>(instr & 0xFFu);
    f.layer = static_cast<int>((instr >> 8) & 0xFFu);
    f.head = static_cast<int>(static_cast<int8_t>((instr >> 16) & 0xFFu));
    f.tile = static_cast<int>(static_cast<int8_t>((instr >> 24) & 0xFFu));
    return f;
}

static uint64_t compute_wl_address(uint32_t instr, const ControlMemSpace &ctrl) {
    const DmaFields f = decode_wl_instruction(instr);
    if (f.layer < 0) {
        return 0;
    }
    const uint64_t layer_u = static_cast<uint64_t>(f.layer);
    switch (f.sel) {
    case DMASEL_WQ:
        if (f.head < 0) return 0;
        return static_cast<uint64_t>(ctrl.wq_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.wq_head_stride);
    case DMASEL_WK:
        if (f.head < 0) return 0;
        return static_cast<uint64_t>(ctrl.wk_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.wk_head_stride);
    case DMASEL_WV:
        if (f.head < 0) return 0;
        return static_cast<uint64_t>(ctrl.wv_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.wv_head_stride);
    case DMASEL_CTX_K:
        if (f.head < 0) return 0;
        return static_cast<uint64_t>(ctrl.k_cache_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.k_cache_stride);
    case DMASEL_CTX_V:
        if (f.head < 0) return 0;
        return static_cast<uint64_t>(ctrl.v_cache_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.v_cache_stride);
    case DMASEL_WO:
        if (f.tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.wo_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.tile) * static_cast<uint64_t>(ctrl.wo_tile_stride);
    case DMASEL_W1:
        if (f.tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.w1_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.tile) * static_cast<uint64_t>(ctrl.w1_tile_stride);
    case DMASEL_W2:
        if (f.tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.w2_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.tile) * static_cast<uint64_t>(ctrl.w2_tile_stride);
    case DMASEL_WLOGIT:
        if (f.tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.wlogit_offset) +
               static_cast<uint64_t>(f.tile) * static_cast<uint64_t>(ctrl.wlogit_tile_stride);
    case DMASEL_LN0:
        return static_cast<uint64_t>(ctrl.ln0_gamma_offset) + layer_u * static_cast<uint64_t>(ctrl.ln0_gamma_stride);
    case DMASEL_LN1:
        return static_cast<uint64_t>(ctrl.ln1_gamma_offset) + layer_u * static_cast<uint64_t>(ctrl.ln1_gamma_stride);
    case DMASEL_FINAL_NORM:
        return static_cast<uint64_t>(ctrl.final_norm_gamma_offset);
    case DMASEL_CONCAT:
        return 0;
    default:
        return 0;
    }
}

static uint64_t compute_wl_address(
    DmaSel sel,
    int layer,
    int head,
    int tile,
    const ControlMemSpace &ctrl
) {
    if (layer < 0) {
        return 0;
    }
    const uint64_t layer_u = static_cast<uint64_t>(layer);
    switch (sel) {
    case DMASEL_WQ:
        if (head < 0) return 0;
        return static_cast<uint64_t>(ctrl.wq_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.wq_head_stride);
    case DMASEL_WK:
        if (head < 0) return 0;
        return static_cast<uint64_t>(ctrl.wk_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.wk_head_stride);
    case DMASEL_WV:
        if (head < 0) return 0;
        return static_cast<uint64_t>(ctrl.wv_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.wv_head_stride);
    case DMASEL_CTX_K:
        if (head < 0) return 0;
        return static_cast<uint64_t>(ctrl.k_cache_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.k_cache_stride);
    case DMASEL_CTX_V:
        if (head < 0) return 0;
        return static_cast<uint64_t>(ctrl.v_cache_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.v_cache_stride);
    case DMASEL_WO:
        if (tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.wo_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(tile) * static_cast<uint64_t>(ctrl.wo_tile_stride);
    case DMASEL_W1:
        if (tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.w1_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(tile) * static_cast<uint64_t>(ctrl.w1_tile_stride);
    case DMASEL_W2:
        if (tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.w2_offset) + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(tile) * static_cast<uint64_t>(ctrl.w2_tile_stride);
    case DMASEL_WLOGIT:
        if (tile < 0) return 0;
        return static_cast<uint64_t>(ctrl.wlogit_offset) +
               static_cast<uint64_t>(tile) * static_cast<uint64_t>(ctrl.wlogit_tile_stride);
    case DMASEL_LN0:
        return static_cast<uint64_t>(ctrl.ln0_gamma_offset) + layer_u * static_cast<uint64_t>(ctrl.ln0_gamma_stride);
    case DMASEL_LN1:
        return static_cast<uint64_t>(ctrl.ln1_gamma_offset) + layer_u * static_cast<uint64_t>(ctrl.ln1_gamma_stride);
    case DMASEL_FINAL_NORM:
        return static_cast<uint64_t>(ctrl.final_norm_gamma_offset);
    default:
        return 0;
    }
}

// Helper to decode status register bits
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
    default:
        return "UNKNOWN";
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
        if (g_loaded_ctrl_mem_valid) {
            return g_loaded_ctrl_mem;
        }
        ctrl_mem.control = CTRL_RESETN_BIT;
        ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
        ctrl_mem.irq_clear = 0;
        // DMA lengths (non-zero required)
        ctrl_mem.dma_layer_len = 0x00000100;
        ctrl_mem.dma_head_len  = 0x00000040;
        ctrl_mem.dma_tile_len  = 0x00000020;
        // Strides (non-zero required) - match OG testbench values
        ctrl_mem.layer_stride    = 0x00001000;
        ctrl_mem.wq_head_stride  = 0x00000100;
        ctrl_mem.wk_head_stride  = 0x00000100;
        ctrl_mem.wv_head_stride  = 0x00000100;
        ctrl_mem.k_cache_stride  = 0x00000100;
        ctrl_mem.v_cache_stride  = 0x00000100;
        ctrl_mem.wo_tile_stride  = 0x00000020;
        ctrl_mem.w1_tile_stride  = 0x00000040;
        ctrl_mem.w2_tile_stride  = 0x00000040;
        ctrl_mem.wo_bias_tile_stride = 0x00000020;
        ctrl_mem.w1_bias_tile_stride = 0x00000040;
        ctrl_mem.w2_bias_tile_stride = 0x00000020;
        ctrl_mem.ln0_gamma_stride = 0x00000040;
        ctrl_mem.ln1_gamma_stride = 0x00000040;
        ctrl_mem.final_norm_gamma_stride = 0x00000040;
        ctrl_mem.ln0_eps_stride = 0x00000004;
        ctrl_mem.ln1_eps_stride = 0x00000004;
        ctrl_mem.final_norm_eps_stride = 0x00000004;
        // Region offsets into the shared AXI full backing image (must remain
        // 64-byte aligned).
        ctrl_mem.wq_offset = static_cast<uint32_t>(TB_BASE_WQ);
        ctrl_mem.wk_offset = static_cast<uint32_t>(TB_BASE_WK);
        ctrl_mem.wv_offset = static_cast<uint32_t>(TB_BASE_WV);
        ctrl_mem.wo_offset = static_cast<uint32_t>(TB_BASE_WO);
        ctrl_mem.w1_offset = static_cast<uint32_t>(TB_BASE_W1);
        ctrl_mem.w2_offset = static_cast<uint32_t>(TB_BASE_W2);
        ctrl_mem.k_cache_offset = static_cast<uint32_t>(TB_BASE_K_CACHE);
        ctrl_mem.v_cache_offset = static_cast<uint32_t>(TB_BASE_V_CACHE);
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

static inline void write_i4(uint8_t *buf, int nibble_idx, int8_t value) {
    const uint8_t v = static_cast<uint8_t>(value) & 0x0F;
    const int byte_addr = nibble_idx / 2;
    if (nibble_idx % 2) {
        buf[byte_addr] = (buf[byte_addr] & 0x0F) | (v << 4);
    } else {
        buf[byte_addr] = (buf[byte_addr] & 0xF0) | v;
    }
}

static inline uint8_t dma_word_get_byte(const axi_gmem_word_t *buf, uint64_t byte_idx) {
    if (byte_idx >= TB_DDR_IMAGE_BYTES) {
        return 0;
    }
    const uint64_t word_idx = byte_idx / static_cast<uint64_t>(AXI_GMEM_WORD_BYTES);
    const uint32_t lane = static_cast<uint32_t>(byte_idx % static_cast<uint64_t>(AXI_GMEM_WORD_BYTES));
    const axi_gmem_word_t word = buf[word_idx];
    const uint32_t hi = ((lane + 1u) * 8u) - 1u;
    const uint32_t lo = lane * 8u;
    return static_cast<uint8_t>(word.range(hi, lo));
}

static inline void dma_word_set_byte(axi_gmem_word_t *buf, uint64_t byte_idx, uint8_t value) {
    if (byte_idx >= TB_DDR_IMAGE_BYTES) {
        return;
    }
    const uint64_t word_idx = byte_idx / static_cast<uint64_t>(AXI_GMEM_WORD_BYTES);
    const uint32_t lane = static_cast<uint32_t>(byte_idx % static_cast<uint64_t>(AXI_GMEM_WORD_BYTES));
    axi_gmem_word_t word = buf[word_idx];
    const uint32_t hi = ((lane + 1u) * 8u) - 1u;
    const uint32_t lo = lane * 8u;
    word.range(hi, lo) = static_cast<ap_uint<8> >(value);
    buf[word_idx] = word;
}

static void seed_ln_params_ddr(const ControlMemSpace &ctrl,
                               axi_gmem_word_t *ddr_mem) {
    auto write_i32_le = [&](uint64_t addr, int32_t value) {
        const uint32_t u = static_cast<uint32_t>(value);
        dma_word_set_byte(ddr_mem, addr + 0, static_cast<uint8_t>(u & 0xFFu));
        dma_word_set_byte(ddr_mem, addr + 1, static_cast<uint8_t>((u >> 8) & 0xFFu));
        dma_word_set_byte(ddr_mem, addr + 2, static_cast<uint8_t>((u >> 16) & 0xFFu));
        dma_word_set_byte(ddr_mem, addr + 3, static_cast<uint8_t>((u >> 24) & 0xFFu));
    };

    for (int layer = 0; layer < NUM_LAYERS; ++layer) {
        const uint64_t ln0_gamma_addr = static_cast<uint64_t>(ctrl.ln0_gamma_offset) +
            static_cast<uint64_t>(layer) * static_cast<uint64_t>(ctrl.ln0_gamma_stride);
        const uint64_t ln1_gamma_addr = static_cast<uint64_t>(ctrl.ln1_gamma_offset) +
            static_cast<uint64_t>(layer) * static_cast<uint64_t>(ctrl.ln1_gamma_stride);
        const uint64_t ln0_eps_addr = static_cast<uint64_t>(ctrl.ln0_eps_offset) +
            static_cast<uint64_t>(layer) * static_cast<uint64_t>(ctrl.ln0_eps_stride);
        const uint64_t ln1_eps_addr = static_cast<uint64_t>(ctrl.ln1_eps_offset) +
            static_cast<uint64_t>(layer) * static_cast<uint64_t>(ctrl.ln1_eps_stride);

        for (int i = 0; i < D_MODEL; ++i) {
            write_i32_le(ln0_gamma_addr + static_cast<uint64_t>(i) * 4ull, 8192);
            write_i32_le(ln1_gamma_addr + static_cast<uint64_t>(i) * 4ull, 8192);
        }
        write_i32_le(ln0_eps_addr, 1);
        write_i32_le(ln1_eps_addr, 1);
    }
}

static int run_top_DEBUG_tb_single_token(size_t selected_stream_token) {
    const int MAX_CYCLES = 10000;
    const int STREAM_TOKEN_BYTES = STREAM_IN_BUF_BYTES;
    const int AXIS_BEATS = STREAM_IN_BUF_BYTES;


    bool wl_ready        = false;
    bool wl_start        = false;
    bool wl_accept       = false;
    uint32_t wl_instruction = 0;
    HeadCtx head_ctx_ref[HEADS_PARALLEL];
    ComputeHeadCtx head_compute_ctx[HEADS_PARALLEL] = {};
    bool dma_start       = false;
    uint32_t dma_addr    = 0;
    uint32_t dma_rx_word = 0;
    uint32_t dma_tx_word = 0;
    axi_gmem_word_t ddr_mem[TB_DDR_IMAGE_WORDS] = {};

    hls::stream<axis8_t> s_axis_in("s_axis_in");
    hls::stream<axis8_t> m_axis_out("m_axis_out");

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;
    bool axis_in_ready   = false;
    uint8_t axis_in_data = 0;
    uint8_t axis_in_keep = 0;
    uint8_t axis_in_strb = 0;
    bool mem_transfer_done = false;
    bool mem_read_request  = false;
    bool mem_write_request = false;
    uint32_t mem_op         = 0;
    uint8_t in_buf[compute_buf::IN_BUF_BYTES] = {};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES] = {};
    uint8_t head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES] = {};
    uint8_t head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES] = {};
    uint8_t dbg_stream_in_buf[STREAM_IN_BUF_BYTES] = {};
    uint8_t prev_dbg_in_buf[compute_buf::IN_BUF_BYTES] = {};
    uint8_t prev_dbg_out_buf[compute_buf::OUT_BUF_BYTES] = {};
    uint8_t prev_dbg_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES] = {};
    uint8_t prev_dbg_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES] = {};
    uint8_t prev_dbg_stream_in_buf[STREAM_IN_BUF_BYTES] = {};
    uint8_t prev_stream_in_buf[STREAM_IN_BUF_BYTES] = {};
    uint8_t prev_stream_out_buf[STREAM_OUT_BUF_BYTES] = {};
    bool dbg_buf_prev_valid = false;

    uint8_t stream_in_buf[STREAM_IN_BUF_BYTES] = {};
    uint8_t stream_out_buf[STREAM_OUT_BUF_BYTES] = {};
    int stream_in_token_index = 0;
    uint8_t stream_in_token_bytes[STREAM_TOKEN_BYTES] = {};
    int stream_in_token_count = 0;
    int stream_out_count = 0;
    int stream_out_token_index = 0;

    SchedState dbg_state     = S_IDLE;
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
    bool seen_attn       = false;
    bool seen_concat     = false;
    bool aborted_on_error = false;
    int  base_assign_step = 0;

    if (!load_shared_ctrl_mem(g_loaded_ctrl_mem)) {
        return 1;
    }
    g_loaded_ctrl_mem_valid = true;
    if (!load_shared_ddr_image(ddr_mem, TB_DDR_IMAGE_WORDS)) {
        return 1;
    }
    size_t total_stream_tokens = 0;
    if (!load_shared_stream_token(stream_in_buf, STREAM_IN_BUF_BYTES,
                                  selected_stream_token, total_stream_tokens)) {
        return 1;
    }
    std::printf("[TEST] stream_in.bin contains %zu token(s), sending token %zu only.\n",
                total_stream_tokens, selected_stream_token);
    print_token_vector(selected_stream_token, stream_in_buf,
                       static_cast<size_t>(STREAM_TOKEN_BYTES));
    enum class CtrlInitStage { 
        TestCtrlInit,           // 0: Initialize with valid config
        TestDmaZeroLen,         // 1: Test DMA zero-length error
        TestDmaZeroLenCheck,    // 2: Verify error was flagged
        TestDmaZeroLenClear,    // 3: Clear the error
        TestZeroStride,         // 4: Test zero-stride error  
        TestZeroStrideCheck,    // 5: Verify error was flagged
        TestZeroStrideClear,    // 6: Clear the error
        TestAlignment,          // 7: Test misaligned address error
        TestAlignmentCheck,     // 8: Verify error was flagged
        TestAlignmentClear,     // 9: Clear the error
        AssertReset,            // 10: Normal operation begins
        DeassertReset, 
        ProgramBases, 
        AssertStart, 
        ClearStart, 
        Done 
    };
    CtrlInitStage ctrl_stage = CtrlInitStage::AssertReset;
    // Test tracking
    bool test_error_detected = false;
    int  test_errors_passed = 0;
    int  test_errors_failed = 0;
    bool dbg_done = false;
    bool dbg_axis_is_empty = false;
    bool dbg_axis_in_ready_wire = false;
    bool dbg_axis_in_last_wire = false;
    uint32_t dbg_stream_in_counter = 0;
    
    ControlMemSpace ctrl_mem{};
    StatusMemSpace status_mem{};
    
    // DEBUG - UNUSED
    uint32_t ctrl_data_in = 0;
    uint32_t ctrl_data_out = 0;
    uint32_t ctrl_shadow_control = 0;
    bool ctrl_resetn_in = false;
    int ctrl_gap_cycles = 0; // spacing between control bus transactions
    bool seen_irq_done = false;

    ControlMemSpace dbg_ctrl_mem{};

    ComputeState dbg_compute_state = ComputeState::IDLE;
    bool dbg_compute_start = false;
    uint32_t dbg_compute_instruction = 0;
    bool dbg_compute_ready = false;
    bool dbg_compute_done = false;
    uint32_t dbg_req_instruction = 0;
    uint8_t dbg_req_op = 0;
    uint8_t dbg_req_layer = 0;
    uint8_t dbg_req_head = 0;
    uint8_t dbg_req_tile = 0;
    bool dbg_mac_start = false;
    bool dbg_mac_ready = false;
    bool dbg_mac_complete = false;
    bool dbg_ctrl_reset_asserted = false;
    int dbg_head_group_idx = 0;
    bool dbg_error = false;
    uint32_t dbg_error_code = 0;
    bool dbg_dma_done = false;

    uint32_t control_reg    = 0;
    uint32_t irq_status_reg     = 0;
    uint32_t irq_mask_reg     = 0;
    uint32_t irq_clear_reg    = 0;
    uint32_t wq_base_addr   = 0;
    uint32_t wk_base_addr   = 0;
    uint32_t wv_base_addr   = 0;
    uint32_t wo_base_addr   = 0;
    uint32_t w1_base_addr   = 0;
    uint32_t w2_base_addr   = 0;
    uint32_t wq_head_stride     = 0;
    uint32_t wk_head_stride     = 0;
    uint32_t wv_head_stride     = 0;
    uint32_t wo_tile_stride     = 0;
    uint32_t w1_tile_stride     = 0;
    uint32_t w2_tile_stride     = 0;

    std::printf("%8s | %5s | %-16s | %10s | %8s | %8s | %8s | %8s | %8s | %12s | %12s | %13s | %12s | %18s | %9s | %10s | %10s | %10s | %12s | %20s | %21s | %22s | %17s | %23s | %17s | %18s | %6s | %11s | %11s | %11s | %13s | %s\n",
                "cycle",
                "reset",
                "dbg_state",
                "s_tdata",
                "s_tvalid",
                "s_tready",
                "s_tkeep",
                "s_tstrb",
                "s_tlast",
                "axis_start",
                "dbg_wl_start",
                "dbg_wl_accept",
                "dbg_wl_ready",
                "dbg_wl_instruction",
                "dma_start",
                "dma_addr",
                "dma_rx_buf",
                "dma_tx_buf",
                "dbg_dma_done",
                "dbg_mem_read_request",
                "dbg_mem_write_request",
                "dbg_mem_transfer_done",
                "dbg_compute_start",
                "dbg_compute_instruction",
                "dbg_compute_state",
                "dbg_req_instruction",
                "irq_ps",
                "ax_empty",
                "ax_rdy_w",
                "ax_last_w",
                "stream_cnt",
                "headed(signals)");
    std::printf("----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Space out control transactions to model multi-cycle AXI-lite access
        if (ctrl_gap_cycles > 0) {
            ctrl_gap_cycles--;
        } else if (ctrl_stage == CtrlInitStage::TestCtrlInit) {
            // Start with valid config
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            std::printf("[TEST] Starting ControlMemInterface error tests...\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLen;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLen) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.dma_layer_len = 0;      // Inject error: zero length
            std::printf("[TEST 1] Injecting dma_layer_len=0 (expect ERR_DMA_ZERO_LEN)\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLenCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenCheck) {
            // Check if error was detected
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ZERO_LEN) {
                std::printf("[TEST 1] PASS: ERR_DMA_ZERO_LEN detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 1] FAIL: Expected ERR_DMA_ZERO_LEN (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            // Clear the error
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestDmaZeroLenClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenClear) {
            ctrl_mem.irq_clear = 0;  // One-shot clear
            ctrl_mem = ctrl_mem_init(true);  // Restore valid config
            ctrl_stage = CtrlInitStage::TestZeroStride;
            ctrl_gap_cycles = 1;
        
        // ========== TEST 2: Zero Stride ==========
        } else if (ctrl_stage == CtrlInitStage::TestZeroStride) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.layer_stride = 0;       // Inject error: zero stride
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
        
        // ========== TEST 3: Address Alignment ==========
        } else if (ctrl_stage == CtrlInitStage::TestAlignment) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.wq_offset = 0x00000001u;  // Inject error: not 64-byte aligned
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
            ctrl_stage = CtrlInitStage::AssertReset;  // Continue to normal operation
            ctrl_gap_cycles = 1;
        
        // ========== NORMAL OPERATION ==========
        } else if (ctrl_stage == CtrlInitStage::AssertReset) {
            ctrl_mem = ctrl_mem_init(false); // Restore default config
            ctrl_mem.control = 0x00000000;
            ctrl_data_in = 0x00000000;
            ctrl_shadow_control = 0x00000000;
            ctrl_resetn_in = false;
            ctrl_stage = CtrlInitStage::DeassertReset;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::DeassertReset) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            ctrl_stage = CtrlInitStage::ProgramBases;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ProgramBases) {
            // Program control-space base addresses and strides with reset asserted
            switch (base_assign_step) {
            case 0:
                // Program all ControlMemSpace fields in one shot.
                // This includes required + optional strides/base addresses and quant data.
                ctrl_mem = ctrl_mem_init(true);
                ctrl_data_in = CTRL_RESETN_BIT;
                break;
            case 1:
                // Clear any pending interrupts during programming.
                ctrl_mem.irq_clear = IRQ_ERROR_BIT;
                ctrl_data_in = IRQ_ERROR_BIT;
                break;
            case 2:
                // Disabled interrupt clearing
                ctrl_mem.irq_clear = 0;
                ctrl_data_in  = 0;
                break;
            case 3:
                // Enable interrupts
                ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
                ctrl_data_in  = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
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
            ctrl_data_in = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_resetn_in = true;
            reset_released = true;
            start_pulsed   = true;
            pending_start_clear = true;
            ctrl_stage = CtrlInitStage::ClearStart;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ClearStart) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            pending_start_clear = false;
            ctrl_stage = CtrlInitStage::Done;
            ctrl_gap_cycles = 1;
        } else if(seen_irq_done){
            ctrl_mem.irq_clear = IRQ_INFER_DONE_BIT;
            ctrl_data_in = IRQ_INFER_DONE_BIT;
            ctrl_gap_cycles = 1;
            seen_irq_done = false;
        }
        else if(irq_ps){
            ctrl_gap_cycles = 1;
            irq_interupt_flagged = true;
            interupt_data = status_mem.irq_status;
        }

        // Drive AXIS ingress beats into the true AXI stream input.
        axis_in_valid = false;
        axis_in_last = false;
        axis_in_ready = false;
        axis_in_data = 0;
        axis_in_keep = 0;
        axis_in_strb = 0;
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
                    axis_in_ready = true;
                    axis_in_data = static_cast<uint8_t>(beat.data);
                    axis_in_keep = static_cast<uint8_t>(beat.keep);
                    axis_in_strb = static_cast<uint8_t>(beat.strb);
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
                        stream_in_token_index++;
                        stream_in_token_count = 0;
                        axis_feed_done = true;
                        axis_drive = false;
                    }
                }
            }
        }

        // Legacy DMA debug fields (DMA is now inside top/MMU over AXI-Full).
        dma_start = false;
        dma_addr = 0;
        dma_rx_word = static_cast<uint32_t>(ddr_mem[0] & 0xFFFF'FFFFu);
        dma_tx_word = static_cast<uint32_t>(ddr_mem[1] & 0xFFFF'FFFFu);

        transformer_top(
            s_axis_in,
            m_axis_out,
            ddr_mem,
            ctrl_mem,
            status_mem,
            irq_ps,
            dbg_state, 
            head_ctx_ref,
            head_compute_ctx,
            dbg_ctrl_mem,
            control_reg,
            irq_status_reg,
            irq_mask_reg,
            irq_clear_reg,
            wq_base_addr,
            wk_base_addr,
            wv_base_addr,
            wo_base_addr,
            w1_base_addr,
            w2_base_addr,
            wq_head_stride,
            wk_head_stride,
            wv_head_stride,
            wo_tile_stride,
            w1_tile_stride,
            w2_tile_stride,
            dbg_compute_start,
            dbg_compute_instruction,
            dbg_compute_ready,
            dbg_compute_done,
            dbg_compute_state,
            dbg_req_instruction,
            dbg_req_op,
            dbg_req_layer,
            dbg_req_head,
            dbg_req_tile,
            dbg_mac_start,
            dbg_mac_ready,
            dbg_mac_complete,
            dbg_ctrl_reset_asserted,
            dbg_head_group_idx,
            wl_ready,
            wl_instruction,
            wl_start,
            wl_accept,
            dbg_dma_done,
            mem_transfer_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            in_buf,
            out_buf,
            head_in_buf,
            head_out_buf,
            dbg_stream_in_buf,
            dbg_error,
            dbg_error_code,
            dbg_done,
            dbg_axis_is_empty,
            dbg_axis_in_ready_wire,
            dbg_axis_in_last_wire,
            dbg_stream_in_counter
        );

        // Drain AXI stream output from DUT into local debug buffer.
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
                const int32_t token_id = static_cast<int32_t>(
                    static_cast<uint32_t>(stream_out_buf[0]) |
                    (static_cast<uint32_t>(stream_out_buf[1]) << 8) |
                    (static_cast<uint32_t>(stream_out_buf[2]) << 16) |
                    (static_cast<uint32_t>(stream_out_buf[3]) << 24));
                std::printf("(index=%d)\n", token_id);
                stream_out_count = 0;
                stream_out_token_index++;
            }
        }

        if (!dbg_buf_prev_valid) {
            copy_buffer(prev_dbg_in_buf, in_buf, compute_buf::IN_BUF_BYTES);
            copy_buffer(prev_dbg_out_buf, out_buf, compute_buf::OUT_BUF_BYTES);
            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                copy_buffer(prev_dbg_head_in_buf[lane], head_in_buf[lane], head_buf::IN_BUF_BYTES);
                copy_buffer(prev_dbg_head_out_buf[lane], head_out_buf[lane], head_buf::OUT_BUF_BYTES);
            }
            copy_buffer(prev_dbg_stream_in_buf, dbg_stream_in_buf, STREAM_IN_BUF_BYTES);
            copy_buffer(prev_stream_in_buf, stream_in_buf, STREAM_IN_BUF_BYTES);
            copy_buffer(prev_stream_out_buf, stream_out_buf, STREAM_OUT_BUF_BYTES);
            dbg_buf_prev_valid = true;
        } else {
            const ComputeOp req_op = decode_op(dbg_req_instruction);
            const bool has_active_req = (dbg_req_instruction != 0u);

            const bool in_changed = buffer_changed(in_buf, prev_dbg_in_buf, compute_buf::IN_BUF_BYTES);
            if (in_changed) {
                if (has_active_req) {
                    std::printf("\n[CYCLE %d] dbg_in_buf updated (op=%s, req=0x%08X)\n",
                                cycle,
                                op_name(req_op),
                                dbg_req_instruction);
                    print_buffer("in_buf", in_buf, compute_buf::IN_BUF_BYTES);
                    print_in_buf_decoded(req_op, in_buf);
                    if (req_op == ComputeOp::CMP_FINAL_NORM) {
                        uint8_t final_norm_gamma_src[compute_buf::INLayerNormLayout::GAMMA_BYTES] = {};
                        uint8_t final_norm_eps_src[compute_buf::INLayerNormLayout::EPS_BYTES] = {};
                        const uint64_t gamma_addr = static_cast<uint64_t>(ctrl_mem.final_norm_gamma_offset);
                        const uint64_t eps_addr = static_cast<uint64_t>(ctrl_mem.final_norm_eps_offset);
                        for (int i = 0; i < compute_buf::INLayerNormLayout::GAMMA_BYTES; ++i) {
                            final_norm_gamma_src[i] = dma_word_get_byte(ddr_mem, gamma_addr + static_cast<uint64_t>(i));
                        }
                        for (int i = 0; i < compute_buf::INLayerNormLayout::EPS_BYTES; ++i) {
                            final_norm_eps_src[i] = dma_word_get_byte(ddr_mem, eps_addr + static_cast<uint64_t>(i));
                        }
                        std::printf("final_norm preload source:\n");
                        std::printf("  gamma_addr=0x%08llX eps_addr=0x%08llX\n",
                                    static_cast<unsigned long long>(gamma_addr),
                                    static_cast<unsigned long long>(eps_addr));
                        print_buffer("final_norm_gamma_src", final_norm_gamma_src,
                                     compute_buf::INLayerNormLayout::GAMMA_BYTES);
                        print_buffer("final_norm_eps_src", final_norm_eps_src,
                                     compute_buf::INLayerNormLayout::EPS_BYTES);
                        std::printf("final_norm source decoded int32:\n");
                        std::printf("  GAMMA:");
                        for (int i = 0; i < D_MODEL; ++i) {
                            std::printf(" %d",
                                        compute_buf::read_i32(final_norm_gamma_src, i * 4));
                        }
                        std::printf("\n  EPS: %d\n",
                                    compute_buf::read_i32(final_norm_eps_src, 0));
                    }
                }
                copy_buffer(prev_dbg_in_buf, in_buf, compute_buf::IN_BUF_BYTES);
            }

            const bool out_changed = buffer_changed(out_buf, prev_dbg_out_buf, compute_buf::OUT_BUF_BYTES);
            if (out_changed) {
                if (has_active_req) {
                    std::printf("\n[CYCLE %d] dbg_out_buf updated (op=%s, req=0x%08X)\n",
                                cycle,
                                op_name(req_op),
                                dbg_req_instruction);
                    print_buffer("out_buf", out_buf, compute_buf::OUT_BUF_BYTES);
                    print_out_buf_decoded(req_op, out_buf);
                }
                copy_buffer(prev_dbg_out_buf, out_buf, compute_buf::OUT_BUF_BYTES);
            }

            const bool stream_in_changed = buffer_changed(stream_in_buf, prev_stream_in_buf, STREAM_IN_BUF_BYTES);
            if (stream_in_changed) {
                std::printf("\n[CYCLE %d] stream_in_buf updated\n", cycle);
                print_buffer("stream_in_buf", stream_in_buf, STREAM_IN_BUF_BYTES);
                print_stream_in_buf_decoded(stream_in_buf);
                copy_buffer(prev_stream_in_buf, stream_in_buf, STREAM_IN_BUF_BYTES);
            }

            const bool dbg_stream_in_changed = buffer_changed(dbg_stream_in_buf, prev_dbg_stream_in_buf, STREAM_IN_BUF_BYTES);
            if (dbg_stream_in_changed) {
                std::printf("\n[CYCLE %d] dbg_stream_in_buf updated\n", cycle);
                print_buffer("dbg_stream_in_buf", dbg_stream_in_buf, STREAM_IN_BUF_BYTES);
                copy_buffer(prev_dbg_stream_in_buf, dbg_stream_in_buf, STREAM_IN_BUF_BYTES);
            }

            const bool stream_out_changed = buffer_changed(stream_out_buf, prev_stream_out_buf, STREAM_OUT_BUF_BYTES);
            if (stream_out_changed) {
                std::printf("\n[CYCLE %d] stream_out_buf updated\n", cycle);
                print_buffer("stream_out_buf", stream_out_buf, STREAM_OUT_BUF_BYTES);
                print_stream_out_buf_decoded(stream_out_buf);
                copy_buffer(prev_stream_out_buf, stream_out_buf, STREAM_OUT_BUF_BYTES);
            }

            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                const HeadCtx &hctx = head_ctx_ref[lane];
                const int hidx = hctx.head_idx;
                if (hidx < 0 || hidx >= NUM_HEADS) continue;
                const ComputeHeadCtx &cctx = head_compute_ctx[lane];
                ComputeOp head_op = decode_op(cctx.mem_op);
                if (head_op == ComputeOp::CMP_NONE) {
                    head_op = decode_op(cctx.compute_instruction);
                }
                if (head_op == ComputeOp::CMP_NONE) {
                    head_op = decode_op(hctx.compute_op);
                }

                const bool head_in_changed = buffer_changed(
                    head_in_buf[lane],
                    prev_dbg_head_in_buf[lane],
                    head_buf::IN_BUF_BYTES);
                if (head_in_changed) {
                    std::printf("\n[CYCLE %d] head_in_buf[%d] updated (head=%d, op=%s)\n",
                                cycle, lane, hidx, op_name(head_op));
                    print_buffer("head_in_buf", head_in_buf[lane], head_buf::IN_BUF_BYTES);
                    print_head_in_buf_decoded(head_op, head_in_buf[lane]);
                    copy_buffer(prev_dbg_head_in_buf[lane], head_in_buf[lane], head_buf::IN_BUF_BYTES);
                }

                const bool head_out_changed = buffer_changed(
                    head_out_buf[lane],
                    prev_dbg_head_out_buf[lane],
                    head_buf::OUT_BUF_BYTES);
                if (head_out_changed) {
                    std::printf("\n[CYCLE %d] head_out_buf[%d] updated (head=%d, op=%s)\n",
                                cycle, lane, hidx, op_name(head_op));
                    print_buffer("head_out_buf", head_out_buf[lane], head_buf::OUT_BUF_BYTES);
                    print_head_out_buf_decoded(head_op, head_out_buf[lane]);
                    copy_buffer(prev_dbg_head_out_buf[lane], head_out_buf[lane], head_buf::OUT_BUF_BYTES);
                }
            }
        }

        if (wl_start && dbg_state == S_HEAD_CONCAT) {
            seen_concat = true;
        }
        if (dbg_req_op == static_cast<uint8_t>(ComputeOp::CMP_ATT_SCORES)) {
            seen_attn = true;
        }

        const bool cntrl_start = ((ctrl_shadow_control & CTRL_START_BIT) != 0);
        std::printf("%8d | %5d | %-16s |       0x%02X | %8d | %8d |     0x%02X |     0x%02X | %8d | %12d | %12d | %13d | %12d |         0x%08X | %9d | 0x%08X | 0x%08X | 0x%08X | %12d | %20d | %21d | %22d | %17d |              0x%08X | %-17s |         0x%08X | %6d | %11d | %11d | %11d | %13u",
                    cycle,
                    dbg_ctrl_reset_asserted ? 1 : 0,
                    state_name(dbg_state),
                    axis_in_data,
                    axis_in_valid ? 1 : 0,
                    axis_in_ready ? 1 : 0,
                    axis_in_keep,
                    axis_in_strb,
                    axis_in_last ? 1 : 0,
                    (axis_in_valid && axis_in_last && axis_in_ready) ? 1 : 0,
                    wl_start ? 1 : 0,
                    wl_accept ? 1 : 0,
                    wl_ready ? 1 : 0,
                    wl_instruction,
                    dma_start ? 1 : 0,
                    dma_addr,
                    dma_rx_word,
                    dma_tx_word,
                    dbg_dma_done ? 1 : 0,
                    mem_read_request ? 1 : 0,
                    mem_write_request ? 1 : 0,
                    mem_transfer_done ? 1 : 0,
                    dbg_compute_start ? 1 : 0,
                    dbg_compute_instruction,
                    compute_state_name(dbg_compute_state),
                    dbg_req_instruction,
                    irq_ps ? 1 : 0,
                    dbg_axis_is_empty ? 1 : 0,
                    dbg_axis_in_ready_wire ? 1 : 0,
                    dbg_axis_in_last_wire ? 1 : 0,
                    dbg_stream_in_counter);

        auto print_head_signals = [&](int lane) {
            if (lane < 0 || lane >= HEADS_PARALLEL) {
                std::printf("H%d[h=- ph=- wl_s=0 wl_a=0 wl_i=0x00000000 c_s=0 c_i=0x00000000 c_st=- mr=0 mw=0 md=0]",
                            lane);
                return;
            }
            const HeadCtx &hctx = head_ctx_ref[lane];
            const ComputeHeadCtx &cctx = head_compute_ctx[lane];
            const int hidx = hctx.head_idx;
            std::printf(
                "H%d[h=%d ph=%-7s wl_s=%d wl_a=%d wl_i=0x%08X c_s=%d c_i=0x%08X c_st=%-10s mr=%d mw=%d md=%d]",
                lane,
                hidx,
                phase_name(hctx.phase),
                hctx.wl_start ? 1 : 0,
                hctx.wl_accept ? 1 : 0,
                hctx.wl_instruction,
                cctx.compute_start ? 1 : 0,
                cctx.compute_instruction,
                compute_state_name(cctx.state),
                cctx.mem_read_request ? 1 : 0,
                cctx.mem_write_request ? 1 : 0,
                cctx.mem_transfer_done ? 1 : 0);
        };
        std::printf(" | ");
        print_head_signals(0);
        std::printf(" | ");
        print_head_signals(1);
        std::printf("\n");

        if (dbg_error) {
            std::fprintf(stderr,
                         "\nERROR: transformer_top flagged error (cycle=%d, code=0x%08X, status=0x%08X, mmu_subcode=%u:%s) : ",
                         cycle, dbg_error_code, status_mem.status,
                         status_mem.mmu_error_subcode, mmu_subcode_name(status_mem.mmu_error_subcode));
            print_error_code_bits(dbg_error_code);
            std::fprintf(stderr, "\n");
            aborted_on_error = true;
            break;
        }

        // Track the tail of the sequence: once we hit STREAM_OUT, watch for 4 idle cycles
        if (dbg_state == S_STREAM_OUT) {
            seen_stream_out = true;
            idle_after_stream = 0;
        } else if (seen_stream_out && dbg_state == S_IDLE) {
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

        if (!cntrl_start && seen_done && seen_idle_after && seen_stream_out && idle_after_stream >= 4) {
            break;
        }
    }

    bool ok = !aborted_on_error && seen_stream_out && (idle_after_stream >= 4);
    bool error_tests_ok = true;
    
    if (!ok) {
        if (!seen_stream_out) std::fprintf(stderr, "ERROR: STREAM_OUT state never reached\n");
        if (idle_after_stream < 4) std::fprintf(stderr, "ERROR: Did not remain in IDLE for 4 cycles after STREAM_OUT\n");
        return 1;
    }
    
    if (!error_tests_ok) {
        return 1;
    }
    std::printf("PASS: STREAM_OUT reached and FSM stayed IDLE for %d cycles after.\n",
                idle_after_stream);
    return 0;
}

int main() {
    if (!init_tb_logs()) {
        return 1;
    }
    return run_top_DEBUG_tb_single_token(0);
}
