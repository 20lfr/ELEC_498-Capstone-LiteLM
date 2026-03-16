#include "headed_compute_controller.hpp"
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

#ifndef __SYNTHESIS__
static const char *head_op_name(ComputeOp op) {
    switch (op) {
        case ComputeOp::CMP_Q: return "CMP_Q";
        case ComputeOp::CMP_K: return "CMP_K";
        case ComputeOp::CMP_V: return "CMP_V";
        case ComputeOp::CMP_ATT_SCORES: return "CMP_ATT_SCORES";
        case ComputeOp::CMP_VALUE_SCALE: return "CMP_VALUE_SCALE";
        case ComputeOp::CMP_SOFTMAX: return "CMP_SOFTMAX";
        case ComputeOp::CMP_ATT_VALUE: return "CMP_ATT_VALUE";
        case ComputeOp::CMP_HEAD_REQUANT: return "CMP_HEAD_REQUANT";
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

static void print_qkv_weight_matrix(const uint8_t in_buf[head_buf::IN_BUF_BYTES]) {
    std::printf("  weight[%d][%d]:\n", D_HEAD_TILE_QKV, D_MODEL);
    for (int r = 0; r < D_HEAD_TILE_QKV; ++r) {
        std::printf("  %02d:", r);
        for (int c = 0; c < D_MODEL; ++c) {
            const int w_idx = (r * D_MODEL) + c;
            const int8_t w = compute_buf::read_i8(in_buf, head_buf::INQkvLayout::W + w_idx);
            std::printf(" %d", static_cast<int>(w));
        }
        std::printf("\n");
    }
}

static void trace_qkv_buffers(ComputeOp op,
                              uint8_t layer_idx,
                              uint8_t head_idx,
                              uint16_t tile_idx,
                              const uint8_t in_buf[head_buf::IN_BUF_BYTES],
                              const uint8_t out_buf[head_buf::OUT_BUF_BYTES],
                              int32_t M,
                              int32_t n) {
    int8_t act[D_MODEL];
    int8_t y[D_HEAD_TILE_QKV];
    for (int i = 0; i < D_MODEL; ++i) {
        act[i] = compute_buf::read_i8(in_buf, head_buf::INQkvLayout::ACT + i);
    }
    for (int i = 0; i < D_HEAD_TILE_QKV; ++i) {
        y[i] = compute_buf::read_i8(out_buf, head_buf::OUTQkvLayout::Y + i);
    }
    std::printf("[HEAD IO] op=%s layer=%u head=%u tile=%u M=%d n=%d\n",
                head_op_name(op),
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(head_idx),
                static_cast<unsigned>(tile_idx),
                M,
                n);
    print_i8_vector("  act", act, D_MODEL);
    print_qkv_weight_matrix(in_buf);
    print_i8_vector("  out", y, D_HEAD_TILE_QKV);
}

static void trace_att_scores_buffers(uint8_t layer_idx,
                                     uint8_t head_idx,
                                     uint16_t tile_idx,
                                     const uint8_t in_buf[head_buf::IN_BUF_BYTES],
                                     const uint8_t out_buf[head_buf::OUT_BUF_BYTES]) {
    int8_t q[D_HEADS];
    int8_t k_cache[ATT_CTX_BLOCK * D_HEADS];
    int32_t y[ATT_CTX_BLOCK];
    for (int i = 0; i < D_HEADS; ++i) {
        q[i] = compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::Q + i);
    }
    for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
        for (int d = 0; d < D_HEADS; ++d) {
            k_cache[t * D_HEADS + d] =
                compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::K_CACHE +
                                             (t * D_HEADS) + d);
        }
        y[t] = compute_buf::read_i32(out_buf, head_buf::OUTAttScoresLayout::X + (t * 4));
    }
    std::printf("[HEAD IO] op=CMP_ATT_SCORES layer=%u head=%u tile=%u\n",
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(head_idx),
                static_cast<unsigned>(tile_idx));
    print_i8_vector("  q", q, D_HEADS);
    print_i8_matrix("  k_cache", k_cache, ATT_CTX_BLOCK, D_HEADS, D_HEADS);
    print_i32_vector("  out", y, ATT_CTX_BLOCK);
}

static void trace_value_scale_buffers(uint8_t layer_idx,
                                      uint8_t head_idx,
                                      const uint8_t in_buf[head_buf::IN_BUF_BYTES],
                                      const uint8_t out_buf[head_buf::OUT_BUF_BYTES]) {
    int32_t x[CONTEXT_LENGTH];
    int16_t y[CONTEXT_LENGTH];
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
        x[i] = compute_buf::read_i32(in_buf, head_buf::INValueScaleLayout::X + (i * 4));
        y[i] = compute_buf::read_i16(out_buf, head_buf::OUTValueScaleLayout::X + (i * 2));
    }
    std::printf("[HEAD IO] op=CMP_VALUE_SCALE layer=%u head=%u\n",
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(head_idx));
    print_i32_vector("  x", x, CONTEXT_LENGTH);
    print_i16_vector("  out", y, CONTEXT_LENGTH);
}

static void trace_softmax_buffers(uint8_t layer_idx,
                                  uint8_t head_idx,
                                  const uint8_t in_buf[head_buf::IN_BUF_BYTES],
                                  const uint8_t out_buf[head_buf::OUT_BUF_BYTES]) {
    int16_t x[CONTEXT_LENGTH];
    int16_t y[CONTEXT_LENGTH];
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
        x[i] = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + (i * 2));
        y[i] = compute_buf::read_i16(out_buf, head_buf::OUTSoftmaxLayout::X + (i * 2));
    }
    std::printf("[HEAD IO] op=CMP_SOFTMAX layer=%u head=%u\n",
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(head_idx));
    print_i16_vector("  x", x, CONTEXT_LENGTH);
    print_i16_vector("  out", y, CONTEXT_LENGTH);
}

static void trace_att_value_buffers(uint8_t layer_idx,
                                    uint8_t head_idx,
                                    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
                                    const uint8_t out_buf[head_buf::OUT_BUF_BYTES]) {
    int16_t weights[CONTEXT_LENGTH];
    int8_t v_cache[D_HEAD_TILE_ATT_VALUE * CONTEXT_LENGTH];
    int32_t y[D_HEAD_TILE_ATT_VALUE];
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        weights[t] = compute_buf::read_i16(in_buf, head_buf::INAttValueLayout::WEIGHTS + (t * 2));
    }
    for (int r = 0; r < D_HEAD_TILE_ATT_VALUE; ++r) {
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            v_cache[r * CONTEXT_LENGTH + t] =
                compute_buf::read_i8(in_buf, head_buf::INAttValueLayout::V_CACHE +
                                             (r * CONTEXT_LENGTH) + t);
        }
        y[r] = compute_buf::read_i32(out_buf, head_buf::OUTAttValueLayout::Y + (r * 4));
    }
    std::printf("[HEAD IO] op=CMP_ATT_VALUE layer=%u head=%u\n",
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(head_idx));
    print_i16_vector("  weights", weights, CONTEXT_LENGTH);
    print_i8_matrix("  v_cache", v_cache, D_HEAD_TILE_ATT_VALUE, CONTEXT_LENGTH,
                    CONTEXT_LENGTH);
    print_i32_vector("  out", y, D_HEAD_TILE_ATT_VALUE);
}

static void trace_head_requant_buffers(uint8_t layer_idx,
                                       uint8_t head_idx,
                                       const uint8_t in_buf[head_buf::IN_BUF_BYTES],
                                       const uint8_t out_buf[head_buf::OUT_BUF_BYTES],
                                       int32_t M,
                                       int32_t n) {
    int32_t x[D_HEADS];
    int8_t y[D_HEADS];
    for (int i = 0; i < D_HEADS; ++i) {
        x[i] = compute_buf::read_i32(in_buf, head_buf::INHeadRequantLayout::X + (i * 4));
        y[i] = compute_buf::read_i8(out_buf, head_buf::OUTHeadRequantLayout::X + i);
    }
    std::printf("[HEAD IO] op=CMP_HEAD_REQUANT layer=%u head=%u M=%d n=%d\n",
                static_cast<unsigned>(layer_idx),
                static_cast<unsigned>(head_idx),
                M,
                n);
    print_i32_vector("  x", x, D_HEADS);
    print_i8_vector("  out", y, D_HEADS);
}
#endif

void VALUE_SCALE_CLAMP(
    const int32_t input[CONTEXT_LENGTH],
    int16_t output[CONTEXT_LENGTH]         // Q1.15
) {
#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=input cyclic factor=VALUE_SCALE_CLAMP_CTX_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=output cyclic factor=VALUE_SCALE_CLAMP_CTX_UNROLL dim=1
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        int64_t prod = static_cast<int64_t>(input[i]) * static_cast<int64_t>(ATTN_SCALE_Q15); // Q2.30
        int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
        int32_t scaled = static_cast<int32_t>(rounded >> 15); // back to Q1.15
        if (scaled > 32767) {
            scaled = 32767;
        } else if (scaled < -32768) {
            scaled = -32768;
        }
        output[i] = static_cast<int16_t>(scaled);
    }
}

// Approximate exp(x) for x in Q1.15 integer units, clamped to [-65535, 0], output in Q1.15.
// LUT covers [-2.0, 0.0] real ([-65535, 0] Q1.15 integer), 257 entries, step 256.
// LUT[0]=exp(-2), LUT[128]=exp(-1), LUT[256]=exp(0)=1.0
inline uint16_t exp_approx_q15(int32_t x) {
#pragma HLS INLINE
    static const uint16_t exp_lut_q15[257] = {
        4435,4469,4505,4540,4575,4611,4647,4684,
        4721,4758,4795,4833,4871,4909,4947,4986,
        5025,5065,5104,5144,5185,5225,5266,5308,
        5349,5391,5433,5476,5519,5562,5606,5650,
        5694,5739,5784,5829,5875,5921,5967,6014,
        6061,6109,6157,6205,6254,6303,6352,6402,
        6452,6503,6554,6605,6657,6709,6762,6815,
        6869,6922,6977,7031,7087,7142,7198,7255,
        7312,7369,7427,7485,7544,7603,7662,7723,
        7783,7844,7906,7968,8030,8093,8157,8221,
        8285,8350,8416,8482,8548,8615,8683,8751,
        8819,8889,8958,9029,9099,9171,9243,9315,
        9388,9462,9536,9611,9686,9762,9839,9916,
        9994,10072,10151,10231,10311,10392,10473,10555,
        10638,10722,10806,10890,10976,11062,11149,11236,
        11324,11413,11503,11593,11684,11775,11868,11961,
        12055,12149,12245,12341,12437,12535,12633,12732,
        12832,12933,13034,13136,13239,13343,13448,13553,
        13660,13767,13875,13984,14093,14204,14315,14428,
        14541,14655,14770,14886,15002,15120,15239,15358,
        15479,15600,15722,15846,15970,16095,16221,16349,
        16477,16606,16736,16868,17000,17133,17268,17403,
        17539,17677,17816,17955,18096,18238,18381,18525,
        18671,18817,18965,19113,19263,19414,19567,19720,
        19875,20031,20188,20346,20506,20667,20829,20992,
        21157,21323,21490,21658,21828,21999,22172,22346,
        22521,22698,22876,23055,23236,23418,23602,23787,
        23974,24162,24351,24542,24735,24929,25124,25321,
        25520,25720,25922,26125,26330,26536,26744,26954,
        27166,27379,27593,27810,28028,28248,28469,28693,
        28918,29144,29373,29603,29836,30070,30305,30543,
        30783,31024,31267,31513,31760,32009,32260,32513,
        32767
    };
    if (x >= 0) {
        return 32767;
    }
    if (x < -65535) {
        return exp_lut_q15[0];
    }
    uint16_t idx = static_cast<uint16_t>((x - (-65535)) >> 8);
    return exp_lut_q15[idx];
}

void SOFTMAX(
    const int16_t input[CONTEXT_LENGTH],  // Q1.15 logits
    int16_t output[CONTEXT_LENGTH]        // Q1.15 probabilities (0..32767)
) {
#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=input cyclic factor=SOFTMAX_CTX_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=output cyclic factor=SOFTMAX_CTX_UNROLL dim=1

    const uint16_t ONE_Q15 = (1u << 15);     // 32768, ≈ 1.0
    const uint16_t MAX_Q15 = ONE_Q15 - 1;    // 32767

    // 1) Find max
    int16_t max_val = input[0];
    for (int i = 1; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        if (input[i] > max_val) {
            max_val = input[i];
        }
    }
    
    // 2) Compute exp_approx and sum
    uint16_t exp_buf[CONTEXT_LENGTH];
#pragma HLS ARRAY_PARTITION variable=exp_buf cyclic factor=SOFTMAX_CTX_UNROLL dim=1

    uint32_t sum_exp = 0;
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        int32_t diff = static_cast<int32_t>(input[i]) - static_cast<int32_t>(max_val);
        uint16_t e_q15 = exp_approx_q15(diff);   // Q1.15
        // uint16_t e_q15 = diff * 2;
        exp_buf[i] = e_q15;
        sum_exp += e_q15;                        // up to CONTEXT_LENGTH * 32767
    }

    // 3) Compute reciprocal of sum_exp in fixed-point (Q1.15)
    //   output = (e_q15 * inv_sum_q15) >> 15  -> Q1.15 again
    uint32_t inv_sum_q15 = 0;
    if (sum_exp > 0) {
        uint64_t num = (1ULL << 30);               // 2^30 = 2^15 (Q1.15) * 2^15 (reciprocal scale)
        inv_sum_q15 = static_cast<uint32_t>((num + (sum_exp / 2)) / sum_exp); // rounded
    }
    

    // 4) Final probabilities
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        uint64_t tmp = static_cast<uint64_t>(exp_buf[i]) * static_cast<uint64_t>(inv_sum_q15); // Q1.15 * Q1.15 = Q2.30
        uint16_t prob_q15 = static_cast<uint16_t>(tmp >> 15);                   // -> Q1.15

        if (prob_q15 > MAX_Q15) prob_q15 = MAX_Q15;
        output[i] = static_cast<int16_t>(prob_q15); // still non-negative, just stored in int16_t
    }
}

void REQUANT_D_HEADS_int32_to_int8(
    int32_t x32[D_HEADS],   // input vector
    int32_t M,              // integer multiplier               (Provided by PS)
    int32_t n,              // right shift                      (Provided by PS)
    int8_t y8[D_HEADS]      // output vector
) {
#pragma HLS INLINE

    for (int t = 0; t < D_HEADS; ++t) {
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

static inline int8_t requant_scalar_to_i8(
    int32_t x32,
    int32_t M,
    int32_t n
) {
#pragma HLS INLINE
    int64_t product = static_cast<int64_t>(x32) * static_cast<int64_t>(M);
    const bool do_shift = (n > 0) && (n < 63);
    int64_t rounded = do_shift ? (1LL << (n - 1)) : 0;
    int32_t scaled = do_shift ? static_cast<int32_t>((product + rounded) >> n)
                             : static_cast<int32_t>(product);

    if (scaled > 127) {
        return 127;
    }
    if (scaled < -128) {
        return -128;
    }
    return static_cast<int8_t>(scaled);
}

static void VALUE_SCALE_CLAMP_TO_BUF(
    uint8_t layer_idx,
    uint8_t head_idx,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t out_buf[head_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int32_t x_local[CONTEXT_LENGTH];
#pragma HLS ARRAY_PARTITION variable=x_local cyclic factor=VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL dim=1

    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS UNROLL factor=VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL
        x_local[t] = compute_buf::read_i32(in_buf, head_buf::INValueScaleLayout::X + (t * 4));
    }

    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS UNROLL factor=VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL
        int64_t prod = static_cast<int64_t>(x_local[t]) * static_cast<int64_t>(ATTN_SCALE_Q15);
        int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
        int32_t scaled = static_cast<int32_t>(rounded >> 15);
        if (scaled > 32767) {
            scaled = 32767;
        } else if (scaled < -32768) {
            scaled = -32768;
        }
        compute_buf::write_i16(out_buf, head_buf::OUTValueScaleLayout::X + (t * 2),
                               static_cast<int16_t>(scaled));
    }
#ifndef __SYNTHESIS__
    trace_value_scale_buffers(layer_idx, head_idx, in_buf, out_buf);
#endif
}

static void SOFTMAX_TO_BUF(
    uint8_t layer_idx,
    uint8_t head_idx,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t out_buf[head_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    const uint16_t MAX_Q15 = (1u << 15) - 1u;

    int16_t max_val = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X);
    for (int i = 1; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        const int16_t x = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + (i * 2));
        if (x > max_val) {
            max_val = x;
        }
    }

    uint32_t sum_exp = 0;
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        const int16_t x = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + (i * 2));
        const int32_t diff = static_cast<int32_t>(x) - static_cast<int32_t>(max_val);
        sum_exp += exp_approx_q15(diff);
    }

    uint32_t inv_sum_q15 = 0;
    if (sum_exp > 0) {
        const uint64_t num = (1ULL << 30);
        inv_sum_q15 = static_cast<uint32_t>((num + (sum_exp / 2)) / sum_exp);
    }

    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        const int16_t x = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + (i * 2));
        const int32_t diff = static_cast<int32_t>(x) - static_cast<int32_t>(max_val);
        uint64_t tmp = static_cast<uint64_t>(exp_approx_q15(diff)) * static_cast<uint64_t>(inv_sum_q15);
        uint16_t prob_q15 = static_cast<uint16_t>(tmp >> 15);
        if (prob_q15 > MAX_Q15) {
            prob_q15 = MAX_Q15;
        }
        compute_buf::write_i16(out_buf, head_buf::OUTSoftmaxLayout::X + (i * 2),
                               static_cast<int16_t>(prob_q15));
    }
#ifndef __SYNTHESIS__
    trace_softmax_buffers(layer_idx, head_idx, in_buf, out_buf);
#endif
}

static void ATT_VALUE_TO_BUF(
    uint8_t layer_idx,
    uint8_t head_idx,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t out_buf[head_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int16_t weight_local[CONTEXT_LENGTH];
    int8_t  v_local[D_HEAD_TILE_ATT_VALUE * CONTEXT_LENGTH];
    int32_t acc_out[D_HEAD_TILE_ATT_VALUE];
#pragma HLS ARRAY_PARTITION variable=weight_local cyclic factor=ATT_VALUE_TO_BUF_CTX_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=v_local      cyclic factor=ATT_VALUE_TO_BUF_CTX_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=acc_out      cyclic factor=ATT_VALUE_TO_BUF_OUT_UNROLL dim=1

    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS UNROLL factor=ATT_VALUE_TO_BUF_CTX_UNROLL
        weight_local[t] = compute_buf::read_i16(in_buf, head_buf::INAttValueLayout::WEIGHTS + (t * 2));
    }

    for (int d = 0; d < D_HEAD_TILE_ATT_VALUE; ++d) {
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS UNROLL factor=ATT_VALUE_TO_BUF_CTX_UNROLL
            v_local[d * CONTEXT_LENGTH + t] = compute_buf::read_i8(
                in_buf, head_buf::INAttValueLayout::V_CACHE + (d * CONTEXT_LENGTH) + t);
        }
    }

    for (int d = 0; d < D_HEAD_TILE_ATT_VALUE; ++d) {
#pragma HLS UNROLL factor=ATT_VALUE_TO_BUF_OUT_UNROLL
        int32_t acc = 0;
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS UNROLL factor=ATT_VALUE_TO_BUF_CTX_UNROLL
            acc += static_cast<int32_t>(weight_local[t]) *
                   static_cast<int32_t>(v_local[d * CONTEXT_LENGTH + t]);
        }
        acc_out[d] = acc;
    }

    for (int d = 0; d < D_HEAD_TILE_ATT_VALUE; ++d) {
#pragma HLS UNROLL factor=ATT_VALUE_TO_BUF_OUT_UNROLL
        compute_buf::write_i32(out_buf, head_buf::OUTAttValueLayout::Y + (d * 4), acc_out[d]);
    }
#ifndef __SYNTHESIS__
    trace_att_value_buffers(layer_idx, head_idx, in_buf, out_buf);
#endif
}

static inline void get_qkv_requant_params(
    ComputeOp op,
    uint8_t layer_idx,
    int32_t &M,
    int32_t &n
) {
#pragma HLS INLINE
    int layer = static_cast<int>(layer_idx);
    if (layer < 0 || layer >= MODEL_LAYERS) {
        layer = 0;
    }
    switch (op) {
        case ComputeOp::CMP_Q:
            M = requant_params::REQUANT_Q_M_L[layer];
            n = requant_params::REQUANT_Q_N_L[layer];
            break;
        case ComputeOp::CMP_K:
            M = requant_params::REQUANT_K_M_L[layer];
            n = requant_params::REQUANT_K_N_L[layer];
            break;
        case ComputeOp::CMP_V:
            M = requant_params::REQUANT_V_M_L[layer];
            n = requant_params::REQUANT_V_N_L[layer];
            break;
        default:
            M = 1;
            n = 0;
            break;
    }
}

static void QKV_TO_BUF(
    ComputeOp op,
    uint8_t layer_idx,
    uint8_t head_idx,
    uint16_t tile_idx,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t out_buf[head_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int32_t accum_tile[HEAD_MAC_OUT_UNROLL];
    int8_t  act_local[HEAD_MAC_VEC_UNROLL];
    int8_t  weight_tile[HEAD_MAC_OUT_UNROLL * HEAD_MAC_VEC_UNROLL];
#pragma HLS ARRAY_PARTITION variable=accum_tile   complete dim=1
#pragma HLS ARRAY_PARTITION variable=act_local    complete dim=1
#pragma HLS ARRAY_PARTITION variable=weight_tile  cyclic factor=QKV_TO_BUF_VEC_UNROLL dim=1

    int32_t M = 1;
    int32_t n = 0;
    get_qkv_requant_params(op, layer_idx, M, n);

    for (int out_base = 0; out_base < D_HEAD_TILE_QKV; out_base += HEAD_MAC_OUT_UNROLL) {
        // Init accum_tile from bias (serial: reads in_buf)
        for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
            const int out_idx = out_base + lane;
            if (out_idx < D_HEAD_TILE_QKV) {
                accum_tile[lane] = compute_buf::read_i32(in_buf, head_buf::INQkvLayout::B + (out_idx * 4));
            } else {
                accum_tile[lane] = 0;
            }
        }

        for (int in_base = 0; in_base < D_MODEL; in_base += HEAD_MAC_VEC_UNROLL) {
            // Load activation stripe into local register bank (serial: reads in_buf)
            for (int k = 0; k < HEAD_MAC_VEC_UNROLL; ++k) {
                const int in_idx = in_base + k;
                act_local[k] = (in_idx < D_MODEL)
                    ? compute_buf::read_i8(in_buf, head_buf::INQkvLayout::ACT + in_idx)
                    : int8_t(0);
            }

            // Load weight tile into local register bank (serial: reads in_buf)
            for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
                for (int k = 0; k < HEAD_MAC_VEC_UNROLL; ++k) {
                    const int out_idx = out_base + lane;
                    const int in_idx  = in_base  + k;
                    const bool valid  = (out_idx < D_HEAD_TILE_QKV) && (in_idx < D_MODEL);
                    const int w_idx   = (out_idx * D_MODEL) + in_idx;
                    weight_tile[lane * HEAD_MAC_VEC_UNROLL + k] = valid
                        ? compute_buf::read_i8(in_buf, head_buf::INQkvLayout::W + w_idx)
                        : int8_t(0);
                }
            }

            // MAC from local register banks
            for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
#pragma HLS UNROLL factor=HEAD_MAC_OUT_UNROLL
                const int out_idx = out_base + lane;
                if (out_idx < D_HEAD_TILE_QKV) {
                    for (int k = 0; k < HEAD_MAC_VEC_UNROLL; ++k) {
#pragma HLS UNROLL factor=QKV_TO_BUF_VEC_UNROLL
                        accum_tile[lane] += static_cast<int32_t>(act_local[k])
                                          * static_cast<int32_t>(weight_tile[lane * HEAD_MAC_VEC_UNROLL + k]);
                    }
                }
            }
        }

        // Write output (serial: writes out_buf)
        for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
            const int out_idx = out_base + lane;
            if (out_idx < D_HEAD_TILE_QKV) {
                const int8_t y = requant_scalar_to_i8(accum_tile[lane], M, n);
                compute_buf::write_i8(out_buf, head_buf::OUTQkvLayout::Y + out_idx, y);
            }
        }
    }
#ifndef __SYNTHESIS__
    trace_qkv_buffers(op, layer_idx, head_idx, tile_idx, in_buf, out_buf, M, n);
#endif
}

static void ATT_SCORES_TO_BUF(
    uint8_t layer_idx,
    uint8_t head_idx,
    uint16_t tile_idx,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t out_buf[head_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int8_t  q_local[D_HEADS];
    int8_t  k_local[ATT_CTX_BLOCK * D_HEADS];
    int32_t acc_tile[ATT_CTX_BLOCK];
#pragma HLS ARRAY_PARTITION variable=q_local  cyclic factor=ATT_SCORES_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=k_local  cyclic factor=ATT_SCORES_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=acc_tile cyclic factor=ATT_SCORES_TO_BUF_OUT_UNROLL dim=1

    for (int d = 0; d < D_HEADS; ++d) {
#pragma HLS UNROLL factor=ATT_SCORES_TO_BUF_VEC_UNROLL
        q_local[d] = compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::Q + d);
    }

    for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
        for (int d = 0; d < D_HEADS; ++d) {
#pragma HLS UNROLL factor=ATT_SCORES_TO_BUF_VEC_UNROLL
            k_local[t * D_HEADS + d] = compute_buf::read_i8(
                in_buf, head_buf::INAttScoresLayout::K_CACHE + (t * D_HEADS) + d);
        }
    }

    for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
#pragma HLS UNROLL factor=ATT_SCORES_TO_BUF_OUT_UNROLL
        int32_t acc = 0;
        for (int d = 0; d < D_HEADS; ++d) {
#pragma HLS UNROLL factor=ATT_SCORES_TO_BUF_VEC_UNROLL
            acc += static_cast<int32_t>(q_local[d]) *
                   static_cast<int32_t>(k_local[t * D_HEADS + d]);
        }
        acc_tile[t] = acc;
    }

    for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
#pragma HLS UNROLL factor=ATT_SCORES_TO_BUF_OUT_UNROLL
        compute_buf::write_i32(out_buf, head_buf::OUTAttScoresLayout::X + (t * 4), acc_tile[t]);
    }
#ifndef __SYNTHESIS__
    trace_att_scores_buffers(layer_idx, head_idx, tile_idx, in_buf, out_buf);
#endif
}

static void headed_compute_controller_lane(
    ComputeHeadCtx &ctx,
    bool        reset_n,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t       out_buf[head_buf::OUT_BUF_BYTES],
    ComputeState &dbg_state,
    uint64_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint16_t    &dbg_req_tile,
    bool        &error
) {
#pragma HLS INLINE

    // Outputs based on current state (before any transition).
    ctx.compute_ready = (ctx.state == ComputeState::IDLE);
    ctx.compute_done  = (ctx.state == ComputeState::DONE);
    ctx.mem_read_request   = false;
    ctx.mem_write_request  = false;
    ctx.mac_start = false;
    ctx.mac_ready = true;
    ctx.mac_complete = false;
    ctx.mac_busy = false;
    error = ctx.error_latched;

    if (!reset_n) {
        ctx.state = ComputeState::IDLE;
        error = false;
        ctx.error_latched = false;
        ctx.compute_ready = true;
        ctx.compute_done  = false;
        ctx.mem_read_request   = false;
        ctx.mem_write_request = false;
        ctx.mem_op        = 0;
        ctx.req = PendingRequest{};
        dbg_state = ctx.state;
        dbg_req_instruction = ctx.req.instruction;
        dbg_req_op = static_cast<uint8_t>(ctx.req.op);
        dbg_req_layer = ctx.req.layer_idx;
        dbg_req_head = ctx.req.head_idx;
        dbg_req_tile = ctx.req.tile_idx;

        ctx.mac_start = false;
        ctx.mac_ready = true;
        ctx.mac_complete = false;
        ctx.mac_busy = false;
        ctx.clear_pending = false;
        ctx.capture_pending = false;
        return;
    }

    ComputeState next_state = ctx.state;

    switch (ctx.state) {
        case ComputeState::IDLE: {
            if (ctx.compute_start) {
                ctx.mac_start = false;
                ctx.mac_complete = false;
                ctx.req.instruction    = ctx.compute_instruction;
                ctx.req.op            = static_cast<ComputeOp>(ctx.compute_instruction & 0xFFu);
                ctx.req.layer_idx     = (ctx.compute_instruction >> 8) & 0xFFu;
                ctx.req.head_idx      = (ctx.compute_instruction >> 16) & 0xFFu;
                ctx.req.tile_idx      = static_cast<uint16_t>((ctx.compute_instruction >> 24) & 0xFFFFu);
                next_state = ComputeState::CAPTURE_INSTRUCTION;
            }

            // look to clear while idling
            if (ctx.clear_pending && !ctx.compute_start) {
                for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
// #pragma HLS PIPELINE II=1
                    out_buf[i] = 0;
                }
                ctx.clear_pending = false;
            }
            break;
        }
        case ComputeState::CAPTURE_INSTRUCTION: {
            if (!ctx.capture_pending && ctx.compute_instruction != ctx.req.instruction) {
                ctx.capture_pending = true;
                ctx.req.instruction    = ctx.compute_instruction;
                ctx.req.op            = static_cast<ComputeOp>(ctx.compute_instruction & 0xFFu);
                ctx.req.layer_idx     = (ctx.compute_instruction >> 8) & 0xFFu;
                ctx.req.head_idx      = (ctx.compute_instruction >> 16) & 0xFFu;
                ctx.req.tile_idx      = static_cast<uint16_t>((ctx.compute_instruction >> 24) & 0xFFFFu);
                next_state = ComputeState::CAPTURE_INSTRUCTION;
                break;
            }
            ctx.capture_pending = false;
            if (ctx.req.op == ComputeOp::CMP_Q ||
                ctx.req.op == ComputeOp::CMP_K ||
                ctx.req.op == ComputeOp::CMP_V ||
                ctx.req.op == ComputeOp::CMP_ATT_SCORES ||
                ctx.req.op == ComputeOp::CMP_VALUE_SCALE ||
                ctx.req.op == ComputeOp::CMP_SOFTMAX ||
                ctx.req.op == ComputeOp::CMP_ATT_VALUE ||
                ctx.req.op == ComputeOp::CMP_HEAD_REQUANT) {
                ctx.error_latched = false; // Clear stale errors on a new request.
                error = false;
                next_state = ComputeState::WAIT_MEM;
            } else {
                ctx.error_latched = true;
                error = true;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::WAIT_MEM: {
            ctx.mem_read_request = true;
            ctx.mem_op = ctx.req.instruction;
            if (ctx.mem_transfer_done) {
                ctx.mem_read_request = false;
                // ctx.mem_op = 0;
                next_state = ComputeState::EXECUTE;
            }
            break;
        }
        case ComputeState::EXECUTE: {
            next_state = ComputeState::MEM_WRITEBACK;
            switch (ctx.req.op) {
                case ComputeOp::CMP_Q:              // Q0.7   -> Q0.7 (requant in-op)
                case ComputeOp::CMP_K:              // Q0.7   -> Q0.7 (requant in-op)
                case ComputeOp::CMP_V: {            // Q0.7   -> Q0.7 (requant in-op)
                    QKV_TO_BUF(ctx.req.op, ctx.req.layer_idx, ctx.req.head_idx,
                               ctx.req.tile_idx, in_buf,
                               out_buf);
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_HEAD_REQUANT:{  // Qacc   -> Q0.7    [After Attention Values]
                    int32_t M = 1;
                    int32_t n = 0;
                    int layer = static_cast<int>(ctx.req.layer_idx);
                    if (layer < 0 || layer >= MODEL_LAYERS) {
                        layer = 0;
                    }

                    // M and N mux
                    switch (ctx.req.op) {
                        case ComputeOp::CMP_HEAD_REQUANT:
                            M = requant_params::REQUANT_HEAD_M_L[layer];
                            n = requant_params::REQUANT_HEAD_N_L[layer];
                            break;
                        default:
                            break;
                    }
                    for (int h = 0; h < D_HEADS; ++h) {
// #pragma HLS PIPELINE II=1
                        const int32_t x = compute_buf::read_i32(in_buf, head_buf::INHeadRequantLayout::X + (h * 4));
                        compute_buf::write_i8(out_buf, head_buf::OUTHeadRequantLayout::X + h,
                                              requant_scalar_to_i8(x, M, n));
                    }
#ifndef __SYNTHESIS__
                    trace_head_requant_buffers(ctx.req.layer_idx, ctx.req.head_idx, in_buf,
                                               out_buf, M, n);
#endif
                    break;
                }
                case ComputeOp::CMP_ATT_SCORES: {   // Q0.7   -> Qacc
                    ATT_SCORES_TO_BUF(ctx.req.layer_idx, ctx.req.head_idx,
                                      ctx.req.tile_idx, in_buf, out_buf);
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_VALUE_SCALE: {  // Qacc   -> Q1.15
                    VALUE_SCALE_CLAMP_TO_BUF(ctx.req.layer_idx, ctx.req.head_idx, in_buf,
                                             out_buf);
                    break;
                }
                case ComputeOp::CMP_SOFTMAX: {      // Q1.15  -> Q1.15
                    SOFTMAX_TO_BUF(ctx.req.layer_idx, ctx.req.head_idx, in_buf, out_buf);
                    break;
                }
                case ComputeOp::CMP_ATT_VALUE: {    // Q1.15  -> Qacc
                    ATT_VALUE_TO_BUF(ctx.req.layer_idx, ctx.req.head_idx, in_buf, out_buf);
                    break;
                }      
                default:
                    ctx.error_latched = true;
                    error = true;
                    next_state = ComputeState::DONE;
                    break;
            }
            break;
        }
        case ComputeState::MEM_WRITEBACK: {
            ctx.mem_write_request = true;
            ctx.mem_op = ctx.req.instruction;
            if (ctx.mem_transfer_done) {
                ctx.mem_write_request = false;
                ctx.mem_op = 0;
                ctx.mac_complete = false;
                ctx.clear_pending = true;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::DONE: {
            // One-cycle done pulse; fall back to idle.
            ctx.req.instruction     = 0;
            ctx.req.op              = static_cast<ComputeOp>(0);
            ctx.req.layer_idx       = 0;
            ctx.req.head_idx        = 0;
            ctx.req.tile_idx        = 0;
            next_state = ComputeState::IDLE;
            break;
        }
    }

    ctx.state = next_state;

    dbg_state = ctx.state;
    dbg_req_instruction = ctx.req.instruction;
    dbg_req_op = static_cast<uint8_t>(ctx.req.op);
    dbg_req_layer = ctx.req.layer_idx;
    dbg_req_head = ctx.req.head_idx;
    dbg_req_tile = ctx.req.tile_idx;
}


void drive_headed_compute_controller(
    ComputeHeadCtx (&ctx)[HEADS_PARALLEL],
    bool        reset_n,
    const uint8_t in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES],
    uint8_t       out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES],
    bool        &error
) {
#pragma HLS INLINE off
#pragma HLS ARRAY_PARTITION variable=ctx complete dim=1

    error = false;
    
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        ComputeState dbg_state;
        uint64_t dbg_req_instruction;
        uint8_t dbg_req_op;
        uint8_t dbg_req_layer;
        uint8_t dbg_req_head;
        uint16_t dbg_req_tile;
        bool lane_error = false;

        headed_compute_controller_lane(
            ctx[lane],
            reset_n,
            in_buf[lane],
            out_buf[lane],
            dbg_state,
            dbg_req_instruction,
            dbg_req_op,
            dbg_req_layer,
            dbg_req_head,
            dbg_req_tile,
            lane_error);

        if (lane_error) {
            error = true;
        }
    }
}


void headed_compute_controller(
    ComputeHeadCtx &ctx,            // [BOTH] Per-head persistent state
    bool        reset_n,             // [INPUT] Active-low reset

    // Flat input/output buffers
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t       out_buf[head_buf::OUT_BUF_BYTES],

    // Debug visibility
    ComputeState &dbg_state,
    uint64_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint16_t    &dbg_req_tile,

    bool        &error               // [OUTPUT] Error flag on invalid request
) {
#pragma HLS INLINE off

    headed_compute_controller_lane(
        ctx,
        reset_n,
        in_buf,
        out_buf,
        dbg_state,
        dbg_req_instruction,
        dbg_req_op,
        dbg_req_layer,
        dbg_req_head,
        dbg_req_tile,
        error);
}
