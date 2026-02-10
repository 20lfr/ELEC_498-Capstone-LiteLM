#include "headed_compute_controller.hpp"

#include <cstdio>
#include <cstdint>
#include <cstring>
#include <vector>

namespace {

uint32_t make_instruction(ComputeOp op, uint8_t layer, int8_t head, int8_t tile) {
    return static_cast<uint32_t>(op)
        | (static_cast<uint32_t>(layer) << 8)
        | (static_cast<uint32_t>(static_cast<uint8_t>(head)) << 16)
        | (static_cast<uint32_t>(static_cast<uint8_t>(tile)) << 24);
}

void init_inputs(
    int8_t q_act[D_MODEL],
    int8_t k_act[D_MODEL],
    int8_t v_act[D_MODEL],
    int4_t wq[D_MODEL * D_HEADS],
    int4_t wk[D_MODEL * D_HEADS],
    int4_t wv[D_MODEL * D_HEADS],
    int4_t q_bias[D_HEADS],
    int4_t k_bias[D_HEADS],
    int4_t v_bias[D_HEADS],
    int32_t rq_q_in[D_HEADS],
    int32_t rq_k_in[D_HEADS],
    int32_t rq_v_in[D_HEADS],
    int32_t rq_head_in[D_HEADS],
    int8_t att_q[D_HEADS],
    int8_t att_k_cache[CONTEXT_LENGTH * D_HEADS],
    int32_t val_scale_in[CONTEXT_LENGTH],
    int16_t softmax_in[CONTEXT_LENGTH],
    int8_t att_weights_in[CONTEXT_LENGTH],
    int8_t att_v_cache[D_HEADS * CONTEXT_LENGTH]
) {
    for (int i = 0; i < D_MODEL; ++i) {
        q_act[i] = static_cast<int8_t>((i & 1) ? -(i + 1) : (i + 1));
        k_act[i] = static_cast<int8_t>((i & 1) ? (i + 3) : -(i + 2));
        v_act[i] = static_cast<int8_t>((i % 3) - 4);
    }

    for (int h = 0; h < D_HEADS; ++h) {
        for (int i = 0; i < D_MODEL; ++i) {
            wq[h * D_MODEL + i] = int4_t((h == 0) ? 1 : 3);
            wk[h * D_MODEL + i] = int4_t((h == 0) ? -2 : 2);
            wv[h * D_MODEL + i] = int4_t((i & 1) ? -3 : 1);
        }
        q_bias[h] = int4_t((h == 0) ? 3 : -2);
        k_bias[h] = int4_t((h == 0) ? -1 : 2);
        v_bias[h] = int4_t((h & 1) ? -3 : 4);
    }

    for (int h = 0; h < D_HEADS; ++h) {
        rq_q_in[h] = 40 + (h * 5);
        rq_k_in[h] = -30 - (h * 7);
        rq_v_in[h] = 15 + (h * 11);
        rq_head_in[h] = (h & 1) ? (-20 - h) : (20 + h);
        att_q[h] = static_cast<int8_t>((h & 1) ? -6 : 5);
    }

    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        for (int h = 0; h < D_HEADS; ++h) {
            const int sign = (t & 1) ? -1 : 1;
            att_k_cache[t * D_HEADS + h] = static_cast<int8_t>(sign * (t + h + 1));
        }
        val_scale_in[t] = (t % 7) * 37 - 90;
        softmax_in[t] = static_cast<int16_t>(-1200 + (t * 95));
        att_weights_in[t] = static_cast<int8_t>(((t % 5) - 2) * 15);
    }

    for (int h = 0; h < D_HEADS; ++h) {
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            const int base = (t % 4) - 1;
            att_v_cache[h * CONTEXT_LENGTH + t] = static_cast<int8_t>((h + 2) * base);
        }
    }
}

void compute_qkv_expected(
    const int8_t valueA[D_MODEL],
    const int4_t weights[D_MODEL * D_HEADS],
    const int4_t bias[D_HEADS],
    int32_t out[D_HEADS]
) {
    for (int h = 0; h < D_HEADS; ++h) {
        int32_t acc = static_cast<int32_t>(bias[h]);
        for (int i = 0; i < D_MODEL; ++i) {
            const int4_t w = weights[h * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        out[h] = acc;
    }
}

void requant_heads_expected(
    const int32_t x32[D_HEADS],
    int32_t M,
    int32_t n,
    int8_t y8[D_HEADS]
) {
    for (int h = 0; h < D_HEADS; ++h) {
        int64_t product = static_cast<int64_t>(x32[h]) * static_cast<int64_t>(M);
        int64_t rounded = 1LL << (n - 1);
        int32_t scaled = static_cast<int32_t>((product + rounded) >> n);

        if (scaled > 127) {
            y8[h] = 127;
        } else if (scaled < -128) {
            y8[h] = -128;
        } else {
            y8[h] = static_cast<int8_t>(scaled);
        }
    }
}

void att_scores_expected(
    const int8_t q[D_HEADS],
    const int8_t k_cache[CONTEXT_LENGTH * D_HEADS],
    int32_t out[CONTEXT_LENGTH]
) {
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        int32_t acc = 0;
        for (int h = 0; h < D_HEADS; ++h) {
            acc += static_cast<int32_t>(q[h]) * static_cast<int32_t>(k_cache[t * D_HEADS + h]);
        }
        out[t] = acc;
    }
}

void value_scale_expected(
    const int32_t input[CONTEXT_LENGTH],
    int16_t output[CONTEXT_LENGTH]
) {
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
        int64_t prod = static_cast<int64_t>(input[i]) * static_cast<int64_t>(ATTN_SCALE_Q15);
        int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
        int32_t scaled = static_cast<int32_t>(rounded >> 15);
        if (scaled > 32767) {
            scaled = 32767;
        } else if (scaled < -32768) {
            scaled = -32768;
        }
        output[i] = static_cast<int16_t>(scaled);
    }
}

static uint16_t exp_approx_q15(int16_t x_q15) {
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

void softmax_expected(
    const int16_t input[CONTEXT_LENGTH],
    int16_t output[CONTEXT_LENGTH]
) {
    const uint16_t ONE_Q15 = (1u << 15);
    const uint16_t MAX_Q15 = ONE_Q15 - 1;

    int16_t max_val = input[0];
    for (int i = 1; i < CONTEXT_LENGTH; ++i) {
        if (input[i] > max_val) {
            max_val = input[i];
        }
    }

    uint16_t exp_buf[CONTEXT_LENGTH];
    uint32_t sum_exp = 0;
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
        int16_t diff = static_cast<int16_t>(input[i] - max_val);
        uint16_t e_q15 = exp_approx_q15(diff);
        exp_buf[i] = e_q15;
        sum_exp += e_q15;
    }

    uint32_t inv_sum_q15 = 0;
    if (sum_exp > 0) {
        // Match DUT: reciprocal in Q1.15 using 2^30 / sum_exp (sum_exp is Q1.15)
        inv_sum_q15 = (static_cast<uint32_t>(1) << 30) / sum_exp;
    }

    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
        uint64_t tmp = static_cast<uint64_t>(exp_buf[i]) * static_cast<uint64_t>(inv_sum_q15);
        uint16_t prob_q15 = static_cast<uint16_t>(tmp >> 15);
        if (prob_q15 > MAX_Q15) {
            prob_q15 = MAX_Q15;
        }
        output[i] = static_cast<int16_t>(prob_q15);
    }
}

void att_value_expected(
    const int8_t weights[CONTEXT_LENGTH],
    const int8_t v_cache[D_HEADS * CONTEXT_LENGTH],
    int32_t output[D_HEADS]
) {
    for (int h = 0; h < D_HEADS; ++h) {
        int32_t acc = 0;
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            acc += static_cast<int32_t>(weights[t]) * static_cast<int32_t>(v_cache[h * CONTEXT_LENGTH + t]);
        }
        output[h] = acc;
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
    default:               return "UNK";
    }
}

void print_i8_vector(const char *label, const int8_t *data, int len) {
    std::printf("%s[%d]:", label, len);
    for (int i = 0; i < len; ++i) {
        std::printf(" %d", static_cast<int>(data[i]));
    }
    std::printf("\n");
}

void print_i16_vector(const char *label, const int16_t *data, int len) {
    std::printf("%s[%d]:", label, len);
    for (int i = 0; i < len; ++i) {
        std::printf(" %d", static_cast<int>(data[i]));
    }
    std::printf("\n");
}

void print_i32_vector(const char *label, const int32_t *data, int len) {
    std::printf("%s[%d]:", label, len);
    for (int i = 0; i < len; ++i) {
        std::printf(" %d", static_cast<int>(data[i]));
    }
    std::printf("\n");
}

void print_i4_vector(const char *label, const int4_t *data, int len) {
    std::printf("%s[%d]:", label, len);
    for (int i = 0; i < len; ++i) {
        std::printf(" %d", static_cast<int>(data[i]));
    }
    std::printf("\n");
}

void print_qkv_weights(const char *label, const int4_t weights[D_MODEL * D_HEADS]) {
    std::printf("%s[%d][%d]:\n", label, D_HEADS, D_MODEL);
    for (int h = 0; h < D_HEADS; ++h) {
        std::printf("  head %d:", h);
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(weights[h * D_MODEL + i]));
        }
        std::printf("\n");
    }
}

void print_cache(const char *label, const int8_t *cache, int rows, int cols) {
    std::printf("%s[%d][%d]:\n", label, rows, cols);
    for (int r = 0; r < rows; ++r) {
        std::printf("  %02d:", r);
        for (int c = 0; c < cols; ++c) {
            std::printf(" %d", static_cast<int>(cache[r * cols + c]));
        }
        std::printf("\n");
    }
}

void print_buffer(const char *label, const uint8_t *buf, int size) {
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

void print_in_buf_decoded(ComputeOp op, const uint8_t *in_buf) {
    switch (op) {
    case ComputeOp::CMP_Q:
    case ComputeOp::CMP_K:
    case ComputeOp::CMP_V: {
        const int bias_base = head_buf::INQkvLayout::B;
        std::printf("QKV in_buf (decoded):\n  ACT:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INQkvLayout::ACT + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (head_buf::INQkvLayout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int h = 0; h < D_HEADS; ++h) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (bias_base * 2) + h)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_K_REQUANT:
    case ComputeOp::CMP_V_REQUANT:
    case ComputeOp::CMP_REQUANT_Q:
    case ComputeOp::CMP_HEAD_REQUANT: {
        std::printf("HEAD_REQUANT in_buf (decoded):\n  X:");
        for (int h = 0; h < D_HEADS; ++h) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, head_buf::INHeadRequantLayout::X + (h * 4))));
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
        for (int h = 0; h < D_HEADS; ++h) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::Q + h)));
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
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, head_buf::INValueScaleLayout::X + (t * 4))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_SOFTMAX: {
        std::printf("SOFTMAX in_buf (decoded):\n  X:");
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + (t * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ATT_VALUE: {
        std::printf("ATT_VALUE in_buf (decoded):\n  WEIGHTS:");
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INAttValueLayout::WEIGHTS + t)));
        }
        std::printf("\n  V_CACHE:");
        for (int i = 0; i < D_HEADS * CONTEXT_LENGTH; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, head_buf::INAttValueLayout::V_CACHE + i)));
        }
        std::printf("\n");
        break;
    }
    default:
        std::printf("in_buf (decoded): <no decoder>\n");
        break;
    }
}

void print_out_buf_decoded(ComputeOp op, const uint8_t *out_buf) {
    switch (op) {
    case ComputeOp::CMP_Q:
    case ComputeOp::CMP_K:
    case ComputeOp::CMP_V:
    case ComputeOp::CMP_ATT_VALUE: {
        std::printf("out_buf (decoded):\n  Y:");
        for (int h = 0; h < D_HEADS; ++h) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, h * 4)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_K_REQUANT:
    case ComputeOp::CMP_V_REQUANT:
    case ComputeOp::CMP_REQUANT_Q:
    case ComputeOp::CMP_HEAD_REQUANT: {
        std::printf("out_buf (decoded):\n  Y:");
        for (int h = 0; h < D_HEADS; ++h) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, head_buf::INHeadRequantLayout::X + h)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_ATT_SCORES: {
        std::printf("out_buf (decoded):\n  Y:");
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, t * 4)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_VALUE_SCALE:
    case ComputeOp::CMP_SOFTMAX: {
        std::printf("out_buf (decoded):\n  Y:");
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(out_buf, t * 2)));
        }
        std::printf("\n");
        break;
    }
    default:
        std::printf("out_buf (decoded): <no decoder>\n");
        break;
    }
}

} // namespace

int main() {
    const int MAX_CYCLES = 200;

    bool compute_ready = false;
    bool compute_done = false;
    bool error = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    bool mem_transfer_done = false;
    uint32_t mem_op = 0;

    int8_t q_act[D_MODEL] = {};
    int8_t k_act[D_MODEL] = {};
    int8_t v_act[D_MODEL] = {};
    int4_t wq[D_MODEL * D_HEADS] = {};
    int4_t wk[D_MODEL * D_HEADS] = {};
    int4_t wv[D_MODEL * D_HEADS] = {};
    int4_t q_bias[D_HEADS] = {};
    int4_t k_bias[D_HEADS] = {};
    int4_t v_bias[D_HEADS] = {};
    int32_t rq_q_in[D_HEADS] = {};
    int32_t rq_k_in[D_HEADS] = {};
    int32_t rq_v_in[D_HEADS] = {};
    int32_t rq_head_in[D_HEADS] = {};
    int8_t att_q[D_HEADS] = {};
    int8_t att_k_cache[CONTEXT_LENGTH * D_HEADS] = {};
    int32_t val_scale_in[CONTEXT_LENGTH] = {};
    int16_t softmax_in[CONTEXT_LENGTH] = {};
    int8_t att_weights_in[CONTEXT_LENGTH] = {};
    int8_t att_v_cache[D_HEADS * CONTEXT_LENGTH] = {};

    int32_t q_out[D_HEADS] = {};
    int32_t k_out[D_HEADS] = {};
    int32_t v_out[D_HEADS] = {};
    int8_t q_rq[D_HEADS] = {};
    int8_t k_rq[D_HEADS] = {};
    int8_t v_rq[D_HEADS] = {};
    int32_t att_scores[CONTEXT_LENGTH] = {};
    int16_t val_scaled[CONTEXT_LENGTH] = {};
    int16_t softmax_out[CONTEXT_LENGTH] = {};
    int32_t att_value_out[D_HEADS] = {};
    int8_t head_rq[D_HEADS] = {};

    int32_t exp_q[D_HEADS] = {};
    int32_t exp_k[D_HEADS] = {};
    int32_t exp_v[D_HEADS] = {};
    int8_t exp_q_rq[D_HEADS] = {};
    int8_t exp_k_rq[D_HEADS] = {};
    int8_t exp_v_rq[D_HEADS] = {};
    int32_t exp_att_scores[CONTEXT_LENGTH] = {};
    int16_t exp_val_scaled[CONTEXT_LENGTH] = {};
    int16_t exp_softmax[CONTEXT_LENGTH] = {};
    int32_t exp_att_value[D_HEADS] = {};
    int8_t exp_head_rq[D_HEADS] = {};

    uint8_t in_buf[head_buf::IN_BUF_BYTES] = {};
    uint8_t out_buf[head_buf::OUT_BUF_BYTES] = {};
    ComputeState dbg_state = ComputeState::IDLE;
    uint32_t dbg_req_instruction = 0;
    uint8_t dbg_req_op = 0;
    uint8_t dbg_req_layer = 0;
    uint8_t dbg_req_head = 0;
    uint8_t dbg_req_tile = 0;
    ComputeHeadCtx compute_ctx{};

    const int32_t rq_M = 3;
    const int32_t rq_N = 3;
    const int MEM_LAT = 2;
    bool mem_busy = false;
    int mem_timer = 0;
    enum class MemPending { NONE, READ, WRITE };
    MemPending mem_pending = MemPending::NONE;
    int mem_done_hold = 0;

    init_inputs(q_act,
                k_act,
                v_act,
                wq,
                wk,
                wv,
                q_bias,
                k_bias,
                v_bias,
                rq_q_in,
                rq_k_in,
                rq_v_in,
                rq_head_in,
                att_q,
                att_k_cache,
                val_scale_in,
                softmax_in,
                att_weights_in,
                att_v_cache);

    compute_qkv_expected(q_act, wq, q_bias, exp_q);
    compute_qkv_expected(k_act, wk, k_bias, exp_k);
    compute_qkv_expected(v_act, wv, v_bias, exp_v);
    requant_heads_expected(rq_q_in, rq_M, rq_N, exp_q_rq);
    requant_heads_expected(rq_k_in, rq_M, rq_N, exp_k_rq);
    requant_heads_expected(rq_v_in, rq_M, rq_N, exp_v_rq);
    att_scores_expected(att_q, att_k_cache, exp_att_scores);
    value_scale_expected(val_scale_in, exp_val_scaled);
    softmax_expected(softmax_in, exp_softmax);
    att_value_expected(att_weights_in, att_v_cache, exp_att_value);
    requant_heads_expected(rq_head_in, rq_M, rq_N, exp_head_rq);

    std::printf("D_MODEL=%d D_HEADS=%d CONTEXT_LENGTH=%d\n", D_MODEL, D_HEADS, CONTEXT_LENGTH);
    print_i8_vector("Q_ACT", q_act, D_MODEL);
    print_i8_vector("K_ACT", k_act, D_MODEL);
    print_i8_vector("V_ACT", v_act, D_MODEL);
    print_qkv_weights("WQ", wq);
    print_qkv_weights("WK", wk);
    print_qkv_weights("WV", wv);
    print_i4_vector("Q_BIAS", q_bias, D_HEADS);
    print_i4_vector("K_BIAS", k_bias, D_HEADS);
    print_i4_vector("V_BIAS", v_bias, D_HEADS);
    print_i32_vector("RQ_Q_IN", rq_q_in, D_HEADS);
    print_i32_vector("RQ_K_IN", rq_k_in, D_HEADS);
    print_i32_vector("RQ_V_IN", rq_v_in, D_HEADS);
    print_i32_vector("RQ_HEAD_IN", rq_head_in, D_HEADS);
    print_i8_vector("ATT_Q", att_q, D_HEADS);
    print_cache("ATT_K_CACHE", att_k_cache, CONTEXT_LENGTH, D_HEADS);
    print_i32_vector("VALUE_SCALE_IN", val_scale_in, CONTEXT_LENGTH);
    print_i16_vector("SOFTMAX_IN", softmax_in, CONTEXT_LENGTH);
    print_i8_vector("ATT_WEIGHTS_IN", att_weights_in, CONTEXT_LENGTH);
    print_cache("ATT_V_CACHE", att_v_cache, D_HEADS, CONTEXT_LENGTH);

    struct Step {
        ComputeOp op;
    };
    std::vector<Step> steps = {
        {ComputeOp::CMP_Q},
        {ComputeOp::CMP_K},
        {ComputeOp::CMP_V},
        {ComputeOp::CMP_K_REQUANT},
        {ComputeOp::CMP_V_REQUANT},
        {ComputeOp::CMP_REQUANT_Q},
        {ComputeOp::CMP_ATT_SCORES},
        {ComputeOp::CMP_VALUE_SCALE},
        {ComputeOp::CMP_SOFTMAX},
        {ComputeOp::CMP_ATT_VALUE},
        {ComputeOp::CMP_HEAD_REQUANT},
        {ComputeOp::CMP_NONE}
    };

    enum class TbState {
        RESET,
        WAIT_READY,
        WAIT_DONE,
        DONE
    };

    TbState state = TbState::RESET;
    uint32_t compute_instruction = 0;
    bool compute_start = false;
    const int8_t tile_field = -1;
    size_t step_idx = 0;

    std::printf("%-6s %-5s %-5s %-5s %-5s %-6s %-6s %-6s %-6s %-10s %-10s %-5s %-5s %-5s %-7s %-10s %-8s %-5s %-5s %-5s\n",
                "Cycle", "Rst", "Start", "Ready", "Done", "Err",
                "MRead", "MWrite", "MDone", "MOp", "Instr", "Op", "Layer", "Head", "Tile",
                "State", "ReqInstr", "ReqOp", "ReqL", "ReqH", "ReqT");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        const bool reset_n = (cycle >= 2);

        mem_transfer_done = false;
        if (mem_done_hold > 0) {
            mem_transfer_done = true;
            --mem_done_hold;
        }
        if (mem_busy) {
            if (mem_timer == 0) {
                mem_transfer_done = true;
                mem_done_hold = 2;
                mem_busy = false;
                if (mem_pending == MemPending::READ) {
                    std::memset(in_buf, 0, sizeof(in_buf));
                    const ComputeOp mem_op_code = static_cast<ComputeOp>(mem_op & 0xFFu);
                    switch (mem_op_code) {
                        case ComputeOp::CMP_Q:
                        case ComputeOp::CMP_K:
                        case ComputeOp::CMP_V: {
                            const int bias_base = head_buf::INQkvLayout::B;
                            const int8_t *act = (mem_op_code == ComputeOp::CMP_Q) ? q_act
                                              : (mem_op_code == ComputeOp::CMP_K) ? k_act
                                              : v_act;
                            const int4_t *bias = (mem_op_code == ComputeOp::CMP_Q) ? q_bias
                                                : (mem_op_code == ComputeOp::CMP_K) ? k_bias
                                                : v_bias;
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, head_buf::INQkvLayout::ACT + i, act[i]);
                            }
                            const int4_t *src = (mem_op_code == ComputeOp::CMP_Q) ? wq
                                              : (mem_op_code == ComputeOp::CMP_K) ? wk
                                              : wv;
                            for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
                                compute_buf::write_i4(in_buf, (head_buf::INQkvLayout::W * 2) + i, src[i]);
                            }
                            for (int h = 0; h < D_HEADS; ++h) {
                                compute_buf::write_i4(in_buf, (bias_base * 2) + h, bias[h]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_K_REQUANT:
                        case ComputeOp::CMP_V_REQUANT:
                        case ComputeOp::CMP_REQUANT_Q:
                        case ComputeOp::CMP_HEAD_REQUANT: {
                            const int32_t *src = (mem_op_code == ComputeOp::CMP_K_REQUANT) ? rq_k_in
                                              : (mem_op_code == ComputeOp::CMP_V_REQUANT) ? rq_v_in
                                              : (mem_op_code == ComputeOp::CMP_REQUANT_Q) ? rq_q_in
                                              : rq_head_in;
                            for (int h = 0; h < D_HEADS; ++h) {
                                compute_buf::write_i32(in_buf, head_buf::INHeadRequantLayout::X + (h * 4), src[h]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_ATT_SCORES: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                compute_buf::write_i8(in_buf, head_buf::INAttScoresLayout::Q + h, att_q[h]);
                            }
                            for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
                                compute_buf::write_i8(in_buf, head_buf::INAttScoresLayout::K_CACHE + i, att_k_cache[i]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_VALUE_SCALE: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                compute_buf::write_i32(in_buf, head_buf::INValueScaleLayout::X + (t * 4), val_scale_in[t]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_SOFTMAX: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                compute_buf::write_i16(in_buf, head_buf::INSoftmaxLayout::X + (t * 2), softmax_in[t]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_ATT_VALUE: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                compute_buf::write_i8(in_buf, head_buf::INAttValueLayout::WEIGHTS + t, att_weights_in[t]);
                            }
                            for (int i = 0; i < D_HEADS * CONTEXT_LENGTH; ++i) {
                                compute_buf::write_i8(in_buf, head_buf::INAttValueLayout::V_CACHE + i, att_v_cache[i]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_NONE:
                        default:
                            break;
                    }
                    print_buffer("in_buf (send)", in_buf, head_buf::IN_BUF_BYTES);
                    print_in_buf_decoded(mem_op_code, in_buf);
                } else if (mem_pending == MemPending::WRITE) {
                }
                mem_pending = MemPending::NONE;
            } else {
                --mem_timer;
            }
        }

        const uint8_t op_field_pre = static_cast<uint8_t>(compute_instruction & 0xFFu);
        const ComputeOp op_pre = static_cast<ComputeOp>(op_field_pre);

        compute_ctx.compute_start = compute_start;
        compute_ctx.compute_instruction = compute_instruction;
        compute_ctx.mem_transfer_done = mem_transfer_done;

        headed_compute_controller(
            compute_ctx,
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

        compute_ready = compute_ctx.compute_ready;
        compute_done = compute_ctx.compute_done;
        mem_read_request = compute_ctx.mem_read_request;
        mem_write_request = compute_ctx.mem_write_request;
        mem_op = compute_ctx.mem_op;

        if (compute_done) {
            print_buffer("out_buf (done)", out_buf, head_buf::OUT_BUF_BYTES);
            print_out_buf_decoded(op_pre, out_buf);
        }

        const uint8_t op_field = static_cast<uint8_t>(compute_instruction & 0xFFu);
        const uint8_t layer_field = static_cast<uint8_t>((compute_instruction >> 8) & 0xFFu);
        const int8_t head_field = static_cast<int8_t>((compute_instruction >> 16) & 0xFFu);
        const int8_t tile_field_decoded = static_cast<int8_t>((compute_instruction >> 24) & 0xFFu);

        std::printf("%-6d %-5d %-5d %-5d %-5d %-6d %-6d %-6d %-6d %-10s 0x%08x %-10s %-5d %-5d %-5d %-7d 0x%08x %-8s %-5d %-5d %-5d\n",
                    cycle,
                    reset_n ? 0 : 1,
                    compute_start ? 1 : 0,
                    compute_ready ? 1 : 0,
                    compute_done ? 1 : 0,
                    error ? 1 : 0,
                    mem_read_request ? 1 : 0,
                    mem_write_request ? 1 : 0,
                    mem_transfer_done ? 1 : 0,
                    op_name(static_cast<ComputeOp>(mem_op & 0xFFu)),
                    compute_instruction,
                    op_name(static_cast<ComputeOp>(op_field)),
                    static_cast<int>(layer_field),
                    static_cast<int>(head_field),
                    static_cast<int>(tile_field_decoded),
                    static_cast<int>(dbg_state),
                    dbg_req_instruction,
                    op_name(static_cast<ComputeOp>(dbg_req_op)),
                    static_cast<int>(dbg_req_layer),
                    static_cast<int>(static_cast<int8_t>(dbg_req_head)),
                    static_cast<int>(static_cast<int8_t>(dbg_req_tile)));
        std::printf("\n");

        if (!mem_busy) {
            if (mem_read_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::READ;
            } else if (mem_write_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::WRITE;
            }
        }

        compute_start = false;
        if (!reset_n) {
            mem_busy = false;
            mem_timer = 0;
            mem_pending = MemPending::NONE;
            state = TbState::RESET;
            continue;
        }

        switch (state) {
            case TbState::RESET: {
                if (compute_ready && !steps.empty()) {
                    step_idx = 0;
                    compute_instruction = make_instruction(steps[step_idx].op, 0, 0, tile_field);
                    compute_start = true;
                    state = TbState::WAIT_DONE;
                }
                break;
            }
            case TbState::WAIT_DONE: {
                if (compute_done) {
                    const ComputeOp op = steps[step_idx].op;
                    if (op == ComputeOp::CMP_NONE) {
                        if (!error) {
                            std::fprintf(stderr, "Invalid op did not assert error.\n");
                            return 1;
                        }
                    } else if (error) {
                        std::fprintf(stderr, "Op %s asserted error unexpectedly.\n", op_name(op));
                        return 1;
                    }
                    switch (op) {
                        case ComputeOp::CMP_Q: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                q_out[h] = compute_buf::read_i32(out_buf, h * 4);
                                if (q_out[h] != exp_q[h]) {
                                    std::fprintf(stderr, "CMP_Q failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(q_out[h]), static_cast<int>(exp_q[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_K: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                k_out[h] = compute_buf::read_i32(out_buf, h * 4);
                                if (k_out[h] != exp_k[h]) {
                                    std::fprintf(stderr, "CMP_K failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(k_out[h]), static_cast<int>(exp_k[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_V: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                v_out[h] = compute_buf::read_i32(out_buf, h * 4);
                                if (v_out[h] != exp_v[h]) {
                                    std::fprintf(stderr, "CMP_V failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(v_out[h]), static_cast<int>(exp_v[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_K_REQUANT: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                k_rq[h] = compute_buf::read_i8(out_buf, head_buf::INHeadRequantLayout::X + h);
                                if (k_rq[h] != exp_k_rq[h]) {
                                    std::fprintf(stderr, "CMP_K_REQUANT failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(k_rq[h]), static_cast<int>(exp_k_rq[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_V_REQUANT: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                v_rq[h] = compute_buf::read_i8(out_buf, head_buf::INHeadRequantLayout::X + h);
                                if (v_rq[h] != exp_v_rq[h]) {
                                    std::fprintf(stderr, "CMP_V_REQUANT failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(v_rq[h]), static_cast<int>(exp_v_rq[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT_Q: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                q_rq[h] = compute_buf::read_i8(out_buf, head_buf::INHeadRequantLayout::X + h);
                                if (q_rq[h] != exp_q_rq[h]) {
                                    std::fprintf(stderr, "CMP_REQUANT_Q failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(q_rq[h]), static_cast<int>(exp_q_rq[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_ATT_SCORES: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                att_scores[t] = compute_buf::read_i32(out_buf, t * 4);
                                if (att_scores[t] != exp_att_scores[t]) {
                                    std::fprintf(stderr, "CMP_ATT_SCORES failed at t %d: got %d expected %d\n",
                                                 t, static_cast<int>(att_scores[t]), static_cast<int>(exp_att_scores[t]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_VALUE_SCALE: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                val_scaled[t] = compute_buf::read_i16(out_buf, t * 2);
                                if (val_scaled[t] != exp_val_scaled[t]) {
                                    std::fprintf(stderr, "CMP_VALUE_SCALE failed at t %d: got %d expected %d\n",
                                                 t, static_cast<int>(val_scaled[t]), static_cast<int>(exp_val_scaled[t]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_SOFTMAX: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                softmax_out[t] = compute_buf::read_i16(out_buf, t * 2);
                                if (softmax_out[t] != exp_softmax[t]) {
                                    std::fprintf(stderr, "CMP_SOFTMAX failed at t %d: got %d expected %d\n",
                                                 t, static_cast<int>(softmax_out[t]), static_cast<int>(exp_softmax[t]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_ATT_VALUE: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                att_value_out[h] = compute_buf::read_i32(out_buf, h * 4);
                                if (att_value_out[h] != exp_att_value[h]) {
                                    std::fprintf(stderr, "CMP_ATT_VALUE failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(att_value_out[h]), static_cast<int>(exp_att_value[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_HEAD_REQUANT: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                head_rq[h] = compute_buf::read_i8(out_buf, head_buf::INHeadRequantLayout::X + h);
                                if (head_rq[h] != exp_head_rq[h]) {
                                    std::fprintf(stderr, "CMP_HEAD_REQUANT failed at head %d: got %d expected %d\n",
                                                 h, static_cast<int>(head_rq[h]), static_cast<int>(exp_head_rq[h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        default:
                            break;
                    }
                    ++step_idx;
                    if (step_idx >= steps.size()) {
                        state = TbState::DONE;
                    } else {
                        state = TbState::WAIT_READY;
                    }
                }
                break;
            }
            case TbState::WAIT_READY: {
                if (compute_ready) {
                    compute_instruction = make_instruction(steps[step_idx].op, 0, 0, tile_field);
                    compute_start = true;
                    state = TbState::WAIT_DONE;
                }
                break;
            }
            case TbState::DONE: {
                break;
            }
        }

        if (state == TbState::DONE) {
            break;
        }
    }

    if (state != TbState::DONE) {
        std::fprintf(stderr, "Testbench timed out before completion.\n");
        return 1;
    }

    std::printf("headed_compute_controller_tb: PASS\n");
    return 0;
}
