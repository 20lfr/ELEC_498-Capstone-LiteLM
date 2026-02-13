// Minimal testbench for Simple_Scheduler_FSM.
// Mirrors the style of Scheduler_tb_minimal.cpp but against the simplified scheduler interface.
#include <cstdio>
#include <cstdint>
#include <limits>
#include <string>

#include "top.hpp"

static const char *state_name(SchedState st) {
    switch (st) {
    case S_IDLE:            return "S_IDLE";
    case S_STREAM_IN:       return "S_STREAM_IN";
    case S_LAYER_COUNT:     return "S_LAYER_COUNT";
    case S_ATTENTION_HEADS: return "S_ATT_HEADS";
    case S_HEAD_CONCAT:     return "S_HEAD_CONCAT";
    case S_OUT_PROJECTION:  return "S_OUT_PROJ";
    case S_REQUANT1:        return "S_RQ1";
    case S_RES_ADD_1:       return "S_RES_ADD_1";
    case S_LAYER_NORM_0:    return "S_LN_0";
    case S_REQUANT2:        return "S_RQ2";
    case S_FFN:             return "S_FFN";
    case S_REQUANT3:        return "S_RQ3";
    case S_RES_ADD_2:       return "S_RES_ADD_2";
    case S_LAYER_NORM_1:    return "S_LN_1";
    case S_REQUANT4:        return "S_RQ4";
    case S_LOOP_CHECK:      return "S_LOOP_CHECK";
    case S_FINAL_NORM:      return "S_FINAL_NORM";
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
    case CMP_RESID0:       return "RESID0";
    case CMP_LN0:          return "LN0";
    case CMP_REQUANT2:     return "RQ2";
    case CMP_FFN_W1:       return "FFN_W1";
    case CMP_FFN_ACT:      return "FFN_ACT";
    case CMP_FFN_W2:       return "FFN_W2";
    case CMP_REQUANT3:     return "RQ3";
    case CMP_RESID1:       return "RESID1";
    case CMP_LN1:          return "LN1";
    case CMP_REQUANT4:     return "RQ4";
    case CMP_DEQUANT:      return "DEQUANT";
    case CMP_FINAL_NORM:   return "FINAL_NORM";
    case CMP_LOGITS:       return "LOGITS";
    default:               return "UNK";
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
    default:            return "UNK";
    }
}

static const char *phase_name(HeadPhase ph) {
    switch (ph) {
    case HeadPhase::IDLE:              return "IDLE";
    case HeadPhase::Q:                 return "Q";
    case HeadPhase::K:                 return "K";
    case HeadPhase::K_REQUANT:         return "K_RQ";
    case HeadPhase::K_WRITEBACK:       return "K_WR";
    case HeadPhase::V:                 return "V";
    case HeadPhase::V_REQUANT:         return "V_RQ";
    case HeadPhase::V_WRITEBACK:       return "V_WR";
    case HeadPhase::REQUANT_Q:         return "Q_RQ";
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
    case ComputeOp::CMP_RESID0:
    case ComputeOp::CMP_RESID1: {
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
    case ComputeOp::CMP_RESID0:
    case ComputeOp::CMP_RESID1: {
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
        std::printf("HEAD QKV in_buf (decoded):\n  ACT:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INQkvLayout::ACT + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (head_buf::INQkvLayout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (head_buf::INQkvLayout::B * 2) + i)));
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
        std::printf("ATT_SCORES in_buf (decoded):\n  Q:");
        for (int i = 0; i < D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::Q + i)));
        }
        std::printf("\n  K_CACHE:");
        for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
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
        std::printf("ATT_VALUE in_buf (decoded):\n  W:");
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, head_buf::INAttValueLayout::WEIGHTS + (i * 2))));
        }
        std::printf("\n  V_CACHE:");
        for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
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
        std::printf("HEAD_Q out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ATT_VALUE: {
        std::printf("HEAD out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_HEADS; ++i) {
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
        std::printf("ATT_SCORES out_buf (decoded):\n  Y:");
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
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
static int4_t g_bq[HEADS_PARALLEL][D_HEADS] = {};
static int4_t g_bk[HEADS_PARALLEL][D_HEADS] = {};
static int4_t g_bv[HEADS_PARALLEL][D_HEADS] = {};

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
        int q_b = static_cast<int>(stim_i4(layer, h, 71 + lane));
        if (q_b > 2) {
            q_b = 2;
        } else if (q_b < -2) {
            q_b = -2;
        }
        g_bq[lane][h] = static_cast<int4_t>(q_b);
        g_bk[lane][h] = stim_i4(layer, h, 81 + lane);
        g_bv[lane][h] = stim_i4(layer, h, 91 + lane);
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
        const int4_t *b = (op == ComputeOp::CMP_Q) ? g_bq[lane]
                          : (op == ComputeOp::CMP_K) ? g_bk[lane]
                          : g_bv[lane];
        for (int i = 0; i < D_MODEL; ++i) {
            compute_buf::write_i8(buf, head_buf::INQkvLayout::ACT + i, act[i]);
        }
        for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
            compute_buf::write_i4(buf, (head_buf::INQkvLayout::W * 2) + i, w[i]);
        }
        for (int h = 0; h < D_HEADS; ++h) {
            compute_buf::write_i4(buf, (head_buf::INQkvLayout::B * 2) + h, b[h]);
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
        return ctrl.wq_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.wq_head_stride);
    case DMASEL_WK:
        if (f.head < 0) return 0;
        return ctrl.wk_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.wk_head_stride);
    case DMASEL_WV:
        if (f.head < 0) return 0;
        return ctrl.wv_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.wv_head_stride);
    case DMASEL_CTX_K:
        if (f.head < 0) return 0;
        return ctrl.k_cache_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.k_cache_stride);
    case DMASEL_CTX_V:
        if (f.head < 0) return 0;
        return ctrl.v_cache_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.head) * static_cast<uint64_t>(ctrl.v_cache_stride);
    case DMASEL_WO:
        if (f.tile < 0) return 0;
        return ctrl.wo_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.tile) * static_cast<uint64_t>(ctrl.wo_tile_stride);
    case DMASEL_W1:
        if (f.tile < 0) return 0;
        return ctrl.w1_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.tile) * static_cast<uint64_t>(ctrl.w1_tile_stride);
    case DMASEL_W2:
        if (f.tile < 0) return 0;
        return ctrl.w2_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(f.tile) * static_cast<uint64_t>(ctrl.w2_tile_stride);
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
        return ctrl.wq_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.wq_head_stride);
    case DMASEL_WK:
        if (head < 0) return 0;
        return ctrl.wk_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.wk_head_stride);
    case DMASEL_WV:
        if (head < 0) return 0;
        return ctrl.wv_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.wv_head_stride);
    case DMASEL_CTX_K:
        if (head < 0) return 0;
        return ctrl.k_cache_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.k_cache_stride);
    case DMASEL_CTX_V:
        if (head < 0) return 0;
        return ctrl.v_cache_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(head) * static_cast<uint64_t>(ctrl.v_cache_stride);
    case DMASEL_WO:
        if (tile < 0) return 0;
        return ctrl.wo_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(tile) * static_cast<uint64_t>(ctrl.wo_tile_stride);
    case DMASEL_W1:
        if (tile < 0) return 0;
        return ctrl.w1_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(tile) * static_cast<uint64_t>(ctrl.w1_tile_stride);
    case DMASEL_W2:
        if (tile < 0) return 0;
        return ctrl.w2_base_addr + layer_u * static_cast<uint64_t>(ctrl.layer_stride) +
               static_cast<uint64_t>(tile) * static_cast<uint64_t>(ctrl.w2_tile_stride);
    default:
        return 0;
    }
}

// Helper to decode status register bits
static const char *status_name(uint32_t status) {
    if (status & STATUS_ERROR)    return "ERROR";
    if (status & STATUS_BUSY_BIT) return "BUSY";
    if (status & STATUS_IDLE)     return "IDLE";
    return "-";
}

static const char *irq_name(uint32_t irq) {
    if (irq & IRQ_ERROR_BIT)        return "ERROR";
    if (irq & IRQ_INFER_DONE_BIT)   return "DONE";
    return "-";
}

ControlMemSpace ctrl_mem_init(bool init) {
    ControlMemSpace ctrl_mem{};
    if(init) {
        ctrl_mem.control = CTRL_RESETN_BIT;
        ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
        ctrl_mem.irq_clear = 0;
        // DMA lengths (non-zero required)
        ctrl_mem.dma_layer_len = 0x00000100;
        ctrl_mem.dma_head_len  = 0x00000100;
        ctrl_mem.dma_tile_len  = 0x00000100;
        // Strides (non-zero required) - match OG testbench values
        ctrl_mem.layer_stride    = 0x00001000;
        ctrl_mem.wq_head_stride  = 0x00000100;
        ctrl_mem.wk_head_stride  = 0x00000100;
        ctrl_mem.wv_head_stride  = 0x00000100;
        ctrl_mem.k_cache_stride  = 0x00000400;
        ctrl_mem.v_cache_stride  = 0x00000400;
        ctrl_mem.wo_tile_stride  = 0x00000100;
        ctrl_mem.w1_tile_stride  = 0x00000300;
        ctrl_mem.w2_tile_stride  = 0x00000800;
        // Base addresses - MUST be 64-byte aligned (& 0x3F == 0)
        ctrl_mem.wq_base_addr = 0x10000000ull;
        ctrl_mem.wk_base_addr = 0x20000000ull;
        ctrl_mem.wv_base_addr = 0x30000000ull;
        ctrl_mem.wo_base_addr = 0x60000000ull;
        ctrl_mem.w1_base_addr = 0x70000000ull;
        ctrl_mem.w2_base_addr = 0x80000000ull;
        ctrl_mem.k_cache_addr = 0x40000000ull;
        ctrl_mem.v_cache_addr = 0x50000000ull;
        // Quantization params
        ctrl_mem.logit_scale_qv = 0x00000100;
        ctrl_mem.scale_q        = 0x00000100;
        ctrl_mem.zero_point_q   = 0x00000000;
        ctrl_mem.scale_k        = 0x00000100;
        ctrl_mem.zero_point_k   = 0x00000000;
        ctrl_mem.scale_v        = 0x00000100;
        ctrl_mem.zero_point_v   = 0x00000000;
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

int main() {
    const int MAX_CYCLES = 8000;
    const int COMP_LAT   = 3;
    const int DMA_LAT    = 3;
    const int AXIS_BEATS = 3;
    const int MEM_LAT     = 5;


    bool wl_ready        = false;
    bool wl_start        = false;
    uint32_t wl_instruction = 0;
    HeadCtx head_ctx_ref[NUM_HEADS];
    ComputeHeadCtx head_compute_ctx[HEADS_PARALLEL] = {};
    bool dma_done        = false;
    bool wl_dma_request  = false;
    uint64_t wl_dma_address = 0;

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    bool axis_in_ready   = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;

    bool mem_transfer_done = false;
    bool mem_read_request  = false;
    bool mem_write_request = false;
    uint32_t mem_op         = 0;
    uint32_t mem_op_latched = 0;
    uint8_t in_buf[compute_buf::IN_BUF_BYTES] = {};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES] = {};
    uint8_t head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES] = {};
    uint8_t head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES] = {};
    bool mem_busy = false;
    int  mem_timer = 0;
    int  active_main_layer = -1;
    enum class MemPending { None, Read, Write };
    MemPending mem_pending = MemPending::None;

    int8_t out_proj_act[D_MODEL] = {};
    int8_t out_proj_w[D_MODEL * D_MODEL] = {};
    int32_t out_proj_b[D_MODEL] = {};

    int32_t rq1_x[D_MODEL] = {};
    int32_t rq2_x[D_MODEL] = {};
    int32_t rq3_x[D_MODEL] = {};
    int32_t rq4_x[D_MODEL] = {};
    int32_t rq1_M = 1, rq1_N = 0;
    int32_t rq2_M = 2, rq2_N = 1;
    int32_t rq3_M = 1, rq3_N = 2;
    int32_t rq4_M = 3, rq4_N = 1;

    int8_t resid0_x[D_MODEL] = {};
    int8_t resid0_r[D_MODEL] = {};
    int8_t resid1_x[D_MODEL] = {};
    int8_t resid1_r[D_MODEL] = {};

    int8_t ln0_x[D_MODEL] = {};
    int8_t ln1_x[D_MODEL] = {};
    int8_t final_norm_x[D_MODEL] = {};
    int32_t ln0_gamma[D_MODEL] = {};
    int32_t ln1_gamma[D_MODEL] = {};
    int32_t final_norm_gamma[D_MODEL] = {};
    int32_t ln0_eps = 1;
    int32_t ln1_eps = 2;
    int32_t final_norm_eps = 3;

    const int W1_OUT_SIZE = 2 * D_FFN;
    int8_t ffn1_x[D_MODEL] = {};
    int8_t ffn1_w[D_MODEL * W1_OUT_SIZE] = {};
    int32_t ffn1_b[W1_OUT_SIZE] = {};

    int16_t ffn_act_gate_in[D_FFN] = {};
    int16_t ffn_act_up_in[D_FFN] = {};

    int16_t ffn2_x[D_FFN] = {};
    int8_t  ffn2_w[D_FFN * D_FFN] = {};
    int32_t ffn2_b[D_FFN] = {};

    bool head_mem_busy[HEADS_PARALLEL] = {false};
    int  head_mem_timer[HEADS_PARALLEL] = {0};
    int  active_head_layer[HEADS_PARALLEL];
    uint32_t head_mem_op_latched[HEADS_PARALLEL] = {0};
    enum class HeadMemPending { None, Read, Write };
    HeadMemPending head_mem_pending[HEADS_PARALLEL] = {HeadMemPending::None};
    bool head_dma_busy[HEADS_PARALLEL] = {false};
    int  head_dma_timer[HEADS_PARALLEL] = {0};
    int  head_dma_active_idx[HEADS_PARALLEL] = {0};
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        head_dma_active_idx[lane] = -1;
        active_head_layer[lane] = -1;
    }

    bool stream_ready    = true;
    bool stream_start    = false;
    bool stream_done     = false;

    SchedState dbg_state     = S_IDLE;
    bool irq_ps              = false;
    bool irq_interupt_flagged = false;
    uint32_t interupt_data = 0;

    bool dma_busy        = false;
    int  dma_timer       = 0;
    bool stream_busy     = false;
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
    int  base_assign_step = 0;
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
    
    ControlMemSpace ctrl_mem{};
    StatusMemSpace status_mem{};
    
    for (int i = 0; i < D_MODEL; ++i) {
        out_proj_act[i] = static_cast<int8_t>(i + 1);
        out_proj_b[i] = 7;
        rq1_x[i] = (i * 3000) - 20000;
        rq2_x[i] = (i * 2000) + 5000;
        rq3_x[i] = 100000 - (i * 4000);
        rq4_x[i] = (i * 5000) - 11000;
        resid0_x[i] = static_cast<int8_t>(i);
        resid0_r[i] = static_cast<int8_t>(i * 2);
        resid1_x[i] = static_cast<int8_t>(-i);
        resid1_r[i] = static_cast<int8_t>(i + 1);
        ln0_x[i] = static_cast<int8_t>(i + 1);
        ln1_x[i] = static_cast<int8_t>(i + 2);
        final_norm_x[i] = static_cast<int8_t>(i + 3);
        ln0_gamma[i] = 1;
        ln1_gamma[i] = 2;
        final_norm_gamma[i] = 3;
        ffn1_x[i] = static_cast<int8_t>(i + 3);
    }
    // Force a couple of extreme values for requant debug visibility.
    if (D_MODEL > 0) {
        rq1_x[0] = INT32_MAX;
        rq3_x[0] = INT32_MAX;
    }
    if (D_MODEL > 1) {
        rq1_x[1] = INT32_MIN;
        rq3_x[1] = INT32_MIN;
    }
    for (int i = 0; i < W1_OUT_SIZE; ++i) {
        ffn1_b[i] = 7;
    }
    for (int r = 0; r < D_MODEL; ++r) {
        for (int c = 0; c < D_MODEL; ++c) {
            out_proj_w[r * D_MODEL + c] = static_cast<int8_t>((r + c) & 0x7);
        }
    }
    for (int r = 0; r < W1_OUT_SIZE; ++r) {
        for (int c = 0; c < D_MODEL; ++c) {
            ffn1_w[r * D_MODEL + c] = 1;
        }
    }
    for (int i = 0; i < D_FFN; ++i) {
        ffn_act_gate_in[i] = static_cast<int16_t>((i * 3) - 20);
        ffn_act_up_in[i] = static_cast<int16_t>((i * 2) - 10);
        ffn2_x[i] = static_cast<int16_t>((i * 2) + 1);
        ffn2_b[i] = 5;
    }
    for (int r = 0; r < D_FFN; ++r) {
        for (int c = 0; c < D_FFN; ++c) {
            ffn2_w[r * D_FFN + c] = 1;
        }
    }

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

    std::printf("%-8s %-6s %-6s %-13s | Heads: [idx C_St C_Rdy C_Dn]\n",
                "Cycle", "Start", "CtrlR", "DbgState");

    auto dash_or = [](bool v) { return v ? "1" : "-"; };

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
            ctrl_mem.wq_base_addr = 0x10000001ull;  // Inject error: not 64-byte aligned
            std::printf("[TEST 3] Injecting wq_base_addr=0x10000001 (expect ERR_DMA_ALIGNMENT)\n");
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
                // Clear any pending interrupts during programming
                ctrl_mem.irq_clear = IRQ_ERROR_BIT;
                ctrl_data_in  = IRQ_ERROR_BIT;
                break;
            case 1:
                ctrl_mem.dma_layer_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 2:
                ctrl_mem.dma_head_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 3:
                ctrl_mem.dma_tile_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 4:
                ctrl_mem.layer_stride = 0x00001000;
                ctrl_data_in  = 0x00001000;
                break;
            case 5:
                ctrl_mem.wq_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 6:
                ctrl_mem.wk_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 7:
                ctrl_mem.wv_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 8:
                ctrl_mem.k_cache_stride = 0x00000400;
                ctrl_data_in  = 0x00000400;
                break;
            case 9:
                ctrl_mem.v_cache_stride = 0x00000400;
                ctrl_data_in  = 0x00000400;
                break;
            case 10:
                ctrl_mem.wo_tile_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 11:
                ctrl_mem.w1_tile_stride = 0x00000300;
                ctrl_data_in  = 0x00000300;
                break;
            case 12:
                ctrl_mem.w2_tile_stride = 0x00000800;
                ctrl_data_in  = 0x00000800;
                break;
            case 13:
                ctrl_mem.wq_base_addr = 0x10000000ull;
                ctrl_data_in  = 0x10000000;
                break;
            case 14:
                ctrl_mem.wk_base_addr = 0x20000000ull;
                ctrl_data_in  = 0x20000000;
                break;
            case 15:
                ctrl_mem.wv_base_addr = 0x30000000ull;
                ctrl_data_in  = 0x30000000;
                break;
            case 16:
                ctrl_mem.k_cache_addr = 0x40000000ull;
                ctrl_data_in  = 0x40000000;
                break;
            case 17:
                ctrl_mem.v_cache_addr = 0x50000000ull;
                ctrl_data_in  = 0x50000000;
                break;
            case 18:
                ctrl_mem.wo_base_addr = 0x60000000ull;
                ctrl_data_in  = 0x60000000;
                break;
            case 19:
                ctrl_mem.w1_base_addr = 0x70000000ull;
                ctrl_data_in  = 0x70000000;
                break;
            case 20:
                ctrl_mem.w2_base_addr = 0x80000000ull;
                ctrl_data_in  = 0x80000000;
                break;
            case 21:
                // Disabled interrupt clearing
                ctrl_mem.irq_clear = 0;
                ctrl_data_in  = 0;
                break;
            case 22:
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

        // Clear per-head DMA done pulse
        for (int i = 0; i < NUM_HEADS; ++i) {
            head_ctx_ref[i].dma_done = false;
        }

        // Complete outstanding per-head DMA operations
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_dma_busy[lane]) {
                if (head_dma_timer[lane] == 0) {
                    int idx = head_dma_active_idx[lane];
                    if (idx >= 0 && idx < NUM_HEADS) {
                        head_ctx_ref[idx].dma_done = true;
                    }
                    head_dma_busy[lane] = false;
                    head_dma_active_idx[lane] = -1;
                } else {
                    --head_dma_timer[lane];
                }
            }
        }

        // Complete outstanding DMA transfers
        dma_done = false;
        if (dma_busy) {
            if (dma_timer == 0) {
                dma_done = true;
                dma_busy = false;
            } else {
                --dma_timer;
            }
        }

        // Stream completion: single-cycle pulse after start
        stream_done = false;
        if (stream_busy) {
            stream_done = true;
            stream_busy = false;
        }

        // Ready signals depend on busy flags
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            head_ctx_ref[i].wl_ready      = !head_dma_busy[lane];
        }
        stream_ready  = !stream_busy;
        wl_ready = !dma_busy;
        wl_dma_request = false;

        // Drive AXIS ingress: send a short burst when ready is asserted
        if (!axis_feed_done && (axis_drive || (((ctrl_shadow_control & CTRL_RESETN_BIT) != 0) && start_pulsed))) {
            axis_drive = true;
            if (!axis_in_valid && axis_in_ready) {
                axis_in_valid = true;
                axis_in_last  = (axis_sent == AXIS_BEATS - 1);
            }
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        // Memory manager model for compute_controller
        mem_transfer_done = false;
        if (mem_busy) {
            if (mem_timer == 0) {
                mem_transfer_done = true;
                mem_busy = false;
                if (mem_pending == MemPending::Read) {
                    const ComputeOp op = decode_op(mem_op_latched);
                    const int tile = static_cast<int>(static_cast<int8_t>((mem_op_latched >> 24) & 0xFFu));
                    const int req_layer = clamp_layer(static_cast<int>((mem_op_latched >> 8) & 0xFFu));
                    for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
                        in_buf[i] = 0;
                    }
                    if (active_main_layer != req_layer) {
                        for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
                            out_buf[i] = 0;
                        }
                        active_main_layer = req_layer;
                    }
                    for (int i = 0; i < D_MODEL; ++i) {
                        out_proj_act[i] = stim_i8_mid(req_layer, i, 11);
                        int32_t out_b = stim_i32(req_layer, i, 13);
                        if (out_b > 96) {
                            out_b = 96;
                        } else if (out_b < -96) {
                            out_b = -96;
                        }
                        out_proj_b[i] = out_b;
                        rq1_x[i] = stim_i32(req_layer, i, 21);
                        rq2_x[i] = stim_i32(req_layer, i, 31);
                        rq3_x[i] = stim_i32(req_layer, i, 41);
                        rq4_x[i] = stim_i32(req_layer, i, 51);
                        resid0_x[i] = stim_i8(req_layer, i, 61);
                        resid0_r[i] = stim_i8(req_layer, i, 71);
                        resid1_x[i] = stim_i8(req_layer, i, 81);
                        resid1_r[i] = stim_i8(req_layer, i, 91);
                        ln0_x[i] = stim_i8_mid(req_layer, i, 101);
                        ln1_x[i] = stim_i8_mid(req_layer, i, 111);
                        final_norm_x[i] = stim_i8(req_layer, i, 121);
                        ln0_gamma[i] = stim_gamma_q19_13(req_layer, i, 131);
                        ln1_gamma[i] = stim_gamma_q19_13(req_layer, i, 141);
                        final_norm_gamma[i] = stim_gamma_q19_13(req_layer, i, 151);
                        ffn1_x[i] = stim_i8(req_layer, i, 161);
                    }
                    ln0_eps = stim_eps(req_layer, 171);
                    ln1_eps = stim_eps(req_layer, 181);
                    final_norm_eps = stim_eps(req_layer, 191);
                    for (int i = 0; i < D_MODEL * D_MODEL; ++i) {
                        int w = static_cast<int>(stim_i4(req_layer, i, 201));
                        if (w > 3) {
                            w = 3;
                        } else if (w < -3) {
                            w = -3;
                        }
                        out_proj_w[i] = static_cast<int8_t>(w);
                    }
                    for (int i = 0; i < W1_OUT_SIZE; ++i) {
                        ffn1_b[i] = stim_i32(req_layer, i, 211);
                    }
                    for (int i = 0; i < D_MODEL * W1_OUT_SIZE; ++i) {
                        ffn1_w[i] = stim_i4(req_layer, i, 221);
                    }
                    for (int i = 0; i < D_FFN; ++i) {
                        ffn_act_gate_in[i] = stim_i16(req_layer, i, 231);
                        ffn_act_up_in[i] = stim_i16(req_layer, i, 241);
                        int32_t x2 = static_cast<int32_t>(stim_i16(req_layer, i, 251));
                        if (x2 > 1024) {
                            x2 = 1024;
                        } else if (x2 < -1024) {
                            x2 = -1024;
                        }
                        ffn2_x[i] = static_cast<int16_t>(x2);
                        int32_t b2 = stim_i32(req_layer, i, 261);
                        if (b2 > 256) {
                            b2 = 256;
                        } else if (b2 < -256) {
                            b2 = -256;
                        }
                        ffn2_b[i] = b2;
                    }
                    for (int i = 0; i < D_FFN * D_FFN; ++i) {
                        int w2 = static_cast<int>(stim_i4(req_layer, i, 271));
                        if (w2 > 3) {
                            w2 = 3;
                        } else if (w2 < -3) {
                            w2 = -3;
                        }
                        ffn2_w[i] = static_cast<int8_t>(w2);
                    }
                    force_i8_i4stored_i8_mm_corners(ffn1_x, D_MODEL, ffn1_w, W1_OUT_SIZE, D_MODEL);
                    switch (op) {
                    case CMP_OUT_PROJ: {
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::INOutProjLayout::ACT + i, out_proj_act[i]);
                        }
                        if (tile >= 0 && tile < NUM_WO_TILES) {
                            const int out_base = tile * D_TILE_WO;
                            for (int t = 0; t < D_TILE_WO; ++t) {
                                for (int i = 0; i < D_MODEL; ++i) {
                                    write_i4(in_buf, (compute_buf::INOutProjLayout::W * 2) + (t * D_MODEL) + i,
                                             out_proj_w[(out_base + t) * D_MODEL + i]);
                                }
                                compute_buf::write_i32(in_buf, compute_buf::INOutProjLayout::B + (t * 4), out_proj_b[out_base + t]);
                            }
                        }
                        break;
                    }
                    case CMP_REQUANT1:
                    case CMP_REQUANT2:
                    case CMP_REQUANT3:
                    case CMP_REQUANT4: {
                        const int32_t *src = (op == CMP_REQUANT1) ? rq1_x
                                           : (op == CMP_REQUANT2) ? rq2_x
                                           : (op == CMP_REQUANT3) ? rq3_x
                                           : rq4_x;
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4), src[i]);
                        }
                        break;
                    }
                    case CMP_RESID0:
                    case CMP_RESID1: {
                        const int8_t *x = (op == CMP_RESID0) ? resid0_x : resid1_x;
                        const int8_t *r = (op == CMP_RESID0) ? resid0_r : resid1_r;
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::INResidLayout::X + i, x[i]);
                            compute_buf::write_i8(in_buf, compute_buf::INResidLayout::R + i, r[i]);
                        }
                        break;
                    }
                    case CMP_LN0:
                    case CMP_LN1:
                    case CMP_FINAL_NORM: {
                        const int8_t *x = (op == CMP_LN0) ? ln0_x
                                           : (op == CMP_LN1) ? ln1_x
                                           : final_norm_x;
                        const int32_t *gamma = (op == CMP_LN0) ? ln0_gamma
                                             : (op == CMP_LN1) ? ln1_gamma
                                             : final_norm_gamma;
                        const int32_t eps = (op == CMP_LN0) ? ln0_eps
                                         : (op == CMP_LN1) ? ln1_eps
                                         : final_norm_eps;
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::INLayerNormLayout::X + i, x[i]);
                            compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), gamma[i]);
                        }
                        compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::EPS, eps);
                        break;
                    }
                    case CMP_FFN_W1: {
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::INFfnW1Layout::X + i, ffn1_x[i]);
                        }
                        if (tile >= 0 && tile < NUM_W1_TILES) {
                            const int out_base = tile * D_TILE_W1;
                            for (int t = 0; t < D_TILE_W1; ++t) {
                                for (int i = 0; i < D_MODEL; ++i) {
                                    write_i4(in_buf, (compute_buf::INFfnW1Layout::W * 2) + (t * D_MODEL) + i,
                                             ffn1_w[(out_base + t) * D_MODEL + i]);
                                }
                                compute_buf::write_i32(in_buf, compute_buf::INFfnW1Layout::B + (t * 4), ffn1_b[out_base + t]);
                            }
                        }
                        break;
                    }
                    case CMP_FFN_ACT: {
                        for (int i = 0; i < D_FFN; ++i) {
                            compute_buf::write_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2), ffn_act_gate_in[i]);
                            compute_buf::write_i16(in_buf, compute_buf::INFfnActLayout::UP + (i * 2), ffn_act_up_in[i]);
                        }
                        break;
                    }
                    case CMP_FFN_W2: {
                        for (int i = 0; i < D_FFN; ++i) {
                            compute_buf::write_i16(in_buf, compute_buf::INFfnW2Layout::X + (i * 2), ffn2_x[i]);
                        }
                        if (tile >= 0 && tile < NUM_W2_TILES) {
                            const int out_base = tile * D_TILE_W2;
                            for (int t = 0; t < D_TILE_W2; ++t) {
                                for (int i = 0; i < D_FFN; ++i) {
                                    write_i4(in_buf, (compute_buf::INFfnW2Layout::W * 2) + (t * D_FFN) + i,
                                             ffn2_w[(out_base + t) * D_FFN + i]);
                                }
                                compute_buf::write_i32(in_buf, compute_buf::INFfnW2Layout::B + (t * 4), ffn2_b[out_base + t]);
                            }
                        }
                        break;
                    }
                    default:
                        break;
                    }
                    print_buffer("in_buf (send)", in_buf, compute_buf::IN_BUF_BYTES);
                    print_in_buf_decoded(op, in_buf);
                }
                if (mem_pending == MemPending::Write) {
                    const ComputeOp op = decode_op(mem_op_latched);
                    print_buffer("out_buf (done)", out_buf, compute_buf::OUT_BUF_BYTES);
                    print_out_buf_decoded(op, out_buf);
                }
                mem_pending = MemPending::None;
            } else {
                --mem_timer;
            }
        }

        // Memory manager model for headed compute lanes
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            head_compute_ctx[lane].mem_transfer_done = false;
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_mem_busy[lane]) {
                if (head_mem_timer[lane] == 0) {
                    head_compute_ctx[lane].mem_transfer_done = true;
                    head_mem_busy[lane] = false;
                    const ComputeOp op = decode_op(head_mem_op_latched[lane]);
                    const int req_layer = clamp_layer(static_cast<int>((head_mem_op_latched[lane] >> 8) & 0xFFu));
                    if (head_mem_pending[lane] == HeadMemPending::Read) {
                        if (active_head_layer[lane] != req_layer) {
                            for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
                                head_out_buf[lane][i] = 0;
                            }
                            active_head_layer[lane] = req_layer;
                        }
                        build_head_in_buf(lane, req_layer, op, head_in_buf);
                        if (op == CMP_ATT_SCORES) {
                            seen_attn = true;
                        }
                        std::printf("HEAD lane %d op %s in_buf\n", lane, op_name(op));
                        print_buffer("head_in_buf (send)", head_in_buf[lane], head_buf::IN_BUF_BYTES);
                        print_head_in_buf_decoded(op, head_in_buf[lane]);
                    } else if (head_mem_pending[lane] == HeadMemPending::Write) {
                        std::printf("HEAD lane %d op %s out_buf\n", lane, op_name(op));
                        print_buffer("head_out_buf (done)", head_out_buf[lane], head_buf::OUT_BUF_BYTES);
                        print_head_out_buf_decoded(op, head_out_buf[lane]);
                    }
                    head_mem_pending[lane] = HeadMemPending::None;
                } else {
                    --head_mem_timer[lane];
                }
                continue;
            }

            if (head_compute_ctx[lane].mem_read_request) {
                head_mem_busy[lane] = true;
                head_mem_timer[lane] = MEM_LAT - 1;
                head_mem_pending[lane] = HeadMemPending::Read;
                head_mem_op_latched[lane] = head_compute_ctx[lane].mem_op;
            } else if (head_compute_ctx[lane].mem_write_request) {
                head_mem_busy[lane] = true;
                head_mem_timer[lane] = MEM_LAT - 1;
                head_mem_pending[lane] = HeadMemPending::Write;
                head_mem_op_latched[lane] = head_compute_ctx[lane].mem_op;
            }
        }

        transformer_top(
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            stream_ready,
            stream_start,
            stream_done,
            ctrl_mem,
            status_mem,
            irq_ps,
            dma_done,
            wl_ready,
            wl_instruction,
            wl_start,
            mem_transfer_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            in_buf,
            out_buf,
            head_in_buf,
            head_out_buf,
            head_ctx_ref,
            head_compute_ctx,
            dbg_state, 
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
            dbg_done
        );

        if (wl_start && dbg_state == S_HEAD_CONCAT) {
            seen_concat = true;
        }

        if (!mem_busy) {
            if (mem_read_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::Read;
                mem_op_latched = mem_op;
            } else if (mem_write_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::Write;
                mem_op_latched = mem_op;
            }
        }

        if (wl_start && !dma_busy) {
            wl_dma_request = true;
            wl_dma_address = compute_wl_address(wl_instruction, dbg_ctrl_mem);
            dma_busy  = true;
            dma_timer = DMA_LAT - 1;
        }

        const bool cntrl_start   = ((ctrl_shadow_control & CTRL_START_BIT) != 0);
        std::printf("%-8d %-6d %-6s %-13s |",
                    cycle,
                    cntrl_start ? 1 : 0,
                    dash_or(dbg_ctrl_reset_asserted),
                    state_name(dbg_state));
        for (int i = 0; i < NUM_HEADS; ++i) {
            std::printf(" %d:%s%s%s",
                        i,
                        dash_or(head_ctx_ref[i].compute_start),
                        dash_or(head_ctx_ref[i].compute_ready),
                        dash_or(head_ctx_ref[i].compute_done));
        }
        std::printf("\n");
        if (dbg_state == S_ATTENTION_HEADS) {
            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                const ComputeHeadCtx &ctx = head_compute_ctx[lane];
                std::printf(
                    "  Lane %d: state=%d req{instr=0x%08X op=%s layer=%d head=%d tile=%d} "
                    "mac{busy=%d ready=%d complete=%d start=%d} pend{clr=%d cap=%d} err=%d "
                    "compute{start=%d instr=0x%08X ready=%d done=%d} mem{rd=%d wr=%d done=%d op=0x%08X}\n",
                    lane,
                    static_cast<int>(ctx.state),
                    ctx.req.instruction,
                    op_name(ctx.req.op),
                    ctx.req.layer_idx,
                    ctx.req.head_idx,
                    ctx.req.tile_idx,
                    ctx.mac_busy ? 1 : 0,
                    ctx.mac_ready ? 1 : 0,
                    ctx.mac_complete ? 1 : 0,
                    ctx.mac_start ? 1 : 0,
                    ctx.clear_pending ? 1 : 0,
                    ctx.capture_pending ? 1 : 0,
                    ctx.error_latched ? 1 : 0,
                    ctx.compute_start ? 1 : 0,
                    ctx.compute_instruction,
                    ctx.compute_ready ? 1 : 0,
                    ctx.compute_done ? 1 : 0,
                    ctx.mem_read_request ? 1 : 0,
                    ctx.mem_write_request ? 1 : 0,
                    ctx.mem_transfer_done ? 1 : 0,
                    ctx.mem_op);
            }
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

        // Launch head DMA requests onto their dedicated lanes
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            if (head_ctx_ref[i].wl_start && !head_dma_busy[lane]) {
                head_dma_busy[lane] = true;
                head_dma_timer[lane] = DMA_LAT - 1;
                head_dma_active_idx[lane] = i;
            }
        }

        if (stream_start) {
            stream_busy = true;
        }

        // Consume AXIS transfer on handshake
        if (axis_in_valid && axis_in_ready) {
            axis_sent++;
            axis_in_valid = false;
            axis_in_last  = false;
            if (axis_sent >= AXIS_BEATS) {
                axis_feed_done = true;
                axis_drive     = false;
            }
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

    bool ok = seen_stream_out && (idle_after_stream >= 4) && seen_attn && seen_concat;
    bool error_tests_ok = true;
    
    if (!ok) {
        if (!seen_stream_out) std::fprintf(stderr, "ERROR: STREAM_OUT state never reached\n");
        if (idle_after_stream < 4) std::fprintf(stderr, "ERROR: Did not remain in IDLE for 4 cycles after STREAM_OUT\n");
        if (!seen_attn)       std::fprintf(stderr, "ERROR: ATT_SCORES compute op never issued\n");
        if (!seen_concat)     std::fprintf(stderr, "ERROR: CONCAT DMA request never issued\n");
        return 1;
    }
    
    if (!error_tests_ok) {
        return 1;
    }
    std::printf("PASS: STREAM_OUT reached and FSM stayed IDLE for %d cycles after.\n",
                idle_after_stream);
    return 0;
}
