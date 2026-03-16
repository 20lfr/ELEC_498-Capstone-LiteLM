#include <cstdint>
#include <cstdio>
#include <cstring>
#include <cerrno>
#include <string>
#include <sys/stat.h>

#include "../../tb_paths.hpp"
#include "headed_compute_controller.hpp"

namespace {

struct HeadStep {
    int lane;
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

static const char *op_name(ComputeOp op) {
    switch (op) {
        case CMP_Q: return "CMP_Q";
        case CMP_K: return "CMP_K";
        case CMP_V: return "CMP_V";
        case CMP_ATT_SCORES: return "CMP_ATT_SCORES";
        case CMP_VALUE_SCALE: return "CMP_VALUE_SCALE";
        case CMP_SOFTMAX: return "CMP_SOFTMAX";
        case CMP_ATT_VALUE: return "CMP_ATT_VALUE";
        case CMP_HEAD_REQUANT: return "CMP_HEAD_REQUANT";
        default: return "OTHER";
    }
}

static void fill_qkv_buf(uint8_t *in_buf) {
    std::memset(in_buf, 0, head_buf::IN_BUF_BYTES);
    for (int i = 0; i < D_MODEL; ++i) {
        compute_buf::write_i8(in_buf, head_buf::INQkvLayout::ACT + i, static_cast<int8_t>((i % 13) - 6));
    }
    for (int i = 0; i < D_MODEL * D_HEAD_TILE_QKV; ++i) {
        compute_buf::write_i8(in_buf, head_buf::INQkvLayout::W + i, static_cast<int8_t>((i % 5) - 2));
    }
    for (int out = 0; out < D_HEAD_TILE_QKV; ++out) {
        compute_buf::write_i32(in_buf, head_buf::INQkvLayout::B + (out * 4), (out % 3) - 1);
    }
}

static void fill_att_scores_buf(uint8_t *in_buf) {
    std::memset(in_buf, 0, head_buf::IN_BUF_BYTES);
    for (int h = 0; h < D_HEADS; ++h) {
        compute_buf::write_i8(in_buf, head_buf::INAttScoresLayout::Q + h, static_cast<int8_t>((h % 7) - 3));
    }
    for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
        for (int h = 0; h < D_HEADS; ++h) {
            const int idx = t * D_HEADS + h;
            compute_buf::write_i8(in_buf, head_buf::INAttScoresLayout::K_CACHE + idx,
                                  static_cast<int8_t>(((t + h) % 17) - 8));
        }
    }
}

static void fill_value_scale_buf(uint8_t *in_buf) {
    std::memset(in_buf, 0, head_buf::IN_BUF_BYTES);
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        // Small int32 so scaled stays well in int16 range.
        compute_buf::write_i32(in_buf, head_buf::INValueScaleLayout::X + (t * 4),
                               static_cast<int32_t>(((t % 17) - 8) * 100));
    }
}

static void fill_softmax_buf(uint8_t *in_buf) {
    std::memset(in_buf, 0, head_buf::IN_BUF_BYTES);
    // Q1.15 logits: max at index 0, rest negative so diff in [-1, 0].
    compute_buf::write_i16(in_buf, head_buf::INSoftmaxLayout::X + 0, 0);
    for (int t = 1; t < CONTEXT_LENGTH; ++t) {
        const int16_t v = static_cast<int16_t>(-((t % 256) * 128)); // down to about -0.996 in Q1.15
        compute_buf::write_i16(in_buf, head_buf::INSoftmaxLayout::X + (t * 2), v);
    }
}

static void fill_att_value_buf(uint8_t *in_buf) {
    std::memset(in_buf, 0, head_buf::IN_BUF_BYTES);
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        compute_buf::write_i16(in_buf, head_buf::INAttValueLayout::WEIGHTS + (t * 2),
                               static_cast<int16_t>((t % 31) - 15));
    }
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        for (int h = 0; h < D_HEAD_TILE_ATT_VALUE; ++h) {
            const int idx = (h * CONTEXT_LENGTH) + t;
            compute_buf::write_i8(in_buf, head_buf::INAttValueLayout::V_CACHE + idx,
                                  static_cast<int8_t>(((t * 2 + h) % 19) - 9));
        }
    }
}

static void fill_head_requant_buf(uint8_t *in_buf) {
    std::memset(in_buf, 0, head_buf::IN_BUF_BYTES);
    for (int i = 0; i < D_HEADS; ++i) {
        compute_buf::write_i32(in_buf, head_buf::INHeadRequantLayout::X + (i * 4), (i - 2) * 1536);
    }
}

static void fill_inputs_for_step(uint8_t *in_buf, ComputeOp op) {
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V:
            fill_qkv_buf(in_buf);
            break;
        case CMP_ATT_SCORES:
            fill_att_scores_buf(in_buf);
            break;
        case CMP_VALUE_SCALE:
            fill_value_scale_buf(in_buf);
            break;
        case CMP_SOFTMAX:
            fill_softmax_buf(in_buf);
            break;
        case CMP_ATT_VALUE:
            fill_att_value_buf(in_buf);
            break;
        case CMP_HEAD_REQUANT:
            fill_head_requant_buf(in_buf);
            break;
        default:
            std::memset(in_buf, 0, head_buf::IN_BUF_BYTES);
            break;
    }
}

static void print_lane_out_sample(const uint8_t *out_buf, ComputeOp op) {
    std::printf("  out sample: ");
    switch (op) {
        case CMP_ATT_SCORES: {
            for (int i = 0; i < head_buf::OUTAttScoresLayout::NUM_ELEMS; ++i) {
                std::printf("%d ", static_cast<int>(compute_buf::read_i32(out_buf, i * 4)));
            }
            break;
        }
        case CMP_ATT_VALUE: {
            for (int i = 0; i < head_buf::OUTAttValueLayout::NUM_ELEMS; ++i) {
                std::printf("%d ", static_cast<int>(compute_buf::read_i32(out_buf, i * 4)));
            }
            break;
        }
        default: {
            for (int i = 0; i < head_buf::OUTQkvLayout::NUM_ELEMS; ++i) {
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
    const std::string tb_dir = base_dir + "/headed_compute_controller_tb";
    const std::string stdout_path = tb_dir + "/headed_compute_controller_tb_stdout.log";
    const std::string stderr_path = tb_dir + "/headed_compute_controller_tb_stderr.log";

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

static inline uint16_t exp_approx_q15(int16_t x_q15) {
    // Matches headed_compute_controller.cpp exp_approx_q15
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
    if (x_q15 >= 0) return 32767;
    if (x_q15 <= -32768) return exp_lut_q15[0];
    const uint16_t idx = static_cast<uint16_t>((static_cast<int32_t>(x_q15) - (-32768)) >> 7);
    return exp_lut_q15[idx];
}

static int out_bytes_for_op(ComputeOp op) {
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V: return head_buf::OUTQkvLayout::TOTAL_BYTES;
        case CMP_ATT_SCORES: return head_buf::OUTAttScoresLayout::TOTAL_BYTES;
        case CMP_VALUE_SCALE: return head_buf::OUTValueScaleLayout::TOTAL_BYTES;
        case CMP_SOFTMAX: return head_buf::OUTSoftmaxLayout::TOTAL_BYTES;
        case CMP_ATT_VALUE: return head_buf::OUTAttValueLayout::TOTAL_BYTES;
        case CMP_HEAD_REQUANT: return head_buf::OUTHeadRequantLayout::TOTAL_BYTES;
        default: return 0;
    }
}

static void compute_expected_out_buf(ComputeOp op,
                                     uint8_t layer,
                                     const uint8_t *in_buf,
                                     uint8_t *expected_out) {
    std::memset(expected_out, 0, head_buf::OUT_BUF_BYTES);
    int layer_i = static_cast<int>(layer);
    if (layer_i < 0 || layer_i >= MODEL_LAYERS) layer_i = 0;

    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V: {
            int32_t M = 1;
            int32_t n = 0;
            switch (op) {
                case CMP_Q: M = requant_params::REQUANT_Q_M_L[layer_i]; n = requant_params::REQUANT_Q_N_L[layer_i]; break;
                case CMP_K: M = requant_params::REQUANT_K_M_L[layer_i]; n = requant_params::REQUANT_K_N_L[layer_i]; break;
                case CMP_V: M = requant_params::REQUANT_V_M_L[layer_i]; n = requant_params::REQUANT_V_N_L[layer_i]; break;
                default: break;
            }
            for (int out = 0; out < D_HEAD_TILE_QKV; ++out) {
                int32_t acc = compute_buf::read_i32(in_buf, head_buf::INQkvLayout::B + out * 4);
                for (int i = 0; i < D_MODEL; ++i) {
                    const int8_t a = compute_buf::read_i8(in_buf, head_buf::INQkvLayout::ACT + i);
                    const int8_t w = compute_buf::read_i8(in_buf, head_buf::INQkvLayout::W + out * D_MODEL + i);
                    acc += static_cast<int32_t>(a) * static_cast<int32_t>(w);
                }
                compute_buf::write_i8(expected_out, head_buf::OUTQkvLayout::Y + out,
                                      requant_scalar_to_i8(acc, M, n));
            }
            break;
        }
        case CMP_ATT_SCORES: {
            for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
                int32_t acc = 0;
                for (int d = 0; d < D_HEADS; ++d) {
                    const int8_t q = compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::Q + d);
                    const int8_t k = compute_buf::read_i8(in_buf, head_buf::INAttScoresLayout::K_CACHE + t * D_HEADS + d);
                    acc += static_cast<int32_t>(q) * static_cast<int32_t>(k);
                }
                compute_buf::write_i32(expected_out, head_buf::OUTAttScoresLayout::X + t * 4, acc);
            }
            break;
        }
        case CMP_VALUE_SCALE: {
            for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                const int32_t x = compute_buf::read_i32(in_buf, head_buf::INValueScaleLayout::X + t * 4);
                int64_t prod = static_cast<int64_t>(x) * static_cast<int64_t>(ATTN_SCALE_Q15);
                int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
                int32_t scaled = static_cast<int32_t>(rounded >> 15);
                if (scaled > 32767) scaled = 32767;
                else if (scaled < -32768) scaled = -32768;
                compute_buf::write_i16(expected_out, head_buf::OUTValueScaleLayout::X + t * 2,
                                       static_cast<int16_t>(scaled));
            }
            break;
        }
        case CMP_SOFTMAX: {
            // Matches headed_compute_controller.cpp SOFTMAX_TO_BUF.
            int16_t max_val = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X);
            for (int i = 1; i < CONTEXT_LENGTH; ++i) {
                const int16_t v = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + i * 2);
                if (v > max_val) max_val = v;
            }

            uint16_t exp_buf[CONTEXT_LENGTH];
            uint32_t sum_exp = 0;
            for (int i = 0; i < CONTEXT_LENGTH; ++i) {
                const int16_t v = compute_buf::read_i16(in_buf, head_buf::INSoftmaxLayout::X + i * 2);
                const int16_t diff = static_cast<int16_t>(v - max_val);
                const uint16_t e = exp_approx_q15(diff);
                exp_buf[i] = e;
                sum_exp += e;
            }

            uint32_t inv_sum_q15 = 0;
            if (sum_exp > 0) {
                const uint64_t num = (1ULL << 30);
                inv_sum_q15 = static_cast<uint32_t>((num + (sum_exp / 2)) / sum_exp);
            }

            const uint16_t MAX_Q15 = (1u << 15) - 1;
            for (int i = 0; i < CONTEXT_LENGTH; ++i) {
                const uint64_t tmp = static_cast<uint64_t>(exp_buf[i]) * static_cast<uint64_t>(inv_sum_q15);
                uint16_t prob_q15 = static_cast<uint16_t>(tmp >> 15);
                if (prob_q15 > MAX_Q15) prob_q15 = MAX_Q15;
                compute_buf::write_i16(expected_out, head_buf::OUTSoftmaxLayout::X + i * 2,
                                       static_cast<int16_t>(prob_q15));
            }
            break;
        }
        case CMP_ATT_VALUE: {
            for (int d = 0; d < D_HEAD_TILE_ATT_VALUE; ++d) {
                int32_t acc = 0;
                for (int t = 0; t < CONTEXT_LENGTH; ++t) {
                    const int16_t w = compute_buf::read_i16(in_buf, head_buf::INAttValueLayout::WEIGHTS + t * 2);
                    const int8_t v = compute_buf::read_i8(in_buf, head_buf::INAttValueLayout::V_CACHE + d * CONTEXT_LENGTH + t);
                    acc += static_cast<int32_t>(w) * static_cast<int32_t>(v);
                }
                compute_buf::write_i32(expected_out, head_buf::OUTAttValueLayout::Y + d * 4, acc);
            }
            break;
        }
        case CMP_HEAD_REQUANT: {
            const int32_t M = requant_params::REQUANT_HEAD_M_L[layer_i];
            const int32_t n = requant_params::REQUANT_HEAD_N_L[layer_i];
            for (int i = 0; i < D_HEADS; ++i) {
                const int32_t x = compute_buf::read_i32(in_buf, head_buf::INHeadRequantLayout::X + i * 4);
                compute_buf::write_i8(expected_out, head_buf::OUTHeadRequantLayout::X + i,
                                      requant_scalar_to_i8(x, M, n));
            }
            break;
        }
        default:
            break;
    }
}

static bool check_out_buf(const HeadStep &step,
                          const uint8_t *in_buf,
                          const uint8_t *out_buf) {
    uint8_t expected[head_buf::OUT_BUF_BYTES]{};
    compute_expected_out_buf(step.op, step.layer, in_buf, expected);
    const int bytes = out_bytes_for_op(step.op);
    if (bytes <= 0) return true;
    if (std::memcmp(out_buf, expected, static_cast<size_t>(bytes)) == 0) {
        return true;
    }
    std::fprintf(stderr, "[TB][MISMATCH] op=%s bytes=%d\n", op_name(step.op), bytes);
    for (int b = 0; b < bytes; ++b) {
        if (out_buf[b] == expected[b]) continue;
        switch (step.op) {
            case CMP_ATT_SCORES:
            case CMP_ATT_VALUE: {
                const int idx = b / 4;
                const int32_t got = compute_buf::read_i32(out_buf, idx * 4);
                const int32_t exp = compute_buf::read_i32(expected, idx * 4);
                std::fprintf(stderr, "  first diff i32[%d]: got=%d exp=%d\n", idx, got, exp);
                break;
            }
            case CMP_VALUE_SCALE:
            case CMP_SOFTMAX: {
                const int idx = b / 2;
                const int16_t got = compute_buf::read_i16(out_buf, idx * 2);
                const int16_t exp = compute_buf::read_i16(expected, idx * 2);
                std::fprintf(stderr, "  first diff i16[%d]: got=%d exp=%d\n", idx, (int)got, (int)exp);
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

} // namespace

int main() {
    if (!init_tb_logs()) {
        return 1;
    }
    constexpr HeadStep steps[] = {
        {0, CMP_Q,            0, 0, 0, "LANE0_Q"},
        {1, CMP_K,            0, 1, 0, "LANE1_K"},
        {0, CMP_V,            0, 0, 0, "LANE0_V"},
        {0, CMP_ATT_SCORES,   0, 0, 0, "LANE0_ATT_SCORES"},
        {1, CMP_VALUE_SCALE,  0, 1, -1, "LANE1_VALUE_SCALE"},
        {1, CMP_SOFTMAX,      0, 1, -1, "LANE1_SOFTMAX"},
        {1, CMP_ATT_VALUE,    0, 1, 0, "LANE1_ATT_VALUE"},
        {0, CMP_HEAD_REQUANT, 0, 0, -1, "LANE0_HEAD_REQUANT"}
    };

    ComputeHeadCtx ctx[HEADS_PARALLEL]{};
    uint8_t in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES]{};
    uint8_t out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES]{};

    bool error = false;
    int cycle = 0;

    int mem_timer[HEADS_PARALLEL];
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        mem_timer[lane] = -1;
    }

    std::printf("%8s | %-18s | %6s | %-10s | %4s | %4s | %8s | %8s | %-10s | %-10s\n",
                "cycle", "step", "lane", "state", "mr", "mw", "mem_done", "cmp_done", "lane0", "lane1");

    for (const HeadStep &step : steps) {
        fill_inputs_for_step(in_buf[step.lane], step.op);
        std::memset(out_buf[step.lane], 0, head_buf::OUT_BUF_BYTES);

        bool issued = false;
        for (int local = 0; local < 300; ++local, ++cycle) {
            const bool reset_n = (cycle >= 2);

            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                ctx[lane].compute_start = false;
                ctx[lane].mem_transfer_done = false;

                if (mem_timer[lane] >= 0) {
                    if (mem_timer[lane] == 0) {
                        ctx[lane].mem_transfer_done = true;
                        mem_timer[lane] = -1;
                    } else {
                        --mem_timer[lane];
                    }
                }
            }

            if (!issued && ctx[step.lane].compute_ready) {
                ctx[step.lane].compute_instruction = make_instruction(step.op, step.layer, step.head, step.tile);
                ctx[step.lane].compute_start = true;
                issued = true;
            }

            drive_headed_compute_controller(ctx, reset_n, in_buf, out_buf, error);

            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
                if ((ctx[lane].mem_read_request || ctx[lane].mem_write_request) && mem_timer[lane] < 0) {
                    mem_timer[lane] = 1;
                }
            }

            std::printf("%8d | %-18s | %6d | %-10s | %4d | %4d | %8d | %8d | %-10s | %-10s\n",
                        cycle,
                        step.name,
                        step.lane,
                        state_name(ctx[step.lane].state),
                        ctx[step.lane].mem_read_request ? 1 : 0,
                        ctx[step.lane].mem_write_request ? 1 : 0,
                        ctx[step.lane].mem_transfer_done ? 1 : 0,
                        ctx[step.lane].compute_done ? 1 : 0,
                        state_name(ctx[0].state),
                        state_name(ctx[1].state));

            if (error) {
                std::fprintf(stderr, "[TB][ERROR] headed controller error on %s at cycle %d\n", step.name, cycle);
                return 1;
            }

            if (ctx[step.lane].compute_done) {
                std::printf("[TB] step %-18s complete (%s)\n", step.name, op_name(step.op));
                print_lane_out_sample(out_buf[step.lane], step.op);
                if (!check_out_buf(step, in_buf[step.lane], out_buf[step.lane])) {
                    std::fprintf(stderr, "[TB][ERROR] golden check failed on %s\n", step.name);
                    return 3;
                }
                break;
            }

            if (local == 299) {
                std::fprintf(stderr, "[TB][ERROR] timeout on step %s\n", step.name);
                return 2;
            }
        }
    }

    std::printf("[TB] headed compute controller test complete\n");
    return 0;
}
