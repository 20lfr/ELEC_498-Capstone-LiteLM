#include <cstdint>
#include <cstdio>
#include <cstring>
#include <cerrno>
#include <sys/stat.h>

#include "compute_controller.hpp"

namespace {

struct OpStep {
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

static const char *op_name(ComputeOp op) {
    switch (op) {
        case CMP_LN0: return "CMP_LN0";
        case CMP_OUT_PROJ: return "CMP_OUT_PROJ";
        case CMP_RESID1: return "CMP_RESID1";
        case CMP_FFN_W1: return "CMP_FFN_W1";
        case CMP_FFN_ACT: return "CMP_FFN_ACT";
        case CMP_FFN_W2: return "CMP_FFN_W2";
        case CMP_FINAL_NORM: return "CMP_FINAL_NORM";
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
        case CMP_FINAL_NORM: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INLayerNormLayout::X + i,
                                      static_cast<int8_t>((i % 17) - 8));
                compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), 256);
            }
            compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::EPS, 1);
            break;
        }
        case CMP_OUT_PROJ: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INOutProjLayout::ACT + i,
                                      static_cast<int8_t>((i % 9) - 4));
            }
            for (int i = 0; i < D_MODEL * D_TILE_WO; ++i) {
                const int8_t w = static_cast<int8_t>((i % 5) - 2);
                compute_buf::write_i4(in_buf, (compute_buf::INOutProjLayout::W * 2) + i, w);
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
        case CMP_FFN_W1: {
            for (int i = 0; i < D_MODEL; ++i) {
                compute_buf::write_i8(in_buf, compute_buf::INFfnW1Layout::X + i,
                                      static_cast<int8_t>((i % 13) - 6));
            }
            for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
                const int8_t w = static_cast<int8_t>((i % 7) - 3);
                compute_buf::write_i4(in_buf, (compute_buf::INFfnW1Layout::W * 2) + i, w);
            }
            for (int i = 0; i < D_TILE_W1; ++i) {
                compute_buf::write_i32(in_buf, compute_buf::INFfnW1Layout::B + (i * 4), (i % 5) - 2);
            }
            break;
        }
        case CMP_FFN_ACT: {
            for (int i = 0; i < D_FFN; ++i) {
                compute_buf::write_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2),
                                       static_cast<int16_t>((i % 101) - 50));
                compute_buf::write_i16(in_buf, compute_buf::INFfnActLayout::UP + (i * 2),
                                       static_cast<int16_t>((i % 83) - 41));
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
                compute_buf::write_i4(in_buf, (compute_buf::INFfnW2Layout::W * 2) + i, w);
            }
            for (int i = 0; i < D_TILE_W2; ++i) {
                compute_buf::write_i32(in_buf, compute_buf::INFfnW2Layout::B + (i * 4), (i % 7) - 3);
            }
            break;
        }
        default:
            break;
    }
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
    const char *base_dir = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs";
    const char *tb_dir = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs/compute_controller_tb";
    const char *stdout_path = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs/compute_controller_tb/compute_controller_tb_stdout.log";
    const char *stderr_path = "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/logs/compute_controller_tb/compute_controller_tb_stderr.log";

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
    constexpr OpStep steps[] = {
        {CMP_LN0,       0, -1, -1, "LN0"},
        {CMP_OUT_PROJ,  0, -1,  0, "OUT_PROJ"},
        {CMP_RESID1,    0, -1, -1, "RESID1"},
        {CMP_FFN_W1,    0, -1,  0, "FFN_W1"},
        {CMP_FFN_ACT,   0, -1, -1, "FFN_ACT"},
        {CMP_FFN_W2,    0, -1,  0, "FFN_W2"},
        {CMP_FINAL_NORM,0, -1, -1, "FINAL_NORM"}
    };

    ControlMemSpace ctrl_mem{};
    ctrl_mem.control = CTRL_RESETN_BIT;

    uint8_t in_buf[compute_buf::IN_BUF_BYTES]{};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]{};

    bool compute_start = false;
    uint32_t compute_instruction = make_instruction(CMP_NONE, 0, -1, -1);
    bool compute_ready = false;
    bool compute_done = false;

    bool mem_transfer_done = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    uint32_t mem_op = 0;

    ComputeState dbg_state = ComputeState::IDLE;
    uint32_t dbg_req_instruction = 0;
    uint8_t dbg_req_op = 0;
    uint8_t dbg_req_layer = 0;
    uint8_t dbg_req_head = 0;
    uint8_t dbg_req_tile = 0;
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
                ctrl_mem,
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
