#include "compute_controller.hpp"
#include <ap_fixed.h>
#include <climits>
#include <hls_math.h>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

static inline int8_t requant_scalar_to_i8(const int32_t x32, const int32_t M, const int32_t n);
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
    // NOTE: `CMP_ARGMAX` consumes per-tile pairs (max_val: i32, local_idx: i32),
    // not a dense D_VOCAB logits vector. Dumping D_VOCAB entries here is both
    // incorrect and can read past `in_buf` (CSim SIGSEGV).
    static_assert((compute_buf::INArgmaxLayout::X + (NUM_LOGIT_TILES * 8) - 1) <
                      compute_buf::IN_BUF_BYTES,
                  "Argmax trace expects NUM_LOGIT_TILES * 8 bytes in in_buf");

    const int32_t best_idx = compute_buf::read_i32(out_buf, compute_buf::OUTArgmaxLayout::Y);
    std::printf("[COMPUTE IO] op=CMP_ARGMAX layer=%u out_idx=%d tiles=%d\n",
                static_cast<unsigned>(layer_idx),
                best_idx,
                static_cast<int>(NUM_LOGIT_TILES));

    const int tiles_to_print = (NUM_LOGIT_TILES < 16) ? NUM_LOGIT_TILES : 16;
    for (int tile = 0; tile < tiles_to_print; ++tile) {
        const int32_t tile_val = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8);
        const int32_t tile_local_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8 + 4);
        std::printf("  tile[%d] max=%d local_idx=%d global_idx=%d\n",
                    tile,
                    tile_val,
                    tile_local_idx,
                    (tile * D_TILE_LOGIT) + tile_local_idx);
    }
    if (NUM_LOGIT_TILES > tiles_to_print) {
        const int tile = NUM_LOGIT_TILES - 1;
        const int32_t tile_val = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8);
        const int32_t tile_local_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8 + 4);
        std::printf("  tile[%d] max=%d local_idx=%d global_idx=%d\n",
                    tile,
                    tile_val,
                    tile_local_idx,
                    (tile * D_TILE_LOGIT) + tile_local_idx);
    }
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

// ---------------------------------------------------------------------------
// Specialized MAC dispatch functions (one per activation data type).
// Each keeps its own correctly-sized, correctly-typed local arrays so HLS
// can infer the minimum-width multiplier for that op class.
// ---------------------------------------------------------------------------

// int8 x int8 -> int32 : CMP_OUT_PROJ, CMP_FFN_W1
static void MAC_I8I8_DISPATCH(
    ComputeOp op,
    uint8_t layer_idx,
    uint16_t tile_idx,
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int8_t  vecA[VECTOR_MAX_I8I8];
    int8_t  matB[MATRIX_MAX_I8I8];
    int32_t bias[ACCUM_MAX_I8I8];
    int32_t accum[ACCUM_MAX_I8I8];
#pragma HLS ARRAY_PARTITION variable=vecA cyclic factor=MAC_I8I8_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matB cyclic factor=MAC_I8I8_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=MAC_I8I8_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=accum cyclic factor=MAC_I8I8_OUT_UNROLL dim=1

    int vec_count = 0, out_count = 0, act_base = 0, w_base = 0, b_base = 0;
    switch (op) {
        case ComputeOp::CMP_OUT_PROJ:
            vec_count = D_MODEL;  out_count = D_TILE_WO;
            act_base  = compute_buf::INOutProjLayout::ACT;
            w_base    = compute_buf::INOutProjLayout::W;
            b_base    = compute_buf::INOutProjLayout::B;
            break;
        case ComputeOp::CMP_FFN_W1:
            vec_count = D_MODEL;  out_count = D_TILE_W1;
            act_base  = compute_buf::INFfnW1Layout::X;
            w_base    = compute_buf::INFfnW1Layout::W;
            b_base    = compute_buf::INFfnW1Layout::B;
            break;
        default: return;
    }

    // Stage activations (int8)
    for (int i = 0; i < VECTOR_MAX_I8I8; ++i) {
#pragma HLS UNROLL factor=MAC_I8I8_VEC_UNROLL
        vecA[i] = (i < vec_count) ? compute_buf::read_i8(in_buf, act_base + i) : int8_t(0);
    }
    // Stage bias (int32)
    for (int out = 0; out < ACCUM_MAX_I8I8; ++out) {
#pragma HLS UNROLL factor=MAC_I8I8_OUT_UNROLL
        bias[out] = (out < out_count) ? compute_buf::read_i32(in_buf, b_base + out * 4) : 0;
    }
    // Stage weight matrix
    for (int out = 0; out < ACCUM_MAX_I8I8; ++out) {
        for (int i = 0; i < VECTOR_MAX_I8I8; ++i) {
#pragma HLS UNROLL factor=MAC_I8I8_VEC_UNROLL
            matB[out * VECTOR_MAX_I8I8 + i] =
                (out < out_count && i < vec_count)
                    ? compute_buf::read_i8(in_buf, w_base + out * vec_count + i)
                    : int8_t(0);
        }
    }
    // Compute (int8 x int8 -> int32 accumulator)
    for (int out = 0; out < ACCUM_MAX_I8I8; ++out) {
#pragma HLS UNROLL factor=MAC_I8I8_OUT_UNROLL
        int32_t acc = bias[out];
        for (int i = 0; i < VECTOR_MAX_I8I8; ++i) {
#pragma HLS UNROLL factor=MAC_I8I8_VEC_UNROLL
            acc += static_cast<int32_t>(vecA[i]) * static_cast<int32_t>(matB[out * VECTOR_MAX_I8I8 + i]);
        }
        accum[out] = acc;
    }

    int layer = static_cast<int>(layer_idx);
    if (layer >= MODEL_LAYERS) layer = 0;
    int32_t trace_M = 0, trace_n = 0;

    // Write outputs
    for (int out = 0; out < ACCUM_MAX_I8I8; ++out) {
#pragma HLS UNROLL factor=MAC_I8I8_OUT_UNROLL
        if (out >= out_count) continue;
        switch (op) {
            case ComputeOp::CMP_OUT_PROJ: {
                const int32_t M = requant_params::REQUANT2_M_L[layer];
                const int32_t n = requant_params::REQUANT2_N_L[layer];
                trace_M = M;  trace_n = n;
                compute_buf::write_i8(out_buf, out, requant_scalar_to_i8(accum[out], M, n));
                break;
            }
            case ComputeOp::CMP_FFN_W1: {
                const int64_t prod =
                    static_cast<int64_t>(accum[out]) *
                    static_cast<int64_t>(requant_scales::FFN_W1_SCALE_Q15);
                const int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
                int32_t scaled = static_cast<int32_t>(rounded >> 15);
                if (scaled >  32767) scaled =  32767;
                else if (scaled < -32768) scaled = -32768;
                compute_buf::write_i16(out_buf, out * 2, static_cast<int16_t>(scaled));
                break;
            }
            default: break;
        }
    }
#ifndef __SYNTHESIS__
    trace_mac_op_outputs(op, layer_idx, tile_idx, accum, out_count, out_buf, trace_M, trace_n);
#endif
}

// int16 x int8 -> int32 : CMP_FFN_W2
static void MAC_I16I8_DISPATCH(
    ComputeOp op,
    uint8_t layer_idx,
    uint16_t tile_idx,
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int16_t vecA[VECTOR_MAX_I16I8];
    int8_t  matB[MATRIX_MAX_I16I8];
    int32_t bias[ACCUM_MAX_I16I8];
    int32_t accum[ACCUM_MAX_I16I8];
#pragma HLS ARRAY_PARTITION variable=vecA cyclic factor=MAC_I16I8_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matB cyclic factor=MAC_I16I8_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=MAC_I16I8_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=accum cyclic factor=MAC_I16I8_OUT_UNROLL dim=1

    const int vec_count = D_FFN;
    const int out_count = D_TILE_W2;

    // Stage activations (int16)
    for (int i = 0; i < VECTOR_MAX_I16I8; ++i) {
#pragma HLS UNROLL factor=MAC_I16I8_VEC_UNROLL
        vecA[i] = compute_buf::read_i16(in_buf, compute_buf::INFfnW2Layout::X + i * 2);
    }
    // Stage bias (int32)
    for (int out = 0; out < ACCUM_MAX_I16I8; ++out) {
#pragma HLS UNROLL factor=MAC_I16I8_OUT_UNROLL
        bias[out] = compute_buf::read_i32(in_buf, compute_buf::INFfnW2Layout::B + out * 4);
    }
    // Stage weight matrix
    for (int out = 0; out < ACCUM_MAX_I16I8; ++out) {
        for (int i = 0; i < VECTOR_MAX_I16I8; ++i) {
#pragma HLS UNROLL factor=MAC_I16I8_VEC_UNROLL
            matB[out * VECTOR_MAX_I16I8 + i] =
                compute_buf::read_i8(in_buf, compute_buf::INFfnW2Layout::W + out * vec_count + i);
        }
    }
    // Compute (int16 x int8 -> int32 accumulator)
    for (int out = 0; out < ACCUM_MAX_I16I8; ++out) {
#pragma HLS UNROLL factor=MAC_I16I8_OUT_UNROLL
        int32_t acc = bias[out];
        for (int i = 0; i < VECTOR_MAX_I16I8; ++i) {
#pragma HLS UNROLL factor=MAC_I16I8_VEC_UNROLL
            acc += static_cast<int32_t>(vecA[i]) * static_cast<int32_t>(matB[out * VECTOR_MAX_I16I8 + i]);
        }
        accum[out] = acc;
    }

    int layer = static_cast<int>(layer_idx);
    if (layer >= MODEL_LAYERS) layer = 0;
    const int32_t M = requant_params::REQUANT4_M_L[layer];
    const int32_t n = requant_params::REQUANT4_N_L[layer];

    for (int out = 0; out < ACCUM_MAX_I16I8; ++out) {
#pragma HLS UNROLL factor=MAC_I16I8_OUT_UNROLL
        compute_buf::write_i8(out_buf, out, requant_scalar_to_i8(accum[out], M, n));
    }
#ifndef __SYNTHESIS__
    trace_mac_op_outputs(op, layer_idx, tile_idx, accum, out_count, out_buf, M, n);
#endif
}

// int32 x int8 -> int32 : CMP_LOGITS (argmax tracking, no bias)
static void MAC_I32I8_DISPATCH(
    ComputeOp op,
    uint8_t layer_idx,
    uint16_t tile_idx,
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int32_t vecA[VECTOR_MAX_I32I8];
    int8_t  matB[MATRIX_MAX_I32I8];
    int32_t accum[ACCUM_MAX_I32I8];
#pragma HLS ARRAY_PARTITION variable=vecA cyclic factor=MAC_I32I8_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matB cyclic factor=MAC_I32I8_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=accum cyclic factor=MAC_I32I8_OUT_UNROLL dim=1

    const int vec_count = D_MODEL;
    const int out_count = D_TILE_LOGIT;
    // Mask padded vocab rows in the final tile:
    //   tile_base = tile_idx * D_TILE_LOGIT
    //   valid_outs = clamp(D_VOCAB - tile_base, 0..D_TILE_LOGIT)
    // Padding must not participate in argmax or it can win when all valid logits
    // are negative (observed as out-of-range token IDs like 50257).
    const int tile_base = static_cast<int>(tile_idx) * D_TILE_LOGIT;
    int valid_outs = D_VOCAB - tile_base;
    if (valid_outs < 0) valid_outs = 0;
    if (valid_outs > D_TILE_LOGIT) valid_outs = D_TILE_LOGIT;

    // Stage activations (int32)
    for (int i = 0; i < VECTOR_MAX_I32I8; ++i) {
#pragma HLS UNROLL factor=MAC_I32I8_VEC_UNROLL
        vecA[i] = compute_buf::read_i32(in_buf, compute_buf::INLogitsLayout::X + i * 4);
    }
    // Stage weight matrix
    for (int out = 0; out < ACCUM_MAX_I32I8; ++out) {
        for (int i = 0; i < VECTOR_MAX_I32I8; ++i) {
#pragma HLS UNROLL factor=MAC_I32I8_VEC_UNROLL
            matB[out * VECTOR_MAX_I32I8 + i] =
                compute_buf::read_i8(in_buf, compute_buf::INLogitsLayout::W + out * vec_count + i);
        }
    }
    // Compute (int32 x int8 -> int32 accumulator, no bias)
    // vecA is Q19.13 with real magnitude up to ~30 (raw ~245760).
    // Without prescaling: 768 * 245760 * 127 ≈ 24B > INT32_MAX → overflow.
    // Pre-shift vecA right by 8 before accumulating: max sum ≈ 768 * 960 * 127 ≈ 94M < INT32_MAX.
    // Ordering is fully preserved (monotonic shift), so argmax result is identical.
    static constexpr int LOGIT_VEC_PRESCALE_SHIFT = 8;
    for (int out = 0; out < ACCUM_MAX_I32I8; ++out) {
#pragma HLS UNROLL factor=MAC_I32I8_OUT_UNROLL
        int32_t acc = 0;
        for (int i = 0; i < VECTOR_MAX_I32I8; ++i) {
#pragma HLS UNROLL factor=MAC_I32I8_VEC_UNROLL
            acc += (vecA[i] >> LOGIT_VEC_PRESCALE_SHIFT) * static_cast<int32_t>(matB[out * VECTOR_MAX_I32I8 + i]);
        }
        accum[out] = acc;
    }

    // Argmax reduction
    int32_t logit_best_val = INT32_MIN;
    int32_t logit_best_local_idx = 0;
    for (int out = 0; out < out_count; ++out) {
#pragma HLS UNROLL factor=MAC_I32I8_OUT_UNROLL
        const int32_t candidate = (out < valid_outs) ? accum[out] : INT32_MIN;
        if (candidate > logit_best_val) {
            logit_best_val = candidate;
            logit_best_local_idx = out;
        }
    }
    compute_buf::write_i32(out_buf, 0, logit_best_val);
    compute_buf::write_i32(out_buf, 4, logit_best_local_idx);
#ifndef __SYNTHESIS__
    trace_mac_op_outputs(op, layer_idx, tile_idx, accum, out_count, out_buf, 0, 0);
#endif
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

    ready = (!busy) && (!start);
    complete = compute_done;

    const bool do_compute = (!busy && start);
    if (do_compute) {
        busy = true;
        compute_done = false;
        switch (op) {
            case ComputeOp::CMP_OUT_PROJ:
            case ComputeOp::CMP_FFN_W1:
                MAC_I8I8_DISPATCH(op, layer_idx, tile_idx, in_buf, out_buf);
                break;
            case ComputeOp::CMP_FFN_W2:
                MAC_I16I8_DISPATCH(op, layer_idx, tile_idx, in_buf, out_buf);
                break;
            case ComputeOp::CMP_LOGITS:
                MAC_I32I8_DISPATCH(op, layer_idx, tile_idx, in_buf, out_buf);
                break;
            default:
                break;
        }
        compute_done = true;
    } else if (compute_done) {
        compute_done = false;
        busy = false;
    }
}
// ---------------------------------------------------------------------------
// Compute kernels
// ---------------------------------------------------------------------------
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
    int8_t x_local[D_MODEL];
    int8_t r_local[D_MODEL];
#pragma HLS ARRAY_PARTITION variable=x_local cyclic factor=RES_ADD_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=r_local cyclic factor=RES_ADD_TO_BUF_VEC_UNROLL dim=1

    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL factor=RES_ADD_TO_BUF_VEC_UNROLL
        x_local[i] = compute_buf::read_i8(in_buf, compute_buf::INResidLayout::X + i);
        r_local[i] = compute_buf::read_i8(in_buf, compute_buf::INResidLayout::R + i);
    }

    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL factor=RES_ADD_TO_BUF_VEC_UNROLL
        const int16_t sum = static_cast<int16_t>(x_local[i]) + static_cast<int16_t>(r_local[i]);
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
    int16_t gate_local[D_FFN];
    int16_t out_local[D_FFN];
#pragma HLS ARRAY_PARTITION variable=gate_local cyclic factor=FFN_ACT_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=out_local  cyclic factor=FFN_ACT_TO_BUF_VEC_UNROLL dim=1

    // Stage 1: load from in_buf into partitioned staging array
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS UNROLL factor=FFN_ACT_TO_BUF_VEC_UNROLL
        gate_local[i] = compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2));
    }

    // Stage 2: parallel GELU — both arrays are cyclic-partitioned so
    // FFN_ACT_TO_BUF_VEC_UNROLL independent GELU lanes can execute simultaneously
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS UNROLL factor=FFN_ACT_TO_BUF_VEC_UNROLL
        out_local[i] = gelu_q15(gate_local[i]);
    }

    // Stage 3: write results back to out_buf
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS UNROLL factor=FFN_ACT_TO_BUF_VEC_UNROLL
        compute_buf::write_i16(out_buf, compute_buf::OUTFfnActLayout::Y + (i * 2), out_local[i]);
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
    int32_t best_local_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + 4);
    int32_t best_global_idx = best_local_idx; // tile 0 => global == local

    // Defensive: if tile 0 local_idx is invalid, ignore it.
    {
        const int tile_base = 0;
        int valid_outs = D_VOCAB - tile_base;
        if (valid_outs < 0) valid_outs = 0;
        if (valid_outs > D_TILE_LOGIT) valid_outs = D_TILE_LOGIT;
        if (best_local_idx < 0 || best_local_idx >= valid_outs) {
            best_val = INT32_MIN;
            best_global_idx = 0;
        }
    }
    for (int tile = 1; tile < NUM_LOGIT_TILES; ++tile) {
        const int32_t tile_local_idx = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8 + 4);
        int32_t tile_val = compute_buf::read_i32(in_buf, compute_buf::INArgmaxLayout::X + tile * 8);

        // Mask padded entries in the final logits tile (and any invalid local_idx values).
        const int tile_base = tile * D_TILE_LOGIT;
        int valid_outs = D_VOCAB - tile_base;
        if (valid_outs < 0) valid_outs = 0;
        if (valid_outs > D_TILE_LOGIT) valid_outs = D_TILE_LOGIT;
        if (tile_local_idx < 0 || tile_local_idx >= valid_outs) {
            tile_val = INT32_MIN;
        }

        if (tile_val > best_val) {
            best_val = tile_val;
            best_global_idx = tile_base + tile_local_idx;
        }
    }

    // Final sentinel clamp: should never trigger if masks above are correct.
#ifndef __SYNTHESIS__
    if (best_global_idx < 0) {
        std::printf("[ERROR] ARGMAX produced negative index=%d (clamping to 0)\n", best_global_idx);
        best_global_idx = 0;
    }
    if (best_global_idx >= D_VOCAB) {
        std::printf("[ERROR] ARGMAX produced out-of-range index=%d (D_VOCAB=%d). Clamping to %d.\n",
                    best_global_idx, D_VOCAB, D_VOCAB - 1);
        best_global_idx = D_VOCAB - 1;
    }
#endif

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
    // Output format is Q16.16 in `scaled_bits` (raw ap_fixed bits).
    // For the final_norm=true path, scaled_bits is right-shifted by 3 before writing
    // (Q16.16 >> 3 = Q19.13) to keep the CMP_LOGITS int32 MAC accumulator in range.
    //
    // DDR packing formats (matching test_data/test_gpt2_int8.py):
    //   - gamma/beta are Q16.16 stored as int32 — bit-cast directly, no conversion needed
    //   - eps is Q0.32 stored as uint32, representing eps_real (e.g. 1e-5)
    //
    // Internal LN math operates directly on the int8 activation domain (no explicit /2^7),
    // so eps must be mapped into the same variance units:
    //   x_real = x_i8 / 2^7  => var_real = var_i8 / 2^14
    //   eps_var_units = eps_real * 2^14 = (eps_q0_32 / 2^32) * 2^14 = eps_q0_32 / 2^18
    // NOTE: use wider intermediates here to avoid overflow when converting large
    // accumulators (e.g. `sumsq`) into fixed-point.
    using ln_acc_t = ap_fixed<48, 28>;

    const ln_acc_t eps_q0_32_to_var_scale = ln_acc_t(262144);      // 2^18 (must be representable)

    int32_t sum = 0;
    int32_t sumsq = 0;
    for (int i = 0; i < D_MODEL; ++i) {
// #pragma HLS PIPELINE II=1
        const int8_t x = compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i);
        sum += static_cast<int32_t>(x);
        sumsq += static_cast<int32_t>(x) * static_cast<int32_t>(x);
    }

    const int32_t epsilon = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::EPS);

    const ap_fixed<32, 16> mean = static_cast<ap_fixed<32, 16> >(ln_acc_t(sum) / D_MODEL);
    const ap_fixed<32, 16> ex2 = static_cast<ap_fixed<32, 16> >(ln_acc_t(sumsq) / D_MODEL);
    ap_fixed<32, 16> var = ex2 - (mean * mean);
    if (var < 0) {
        var = 0;
    }

    const ln_acc_t eps_var_units = ln_acc_t(static_cast<uint32_t>(epsilon)) / eps_q0_32_to_var_scale;
    ap_fixed<32, 16> v = var + static_cast<ap_fixed<32, 16> >(eps_var_units);
    if (v < 0) {
        v = 0;
    }
    // Guard against divide-by-zero in fixed-point sqrt() paths (CSim SIGFPE).
    // If v quantizes to 0, the normalized term is effectively 0 (x-mean is also ~0),
    // so falling back to inv_std=0 keeps output well-defined (y ~= beta).
    ap_fixed<32, 16> inv_std = 0;
    const ap_fixed<32, 16> stddev = hls::sqrt(v);

    // safe guarding against divide-by-zero in fixed-point reciprocal paths (CSim SIGFPE)
    if (stddev != 0) {
        inv_std = ap_fixed<32, 16>(1) / stddev;
    }

    // Simple, element-by-element LN. No tiling/unrolling: keep the datapath easy to reason about.
    for (int i = 0; i < D_MODEL; ++i) {
// #pragma HLS PIPELINE II=1
        const int8_t x = compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i);
        const int32_t gamma_bits = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4));
        const int32_t beta_bits = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::BETA + (i * 4));

        // Bit-cast Q16.16 packed params into ap_fixed (no numeric conversion).
        ap_fixed<32, 16> gamma_fx, beta_fx;
        gamma_fx.range(31, 0) = static_cast<uint32_t>(gamma_bits);
        beta_fx.range(31, 0)  = static_cast<uint32_t>(beta_bits);

        const ap_fixed<32, 16> normalized = (ap_fixed<32, 16>(x) - mean) * inv_std;
        const ap_fixed<32, 16> scaled = (normalized * gamma_fx) + beta_fx;
        const int32_t scaled_bits = static_cast<int32_t>(scaled.range(31, 0)); // Q16.16 raw bits

        if (final_norm) {
            // Right-shift Q16.16 → Q19.13 to keep CMP_LOGITS int32 accumulator in range
            const int32_t q19_13_bits = scaled_bits >> 3;
            compute_buf::write_i32(out_buf, compute_buf::OUTLayerNormLayout::X + (i * 4), q19_13_bits);
        } else {
            // Requant + clamp (saturate to int8) at the very end.
            compute_buf::write_i8(out_buf, compute_buf::OUTRequantLayout::X + i,
                                  requant_scalar_to_i8(scaled_bits, requant_M, requant_n));
        }
    }
#ifndef __SYNTHESIS__
    trace_layer_norm_buffers(op, layer_idx, in_buf, out_buf, final_norm, requant_M,
                           requant_n);
#endif
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
