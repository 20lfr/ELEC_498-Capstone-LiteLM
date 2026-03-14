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
    int8_t tile;
    const char *name;
};

static inline uint32_t make_instruction(ComputeOp op, uint8_t layer, int8_t head, int8_t tile) {
    return static_cast<uint32_t>(op)
        | (static_cast<uint32_t>(layer) << 8)
        | (static_cast<uint32_t>(static_cast<uint8_t>(head)) << 16)
        | (static_cast<uint32_t>(static_cast<uint8_t>(tile)) << 24);
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
        case CMP_ATT_SCORES: return "CMP_ATT_SCORES";
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
            fill_qkv_buf(in_buf);
            break;
        case CMP_ATT_SCORES:
            fill_att_scores_buf(in_buf);
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

} // namespace

int main() {
    if (!init_tb_logs()) {
        return 1;
    }
    constexpr HeadStep steps[] = {
        {0, CMP_Q,            0, 0, 0, "LANE0_Q"},
        {1, CMP_K,            0, 1, 0, "LANE1_K"},
        {0, CMP_ATT_SCORES,   0, 0, 0, "LANE0_ATT_SCORES"},
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
