#include <cstdint>
#include <cstdio>
#include <cerrno>
#include <sys/stat.h>

#include "Scheduler_FSM.hpp"

namespace {

static inline uint32_t pack_dma_instruction(DmaSel sel, int layer, int head, int tile) {
    return (static_cast<uint32_t>(sel) & 0xFFu)
         | ((static_cast<uint32_t>(layer) & 0xFFu) << 8)
         | ((static_cast<uint32_t>(head) & 0xFFu) << 16)
         | ((static_cast<uint32_t>(tile) & 0xFFu) << 24);
}

static inline DmaSel decode_dma_sel(uint32_t instr) {
    return static_cast<DmaSel>(instr & 0xFFu);
}

static const char *state_name(SchedState st) {
    switch (st) {
        case S_IDLE: return "S_IDLE";
        case S_STREAM_IN: return "S_STREAM_IN";
        case S_LAYER_COUNT: return "S_LAYER_COUNT";
        case S_ATTENTION_HEADS: return "S_ATTENTION_HEADS";
        case S_HEAD_CONCAT: return "S_HEAD_CONCAT";
        case S_OUT_PROJECTION: return "S_OUT_PROJECTION";
        case S_RES_ADD_1: return "S_RES_ADD_1";
        case S_LAYER_NORM_0: return "S_LAYER_NORM_0";
        case S_FFN: return "S_FFN";
        case S_RES_ADD_2: return "S_RES_ADD_2";
        case S_LAYER_NORM_1: return "S_LAYER_NORM_1";
        case S_LOOP_CHECK: return "S_LOOP_CHECK";
        case S_FINAL_NORM: return "S_FINAL_NORM";
        case S_STREAM_OUT: return "S_STREAM_OUT";
        default: return "UNKNOWN";
    }
}

static const char *phase_name(HeadPhase ph) {
    switch (ph) {
        case HeadPhase::IDLE: return "IDLE";
        case HeadPhase::Q: return "Q";
        case HeadPhase::K: return "K";
        case HeadPhase::K_REQUANT: return "K_RQ";
        case HeadPhase::K_WRITEBACK: return "K_WR";
        case HeadPhase::V: return "V";
        case HeadPhase::V_REQUANT: return "V_RQ";
        case HeadPhase::V_WRITEBACK: return "V_WR";
        case HeadPhase::REQUANT_Q: return "RQ_Q";
        case HeadPhase::ATT_SCORES: return "ATT";
        case HeadPhase::VALUE_SCALE_CLAMP: return "VAL_SCL";
        case HeadPhase::ATT_SOFTMAX: return "SOFTMAX";
        case HeadPhase::ATT_VALUE: return "ATT_VAL";
        case HeadPhase::HEAD_REQUANT: return "HEAD_RQ";
        case HeadPhase::DONE: return "DONE";
        default: return "?";
    }
}

static bool ensure_dir(const char *path) {
    if (mkdir(path, 0777) == 0) {
        return true;
    }
    return (errno == EEXIST);
}

static bool init_tb_logs() {
    const char *base_dir = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs";
    const char *tb_dir = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs/scheduler_tb";
    const char *stdout_path = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs/scheduler_tb/scheduler_tb_stdout.log";
    const char *stderr_path = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs/scheduler_tb/scheduler_tb_stderr.log";

    if (!ensure_dir(base_dir) || !ensure_dir(tb_dir)) {
        std::fprintf(stderr, "[TB][ERROR] failed to create log directories\n");
        return false;
    }
    if (std::freopen(stdout_path, "w", stdout) == nullptr) {
        std::fprintf(stderr, "[TB][ERROR] failed to open stdout log: %s\n", stdout_path);
        return false;
    }
    if (std::freopen(stderr_path, "w", stderr) == nullptr) {
        std::fprintf(stdout, "[TB][ERROR] failed to open stderr log: %s\n", stderr_path);
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
    constexpr int MAX_CYCLES = 4000;
    constexpr int AXIS_BEATS = 3;
    constexpr int DMA_LAT = 2;
    constexpr int CMP_LAT = 2;

    ControlMemSpace ctrl_mem{};
    StatusMemSpace status_mem{};

    bool axis_in_valid = false;
    bool axis_in_last = false;
    bool axis_in_ready = false;
    bool axis_in_start = false;

    bool dma_done = false;
    bool wl_ready = true;
    bool wl_accept = false;
    uint32_t wl_instruction = pack_dma_instruction(DMASEL_NONE, 0, -1, -1);
    bool wl_start = false;

    bool compute_ready = true;
    bool compute_done = false;
    bool compute_start = false;
    uint32_t compute_instruction = 0;

    bool stream_ready = true;
    bool stream_start = false;
    bool stream_done = false;

    bool done = false;
    bool error = false;
    SchedState state = S_IDLE;

    HeadCtx head_ctx[NUM_HEADS]{};
    for (int h = 0; h < NUM_HEADS; ++h) {
        head_ctx[h].head_idx = h;
        head_ctx[h].phase = HeadPhase::IDLE;
    }

    int head_group_idx = 0;

    int axis_sent = 0;
    bool axis_feed_done = false;

    int main_dma_timer = -1;
    int main_cmp_timer = -1;
    bool main_accept_pulse = false;

    int head_dma_timer[NUM_HEADS];
    int head_cmp_timer[NUM_HEADS];
    bool head_accept_pulse[NUM_HEADS];
    for (int h = 0; h < NUM_HEADS; ++h) {
        head_dma_timer[h] = -1;
        head_cmp_timer[h] = -1;
        head_accept_pulse[h] = false;
    }

    bool seen_att_heads = false;
    bool seen_stream_out = false;

    std::printf("%8s | %5s | %-18s | %6s | %6s | %6s | %8s | %8s | %9s | %9s | %7s | %7s | %-35s | %-35s\n",
                "cycle", "rst", "state", "axis_v", "axis_l", "axis_r",
                "wl_st", "wl_acc", "cmp_st", "cmp_dn", "done", "err",
                "head0", "head1");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        const bool reset_n = (cycle >= 2);
        ctrl_mem.control = reset_n ? CTRL_RESETN_BIT : 0u;
        if (cycle == 3) {
            ctrl_mem.control = CTRL_RESETN_BIT | CTRL_START_BIT;
        }

        wl_accept = main_accept_pulse;
        main_accept_pulse = false;

        dma_done = false;
        if (main_dma_timer >= 0) {
            if (main_dma_timer == 0) {
                dma_done = true;
                main_dma_timer = -1;
            } else {
                --main_dma_timer;
            }
        }

        compute_done = false;
        if (main_cmp_timer >= 0) {
            if (main_cmp_timer == 0) {
                compute_done = true;
                main_cmp_timer = -1;
            } else {
                --main_cmp_timer;
            }
        }

        for (int h = 0; h < NUM_HEADS; ++h) {
            head_ctx[h].wl_ready = wl_ready;
            head_ctx[h].compute_ready = compute_ready;
            head_ctx[h].wl_accept = head_accept_pulse[h];
            head_accept_pulse[h] = false;

            head_ctx[h].dma_done = false;
            if (head_dma_timer[h] >= 0) {
                if (head_dma_timer[h] == 0) {
                    head_ctx[h].dma_done = true;
                    head_dma_timer[h] = -1;
                } else {
                    --head_dma_timer[h];
                }
            }

            head_ctx[h].compute_done = false;
            if (head_cmp_timer[h] >= 0) {
                if (head_cmp_timer[h] == 0) {
                    head_ctx[h].compute_done = true;
                    head_cmp_timer[h] = -1;
                } else {
                    --head_cmp_timer[h];
                }
            }
        }

        if (!axis_feed_done && reset_n && axis_in_ready) {
            axis_in_valid = true;
            axis_in_last = (axis_sent == (AXIS_BEATS - 1));
        } else {
            axis_in_valid = false;
            axis_in_last = false;
        }

        scheduler_hls(
            ctrl_mem,
            status_mem,
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            axis_in_start,
            dma_done,
            wl_ready,
            wl_accept,
            wl_instruction,
            wl_start,
            compute_ready,
            compute_done,
            head_ctx,
            head_group_idx,
            compute_start,
            compute_instruction,
            stream_ready,
            stream_start,
            stream_done,
            done,
            error,
            state
        );

        if (axis_in_valid && axis_in_ready) {
            ++axis_sent;
            if (axis_in_last) {
                axis_feed_done = true;
            }
        }

        if (wl_start && decode_dma_sel(wl_instruction) != DMASEL_NONE) {
            main_accept_pulse = true;
            if (main_dma_timer < 0) {
                main_dma_timer = DMA_LAT;
            }
        }

        if (compute_start && main_cmp_timer < 0) {
            main_cmp_timer = CMP_LAT;
        }

        for (int h = 0; h < NUM_HEADS; ++h) {
            if (head_ctx[h].wl_start && decode_dma_sel(head_ctx[h].wl_instruction) != DMASEL_NONE) {
                head_accept_pulse[h] = true;
                if (head_dma_timer[h] < 0) {
                    head_dma_timer[h] = DMA_LAT;
                }
            }
            if (head_ctx[h].compute_start && head_cmp_timer[h] < 0) {
                head_cmp_timer[h] = CMP_LAT;
            }
        }

        stream_done = false;
        if (stream_start) {
            stream_done = true;
        }

        seen_att_heads = seen_att_heads || (state == S_ATTENTION_HEADS);
        seen_stream_out = seen_stream_out || (state == S_STREAM_OUT);

        std::printf("%8d | %5d | %-18s | %6d | %6d | %6d | %8d | %8d | %9d | %9d | %7d | %7d | ",
                    cycle,
                    reset_n ? 0 : 1,
                    state_name(state),
                    axis_in_valid ? 1 : 0,
                    axis_in_last ? 1 : 0,
                    axis_in_ready ? 1 : 0,
                    wl_start ? 1 : 0,
                    wl_accept ? 1 : 0,
                    compute_start ? 1 : 0,
                    compute_done ? 1 : 0,
                    done ? 1 : 0,
                    error ? 1 : 0);

        std::printf("h0 ph=%-8s wl_s=%d wl_a=%d d=%d c_s=%d c_d=%d | ",
                    phase_name(head_ctx[0].phase),
                    head_ctx[0].wl_start ? 1 : 0,
                    head_ctx[0].wl_accept ? 1 : 0,
                    head_ctx[0].dma_done ? 1 : 0,
                    head_ctx[0].compute_start ? 1 : 0,
                    head_ctx[0].compute_done ? 1 : 0);
        std::printf("h1 ph=%-8s wl_s=%d wl_a=%d d=%d c_s=%d c_d=%d\n",
                    phase_name(head_ctx[1].phase),
                    head_ctx[1].wl_start ? 1 : 0,
                    head_ctx[1].wl_accept ? 1 : 0,
                    head_ctx[1].dma_done ? 1 : 0,
                    head_ctx[1].compute_start ? 1 : 0,
                    head_ctx[1].compute_done ? 1 : 0);

        if (error) {
            std::fprintf(stderr, "[TB][ERROR] scheduler_hls set error at cycle %d\n", cycle);
            return 1;
        }

        if (done && state == S_IDLE && cycle > 50) {
            break;
        }
    }

    if (!seen_att_heads) {
        std::fprintf(stderr, "[TB][ERROR] did not reach S_ATTENTION_HEADS\n");
        return 2;
    }
    if (!seen_stream_out) {
        std::fprintf(stderr, "[TB][ERROR] did not reach S_STREAM_OUT\n");
        return 3;
    }

    std::printf("[TB] Scheduler test completed. seen_att_heads=%d seen_stream_out=%d\n",
                seen_att_heads ? 1 : 0,
                seen_stream_out ? 1 : 0);
    return 0;
}
