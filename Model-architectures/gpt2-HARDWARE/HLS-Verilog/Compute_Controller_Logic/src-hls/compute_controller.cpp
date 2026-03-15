#include "compute_controller.hpp"
#include <ap_fixed.h>
#include <climits>
#include <hls_math.h>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

static inline int8_t requant_scalar_to_i8(const int32_t x32, const int32_t M, const int32_t n);
static inline int16_t sigmoid_q15(int16_t x_q15);
static inline int16_t gelu_q15(int16_t x_q15);

#ifndef __SYNTHESIS__
static const char *compute_op_name(ComputeOp op) {
    switch (op) {
        case ComputeOp::CMP_OUT_PROJ: return "CMP_OUT_PROJ";
        case ComputeOp::CMP_RESID1: return "CMP_RESID1";
        case ComputeOp::CMP_RESID2: return "CMP_RESID2";
        case ComputeOp::CMP_LN0: return "CMP_LN0";
        case ComputeOp::CMP_LN1: return "CMP_LN1";
        case ComputeOp::CMP_FINAL_NORM: return "CMP_FINAL_NORM";
        case ComputeOp::CMP_FFN_W1: return "CMP_FFN_W1";
        case ComputeOp::CMP_FFN_ACT: return "CMP_FFN_ACT";
        case ComputeOp::CMP_FFN_W2: return "CMP_FFN_W2";
        case ComputeOp::CMP_LOGITS: return "CMP_LOGITS";
        case ComputeOp::CMP_ARGMAX: return "CMP_ARGMAX";
        default: return "CMP_UNKNOWN";
    }
}

static void print_i8_vector(const char *label, const int8_t *data, int count) {
    std::printf("%s[%d]:", label, count);
    for (int i = 0; i < count; ++i) {
        std::printf(" %d", static_cast<int>(data[i]));
    }
    std::printf("\n");
}

static void print_i16_vector(const char *label, const int16_t *data, int count) {
    std::printf("%s[%d]:", label, count);
    for (int i = 0; i < count; ++i) {
        std::printf(" %d", static_cast<int>(data[i]));
    }
    std::printf("\n");
}

static void print_i32_vector(const char *label, const int32_t *data, int count) {
    std::printf("%s[%d]:", label, count);
    for (int i = 0; i < count; ++i) {
        std::printf(" %d", data[i]);
    }
    std::printf("\n");
}

static void print_i8_matrix(const char *label,
                            const int8_t *data,
                            int rows,
                            int cols,
                            int stride) {
    std::printf("%s[%d][%d]:\n", label, rows, cols);
    for (int r = 0; r < rows; ++r) {
        std::printf("  %02d:", r);
        for (int c = 0; c < cols; ++c) {
            std::printf(" %d", static_cast<int>(data[r * stride + c]));
        }
        std::printf("\n");
    }
}

static void trace_mac_op_inputs(ComputeOp op,
                                uint8_t layer_idx,
                                uint16_t tile_idx,
                                const int32_t *vectorA,
                                int vec_count,
                                const int8_t *matrixB,
                                const int32_t *bias,
                                int out_count,
                                bool use_bias) {
    std::printf("[COMPUTE IN] op=%s layer=%u tile=%u\n",
                compute_op_name(op),
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(tile_idx));
    print_i32_vector("  act", vectorA, vec_count);
    print_i8_matrix("  weight", matrixB, out_count, vec_count, VECTOR_MAX);
    if (use_bias) {
        print_i32_vector("  bias", bias, out_count);
    }
}

static void trace_mac_op_outputs(ComputeOp op,
                                 uint8_t layer_idx,
                                 uint16_t tile_idx,
                                 const int32_t *accum_vector,
                                 int out_count,
                                 const uint8_t out_buf[],
                                 int32_t requant_M,
                                 int32_t requant_n) {
    std::printf("[COMPUTE OUT] op=%s layer=%u tile=%u M=%d n=%d\n",
                compute_op_name(op),
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(tile_idx),
                requant_M,
                requant_n);
    print_i32_vector("  accum", accum_vector, out_count);
    switch (op) {
        case ComputeOp::CMP_OUT_PROJ:
        case ComputeOp::CMP_FFN_W2: {
            int8_t y[ACCUM_MAX];
            for (int i = 0; i < out_count; ++i) {
                y[i] = compute_buf::read_i8(out_buf, i);
            }
            print_i8_vector("  out", y, out_count);
            break;
        }
        case ComputeOp::CMP_FFN_W1: {
            int16_t y[ACCUM_MAX];
            for (int i = 0; i < out_count; ++i) {
                y[i] = compute_buf::read_i16(out_buf, i * 2);
            }
            print_i16_vector("  out", y, out_count);
            break;
        }
        case ComputeOp::CMP_LOGITS: {
            int32_t y[ACCUM_MAX];
            for (int i = 0; i < out_count; ++i) {
                y[i] = compute_buf::read_i32(out_buf, i * 4);
            }
            print_i32_vector("  out", y, out_count);
            break;
        }
        default:
            break;
    }
}

static void trace_res_add_buffers(ComputeOp op,
                                  uint8_t layer_idx,
                                  const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                                  const uint8_t out_buf[compute_buf::OUT_BUF_BYTES]) {
    int8_t x[D_MODEL];
    int8_t r[D_MODEL];
    int8_t y[D_MODEL];
    for (int i = 0; i < D_MODEL; ++i) {
        x[i] = compute_buf::read_i8(in_buf, compute_buf::INResidLayout::X + i);
        r[i] = compute_buf::read_i8(in_buf, compute_buf::INResidLayout::R + i);
        y[i] = compute_buf::read_i8(out_buf, compute_buf::OUTResidLayout::X + i);
    }
    std::printf("[COMPUTE IO] op=%s layer=%u\n",
                compute_op_name(op),
                static_cast<unsigned>(layer_idx));
    print_i8_vector("  x", x, D_MODEL);
    print_i8_vector("  residual", r, D_MODEL);
    print_i8_vector("  out", y, D_MODEL);
}

static void trace_ffn_act_buffers(uint8_t layer_idx,
                                  uint16_t tile_idx,
                                  const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                                  const uint8_t out_buf[compute_buf::OUT_BUF_BYTES]) {
    int16_t x[D_FFN];
    int16_t y[D_FFN];
    for (int i = 0; i < D_FFN; ++i) {
        x[i] = compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2));
        y[i] = compute_buf::read_i16(out_buf, compute_buf::OUTFfnActLayout::Y + (i * 2));
    }
    std::printf("[COMPUTE IO] op=CMP_FFN_ACT layer=%u tile=%u\n",
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(tile_idx));
    print_i16_vector("  x", x, D_FFN);
    print_i16_vector("  out", y, D_FFN);
}

static void trace_argmax_buffers(uint8_t layer_idx,
                                 const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                                 const uint8_t out_buf[compute_buf::OUT_BUF_BYTES]) {
    int32_t x[D_VOCAB];
    for (int i = 0; i < D_VOCAB; ++i) {
        x[i] = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + (i * 4));
    }
    const int32_t best_idx = compute_buf::read_i32(out_buf, compute_buf::OUTArgmaxLayout::Y);
    std::printf("[COMPUTE IO] op=CMP_ARGMAX layer=%u\n",
                static_cast<unsigned>(layer_idx));
    print_i32_vector("  logits", x, D_VOCAB);
    std::printf("  out_idx: %d\n", best_idx);
}

static void trace_layer_norm_buffers(ComputeOp op,
                                   uint8_t layer_idx,
                                   const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                                   const uint8_t out_buf[compute_buf::OUT_BUF_BYTES],
                                   bool final_norm,
                                   int32_t requant_M,
                                   int32_t requant_n) {
    int8_t x[D_MODEL];
    int32_t gamma[D_MODEL];
    int32_t beta[D_MODEL];
    for (int i = 0; i < D_MODEL; ++i) {
        x[i] = compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i);
        gamma[i] = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4));
        beta[i] = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::BETA + (i * 4));
    }
    const int32_t eps = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::EPS);

    std::printf("[COMPUTE IO] op=%s layer=%u final_norm=%u M=%d n=%d\n",
                compute_op_name(op),
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(final_norm),
                requant_M,
                requant_n);
    print_i8_vector("  x", x, D_MODEL);
    print_i32_vector("  gamma", gamma, D_MODEL);
    print_i32_vector("  beta", beta, D_MODEL);
    std::printf("  eps: %d\n", eps);

    if (final_norm) {
        int32_t y[D_MODEL];
        for (int i = 0; i < D_MODEL; ++i) {
            y[i] = compute_buf::read_i32(out_buf, compute_buf::OUTLayerNormLayout::X + (i * 4));
        }
        print_i32_vector("  out", y, D_MODEL);
    } else {
        int8_t y[D_MODEL];
        for (int i = 0; i < D_MODEL; ++i) {
            y[i] = compute_buf::read_i8(out_buf, compute_buf::OUTRequantLayout::X + i);
        }
        print_i8_vector("  out", y, D_MODEL);
    }
}
#endif

static void MAC_COMPUTE_CORE(
    const int32_t vectorA[VECTOR_MAX],
    const int8_t matrixB[MATRIX_MAX],
    const int32_t bias[ACCUM_MAX],
    int32_t accum_vector[ACCUM_MAX]
) {
#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=vectorA cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matrixB cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=accum_vector cyclic factor=MAC_OUT_UNROLL dim=1

    for (int out = 0; out < ACCUM_MAX; ++out) {
#pragma HLS UNROLL factor=MAC_OUT_UNROLL
        int32_t acc = bias[out];
        for (int i = 0; i < VECTOR_MAX; ++i) {
#pragma HLS UNROLL factor=MAC_VEC_UNROLL
            const int8_t w = matrixB[out * VECTOR_MAX + i];
            acc += vectorA[i] * static_cast<int32_t>(w);
        }
        accum_vector[out] = acc;
    }
}

// MAC Architecture
void MAC_ARCHITECTURE(
    bool start,
    bool &ready,
    const int32_t vectorA[VECTOR_MAX],
    const int8_t matrixB[MATRIX_MAX],
    const int32_t bias[ACCUM_MAX],
    bool &complete,
    int32_t accum_vector[ACCUM_MAX]
) {
#pragma HLS INLINE
    static bool busy = false;
    static bool compute_done = false;
#pragma HLS reset variable = busy
#pragma HLS reset variable = compute_done

    ready = (!busy) && (!start);
    complete = compute_done;

    const bool do_compute = (!busy && start);

    if (do_compute) {
        busy = true;
        compute_done = false;
        MAC_COMPUTE_CORE(vectorA, matrixB, bias, accum_vector);
        compute_done = true;
    } else if (compute_done) {
        compute_done = false;
        busy = false;
    }
}

static void MAC_OP_TO_BUF(
    bool start,
    bool &ready,
    ComputeOp op,
    uint8_t layer_idx,
    uint16_t tile_idx,
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    bool &complete,
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    static bool busy = false;
    static bool compute_done = false;
#pragma HLS reset variable = busy
#pragma HLS reset variable = compute_done

    int32_t vectorA[VECTOR_MAX];
    int8_t matrixB[MATRIX_MAX];
    int32_t bias[ACCUM_MAX];
    int32_t accum_vector[ACCUM_MAX];
#pragma HLS ARRAY_PARTITION variable=vectorA cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matrixB cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=accum_vector cyclic factor=MAC_OUT_UNROLL dim=1

    ready = (!busy) && (!start);
    complete = compute_done;

    const bool do_compute = (!busy && start);
    if (do_compute) {
        busy = true;
        compute_done = false;

	        int vec_count = 0;
	        int out_count = 0;
	        int act_byte_base = 0;
	        int weight_byte_base = 0;
	        int bias_byte_base = 0;
	        bool act_is_i16 = false;
	        bool act_is_i32 = false;
	        bool use_bias = true;

        switch (op) {
	            case ComputeOp::CMP_OUT_PROJ:
	                vec_count = D_MODEL;
	                out_count = D_TILE_WO;
	                act_byte_base = compute_buf::INOutProjLayout::ACT;
	                weight_byte_base = compute_buf::INOutProjLayout::W;
	                bias_byte_base = compute_buf::INOutProjLayout::B;
	                break;
	            case ComputeOp::CMP_FFN_W1:
	                vec_count = D_MODEL;
	                out_count = D_TILE_W1;
	                act_byte_base = compute_buf::INFfnW1Layout::X;
	                weight_byte_base = compute_buf::INFfnW1Layout::W;
	                bias_byte_base = compute_buf::INFfnW1Layout::B;
	                break;
	            case ComputeOp::CMP_FFN_W2:
	                vec_count = D_FFN;
	                out_count = D_TILE_W2;
	                act_byte_base = compute_buf::INFfnW2Layout::X;
	                weight_byte_base = compute_buf::INFfnW2Layout::W;
	                bias_byte_base = compute_buf::INFfnW2Layout::B;
	                act_is_i16 = true;
	                break;
	            case ComputeOp::CMP_LOGITS:
	                vec_count = D_MODEL;
	                out_count = D_TILE_LOGIT;
	                act_byte_base = compute_buf::INLogitsLayout::X;
	                weight_byte_base = compute_buf::INLogitsLayout::W;
	                act_is_i32 = true;
	                use_bias = false;
	                break;
            default:
                compute_done = true;
                break;
        }

	        if (!compute_done) {
	            int layer = static_cast<int>(layer_idx);
	            if (layer >= MODEL_LAYERS) {
	                layer = 0;
	            }
            int32_t trace_M = 0;
            int32_t trace_n = 0;

	            for (int i = 0; i < VECTOR_MAX; ++i) {
#pragma HLS UNROLL factor=MAC_VEC_UNROLL
	                if (i < vec_count) {
                    if (act_is_i32) {
                        const int act_addr = act_byte_base + (i * 4);
                        vectorA[i] = compute_buf::read_i32(in_buf, act_addr);
                    } else if (act_is_i16) {
                        const int act_addr = act_byte_base + (i * 2);
                        vectorA[i] = static_cast<int32_t>(compute_buf::read_i16(in_buf, act_addr));
                    } else {
                        const int act_addr = act_byte_base + i;
                        vectorA[i] = static_cast<int32_t>(compute_buf::read_i8(in_buf, act_addr));
                    }
                } else {
                    vectorA[i] = 0;
                }
            }

            for (int out = 0; out < ACCUM_MAX; ++out) {
#pragma HLS UNROLL factor=MAC_OUT_UNROLL
                if (use_bias && out < out_count) {
                    const int bias_addr = bias_byte_base + (out * 4);
                    bias[out] = compute_buf::read_i32(in_buf, bias_addr);
                } else {
                    bias[out] = 0;
                }
            }

	            for (int out = 0; out < ACCUM_MAX; ++out) {
#pragma HLS UNROLL factor=MAC_OUT_UNROLL
	                for (int i = 0; i < VECTOR_MAX; ++i) {
#pragma HLS UNROLL factor=MAC_VEC_UNROLL
	                    if (out < out_count && i < vec_count) {
	                        const int w_idx = (out * vec_count) + i;
	                        const int weight_addr = weight_byte_base + w_idx;
	                        matrixB[out * VECTOR_MAX + i] = compute_buf::read_i8(in_buf, weight_addr);
	                    } else {
	                        matrixB[out * VECTOR_MAX + i] = 0;
			                    }
			                }
			            }

#ifndef __SYNTHESIS__
            trace_mac_op_inputs(op, layer_idx, tile_idx, vectorA, vec_count,
                                matrixB, bias, out_count, use_bias);
#endif
	            MAC_COMPUTE_CORE(vectorA, matrixB, bias, accum_vector);

	            int32_t logit_best_val = INT32_MIN;
	            int32_t logit_best_local_idx = 0;

	            for (int out = 0; out < out_count; ++out) {
#pragma HLS UNROLL factor=MAC_OUT_UNROLL
	                switch (op) {
	                    case ComputeOp::CMP_OUT_PROJ: {
	                        const int32_t M = requant_params::REQUANT2_M_L[layer];
	                        const int32_t n = requant_params::REQUANT2_N_L[layer];
                            trace_M = M;
                            trace_n = n;
	                        compute_buf::write_i8(out_buf, out, requant_scalar_to_i8(accum_vector[out], M, n));
	                        break;
	                    }
	                    case ComputeOp::CMP_FFN_W1: {
                        const int64_t prod =
                            static_cast<int64_t>(accum_vector[out]) *
                            static_cast<int64_t>(requant_scales::FFN_W1_SCALE_Q15);
                        const int64_t rounded =
                            prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
                        int32_t scaled = static_cast<int32_t>(rounded >> 15);
                        if (scaled > 32767) scaled = 32767;
                        else if (scaled < -32768) scaled = -32768;
                        compute_buf::write_i16(out_buf, out * 2, static_cast<int16_t>(scaled));
                        break;
                    }
	                    case ComputeOp::CMP_FFN_W2: {
	                        const int32_t M = requant_params::REQUANT4_M_L[layer];
	                        const int32_t n = requant_params::REQUANT4_N_L[layer];
                            trace_M = M;
                            trace_n = n;
	                        compute_buf::write_i8(out_buf, out, requant_scalar_to_i8(accum_vector[out], M, n));
	                        break;
	                    }
	                    case ComputeOp::CMP_LOGITS: {
	                        if (accum_vector[out] > logit_best_val) {
	                            logit_best_val = accum_vector[out];
	                            logit_best_local_idx = out;
	                        }
                        break;
                    }
	                    default:
	                        break;
	                }
	            }
	            if (op == ComputeOp::CMP_LOGITS) {
	                compute_buf::write_i32(out_buf, 0, logit_best_val);
	                compute_buf::write_i32(out_buf, 4, logit_best_local_idx);
	            }

#ifndef __SYNTHESIS__
            trace_mac_op_outputs(op, layer_idx, tile_idx, accum_vector, out_count,
                                 out_buf, trace_M, trace_n);
#endif
	            compute_done = true;
	        }
	    } else if (compute_done) {
	        compute_done = false;
        busy = false;
    }
}

// ---------------------------------------------------------------------------
// Compute kernels
// ---------------------------------------------------------------------------
void REQUANT_D_MODEL_int32_to_int8(
    const int32_t x32[D_MODEL],   // input vector
    const int32_t M,              // integer multiplier               (Provided by PS)
    const int32_t n,              // right shift                      (Provided by PS)

    int8_t y8[D_MODEL]      // output vector
) {

    // Original Integer Requant Formula (for each element in vector):
    /*
        How to calculate M and n (offline, from quantization params)

        Notation:
          S_x   = input activation scale (int8)  -> max_abs_x / 127
          S_w   = weight scale (int8)            -> max_abs_w / 127
          S_out = desired output activation scale (int8) from calibration

        Example: weighted matmul output (int32 accum -> int8)
          S_accum = S_x * S_w
          real_scale = S_accum / S_out
          M = round(real_scale * 2^n)
          n = chosen so M fits int32 (typically 0..31)

        Example: RMS/LayerNorm output requant (fixed-point -> int8)
          S_fixed = 2^-F (e.g., Q19.13 => F=13)
          real_scale = S_fixed / S_out
          M = round(real_scale * 2^n)
          n = chosen so M fits int32

        Runtime formula:
          y[t] = saturate_to_int8( (x[t] * M + 2^(n-1)) >> n )
    */
    for (int t = 0; t < D_MODEL; ++t) {
// #pragma HLS UNROLL
        int64_t product = static_cast<int64_t>(x32[t]) * static_cast<int64_t>(M);
        const bool do_shift = (n > 0) && (n < 63);
        int64_t rounded = do_shift ? (1LL << (n - 1)) : 0;
        int32_t scaled = do_shift ? static_cast<int32_t>((product + rounded) >> n)
                                 : static_cast<int32_t>(product);

        if (scaled > 127) {
            y8[t] = 127;
        } else if (scaled < -128) {
            y8[t] = -128;
        } else {
            y8[t] = static_cast<int8_t>(scaled);
        }
    }   
}

void REQUANT_D_TILE_int32_to_int8(
    const int32_t x32[ACCUM_MAX],
    const int count,
    const int32_t M,
    const int32_t n,
    int8_t y8[ACCUM_MAX]
) {
    for (int t = 0; t < ACCUM_MAX; ++t) {
// #pragma HLS PIPELINE II=1
        if (t >= count) {
            continue;
        }
        const int64_t product = static_cast<int64_t>(x32[t]) * static_cast<int64_t>(M);
        const bool do_shift = (n > 0) && (n < 63);
        const int64_t rounded = do_shift ? (1LL << (n - 1)) : 0;
        const int32_t scaled = do_shift ? static_cast<int32_t>((product + rounded) >> n)
                                       : static_cast<int32_t>(product);
        if (scaled > 127) {
            y8[t] = 127;
        } else if (scaled < -128) {
            y8[t] = -128;
        } else {
            y8[t] = static_cast<int8_t>(scaled);
        }
    }
}

static inline int8_t requant_scalar_to_i8(const int32_t x32, const int32_t M, const int32_t n) {
#pragma HLS INLINE
    const int64_t product = static_cast<int64_t>(x32) * static_cast<int64_t>(M);
    const bool do_shift = (n > 0) && (n < 63);
    const int64_t rounded = do_shift ? (1LL << (n - 1)) : 0;
    const int32_t scaled = do_shift ? static_cast<int32_t>((product + rounded) >> n)
                                   : static_cast<int32_t>(product);
    if (scaled > 127) return 127;
    if (scaled < -128) return -128;
    return static_cast<int8_t>(scaled);
}

static void RES_ADD_TO_BUF(ComputeOp op,
                           uint8_t layer_idx,
                           const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                           uint8_t out_buf[compute_buf::OUT_BUF_BYTES]) {
#pragma HLS INLINE off
    for (int i = 0; i < D_MODEL; ++i) {
// #pragma HLS PIPELINE II=1
        const int16_t sum =
            static_cast<int16_t>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::X + i)) +
            static_cast<int16_t>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::R + i));
        int16_t sat = sum;
        if (sat > 127) sat = 127;
        else if (sat < -128) sat = -128;
        compute_buf::write_i8(out_buf, compute_buf::OUTResidLayout::X + i, static_cast<int8_t>(sat));
    }
#ifndef __SYNTHESIS__
    trace_res_add_buffers(op, layer_idx, in_buf, out_buf);
#endif
}

static void FFN_ACT_Gelu_TO_BUF(uint8_t layer_idx,
                                uint16_t tile_idx,
                                const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                                uint8_t out_buf[compute_buf::OUT_BUF_BYTES]) {
#pragma HLS INLINE off
    for (int i = 0; i < D_FFN; ++i) {
// #pragma HLS PIPELINE II=1
        const int16_t gate = compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2));
        compute_buf::write_i16(out_buf, compute_buf::OUTFfnActLayout::Y + (i * 2), gelu_q15(gate));
    }
#ifndef __SYNTHESIS__
    trace_ffn_act_buffers(layer_idx, tile_idx, in_buf, out_buf);
#endif
}

static void ARGMAX_TO_BUF(uint8_t layer_idx,
                          const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                          uint8_t out_buf[compute_buf::OUT_BUF_BYTES]) {
#pragma HLS INLINE off
    // Each tile wrote (max_val: i32, local_idx: i32) = 8 bytes.
    // Reconstruct global argmax: global_idx = tile * D_TILE_LOGIT + local_idx.
    int32_t best_val = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X);
    int32_t best_global_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + 4);
    for (int tile = 1; tile < NUM_LOGIT_TILES; ++tile) {
        const int32_t tile_val       = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8);
        const int32_t tile_local_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8 + 4);
        if (tile_val > best_val) {
            best_val = tile_val;
            best_global_idx = tile * D_TILE_LOGIT + tile_local_idx;
        }
    }
    compute_buf::write_i32(out_buf, compute_buf::OUTArgmaxLayout::Y, best_global_idx);
#ifndef __SYNTHESIS__
    trace_argmax_buffers(layer_idx, in_buf, out_buf);
#endif
}

static void LAYER_NORM_TO_BUF(ComputeOp op,
                            uint8_t layer_idx,
                            const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                            uint8_t out_buf[compute_buf::OUT_BUF_BYTES],
                            bool final_norm,
                            int32_t requant_M,
                            int32_t requant_n) {
#pragma HLS INLINE off
    // LayerNorm (not RMSNorm):
    //   y = (x - mean(x)) / sqrt(var(x) + eps) * gamma
    // Output format is Q19.13 in `scaled_bits` (raw ap_fixed bits).
    //
    // DDR packing formats (matching test_data/test_gpt2_int8.py):
    //   - gamma/beta are Q16.16 stored as int32
    //   - eps is Q0.32 stored as uint32, representing eps_real (e.g. 1e-5)
    //
    // Internal LN math operates directly on the int8 activation domain (no explicit /2^7),
    // so eps must be mapped into the same variance units:
    //   x_real = x_i8 / 2^7  => var_real = var_i8 / 2^14
    //   eps_var_units = eps_real * 2^14 = (eps_q0_32 / 2^32) * 2^14 = eps_q0_32 / 2^18
    const ap_fixed<32, 19> q16_16_scale = ap_fixed<32, 19>(65536);          // 2^16
    const ap_fixed<32, 19> eps_q0_32_to_var_scale = ap_fixed<32, 19>(262144); // 2^18

    int32_t sum = 0;
    int32_t sumsq = 0;
    for (int i = 0; i < D_MODEL; ++i) {
// #pragma HLS PIPELINE II=1
        const int8_t x = compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i);
        sum += static_cast<int32_t>(x);
        sumsq += static_cast<int32_t>(x) * static_cast<int32_t>(x);
    }

    const int32_t epsilon = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::EPS);

    ap_fixed<32, 19> mean = ap_fixed<32, 19>(sum) / D_MODEL;
    ap_fixed<32, 19> ex2 = ap_fixed<32, 19>(sumsq) / D_MODEL;
    ap_fixed<32, 19> var = ex2 - (mean * mean);
    if (var < 0) {
        var = 0;
    }

    ap_fixed<32, 19> v = var + (ap_fixed<32, 19>(epsilon) / eps_q0_32_to_var_scale);
    if (v < 0) {
        v = 0;
    }
    ap_fixed<32, 19> inv_std = ap_fixed<32, 19>(1) / hls::sqrt(v);

    for (int base = 0; base < D_MODEL; base += MAX_CYCLIC_SIZE) {
#pragma HLS PIPELINE off
#pragma HLS LOOP_FLATTEN off
        const int tile_elems =
            ((base + MAX_CYCLIC_SIZE) < D_MODEL) ? MAX_CYCLIC_SIZE : (D_MODEL - base);
        int8_t x_tile[MAX_CYCLIC_SIZE];
        int32_t gamma_tile[MAX_CYCLIC_SIZE];
        int32_t beta_tile[MAX_CYCLIC_SIZE];
#pragma HLS ARRAY_PARTITION variable=x_tile complete dim=1
#pragma HLS ARRAY_PARTITION variable=gamma_tile complete dim=1
#pragma HLS ARRAY_PARTITION variable=beta_tile complete dim=1
        for (int i = 0; i < MAX_CYCLIC_SIZE; ++i) {
#pragma HLS PIPELINE II=1
            if (i < tile_elems) {
                x_tile[i] = compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + base + i);
                gamma_tile[i] =
                    compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + ((base + i) * 4));
                beta_tile[i] =
                    compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::BETA + ((base + i) * 4));
            } else {
                x_tile[i] = 0;
                gamma_tile[i] = 0;
                beta_tile[i] = 0;
            }
        }
        for (int i = 0; i < MAX_CYCLIC_SIZE; ++i) {
#pragma HLS PIPELINE II=1
            if (i >= tile_elems) {
                continue;
            }
            ap_fixed<32, 19> normalized = (ap_fixed<32, 19>(x_tile[i]) - mean) * inv_std;
            ap_fixed<32, 19> gamma_fx = ap_fixed<32, 19>(gamma_tile[i]) / q16_16_scale;
            ap_fixed<32, 19> beta_fx = ap_fixed<32, 19>(beta_tile[i]) / q16_16_scale;
            ap_fixed<32, 19> scaled = (normalized * gamma_fx) + beta_fx;
            const int32_t scaled_bits = static_cast<int32_t>(scaled.range(31, 0));
            if (final_norm) {
                compute_buf::write_i32(out_buf, compute_buf::OUTLayerNormLayout::X + ((base + i) * 4), scaled_bits);
            } else {
                compute_buf::write_i8(out_buf, compute_buf::OUTRequantLayout::X + base + i,
                                      requant_scalar_to_i8(scaled_bits, requant_M, requant_n));
            }
        }
    }
#ifndef __SYNTHESIS__
    trace_layer_norm_buffers(op, layer_idx, in_buf, out_buf, final_norm, requant_M,
                           requant_n);
#endif
}


// Approximate exp(x) for x in Q1.15, clamped to [-1.0, 0.0], output in Q1.15.
static inline uint16_t exp_approx_q15(int16_t x_q15) {
#pragma HLS INLINE
    static const uint16_t exp_lut_q15[257] = {
        12055, 12102, 12149, 12197, 12245, 12292, 12341, 12389,
        12437, 12486, 12535, 12584, 12633, 12683, 12732, 12782,
        12832, 12882, 12933, 12983, 13034, 13085, 13136, 13188,
        13239, 13291, 13343, 13396, 13448, 13501, 13553, 13606,
        13660, 13713, 13767, 13821, 13875, 13929, 13984, 14038,
        14093, 14149, 14204, 14259, 14315, 14371, 14428, 14484,
        14541, 14598, 14655, 14712, 14770, 14828, 14886, 14944,
        15002, 15061, 15120, 15179, 15239, 15298, 15358, 15418,
        15479, 15539, 15600, 15661, 15722, 15784, 15846, 15908,
        15970, 16032, 16095, 16158, 16221, 16285, 16349, 16413,
        16477, 16541, 16606, 16671, 16736, 16802, 16868, 16934,
        17000, 17066, 17133, 17200, 17268, 17335, 17403, 17471,
        17539, 17608, 17677, 17746, 17816, 17885, 17955, 18026,
        18096, 18167, 18238, 18310, 18381, 18453, 18525, 18598,
        18671, 18744, 18817, 18891, 18965, 19039, 19113, 19188,
        19263, 19339, 19414, 19490, 19567, 19643, 19720, 19797,
        19875, 19953, 20031, 20109, 20188, 20267, 20346, 20426,
        20506, 20586, 20667, 20747, 20829, 20910, 20992, 21074,
        21157, 21239, 21323, 21406, 21490, 21574, 21658, 21743,
        21828, 21914, 21999, 22085, 22172, 22259, 22346, 22433,
        22521, 22609, 22698, 22787, 22876, 22965, 23055, 23145,
        23236, 23327, 23418, 23510, 23602, 23694, 23787, 23880,
        23974, 24067, 24162, 24256, 24351, 24446, 24542, 24638,
        24735, 24831, 24929, 25026, 25124, 25222, 25321, 25420,
        25520, 25620, 25720, 25821, 25922, 26023, 26125, 26227,
        26330, 26433, 26536, 26640, 26744, 26849, 26954, 27060,
        27166, 27272, 27379, 27486, 27593, 27701, 27810, 27919,
        28028, 28138, 28248, 28358, 28469, 28581, 28693, 28805,
        28918, 29031, 29144, 29259, 29373, 29488, 29603, 29719,
        29836, 29952, 30070, 30187, 30305, 30424, 30543, 30663,
        30783, 30903, 31024, 31146, 31267, 31390, 31513, 31636,
        31760, 31884, 32009, 32134, 32260, 32386, 32513, 32640,
        32767
    };
    if (x_q15 >= 0) {
        return 32767;
    }
    if (x_q15 <= -32768) {
        return exp_lut_q15[0];
    }
    const uint16_t idx = static_cast<uint16_t>((static_cast<int32_t>(x_q15) - (-32768)) >> 7);
    return exp_lut_q15[idx];
}

static inline int16_t sigmoid_q15(int16_t x_q15) {
#pragma HLS INLINE
    if (x_q15 >= 0) {
        const int16_t neg = static_cast<int16_t>(-static_cast<int32_t>(x_q15));
        const uint16_t e = exp_approx_q15(neg);
        const uint32_t denom = static_cast<uint32_t>(e) + (1u << 15);
        const uint32_t num = (1u << 30);
        const uint32_t sig = (num + (denom / 2)) / denom;
        return static_cast<int16_t>(sig > 32767 ? 32767 : sig);
    }
    const uint16_t e = exp_approx_q15(x_q15);
    const uint32_t denom = static_cast<uint32_t>(e) + (1u << 15);
    const uint32_t num = static_cast<uint32_t>(e) << 15;
    const uint32_t sig = (num + (denom / 2)) / denom;
    return static_cast<int16_t>(sig > 32767 ? 32767 : sig);
}

static inline int32_t mul_q15_i32(int32_t a_q15, int32_t b_q15) {
#pragma HLS INLINE
    const int64_t prod = static_cast<int64_t>(a_q15) * static_cast<int64_t>(b_q15);
    const int64_t round = (prod >= 0) ? (1LL << 14) : -(1LL << 14);
    return static_cast<int32_t>((prod + round) >> 15);
}

static inline int16_t gelu_q15(int16_t x_q15) {
#pragma HLS INLINE
    // GELU tanh-approx in Q1.15:
    //   gelu(x) = 0.5*x*(1 + tanh(sqrt(2/pi)*(x + 0.044715*x^3)))
    // tanh is approximated with: u - u^3/3 + 2u^5/15 (good over |u|~<1).
    constexpr int32_t A_Q15 = 26200;  // round(sqrt(2/pi) * 2^15)
    constexpr int32_t B_Q15 = 1466;   // round(0.044715 * 2^15)
    constexpr int32_t INV3_Q15 = 10923;   // round((1/3) * 2^15)
    constexpr int32_t TWO_INV15_Q15 = 4369; // round((2/15) * 2^15)

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

void FFN_ACT_Silu(
    const int16_t input_up[D_FFN],
    const int16_t input_gate[D_FFN],
    int16_t       output[D_FFN]
) {
    for (int i = 0; i < D_FFN; ++i) {
// #pragma HLS PIPELINE II=1
        const int16_t sig = sigmoid_q15(input_gate[i]);
        const int32_t prod = static_cast<int32_t>(input_up[i]) * static_cast<int32_t>(sig);
        int32_t scaled = prod >> 15;
        if (scaled > 32767) {
            scaled = 32767;
        } else if (scaled < -32768) {
            scaled = -32768;
        }
        const int16_t out = scaled;
        output[i] = out;
    }

}

void FFN_ACT_Gelu(const int16_t input_gate[D_FFN], int16_t output[D_FFN]) {
    for (int i = 0; i < D_FFN; ++i) {
// #pragma HLS PIPELINE II=1
        output[i] = gelu_q15(input_gate[i]);
    }
}
 

void RES_ADD(
    const int8_t input[D_MODEL],
    const int8_t residual[D_MODEL],
    int8_t output[D_MODEL]
) { 
    for (int i = 0; i < D_MODEL; ++i) {
// #pragma HLS UNROLL
        const int16_t sum = static_cast<int16_t>(input[i]) + static_cast<int16_t>(residual[i]);
        int16_t sat = sum;
        if (sat > 127) {
            sat = 127;
        } else if (sat < -128) {
            sat = -128;
        }
        output[i] = static_cast<int8_t>(sat);
    }
}


// ---------------------------------------------------------------------------
// Top-level compute controller
// ---------------------------------------------------------------------------
void compute_controller(
    bool        cntrl_reset_n,         // [INPUT] Control reset bit

    // FSM communication signals
    bool        compute_start,       // [INPUT] Start signal for compute
    uint64_t    compute_instruction,          // [INPUT] Compute operation [7:0]=op [15:8]=layer [23:16]=head [55:24]=tile
    bool        &compute_ready,      // [OUTPUT] Compute engine ready for new operation
    bool        &compute_done,       // [OUTPUT] Compute operation finished

    // Memory manager handshake
    bool        mem_transfer_done,
    bool        &mem_read_request,        // [OUTPUT] Request memory manager
    bool        &mem_write_request,        // [OUTPUT] Request memory manager
    uint64_t     &mem_op,             // [OUTPUT] Full Instruction Identifier for memory manager

    // Flat input/output buffers
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t       out_buf[compute_buf::OUT_BUF_BYTES],

    // Debug visibility
    ComputeState &dbg_state,
    uint64_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint16_t    &dbg_req_tile,
    bool        &dbg_mac_start,
    bool        &dbg_mac_ready,
    bool        &dbg_mac_complete,

    bool        &error               // [OUTPUT] Error flag on invalid request
) {
#pragma HLS INLINE off

    static ComputeState state = ComputeState::IDLE;
#pragma HLS reset variable = state
    static PendingRequest req;


    // Outputs based on current state (before any transition).
    compute_ready = (state == ComputeState::IDLE);
    compute_done  = (state == ComputeState::DONE);

    bool mac_start = false;
    static bool mac_ready = true;
    static bool mac_complete = false;
    static bool capture_pending = false;
    static bool clear_pending = false;

    if (!mac_ready && mac_start && !mac_complete) {
        mac_start = false;
    } 
    

    if (!cntrl_reset_n) {
        state = ComputeState::IDLE;
        req = PendingRequest{};
        error = false;
        compute_ready = true;
        compute_done  = false;
        mem_read_request   = false;
        mem_write_request = false;
        mem_op        = 0;
        dbg_state = state;
        dbg_req_instruction = req.instruction;
        dbg_req_op = static_cast<uint8_t>(req.op);
        dbg_req_layer = req.layer_idx;
        dbg_req_head = req.head_idx;
        dbg_req_tile = req.tile_idx;

        mac_start = false;
        mac_ready = true;
        mac_complete = false;
        capture_pending = false;
        clear_pending = false;

        return;
    }

    ComputeState next_state = state;

    switch (state) {
        case ComputeState::IDLE: {
            capture_pending = false;
            if (compute_start) {
                mac_start = false;
                mac_complete = false;
                req.instruction     = compute_instruction;
                req.op              = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx       = (compute_instruction >> 8) & 0xFFu;
                req.head_idx        = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx        = static_cast<uint16_t>((compute_instruction >> 24) & 0xFFFFu);
                next_state = ComputeState::CAPTURE_INSTRUCTION;
            }
            // Clear output buffer when idling
            if (clear_pending && !compute_start) {
                for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
// #pragma HLS PIPELINE II=1
                    out_buf[i] = 0;
                }
                clear_pending = false;
            }
            break;
        }
        case ComputeState::CAPTURE_INSTRUCTION: {
            if (!capture_pending && compute_instruction != req.instruction) {
                capture_pending = true;
                req.instruction     = compute_instruction;
                req.op              = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx       = (compute_instruction >> 8) & 0xFFu;
                req.head_idx        = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx        = static_cast<uint16_t>((compute_instruction >> 24) & 0xFFFFu);
                next_state = ComputeState::CAPTURE_INSTRUCTION;
                break;
            }
            capture_pending = false;
            // This state is now merged into IDLE.
            // Check from proper op request
            if (req.op == ComputeOp::CMP_OUT_PROJ || 
                req.op == ComputeOp::CMP_RESID1 || 
                req.op == ComputeOp::CMP_LN0 || 
                req.op == ComputeOp::CMP_FFN_W1 || 
                req.op == ComputeOp::CMP_FFN_ACT || 
                req.op == ComputeOp::CMP_FFN_W2 || 
                req.op == ComputeOp::CMP_RESID2 || 
                req.op == ComputeOp::CMP_LN1 || 
                req.op == ComputeOp::CMP_FINAL_NORM ||
                req.op == ComputeOp::CMP_LOGITS ||
                req.op == ComputeOp::CMP_ARGMAX) {
                
                error = false; // Clear stale errors on a new request.
                next_state = ComputeState::WAIT_MEM;
            } else {
                error = true;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::WAIT_MEM: {
            mem_read_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_read_request = false;
                next_state = ComputeState::EXECUTE;
            }
            break;
        }
        case ComputeState::EXECUTE: {
            switch (req.op) {
                case ComputeOp::CMP_OUT_PROJ:       // Q0.7   -> Q0.7   [After Headed Attention, requant in-op]
                {
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_RESID1:         // Q0.7   -> Q0.7    [After OutputProj] 
                case ComputeOp::CMP_RESID2:{        // Q0.7   -> Q0.7    [After FFN] 
                    RES_ADD_TO_BUF(req.op, req.layer_idx, in_buf, out_buf);
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_LN0:            // Q0.7    -> Q0.7    [requant in-op]
                case ComputeOp::CMP_LN1: {          // Q0.7    -> Q0.7    [requant in-op]
                    int layer = static_cast<int>(req.layer_idx);
                    if (layer < 0 || layer >= MODEL_LAYERS) {
                        layer = 0;
                    }
                    int32_t M = 0;
                    int32_t n = 0;
                    switch (req.op) {
                        case ComputeOp::CMP_LN0:
                            M = requant_params::REQUANT1_M_L[layer];
                            n = requant_params::REQUANT1_N_L[layer];
                            break;
                        case ComputeOp::CMP_LN1:
                            M = requant_params::REQUANT3_M_L[layer];
                            n = requant_params::REQUANT3_N_L[layer];
                            break;
                        default:
                            M = 0;
                            n = 0;
                            break;
                    }
                    LAYER_NORM_TO_BUF(req.op, req.layer_idx, in_buf, out_buf, false,
                                    M, n);
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_FINAL_NORM: {   // Q0.7    -> Q19.13
                    LAYER_NORM_TO_BUF(req.op, req.layer_idx, in_buf, out_buf, true,
                                    0, 0);
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_LOGITS: {       // Q19.13 -> Qacc vocab tile
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_ARGMAX: {       // logits packed -> token id
                    ARGMAX_TO_BUF(req.layer_idx, in_buf, out_buf);
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_FFN_W1:{        // Q0.7    -> Qacc     -> Q1.15    [First FFN stage]
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_FFN_ACT:{       // Q1.15   -> Q1.15     [FFN GELU activation]
                    FFN_ACT_Gelu_TO_BUF(req.layer_idx, req.tile_idx, in_buf, out_buf);
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_FFN_W2:{        // Q1.15   -> Q0.7      [Second FFN stage, requant in-op]
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                default:
                    error = true;
                    next_state = ComputeState::DONE;
                    break;
            }
            MAC_OP_TO_BUF(mac_start, mac_ready, req.op, req.layer_idx,
                          req.tile_idx, in_buf, mac_complete, out_buf);
            break;
        }
        case ComputeState::MEM_WRITEBACK: {
            mem_write_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_write_request = false;
                mem_op = 0;
                mac_complete = false;
                clear_pending = true;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::DONE: {
            // One-cycle done pulse; fall back to idle.
            req.instruction     = 0;
            req.op              = static_cast<ComputeOp>(0);
            req.layer_idx       = 0;
            req.head_idx        = 0;
            req.tile_idx        = 0;
            next_state = ComputeState::IDLE;
            break;
        }
    }

    state = next_state;

    dbg_state = state;
    dbg_req_instruction = req.instruction;
    dbg_req_op = static_cast<uint8_t>(req.op);
    dbg_req_layer = req.layer_idx;
    dbg_req_head = req.head_idx;
    dbg_req_tile = req.tile_idx;
    dbg_mac_start = mac_start;
    dbg_mac_ready = mac_ready;
    dbg_mac_complete = mac_complete;
}
