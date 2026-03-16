#include <cstdint>
#include <cstdio>
#include <cstring>
#include <cerrno>
#include <climits>
#include <cmath>
#include <string>
#include <sys/stat.h>

#include "../../tb_paths.hpp"
#include "compute_controller.hpp"

namespace {

struct OpStep {
    ComputeOp op;
    uint8_t layer;
    int8_t head;
    int16_t tile;
    const char *name;
};

static inline uint64_t make_instruction(ComputeOp op, uint8_t layer, int8_t head, int16_t tile) {
    return static_cast<uint32_t>(op)
        | (static_cast<uint32_t>(layer) << 8)
        | (static_cast<uint32_t>(static_cast<uint8_t>(head)) << 16)
        | (static_cast<uint32_t>(static_cast<uint16_t>(tile)) << 24);
}

static const char *op_name(ComputeOp op) {
    switch (op) {
        case CMP_LN0: return "CMP_LN0";
        case CMP_LN1: return "CMP_LN1";
        case CMP_OUT_PROJ: return "CMP_OUT_PROJ";
        case CMP_RESID1: return "CMP_RESID1";
        case CMP_RESID2: return "CMP_RESID2";
        case CMP_FFN_W1: return "CMP_FFN_W1";
        case CMP_FFN_ACT: return "CMP_FFN_ACT";
        case CMP_FFN_W2: return "CMP_FFN_W2";
        case CMP_FINAL_NORM: return "CMP_FINAL_NORM";
        case CMP_LOGITS: return "CMP_LOGITS";
        case CMP_ARGMAX: return "CMP_ARGMAX";
        default: return "OTHER";
    }
}

static const char *state_name(ComputeState s) {
    switch (s) {
        case ComputeState::IDLE: return "IDLE";
        case ComputeState::CAPTURE_INSTRUCTION: return "CAPTURE";
        case ComputeState::WAIT_MEM: return "WAIT_MEM";
        case ComputeState::EXECUTE: return "EXECUTE";
        case ComputeState::MEM_WRITEBACK: return "WRITEBACK";
        case ComputeState::DONE: return "DONE";
        default: return "?";
    }
}

static void fill_in_buf_for_op(uint8_t *in_buf, const OpStep &step) {
    std::memset(in_buf, 0, compute_buf::IN_BUF_BYTES);

    switch (step.op) {
        case CMP_LN0:
        case CMP_LN1:
        case CMP_FINAL_NORM: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INLayerNormLayout::X + i,
                                      static_cast<int8_t>((i & 1) ? 1 : -1));
                // gamma=0.5 in Q16.16 => 0x00008000, beta=0.
                compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), 0x00008000);
                compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::BETA + (i * 4), 0);
            }
            // eps=0 for bit-exact ln test (var=1 from +/-1 pattern)
            compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::EPS, 0);
            break;
        }
        case CMP_OUT_PROJ: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INOutProjLayout::ACT + i,
                                      static_cast<int8_t>((i % 5) - 2));
            }
            for (int i = 0; i < D_MODEL * D_TILE_WO; ++i) {
                const int8_t w = static_cast<int8_t>((i % 3) - 1);
                compute_buf::write_i8(in_buf, compute_buf::INOutProjLayout::W + i, w);
            }
            for (int i = 0; i < D_TILE_WO; ++i) {
                compute_buf::write_i32(in_buf, compute_buf::INOutProjLayout::B + (i * 4), (i % 3) - 1);
            }
            break;
        }
        case CMP_RESID1: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::X + i,
                                      static_cast<int8_t>((i % 11) - 5));
                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::R + i,
                                      static_cast<int8_t>((i % 7) - 3));
            }
            break;
        }
        case CMP_RESID2: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::X + i,
                                      static_cast<int8_t>((i % 19) - 9));
                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::R + i,
                                      static_cast<int8_t>((i % 13) - 6));
            }
            break;
        }
        case CMP_FFN_W1: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INFfnW1Layout::X + i,
                                      static_cast<int8_t>((i % 13) - 6));
            }
            for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
                const int8_t w = static_cast<int8_t>((i % 7) - 3);
                compute_buf::write_i8(in_buf, compute_buf::INFfnW1Layout::W + i, w);
            }
            for (int i = 0; i < D_TILE_W1; ++i) {
                compute_buf::write_i32(in_buf, compute_buf::INFfnW1Layout::B + (i * 4), (i % 5) - 2);
            }
            break;
        }
        case CMP_FFN_ACT: {
            for (int i = 0; i < D_FFN; ++i) {
                compute_buf::write_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2),
                                       static_cast<int16_t>(((i % 31) - 15) * 512));
            }
            break;
        }
        case CMP_FFN_W2: {
            for (int i = 0; i < D_FFN; ++i) {
                compute_buf::write_i16(in_buf, compute_buf::INFfnW2Layout::X + (i * 2),
                                       static_cast<int16_t>((i % 121) - 60));
            }
            for (int i = 0; i < D_FFN * D_TILE_W2; ++i) {
                const int8_t w = static_cast<int8_t>((i % 9) - 4);
                compute_buf::write_i8(in_buf, compute_buf::INFfnW2Layout::W + i, w);
            }
            for (int i = 0; i < D_TILE_W2; ++i) {
                compute_buf::write_i32(in_buf, compute_buf::INFfnW2Layout::B + (i * 4), (i % 7) - 3);
            }
            break;
        }
        case CMP_LOGITS: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i32(in_buf, compute_buf::INLogitsLayout::X + i * 4,
                                       static_cast<int32_t>(((i % 9) - 4) * 100));
            }
            for (int out = 0; out < D_TILE_LOGIT; ++out) {
                for (int i = 0; i < D_MODEL; ++i) {
                    const int idx = out * D_MODEL + i;
                    compute_buf::write_i8(in_buf, compute_buf::INLogitsLayout::W + idx,
                                          static_cast<int8_t>(((out + i) % 7) - 3));
                }
            }
            break;
        }
        case CMP_ARGMAX: {
            // Fill tile maxima: each tile has (max_val: i32, local_idx: i32).
            // Ensure a clear winner.
            for (int tile = 0; tile < NUM_LOGIT_TILES; ++tile) {
                const int32_t val = (tile == 7) ? 123456 : (tile * 100 - 5000);
                const int32_t local_idx = (tile * 3) % D_TILE_LOGIT;
                compute_buf::write_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8, val);
                compute_buf::write_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8 + 4, local_idx);
            }
            break;
        }
        default:
            break;
    }
}

static inline int8_t requant_scalar_to_i8(const int32_t x32, const int32_t M, const int32_t n) {
    const int64_t product = static_cast<int64_t>(x32) * static_cast<int64_t>(M);
    const bool do_shift = (n > 0) && (n < 63);
    const int64_t rounded = do_shift ? (1LL << (n - 1)) : 0;
    const int32_t scaled = do_shift ? static_cast<int32_t>((product + rounded) >> n)
                                   : static_cast<int32_t>(product);
    if (scaled > 127) return 127;
    if (scaled < -128) return -128;
    return static_cast<int8_t>(scaled);
}

static inline int32_t mul_q15_i32(int32_t a_q15, int32_t b_q15) {
    const int64_t prod = static_cast<int64_t>(a_q15) * static_cast<int64_t>(b_q15);
    const int64_t round = (prod >= 0) ? (1LL << 14) : -(1LL << 14);
    return static_cast<int32_t>((prod + round) >> 15);
}

static inline int16_t gelu_q15(int16_t x_q15) {
    // Matches compute_controller.cpp gelu_q15 (tanh-approx), Q1.15 in/out.
    constexpr int32_t A_Q15 = 26200;          // round(sqrt(2/pi) * 2^15)
    constexpr int32_t B_Q15 = 1466;           // round(0.044715 * 2^15)
    constexpr int32_t INV3_Q15 = 10923;       // round((1/3) * 2^15)
    constexpr int32_t TWO_INV15_Q15 = 4369;   // round((2/15) * 2^15)

    const int32_t x = static_cast<int32_t>(x_q15);
    const int32_t x2 = mul_q15_i32(x, x);
    const int32_t x3 = mul_q15_i32(x2, x);
    const int32_t inner = x + mul_q15_i32(B_Q15, x3);
    const int32_t u = mul_q15_i32(A_Q15, inner);

    const int32_t u2 = mul_q15_i32(u, u);
    const int32_t u3 = mul_q15_i32(u2, u);
    const int32_t u4 = mul_q15_i32(u2, u2);
    const int32_t u5 = mul_q15_i32(u4, u);

    int32_t tanh_q15 = u - mul_q15_i32(INV3_Q15, u3) + mul_q15_i32(TWO_INV15_Q15, u5);
    if (tanh_q15 > 32767) tanh_q15 = 32767;
    else if (tanh_q15 < -32768) tanh_q15 = -32768;

    const int32_t one_plus = (1 << 15) + tanh_q15; // Q1.15 in [0, 2]
    const int64_t prod = static_cast<int64_t>(x) * static_cast<int64_t>(one_plus); // Q2.30
    const int64_t round = (prod >= 0) ? (1LL << 15) : -(1LL << 15);
    const int32_t y = static_cast<int32_t>((prod + round) >> 16); // 0.5 scaling + back to Q1.15

    if (y > 32767) return 32767;
    if (y < -32768) return -32768;
    return static_cast<int16_t>(y);
}

static int out_bytes_for_op(ComputeOp op) {
    switch (op) {
        case CMP_OUT_PROJ: return compute_buf::OUTOutProjLayout::TOTAL_BYTES;
        case CMP_RESID1:
        case CMP_RESID2: return compute_buf::OUTResidLayout::TOTAL_BYTES;
        case CMP_LN0:
        case CMP_LN1: return compute_buf::OUTRequantLayout::TOTAL_BYTES;
        case CMP_FINAL_NORM: return compute_buf::OUTLayerNormLayout::TOTAL_BYTES;
        case CMP_FFN_W1: return compute_buf::OUTFfnW1Layout::TOTAL_BYTES;
        case CMP_FFN_ACT: return compute_buf::OUTFfnActLayout::TOTAL_BYTES;
        case CMP_FFN_W2: return compute_buf::OUTFfnW2Layout::TOTAL_BYTES;
        case CMP_LOGITS: return compute_buf::OUTLogitsLayout::TOTAL_BYTES;
        case CMP_ARGMAX: return compute_buf::OUTArgmaxLayout::TOTAL_BYTES;
        default: return 0;
    }
}

static void compute_expected_out_buf(const OpStep &step,
                                     const uint8_t *in_buf,
                                     uint8_t *expected_out) {
    std::memset(expected_out, 0, compute_buf::OUT_BUF_BYTES);
    int layer = static_cast<int>(step.layer);
    if (layer < 0 || layer >= MODEL_LAYERS) layer = 0;

    switch (step.op) {
        case CMP_OUT_PROJ: {
            const int32_t M = requant_params::REQUANT2_M_L[layer];
            const int32_t n = requant_params::REQUANT2_N_L[layer];
            for (int out = 0; out < D_TILE_WO; ++out) {
                int32_t acc = compute_buf::read_i32(in_buf, compute_buf::INOutProjLayout::B + out * 4);
                for (int i = 0; i < D_MODEL; ++i) {
                    const int8_t a = compute_buf::read_i8(in_buf, compute_buf::INOutProjLayout::ACT + i);
                    const int8_t w = compute_buf::read_i8(in_buf, compute_buf::INOutProjLayout::W + out * D_MODEL + i);
                    acc += static_cast<int32_t>(a) * static_cast<int32_t>(w);
                }
                compute_buf::write_i8(expected_out, compute_buf::OUTOutProjLayout::Y + out,
                                      requant_scalar_to_i8(acc, M, n));
            }
            break;
        }
        case CMP_RESID1:
        case CMP_RESID2: {
            for (int i = 0; i < D_MODEL; ++i) {
                const int8_t x = compute_buf::read_i8(in_buf, compute_buf::INResidLayout::X + i);
                const int8_t r = compute_buf::read_i8(in_buf, compute_buf::INResidLayout::R + i);
                const int16_t sum = static_cast<int16_t>(x) + static_cast<int16_t>(r);
                int16_t sat = sum;
                if (sat > 127) sat = 127;
                else if (sat < -128) sat = -128;
                compute_buf::write_i8(expected_out, compute_buf::OUTResidLayout::X + i,
                                      static_cast<int8_t>(sat));
            }
            break;
        }
        case CMP_FFN_W1: {
            for (int out = 0; out < D_TILE_W1; ++out) {
                int32_t acc = compute_buf::read_i32(in_buf, compute_buf::INFfnW1Layout::B + out * 4);
                for (int i = 0; i < D_MODEL; ++i) {
                    const int8_t x = compute_buf::read_i8(in_buf, compute_buf::INFfnW1Layout::X + i);
                    const int8_t w = compute_buf::read_i8(in_buf, compute_buf::INFfnW1Layout::W + out * D_MODEL + i);
                    acc += static_cast<int32_t>(x) * static_cast<int32_t>(w);
                }
                const int64_t prod =
                    static_cast<int64_t>(acc) * static_cast<int64_t>(requant_scales::FFN_W1_SCALE_Q15);
                const int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
                int32_t scaled = static_cast<int32_t>(rounded >> 15);
                if (scaled > 32767) scaled = 32767;
                else if (scaled < -32768) scaled = -32768;
                compute_buf::write_i16(expected_out, compute_buf::OUTFfnW1Layout::Y + out * 2,
                                       static_cast<int16_t>(scaled));
            }
            break;
        }
        case CMP_FFN_ACT: {
            for (int i = 0; i < D_FFN; ++i) {
                const int16_t gate = compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::GATE + i * 2);
                compute_buf::write_i16(expected_out, compute_buf::OUTFfnActLayout::Y + i * 2,
                                       gelu_q15(gate));
            }
            break;
        }
        case CMP_FFN_W2: {
            const int32_t M = requant_params::REQUANT4_M_L[layer];
            const int32_t n = requant_params::REQUANT4_N_L[layer];
            for (int out = 0; out < D_TILE_W2; ++out) {
                int32_t acc = compute_buf::read_i32(in_buf, compute_buf::INFfnW2Layout::B + out * 4);
                for (int i = 0; i < D_FFN; ++i) {
                    const int16_t x = compute_buf::read_i16(in_buf, compute_buf::INFfnW2Layout::X + i * 2);
                    const int8_t w = compute_buf::read_i8(in_buf, compute_buf::INFfnW2Layout::W + out * D_FFN + i);
                    acc += static_cast<int32_t>(x) * static_cast<int32_t>(w);
                }
                compute_buf::write_i8(expected_out, compute_buf::OUTFfnW2Layout::Y + out,
                                      requant_scalar_to_i8(acc, M, n));
            }
            break;
        }
        case CMP_LN0:
        case CMP_LN1:
        case CMP_FINAL_NORM: {
            const bool final_norm = (step.op == CMP_FINAL_NORM);
            int32_t M = 0, n = 0;
            if (!final_norm) {
                if (step.op == CMP_LN0) {
                    M = requant_params::REQUANT1_M_L[layer];
                    n = requant_params::REQUANT1_N_L[layer];
                } else {
                    M = requant_params::REQUANT3_M_L[layer];
                    n = requant_params::REQUANT3_N_L[layer];
                }
            }

            int32_t sum = 0;
            int32_t sumsq = 0;
            for (int i = 0; i < D_MODEL; ++i) {
                const int8_t x = compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i);
                sum += static_cast<int32_t>(x);
                sumsq += static_cast<int32_t>(x) * static_cast<int32_t>(x);
            }

            const uint32_t eps_q0_32 =
                static_cast<uint32_t>(compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::EPS));

            const double mean = static_cast<double>(sum) / static_cast<double>(D_MODEL);
            const double ex2 = static_cast<double>(sumsq) / static_cast<double>(D_MODEL);
            double var = ex2 - (mean * mean);
            if (var < 0) var = 0;
            const double eps_var_units = static_cast<double>(eps_q0_32) / static_cast<double>(1u << 18);
            const double v = var + eps_var_units;
            const double inv_std = (v > 0.0) ? (1.0 / std::sqrt(v)) : 0.0;

            for (int i = 0; i < D_MODEL; ++i) {
                const int8_t x = compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i);
                const int32_t gamma_bits = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + i * 4);
                const int32_t beta_bits = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::BETA + i * 4);
                const double gamma = static_cast<double>(gamma_bits) / 65536.0;
                const double beta = static_cast<double>(beta_bits) / 65536.0;
                const double normalized = (static_cast<double>(x) - mean) * inv_std;
                const double scaled = (normalized * gamma) + beta;
                const int32_t scaled_bits = static_cast<int32_t>(scaled * 65536.0); // trunc toward zero
                if (final_norm) {
                    compute_buf::write_i32(expected_out, compute_buf::OUTLayerNormLayout::X + i * 4,
                                           scaled_bits >> 3);
                } else {
                    compute_buf::write_i8(expected_out, compute_buf::OUTRequantLayout::X + i,
                                          requant_scalar_to_i8(scaled_bits, M, n));
                }
            }
            break;
        }
        case CMP_LOGITS: {
            int32_t best_val = INT32_MIN;
            int32_t best_idx = 0;
            for (int out = 0; out < D_TILE_LOGIT; ++out) {
                int32_t acc = 0;
                for (int i = 0; i < D_MODEL; ++i) {
                    const int32_t x = compute_buf::read_i32(in_buf, compute_buf::INLogitsLayout::X + i * 4);
                    const int8_t w = compute_buf::read_i8(in_buf, compute_buf::INLogitsLayout::W + out * D_MODEL + i);
                    acc += x * static_cast<int32_t>(w);
                }
                if (acc > best_val) {
                    best_val = acc;
                    best_idx = out;
                }
            }
            compute_buf::write_i32(expected_out, compute_buf::OUTLogitsLayout::Y + 0, best_val);
            compute_buf::write_i32(expected_out, compute_buf::OUTLogitsLayout::Y + 4, best_idx);
            break;
        }
        case CMP_ARGMAX: {
            int32_t best_val = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + 0);
            int32_t best_global_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + 4);
            for (int tile = 1; tile < NUM_LOGIT_TILES; ++tile) {
                const int32_t tile_val = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8);
                const int32_t tile_local_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8 + 4);
                if (tile_val > best_val) {
                    best_val = tile_val;
                    best_global_idx = (tile * D_TILE_LOGIT) + tile_local_idx;
                }
            }
            compute_buf::write_i32(expected_out, compute_buf::OUTArgmaxLayout::Y, best_global_idx);
            break;
        }
        default:
            break;
    }
}

static bool check_out_buf(const OpStep &step,
                          const uint8_t *in_buf,
                          const uint8_t *out_buf) {
    uint8_t expected[compute_buf::OUT_BUF_BYTES]{};
    compute_expected_out_buf(step, in_buf, expected);

    const int bytes = out_bytes_for_op(step.op);
    if (bytes <= 0) {
        return true;
    }
    if (std::memcmp(out_buf, expected, static_cast<size_t>(bytes)) == 0) {
        return true;
    }

    std::fprintf(stderr, "[TB][MISMATCH] op=%s bytes=%d\n", op_name(step.op), bytes);
    for (int b = 0; b < bytes; ++b) {
        if (out_buf[b] == expected[b]) continue;
        // Try to print a useful element-level diff.
        switch (step.op) {
            case CMP_FFN_W1:
            case CMP_FFN_ACT: {
                const int idx = b / 2;
                const int16_t got = compute_buf::read_i16(out_buf, idx * 2);
                const int16_t exp = compute_buf::read_i16(expected, idx * 2);
                std::fprintf(stderr, "  first diff i16[%d]: got=%d exp=%d\n", idx, (int)got, (int)exp);
                break;
            }
            case CMP_FINAL_NORM:
            case CMP_LOGITS:
            case CMP_ARGMAX: {
                const int idx = b / 4;
                const int32_t got = compute_buf::read_i32(out_buf, idx * 4);
                const int32_t exp = compute_buf::read_i32(expected, idx * 4);
                std::fprintf(stderr, "  first diff i32[%d]: got=%d exp=%d\n", idx, got, exp);
                break;
            }
            default: {
                const int idx = b;
                const int8_t got = compute_buf::read_i8(out_buf, idx);
                const int8_t exp = compute_buf::read_i8(expected, idx);
                std::fprintf(stderr, "  first diff i8[%d]: got=%d exp=%d\n", idx, (int)got, (int)exp);
                break;
            }
        }
        return false;
    }
    return false;
}

static void print_out_sample(const uint8_t *out_buf, ComputeOp op) {
    std::printf("  out sample: ");
    switch (op) {
        case CMP_FFN_W1:
        case CMP_FFN_ACT: {
            for (int i = 0; i < 8 && (i * 2) < compute_buf::OUT_BUF_BYTES; ++i) {
                std::printf("%d ", static_cast<int>(compute_buf::read_i16(out_buf, i * 2)));
            }
            break;
        }
        case CMP_FINAL_NORM: {
            for (int i = 0; i < 4 && (i * 4) < compute_buf::OUT_BUF_BYTES; ++i) {
                std::printf("%d ", static_cast<int>(compute_buf::read_i32(out_buf, i * 4)));
            }
            break;
        }
        case CMP_LOGITS: {
            std::printf("best_val=%d best_local=%d ",
                        compute_buf::read_i32(out_buf, 0),
                        compute_buf::read_i32(out_buf, 4));
            break;
        }
        case CMP_ARGMAX: {
            std::printf("best_global=%d ", compute_buf::read_i32(out_buf, 0));
            break;
        }
        default: {
            for (int i = 0; i < 8 && i < compute_buf::OUT_BUF_BYTES; ++i) {
                std::printf("%d ", static_cast<int>(compute_buf::read_i8(out_buf, i)));
            }
            break;
        }
    }
    std::printf("\n");
}

static bool ensure_dir(const char *path) {
    if (mkdir(path, 0777) == 0) {
        return true;
    }
    return (errno == EEXIST);
}

static bool init_tb_logs() {
    const std::string base_dir = tb_paths::log_root_from_file(__FILE__);
    const std::string tb_dir = base_dir + "/compute_controller_tb";
    const std::string stdout_path = tb_dir + "/compute_controller_tb_stdout.log";
    const std::string stderr_path = tb_dir + "/compute_controller_tb_stderr.log";

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
    constexpr OpStep steps[] = {
        {CMP_LN0,        0, -1, -1, "LN0"},
        {CMP_OUT_PROJ,   0, -1,  0, "OUT_PROJ"},
        {CMP_RESID1,     0, -1, -1, "RESID1"},
        {CMP_FFN_W1,     0, -1,  0, "FFN_W1"},
        {CMP_FFN_ACT,    0, -1, -1, "FFN_ACT"},
        {CMP_FFN_W2,     0, -1,  0, "FFN_W2"},
        {CMP_RESID2,     0, -1, -1, "RESID2"},
        {CMP_LN1,        0, -1, -1, "LN1"},
        {CMP_FINAL_NORM, 0, -1, -1, "FINAL_NORM"},
        {CMP_LOGITS,     0, -1,  0, "LOGITS"},
        {CMP_ARGMAX,     0, -1, -1, "ARGMAX"},
    };

    ControlMemSpace ctrl_mem{};
    ctrl_mem.control = CTRL_RESETN_BIT;

    uint8_t in_buf[compute_buf::IN_BUF_BYTES]{};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]{};

    bool compute_start = false;
    uint64_t compute_instruction = make_instruction(CMP_NONE, 0, -1, -1);
    bool compute_ready = false;
    bool compute_done = false;

    bool mem_transfer_done = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    uint64_t mem_op = 0;

    ComputeState dbg_state = ComputeState::IDLE;
    uint64_t dbg_req_instruction = 0;
    uint8_t dbg_req_op = 0;
    uint8_t dbg_req_layer = 0;
    uint8_t dbg_req_head = 0;
    uint16_t dbg_req_tile = 0;
    bool dbg_mac_start = false;
    bool dbg_mac_ready = false;
    bool dbg_mac_complete = false;
    bool error = false;

    std::printf("%8s | %-12s | %8s | %-10s | %4s | %4s | %8s | %8s | %9s\n",
                "cycle", "step", "start", "state", "mr", "mw", "mem_done", "cmp_done", "req_op");

    int cycle = 0;
    for (const OpStep &step : steps) {
        fill_in_buf_for_op(in_buf, step);
        std::memset(out_buf, 0, sizeof(out_buf));

        bool issued = false;
        int mem_timer = -1;

        for (int local = 0; local < 200; ++local, ++cycle) {
            mem_transfer_done = false;
            if (mem_timer >= 0) {
                if (mem_timer == 0) {
                    mem_transfer_done = true;
                    mem_timer = -1;
                } else {
                    --mem_timer;
                }
            }

            compute_start = false;
            if (!issued && compute_ready) {
                compute_start = true;
                compute_instruction = make_instruction(step.op, step.layer, step.head, step.tile);
                issued = true;
            }

            compute_controller(
                (ctrl_mem.control & CTRL_RESETN_BIT) != 0u,
                compute_start,
                compute_instruction,
                compute_ready,
                compute_done,
                mem_transfer_done,
                mem_read_request,
                mem_write_request,
                mem_op,
                in_buf,
                out_buf,
                dbg_state,
                dbg_req_instruction,
                dbg_req_op,
                dbg_req_layer,
                dbg_req_head,
                dbg_req_tile,
                dbg_mac_start,
                dbg_mac_ready,
                dbg_mac_complete,
                error
            );

            if ((mem_read_request || mem_write_request) && mem_timer < 0) {
                mem_timer = 1;
            }

            std::printf("%8d | %-12s | %8d | %-10s | %4d | %4d | %8d | %8d | %9s\n",
                        cycle,
                        step.name,
                        compute_start ? 1 : 0,
                        state_name(dbg_state),
                        mem_read_request ? 1 : 0,
                        mem_write_request ? 1 : 0,
                        mem_transfer_done ? 1 : 0,
                        compute_done ? 1 : 0,
                        op_name(static_cast<ComputeOp>(dbg_req_op)));

            if (error) {
                std::fprintf(stderr, "[TB][ERROR] compute_controller error on step %s cycle %d\n", step.name, cycle);
                return 1;
            }

            if (compute_done) {
                std::printf("[TB] step %-12s complete\n", step.name);
                print_out_sample(out_buf, step.op);
                if (!check_out_buf(step, in_buf, out_buf)) {
                    std::fprintf(stderr, "[TB][ERROR] golden check failed on step %s\n", step.name);
                    return 3;
                }
                break;
            }

            if (local == 199) {
                std::fprintf(stderr, "[TB][ERROR] timeout on step %s\n", step.name);
                return 2;
            }
        }
    }

    std::printf("[TB] compute_controller test complete\n");
    return 0;
}
