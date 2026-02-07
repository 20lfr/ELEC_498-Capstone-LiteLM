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

void init_inputs_lane(
    int lane,
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
    const int lane_off = lane + 1;

    for (int i = 0; i < D_MODEL; ++i) {
        q_act[i] = static_cast<int8_t>(((i & 1) ? -(i + 1) : (i + 1)) + lane_off);
        k_act[i] = static_cast<int8_t>(((i & 1) ? (i + 3) : -(i + 2)) - lane_off);
        v_act[i] = static_cast<int8_t>(((i % 3) - 4) + lane_off);
    }

    for (int h = 0; h < D_HEADS; ++h) {
        for (int i = 0; i < D_MODEL; ++i) {
            wq[h * D_MODEL + i] = int4_t((h == 0) ? 1 : 3);
            wk[h * D_MODEL + i] = int4_t((h == 0) ? -2 : 2);
            wv[h * D_MODEL + i] = int4_t((i & 1) ? -3 : 1);
        }
        q_bias[h] = int4_t(((h == 0) ? 3 : -2) + lane_off);
        k_bias[h] = int4_t(((h == 0) ? -1 : 2) - lane_off);
        v_bias[h] = int4_t(((h & 1) ? -3 : 4) + lane_off);
    }

    for (int h = 0; h < D_HEADS; ++h) {
        rq_q_in[h] = 40 + (h * 5) + lane_off;
        rq_k_in[h] = -30 - (h * 7) - lane_off;
        rq_v_in[h] = 15 + (h * 11) + lane_off;
        rq_head_in[h] = (h & 1) ? (-20 - h - lane_off) : (20 + h + lane_off);
        att_q[h] = static_cast<int8_t>(((h & 1) ? -6 : 5) + lane_off);
    }

    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        for (int h = 0; h < D_HEADS; ++h) {
            const int sign = (t & 1) ? -1 : 1;
            att_k_cache[t * D_HEADS + h] =
                static_cast<int8_t>(sign * (t + h + 1 + lane_off));
        }
        val_scale_in[t] = (t % 7) * 37 - 90 + (lane_off * 3);
        softmax_in[t] = static_cast<int16_t>(-1200 + (t * 95) + (lane_off * 11));
        att_weights_in[t] = static_cast<int8_t>(((t % 5) - 2) * 15 + lane_off);
    }

    for (int h = 0; h < D_HEADS; ++h) {
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
            const int base = (t % 4) - 1;
            att_v_cache[h * CONTEXT_LENGTH + t] =
                static_cast<int8_t>(((h + 2) * base) + lane_off);
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

uint16_t exp_approx_q15(int16_t x_q15) {
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

void dump_dbg_head_vec(int lane, const int8_t vec[HEAD_VECTOR_MAX]) {
    std::printf("DBG L%d head_vec[%d]:", lane, HEAD_VECTOR_MAX);
    for (int i = 0; i < HEAD_VECTOR_MAX; ++i) {
        std::printf(" %d", static_cast<int>(vec[i]));
    }
    std::printf("\n");
}

void dump_dbg_head_out(int lane, const int32_t vec[HEAD_ACCUM_MAX]) {
    std::printf("DBG L%d head_out[%d]:", lane, HEAD_ACCUM_MAX);
    for (int i = 0; i < HEAD_ACCUM_MAX; ++i) {
        std::printf(" %d", static_cast<int>(vec[i]));
    }
    std::printf("\n");
}

} // namespace

int main() {
    const int MAX_CYCLES = 400;
    const int32_t rq_M = 3;
    const int32_t rq_N = 3;
    const int MEM_LAT = 2;
    const int8_t tile_field = -1;

    ComputeHeadCtx ctx[HEADS_PARALLEL] = {};
    uint8_t in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES] = {};
    uint8_t out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES] = {};
    int8_t dbg_head_vec[HEADS_PARALLEL][HEAD_VECTOR_MAX] = {};
    int32_t dbg_head_out[HEADS_PARALLEL][HEAD_ACCUM_MAX] = {};
    bool error = false;

    int8_t q_act[HEADS_PARALLEL][D_MODEL] = {};
    int8_t k_act[HEADS_PARALLEL][D_MODEL] = {};
    int8_t v_act[HEADS_PARALLEL][D_MODEL] = {};
    int4_t wq[HEADS_PARALLEL][D_MODEL * D_HEADS] = {};
    int4_t wk[HEADS_PARALLEL][D_MODEL * D_HEADS] = {};
    int4_t wv[HEADS_PARALLEL][D_MODEL * D_HEADS] = {};
    int4_t q_bias[HEADS_PARALLEL][D_HEADS] = {};
    int4_t k_bias[HEADS_PARALLEL][D_HEADS] = {};
    int4_t v_bias[HEADS_PARALLEL][D_HEADS] = {};
    int32_t rq_q_in[HEADS_PARALLEL][D_HEADS] = {};
    int32_t rq_k_in[HEADS_PARALLEL][D_HEADS] = {};
    int32_t rq_v_in[HEADS_PARALLEL][D_HEADS] = {};
    int32_t rq_head_in[HEADS_PARALLEL][D_HEADS] = {};
    int8_t att_q[HEADS_PARALLEL][D_HEADS] = {};
    int8_t att_k_cache[HEADS_PARALLEL][CONTEXT_LENGTH * D_HEADS] = {};
    int32_t val_scale_in[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
    int16_t softmax_in[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
    int8_t att_weights_in[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
    int8_t att_v_cache[HEADS_PARALLEL][D_HEADS * CONTEXT_LENGTH] = {};

    int32_t exp_q[HEADS_PARALLEL][D_HEADS] = {};
    int32_t exp_k[HEADS_PARALLEL][D_HEADS] = {};
    int32_t exp_v[HEADS_PARALLEL][D_HEADS] = {};
    int8_t exp_q_rq[HEADS_PARALLEL][D_HEADS] = {};
    int8_t exp_k_rq[HEADS_PARALLEL][D_HEADS] = {};
    int8_t exp_v_rq[HEADS_PARALLEL][D_HEADS] = {};
    int32_t exp_att_scores[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
    int16_t exp_val_scaled[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
    int16_t exp_softmax[HEADS_PARALLEL][CONTEXT_LENGTH] = {};
    int32_t exp_att_value[HEADS_PARALLEL][D_HEADS] = {};
    int8_t exp_head_rq[HEADS_PARALLEL][D_HEADS] = {};

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        init_inputs_lane(
            lane,
            q_act[lane],
            k_act[lane],
            v_act[lane],
            wq[lane],
            wk[lane],
            wv[lane],
            q_bias[lane],
            k_bias[lane],
            v_bias[lane],
            rq_q_in[lane],
            rq_k_in[lane],
            rq_v_in[lane],
            rq_head_in[lane],
            att_q[lane],
            att_k_cache[lane],
            val_scale_in[lane],
            softmax_in[lane],
            att_weights_in[lane],
            att_v_cache[lane]);

        compute_qkv_expected(q_act[lane], wq[lane], q_bias[lane], exp_q[lane]);
        compute_qkv_expected(k_act[lane], wk[lane], k_bias[lane], exp_k[lane]);
        compute_qkv_expected(v_act[lane], wv[lane], v_bias[lane], exp_v[lane]);
        requant_heads_expected(rq_q_in[lane], rq_M, rq_N, exp_q_rq[lane]);
        requant_heads_expected(rq_k_in[lane], rq_M, rq_N, exp_k_rq[lane]);
        requant_heads_expected(rq_v_in[lane], rq_M, rq_N, exp_v_rq[lane]);
        att_scores_expected(att_q[lane], att_k_cache[lane], exp_att_scores[lane]);
        value_scale_expected(val_scale_in[lane], exp_val_scaled[lane]);
        softmax_expected(softmax_in[lane], exp_softmax[lane]);
        att_value_expected(att_weights_in[lane], att_v_cache[lane], exp_att_value[lane]);
        requant_heads_expected(rq_head_in[lane], rq_M, rq_N, exp_head_rq[lane]);
    }

    auto op_name = [](ComputeOp op) {
        switch (op) {
            case ComputeOp::CMP_Q: return "CMP_Q";
            case ComputeOp::CMP_K: return "CMP_K";
            case ComputeOp::CMP_V: return "CMP_V";
            case ComputeOp::CMP_K_REQUANT: return "CMP_K_REQUANT";
            case ComputeOp::CMP_V_REQUANT: return "CMP_V_REQUANT";
            case ComputeOp::CMP_REQUANT_Q: return "CMP_REQUANT_Q";
            case ComputeOp::CMP_ATT_SCORES: return "CMP_ATT_SCORES";
            case ComputeOp::CMP_VALUE_SCALE: return "CMP_VALUE_SCALE";
            case ComputeOp::CMP_SOFTMAX: return "CMP_SOFTMAX";
            case ComputeOp::CMP_ATT_VALUE: return "CMP_ATT_VALUE";
            case ComputeOp::CMP_HEAD_REQUANT: return "CMP_HEAD_REQUANT";
            case ComputeOp::CMP_NONE: return "CMP_NONE";
            default: return "CMP_?";
        }
    };

    auto state_name = [](ComputeState st) {
        switch (st) {
            case ComputeState::IDLE: return "IDLE";
            case ComputeState::CAPTURE_INSTRUCTION: return "CAPTURE";
            case ComputeState::WAIT_MEM: return "WAIT_MEM";
            case ComputeState::EXECUTE: return "EXECUTE";
            case ComputeState::MEM_WRITEBACK: return "WRITEBK";
            case ComputeState::DONE: return "DONE";
            default: return "?";
        }
    };

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

    enum class MemPending { NONE, READ, WRITE };
    bool mem_busy[HEADS_PARALLEL] = {};
    int mem_timer[HEADS_PARALLEL] = {};
    int mem_done_hold[HEADS_PARALLEL] = {};
    MemPending mem_pending[HEADS_PARALLEL];
    uint32_t mem_op_lat[HEADS_PARALLEL] = {};
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        mem_pending[lane] = MemPending::NONE;
    }

    std::vector<bool> lane_done(HEADS_PARALLEL, false);

    enum class TbState { RESET, WAIT_READY, WAIT_DONE, DONE };
    TbState state = TbState::RESET;
    size_t step_idx = 0;

    auto tb_state_name = [](TbState st) {
        switch (st) {
            case TbState::RESET: return "RESET";
            case TbState::WAIT_READY: return "WAIT_READY";
            case TbState::WAIT_DONE: return "WAIT_DONE";
            case TbState::DONE: return "DONE";
            default: return "?";
        }
    };

    auto mem_pending_name = [](MemPending mp) {
        switch (mp) {
            case MemPending::NONE: return "NONE";
            case MemPending::READ: return "READ";
            case MemPending::WRITE: return "WRITE";
            default: return "?";
        }
    };

    auto print_vec_i8 = [](const char *label, const int8_t *v, int n) {
        std::printf("%s:", label);
        for (int i = 0; i < n; ++i) {
            std::printf(" %d", static_cast<int>(v[i]));
        }
        std::printf("\n");
    };
    auto print_vec_i16 = [](const char *label, const int16_t *v, int n) {
        std::printf("%s:", label);
        for (int i = 0; i < n; ++i) {
            std::printf(" %d", static_cast<int>(v[i]));
        }
        std::printf("\n");
    };
    auto print_vec_i32 = [](const char *label, const int32_t *v, int n) {
        std::printf("%s:", label);
        for (int i = 0; i < n; ++i) {
            std::printf(" %d", static_cast<int>(v[i]));
        }
        std::printf("\n");
    };
    auto print_vec_i4 = [](const char *label, const int4_t *v, int n) {
        std::printf("%s:", label);
        for (int i = 0; i < n; ++i) {
            std::printf(" %d", static_cast<int>(v[i]));
        }
        std::printf("\n");
    };
    auto print_mat_i4 = [](const char *label, const int4_t *m, int rows, int cols) {
        std::printf("%s:\n", label);
        for (int r = 0; r < rows; ++r) {
            std::printf("  %02d:", r);
            for (int c = 0; c < cols; ++c) {
                std::printf(" %d", static_cast<int>(m[r * cols + c]));
            }
            std::printf("\n");
        }
    };
    auto print_mat_i8 = [](const char *label, const int8_t *m, int rows, int cols) {
        std::printf("%s:\n", label);
        for (int r = 0; r < rows; ++r) {
            std::printf("  %02d:", r);
            for (int c = 0; c < cols; ++c) {
                std::printf(" %d", static_cast<int>(m[r * cols + c]));
            }
            std::printf("\n");
        }
    };

    auto dump_lane_issue = [&](int cycle, int lane, ComputeOp op) {
        std::printf("C%04d ISSUE lane=%d op=%s instr=0x%08X\n",
                    cycle, lane, op_name(op), ctx[lane].compute_instruction);
        switch (op) {
            case ComputeOp::CMP_Q:
            case ComputeOp::CMP_K:
            case ComputeOp::CMP_V: {
                const int8_t *act = (op == ComputeOp::CMP_Q) ? q_act[lane]
                                  : (op == ComputeOp::CMP_K) ? k_act[lane]
                                  : v_act[lane];
                const int4_t *w = (op == ComputeOp::CMP_Q) ? wq[lane]
                                 : (op == ComputeOp::CMP_K) ? wk[lane]
                                 : wv[lane];
                const int4_t *b = (op == ComputeOp::CMP_Q) ? q_bias[lane]
                                 : (op == ComputeOp::CMP_K) ? k_bias[lane]
                                 : v_bias[lane];
                const int32_t *exp = (op == ComputeOp::CMP_Q) ? exp_q[lane]
                                    : (op == ComputeOp::CMP_K) ? exp_k[lane]
                                    : exp_v[lane];
                print_vec_i8("  act", act, D_MODEL);
                print_mat_i4("  weights", w, D_HEADS, D_MODEL);
                print_vec_i4("  bias", b, D_HEADS);
                print_vec_i32("  exp_out", exp, D_HEADS);
                break;
            }
            case ComputeOp::CMP_K_REQUANT:
            case ComputeOp::CMP_V_REQUANT:
            case ComputeOp::CMP_REQUANT_Q:
            case ComputeOp::CMP_HEAD_REQUANT: {
                const int32_t *src = (op == ComputeOp::CMP_K_REQUANT) ? rq_k_in[lane]
                                  : (op == ComputeOp::CMP_V_REQUANT) ? rq_v_in[lane]
                                  : (op == ComputeOp::CMP_REQUANT_Q) ? rq_q_in[lane]
                                  : rq_head_in[lane];
                const int8_t *exp = (op == ComputeOp::CMP_K_REQUANT) ? exp_k_rq[lane]
                                 : (op == ComputeOp::CMP_V_REQUANT) ? exp_v_rq[lane]
                                 : (op == ComputeOp::CMP_REQUANT_Q) ? exp_q_rq[lane]
                                 : exp_head_rq[lane];
                print_vec_i32("  rq_in", src, D_HEADS);
                std::printf("  rq_M=%d rq_N=%d\n", static_cast<int>(rq_M), static_cast<int>(rq_N));
                print_vec_i8("  exp_out", exp, D_HEADS);
                break;
            }
            case ComputeOp::CMP_ATT_SCORES: {
                print_vec_i8("  att_q", att_q[lane], D_HEADS);
                print_mat_i8("  k_cache", att_k_cache[lane], CONTEXT_LENGTH, D_HEADS);
                print_vec_i32("  exp_scores", exp_att_scores[lane], CONTEXT_LENGTH);
                break;
            }
            case ComputeOp::CMP_VALUE_SCALE: {
                print_vec_i32("  val_in", val_scale_in[lane], CONTEXT_LENGTH);
                print_vec_i16("  exp_scaled", exp_val_scaled[lane], CONTEXT_LENGTH);
                break;
            }
            case ComputeOp::CMP_SOFTMAX: {
                print_vec_i16("  soft_in", softmax_in[lane], CONTEXT_LENGTH);
                print_vec_i16("  exp_softmax", exp_softmax[lane], CONTEXT_LENGTH);
                break;
            }
            case ComputeOp::CMP_ATT_VALUE: {
                print_vec_i8("  att_w", att_weights_in[lane], CONTEXT_LENGTH);
                print_mat_i8("  v_cache", att_v_cache[lane], D_HEADS, CONTEXT_LENGTH);
                print_vec_i32("  exp_out", exp_att_value[lane], D_HEADS);
                break;
            }
            case ComputeOp::CMP_NONE:
            default:
                std::printf("  (no inputs; expect error)\n");
                break;
        }
    };

    std::printf("Cycle-by-cycle trace\n");
    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        const bool reset_n = (cycle >= 2);

        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            ctx[lane].mem_transfer_done = false;
            if (mem_done_hold[lane] > 0) {
                ctx[lane].mem_transfer_done = true;
                --mem_done_hold[lane];
            }
            if (mem_busy[lane]) {
                if (mem_timer[lane] == 0) {
                    ctx[lane].mem_transfer_done = true;
                    mem_done_hold[lane] = 2;
                    mem_busy[lane] = false;
                    if (mem_pending[lane] == MemPending::READ) {
                        std::memset(in_buf[lane], 0, sizeof(in_buf[lane]));
                        const ComputeOp mem_op_code = static_cast<ComputeOp>(mem_op_lat[lane] & 0xFFu);
                        switch (mem_op_code) {
                            case ComputeOp::CMP_Q:
                            case ComputeOp::CMP_K:
                            case ComputeOp::CMP_V: {
                                const int bias_base = head_buf::QkvLayout::B;
                                const int8_t *act = (mem_op_code == ComputeOp::CMP_Q) ? q_act[lane]
                                                  : (mem_op_code == ComputeOp::CMP_K) ? k_act[lane]
                                                  : v_act[lane];
                                const int4_t *bias = (mem_op_code == ComputeOp::CMP_Q) ? q_bias[lane]
                                                    : (mem_op_code == ComputeOp::CMP_K) ? k_bias[lane]
                                                    : v_bias[lane];
                                for (int i = 0; i < D_MODEL; ++i) {
                                    compute_buf::write_i8(in_buf[lane], head_buf::QkvLayout::ACT + i, act[i]);
                                }
                                const int4_t *src = (mem_op_code == ComputeOp::CMP_Q) ? wq[lane]
                                                  : (mem_op_code == ComputeOp::CMP_K) ? wk[lane]
                                                  : wv[lane];
                                for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
                                    compute_buf::write_i4(in_buf[lane], (head_buf::QkvLayout::W * 2) + i, src[i]);
                                }
                                for (int h = 0; h < D_HEADS; ++h) {
                                    compute_buf::write_i4(in_buf[lane], (bias_base * 2) + h, bias[h]);
                                }
                                break;
                            }
                            case ComputeOp::CMP_K_REQUANT:
                            case ComputeOp::CMP_V_REQUANT:
                            case ComputeOp::CMP_REQUANT_Q:
                            case ComputeOp::CMP_HEAD_REQUANT: {
                                const int32_t *src = (mem_op_code == ComputeOp::CMP_K_REQUANT) ? rq_k_in[lane]
                                                  : (mem_op_code == ComputeOp::CMP_V_REQUANT) ? rq_v_in[lane]
                                                  : (mem_op_code == ComputeOp::CMP_REQUANT_Q) ? rq_q_in[lane]
                                                  : rq_head_in[lane];
                                for (int h = 0; h < D_HEADS; ++h) {
                                    compute_buf::write_i32(in_buf[lane], head_buf::HeadRequantLayout::X + (h * 4), src[h]);
                                }
                                compute_buf::write_i32(in_buf[lane], head_buf::HeadRequantLayout::M, rq_M);
                                compute_buf::write_i32(in_buf[lane], head_buf::HeadRequantLayout::N, rq_N);
                                break;
                            }
                            case ComputeOp::CMP_ATT_SCORES: {
                                for (int h = 0; h < D_HEADS; ++h) {
                                    compute_buf::write_i8(in_buf[lane], head_buf::AttScoresLayout::Q + h, att_q[lane][h]);
                                }
                                for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
                                    compute_buf::write_i8(in_buf[lane], head_buf::AttScoresLayout::K_CACHE + i, att_k_cache[lane][i]);
                                }
                                break;
                            }
                            case ComputeOp::CMP_VALUE_SCALE: {
                                for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                    compute_buf::write_i32(in_buf[lane], head_buf::ValueScaleLayout::X + (t * 4), val_scale_in[lane][t]);
                                }
                                break;
                            }
                            case ComputeOp::CMP_SOFTMAX: {
                                for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                    compute_buf::write_i16(in_buf[lane], head_buf::SoftmaxLayout::X + (t * 2), softmax_in[lane][t]);
                                }
                                break;
                            }
                            case ComputeOp::CMP_ATT_VALUE: {
                                for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                    compute_buf::write_i8(in_buf[lane], head_buf::AttValueLayout::WEIGHTS + t, att_weights_in[lane][t]);
                                }
                                for (int i = 0; i < D_HEADS * CONTEXT_LENGTH; ++i) {
                                    compute_buf::write_i8(in_buf[lane], head_buf::AttValueLayout::V_CACHE + i, att_v_cache[lane][i]);
                                }
                                break;
                            }
                            case ComputeOp::CMP_NONE:
                            default:
                                break;
                        }
                    }
                    mem_pending[lane] = MemPending::NONE;
                } else {
                    --mem_timer[lane];
                }
            }
        }

        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            ctx[lane].compute_start = false;
            if (step_idx < steps.size()) {
                ctx[lane].compute_instruction = make_instruction(steps[step_idx].op, 0, lane, tile_field);
            }
        }

        if (!reset_n) {
            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                lane_done[lane] = false;
                mem_busy[lane] = false;
                mem_timer[lane] = 0;
                mem_pending[lane] = MemPending::NONE;
            }
            state = TbState::RESET;
            drive_headed_compute_controller(ctx, false, in_buf, out_buf, dbg_head_vec, dbg_head_out, error);
            continue;
        }

        switch (state) {
            case TbState::RESET: {
                bool all_ready = true;
                for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                    all_ready = all_ready && ctx[lane].compute_ready;
                }
                if (all_ready && !steps.empty()) {
                    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                        ctx[lane].compute_start = true;
                        lane_done[lane] = false;
                    }
                    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                        dump_lane_issue(cycle, lane, steps[step_idx].op);
                    }
                    state = TbState::WAIT_DONE;
                }
                break;
            }
            case TbState::WAIT_READY: {
                bool all_ready = true;
                for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                    all_ready = all_ready && ctx[lane].compute_ready;
                }
                if (all_ready) {
                    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                        ctx[lane].compute_start = true;
                        lane_done[lane] = false;
                    }
                    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                        dump_lane_issue(cycle, lane, steps[step_idx].op);
                    }
                    state = TbState::WAIT_DONE;
                }
                break;
            }
            case TbState::WAIT_DONE:
            case TbState::DONE:
            default:
                break;
        }

        drive_headed_compute_controller(ctx, reset_n, in_buf, out_buf, dbg_head_vec, dbg_head_out, error);

        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (!mem_busy[lane]) {
                if (ctx[lane].mem_read_request) {
                    mem_busy[lane] = true;
                    mem_timer[lane] = MEM_LAT - 1;
                    mem_pending[lane] = MemPending::READ;
                    mem_op_lat[lane] = ctx[lane].mem_op;
                } else if (ctx[lane].mem_write_request) {
                    mem_busy[lane] = true;
                    mem_timer[lane] = MEM_LAT - 1;
                    mem_pending[lane] = MemPending::WRITE;
                    mem_op_lat[lane] = ctx[lane].mem_op;
                }
            }
        }

        std::printf("C%04d TB=%s Step=%s Err=%d\n",
                    cycle,
                    tb_state_name(state),
                    (step_idx < steps.size()) ? op_name(steps[step_idx].op) : "DONE",
                    error ? 1 : 0);
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            std::printf(
                "  L%d st=%s rdy=%d dn=%d start=%d memR=%d memW=%d memOp=0x%08X memBusy=%d memT=%d pend=%s macR=%d macC=%d macB=%d errL=%d\n",
                lane,
                state_name(ctx[lane].state),
                ctx[lane].compute_ready ? 1 : 0,
                ctx[lane].compute_done ? 1 : 0,
                ctx[lane].compute_start ? 1 : 0,
                ctx[lane].mem_read_request ? 1 : 0,
                ctx[lane].mem_write_request ? 1 : 0,
                ctx[lane].mem_op,
                mem_busy[lane] ? 1 : 0,
                mem_timer[lane],
                mem_pending_name(mem_pending[lane]),
                ctx[lane].mac_ready ? 1 : 0,
                ctx[lane].mac_complete ? 1 : 0,
                ctx[lane].mac_busy ? 1 : 0,
                ctx[lane].error_latched ? 1 : 0);
        }

        if (state == TbState::WAIT_DONE) {
            bool all_done = true;
            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                if (ctx[lane].compute_done) {
                    lane_done[lane] = true;
                }
                all_done = all_done && lane_done[lane];
            }

            if (all_done) {
                const ComputeOp op = steps[step_idx].op;
                for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                    dump_dbg_head_vec(lane, dbg_head_vec[lane]);
                    dump_dbg_head_out(lane, dbg_head_out[lane]);
                    switch (op) {
                        case ComputeOp::CMP_Q: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int32_t got = compute_buf::read_i32(out_buf[lane], h * 4);
                                if (got != exp_q[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_Q head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_q[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_K: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int32_t got = compute_buf::read_i32(out_buf[lane], h * 4);
                                if (got != exp_k[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_K head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_k[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_V: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int32_t got = compute_buf::read_i32(out_buf[lane], h * 4);
                                if (got != exp_v[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_V head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_v[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_K_REQUANT: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int8_t got = compute_buf::read_i8(out_buf[lane], head_buf::HeadRequantLayout::X + h);
                                if (got != exp_k_rq[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_K_REQUANT head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_k_rq[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_V_REQUANT: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int8_t got = compute_buf::read_i8(out_buf[lane], head_buf::HeadRequantLayout::X + h);
                                if (got != exp_v_rq[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_V_REQUANT head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_v_rq[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT_Q: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int8_t got = compute_buf::read_i8(out_buf[lane], head_buf::HeadRequantLayout::X + h);
                                if (got != exp_q_rq[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_REQUANT_Q head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_q_rq[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_ATT_SCORES: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                const int32_t got = compute_buf::read_i32(out_buf[lane], t * 4);
                                if (got != exp_att_scores[lane][t]) {
                                    std::fprintf(stderr, "Lane %d CMP_ATT_SCORES t %d got %d expected %d\n",
                                                 lane, t, static_cast<int>(got), static_cast<int>(exp_att_scores[lane][t]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_VALUE_SCALE: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                const int16_t got = compute_buf::read_i16(out_buf[lane], t * 2);
                                if (got != exp_val_scaled[lane][t]) {
                                    std::fprintf(stderr, "Lane %d CMP_VALUE_SCALE t %d got %d expected %d\n",
                                                 lane, t, static_cast<int>(got), static_cast<int>(exp_val_scaled[lane][t]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_SOFTMAX: {
                            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                                const int16_t got = compute_buf::read_i16(out_buf[lane], t * 2);
                                if (got != exp_softmax[lane][t]) {
                                    std::fprintf(stderr, "Lane %d CMP_SOFTMAX t %d got %d expected %d\n",
                                                 lane, t, static_cast<int>(got), static_cast<int>(exp_softmax[lane][t]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_ATT_VALUE: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int32_t got = compute_buf::read_i32(out_buf[lane], h * 4);
                                if (got != exp_att_value[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_ATT_VALUE head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_att_value[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_HEAD_REQUANT: {
                            for (int h = 0; h < D_HEADS; ++h) {
                                const int8_t got = compute_buf::read_i8(out_buf[lane], head_buf::HeadRequantLayout::X + h);
                                if (got != exp_head_rq[lane][h]) {
                                    std::fprintf(stderr, "Lane %d CMP_HEAD_REQUANT head %d got %d expected %d\n",
                                                 lane, h, static_cast<int>(got), static_cast<int>(exp_head_rq[lane][h]));
                                    return 1;
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_NONE: {
                            if (!error) {
                                std::fprintf(stderr, "Lane %d CMP_NONE did not assert error.\n", lane);
                                return 1;
                            }
                            break;
                        }
                        default:
                            break;
                    }
                }

                ++step_idx;
                if (step_idx >= steps.size()) {
                    state = TbState::DONE;
                } else {
                    state = TbState::WAIT_READY;
                }
            }
        }

        if (state == TbState::DONE) {
            break;
        }
    }

    if (state != TbState::DONE) {
        std::fprintf(stderr, "Parallel TB timed out before completion.\n");
        return 1;
    }

    std::printf("headed_compute_controller_parallel_tb: PASS (lanes=%d)\n", HEADS_PARALLEL);
    return 0;
}
