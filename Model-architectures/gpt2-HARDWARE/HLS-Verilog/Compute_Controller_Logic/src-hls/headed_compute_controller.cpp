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
                              uint8_t tile_idx,
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
                                     uint8_t tile_idx,
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
#pragma HLS ARRAY_PARTITION variable=input cyclic factor=CONTEXT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=output cyclic factor=CONTEXT_UNROLL dim=1
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

// Approximate exp(x) for x in Q1.15, clamped to [-1.0, 0.0], output in Q1.15.
inline uint16_t exp_approx_q15(int16_t x_q15) {
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
    uint16_t idx = static_cast<uint16_t>((static_cast<int32_t>(x_q15) - (-32768)) >> 7);
    return exp_lut_q15[idx];
}

void SOFTMAX(
    const int16_t input[CONTEXT_LENGTH],  // Q1.15 logits
    int16_t output[CONTEXT_LENGTH]        // Q1.15 probabilities (0..32767)
) {
#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=input cyclic factor=CONTEXT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=output cyclic factor=CONTEXT_UNROLL dim=1

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
#pragma HLS ARRAY_PARTITION variable=exp_buf cyclic factor=CONTEXT_UNROLL dim=1

    uint32_t sum_exp = 0;
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
// #pragma HLS PIPELINE II=1
        int16_t diff = static_cast<int16_t>(input[i] - max_val);
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
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
// #pragma HLS PIPELINE II=1
        int64_t prod = static_cast<int64_t>(
                           compute_buf::read_i32(in_buf, head_buf::INValueScaleLayout::X + (t * 4))) *
                       static_cast<int64_t>(ATTN_SCALE_Q15);
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
        const int16_t diff = static_cast<int16_t>(x - max_val);
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
        const int16_t diff = static_cast<int16_t>(x - max_val);
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
    int32_t accum_tile[HEAD_MAC_OUT_UNROLL];
#pragma HLS ARRAY_PARTITION variable=accum_tile complete dim=1

    for (int out_base = 0; out_base < D_HEAD_TILE_ATT_VALUE; out_base += HEAD_MAC_OUT_UNROLL) {
        for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
#pragma HLS UNROLL factor=HEAD_MAC_OUT_UNROLL
            accum_tile[lane] = 0;
        }

        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
// #pragma HLS PIPELINE II=1
            const int16_t weight = compute_buf::read_i16(in_buf, head_buf::INAttValueLayout::WEIGHTS + (t * 2));
            for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
#pragma HLS UNROLL factor=HEAD_MAC_OUT_UNROLL
                const int out_idx = out_base + lane;
                if (out_idx < D_HEAD_TILE_ATT_VALUE) {
                    const int v_idx = (out_idx * CONTEXT_LENGTH) + t;
                    const int8_t v = compute_buf::read_i8(in_buf, head_buf::INAttValueLayout::V_CACHE + v_idx);
                    accum_tile[lane] += static_cast<int32_t>(weight) * static_cast<int32_t>(v);
                }
            }
        }

        for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
#pragma HLS UNROLL factor=HEAD_MAC_OUT_UNROLL
            const int out_idx = out_base + lane;
            if (out_idx < D_HEAD_TILE_ATT_VALUE) {
                compute_buf::write_i32(out_buf, head_buf::OUTAttValueLayout::Y + (out_idx * 4),
                                       accum_tile[lane]);
            }
        }
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
    uint8_t tile_idx,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t out_buf[head_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE
    int32_t accum_tile[HEAD_MAC_OUT_UNROLL];
#pragma HLS ARRAY_PARTITION variable=accum_tile complete dim=1

    int32_t M = 1;
    int32_t n = 0;
    get_qkv_requant_params(op, layer_idx, M, n);

    for (int out_base = 0; out_base < D_HEAD_TILE_QKV; out_base += HEAD_MAC_OUT_UNROLL) {
        for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
#pragma HLS UNROLL factor=HEAD_MAC_OUT_UNROLL
            const int out_idx = out_base + lane;
            accum_tile[lane] = 0;
        }

        for (int in_base = 0; in_base < D_MODEL; in_base += HEAD_MAC_VEC_UNROLL) {
            for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
#pragma HLS UNROLL factor=HEAD_MAC_OUT_UNROLL
                const int out_idx = out_base + lane;
                if (out_idx < D_HEAD_TILE_QKV) {
                    for (int k = 0; k < HEAD_MAC_VEC_UNROLL; ++k) {
#pragma HLS UNROLL factor=HEAD_MAC_VEC_UNROLL
                        const int in_idx = in_base + k;
	                        if (in_idx < D_MODEL) {
	                            const int8_t x = compute_buf::read_i8(in_buf, head_buf::INQkvLayout::ACT + in_idx);
	                            const int w_idx = (out_idx * D_MODEL) + in_idx;
	                            const int8_t w = compute_buf::read_i8(in_buf, head_buf::INQkvLayout::W + w_idx);
	                            accum_tile[lane] += static_cast<int32_t>(x) * static_cast<int32_t>(w);
	                        }
	                    }
	                }
            }
        }

        for (int lane = 0; lane < HEAD_MAC_OUT_UNROLL; ++lane) {
#pragma HLS UNROLL factor=HEAD_MAC_OUT_UNROLL
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
    uint8_t tile_idx,
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t out_buf[head_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE

    for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
// #pragma HLS PIPELINE II=1
        int32_t acc = 0;
        for (int d = 0; d < D_HEADS; ++d) {
// #pragma HLS UNROLL
            const int8_t q = compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::Q + d);
            const int k_base = head_buf::INAttScoresLayout::K_CACHE + (t * D_HEADS) + d;
            const int8_t k = compute_buf::read_i8(in_buf, k_base);
            acc += static_cast<int32_t>(q) * static_cast<int32_t>(k);
        }
        compute_buf::write_i32(out_buf, head_buf::OUTAttScoresLayout::X + (t * 4), acc);
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
    uint32_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint8_t     &dbg_req_tile,
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
                ctx.req.tile_idx      = (ctx.compute_instruction >> 24) & 0xFFu;
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
                ctx.req.tile_idx      = (ctx.compute_instruction >> 24) & 0xFFu;
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
// #pragma HLS UNROLL
        ComputeState dbg_state;
        uint32_t dbg_req_instruction;
        uint8_t dbg_req_op;
        uint8_t dbg_req_layer;
        uint8_t dbg_req_head;
        uint8_t dbg_req_tile;
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
    uint32_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint8_t     &dbg_req_tile,

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
