#include <cstdint>
#include <cstdio>
#include <cstring>

#include "top_params.hpp"
#include "Scheduler_FSM/src-hls/Scheduler_FSM.hpp"
#include "Transformer_logic/src-hls/compute_controller.hpp"
#include "Transformer_logic/src-hls/headed_compute_controller.hpp"
#include "MMU/mmu_luka.hpp"

static inline uint32_t pack_compute_instruction(ComputeOp op, int layer, int head, int tile) {
    return (static_cast<uint32_t>(op) & 0xFFu)
         | ((static_cast<uint32_t>(layer) & 0xFFu) << 8)
         | ((static_cast<uint32_t>(head) & 0xFFu) << 16)
         | ((static_cast<uint32_t>(tile) & 0xFFu) << 24);
}

static inline uint32_t pack_dma_instruction(DmaSel op, int layer, int head, int tile) {
    return (static_cast<uint32_t>(op) & 0xFFu)
         | ((static_cast<uint32_t>(layer) & 0xFFu) << 8)
         | ((static_cast<uint32_t>(head) & 0xFFu) << 16)
         | ((static_cast<uint32_t>(tile) & 0xFFu) << 24);
}

static inline void dma_word_set_byte(uint32_t *buf, uint32_t byte_idx, uint8_t value) {
    const uint32_t word_idx = byte_idx >> 2;
    const uint32_t shift = (byte_idx & 0x3u) << 3;
    uint32_t word = buf[word_idx];
    word &= ~(0xFFu << shift);
    word |= (static_cast<uint32_t>(value) << shift);
    buf[word_idx] = word;
}

static const char *sched_state_name(SchedState st) {
    switch (st) {
        case S_IDLE: return "S_IDLE";
        case S_STREAM_IN: return "S_STREAM_IN";
        case S_LAYER_COUNT: return "S_LAYER_COUNT";
        case S_ATTENTION_HEADS: return "S_ATT_HEADS";
        case S_HEAD_CONCAT: return "S_HEAD_CONCAT";
        case S_OUT_PROJECTION: return "S_OUT_PROJ";
        case S_REQUANT1: return "S_RQ1";
        case S_RES_ADD_1: return "S_RES_ADD_1";
        case S_LAYER_NORM_0: return "S_LN0";
        case S_REQUANT2: return "S_RQ2";
        case S_FFN: return "S_FFN";
        case S_REQUANT3: return "S_RQ3";
        case S_RES_ADD_2: return "S_RES_ADD_2";
        case S_LAYER_NORM_1: return "S_LN1";
        case S_REQUANT4: return "S_RQ4";
        case S_LOOP_CHECK: return "S_LOOP_CHECK";
        case S_FINAL_NORM: return "S_FINAL_NORM";
        case S_STREAM_OUT: return "S_STREAM_OUT";
        default: return "UNKNOWN";
    }
}

static const char *compute_state_name(ComputeState st) {
    switch (st) {
        case ComputeState::IDLE: return "IDLE";
        case ComputeState::CAPTURE_INSTRUCTION: return "CAPTURE";
        case ComputeState::WAIT_MEM: return "WAIT_MEM";
        case ComputeState::EXECUTE: return "EXECUTE";
        case ComputeState::MEM_WRITEBACK: return "WRITEBK";
        case ComputeState::DONE: return "DONE";
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
        case HeadPhase::REQUANT_Q: return "Q_RQ";
        case HeadPhase::ATT_SCORES: return "ATT";
        case HeadPhase::VALUE_SCALE_CLAMP: return "SCL";
        case HeadPhase::ATT_SOFTMAX: return "SMX";
        case HeadPhase::ATT_VALUE: return "VAL";
        case HeadPhase::HEAD_REQUANT: return "HEAD_RQ";
        case HeadPhase::DONE: return "DONE";
        default: return "UNK";
    }
}

static ControlMemSpace make_ctrl() {
    ControlMemSpace c{};
    c.control = CTRL_RESETN_BIT | CTRL_START_BIT;
    c.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;

    c.layer_stride = static_cast<uint32_t>(NUM_HEADS * CONTEXT_LENGTH * D_HEADS);
    c.k_cache_stride = static_cast<uint32_t>(CONTEXT_LENGTH * D_HEADS);
    c.v_cache_stride = static_cast<uint32_t>(CONTEXT_LENGTH * D_HEADS);

    c.wq_head_stride = static_cast<uint32_t>(D_MODEL * D_HEADS / 2 + D_HEADS / 2);
    c.wk_head_stride = c.wq_head_stride;
    c.wv_head_stride = c.wq_head_stride;
    c.wo_tile_stride = static_cast<uint32_t>(D_MODEL * D_TILE_WO / 2 + D_TILE_WO / 2);
    c.w1_tile_stride = static_cast<uint32_t>(D_MODEL * D_TILE_W1 / 2 + D_TILE_W1 / 2);
    c.w2_tile_stride = static_cast<uint32_t>(D_FFN * D_TILE_W2 / 2 + D_TILE_W2 / 2);

    c.wq_base_addr = 0x10000000ull;
    c.wk_base_addr = 0x11000000ull;
    c.wv_base_addr = 0x12000000ull;
    c.wo_base_addr = 0x13000000ull;
    c.w1_base_addr = 0x14000000ull;
    c.w2_base_addr = 0x15000000ull;
    c.k_cache_addr = 0x20000000ull;
    c.v_cache_addr = 0x21000000ull;
    c.ln0_gamma_base_addr = 0x30000000ull;
    c.ln1_gamma_base_addr = 0x31000000ull;
    c.ln0_eps_base_addr = 0x32000000ull;
    c.ln1_eps_base_addr = 0x33000000ull;
    c.ln0_gamma_stride = D_MODEL * 4;
    c.ln1_gamma_stride = D_MODEL * 4;
    c.ln0_eps_stride = 4;
    c.ln1_eps_stride = 4;
    return c;
}

static void run_scheduler_tb() {
    std::printf("\n=== scheduler_hls dedicated tb ===\n");

    ControlMemSpace ctrl = make_ctrl();
    StatusMemSpace status{};

    bool axis_in_valid = false;
    bool axis_in_last = false;
    bool axis_in_ready = false;
    bool axis_in_start = false;
    bool dma_done = false;
    bool wl_ready = true;
    bool wl_accept = false;
    uint32_t wl_instruction = 0;
    bool wl_start = false;
    bool compute_ready = true;
    bool compute_done = false;
    HeadCtx head_ctx[NUM_HEADS]{};
    int head_group_idx = 0;
    bool compute_start = false;
    uint32_t compute_instruction = 0;
    bool stream_ready = true;
    bool stream_start = false;
    bool stream_done = false;
    bool done = false;
    bool error = false;
    SchedState st = S_IDLE;

    std::printf("%8s | %5s | %-16s | %6s | %6s | %6s | %9s | %9s | %10s | %13s | %20s | %11s | %7s | %6s\n",
                "cycle", "reset", "state", "axis_v", "axis_l", "axis_r", "axis_st", "wl_start", "wl_accept", "wl_ready", "wl_instruction", "cmp_start", "done", "error");

    bool prev_compute_start = false;
    for (int cycle = 0; cycle < 24; ++cycle) {
        const bool reset = (cycle < 2);
        ctrl.control = reset ? 0u : (CTRL_RESETN_BIT | CTRL_START_BIT);

        axis_in_valid = (cycle == 3);
        axis_in_last = axis_in_valid;
        dma_done = wl_start;
        wl_accept = wl_start;

        compute_done = prev_compute_start;
        prev_compute_start = compute_start;

        scheduler_hls(
            ctrl, status,
            axis_in_valid, axis_in_last, axis_in_ready, axis_in_start,
            dma_done,
            wl_ready, wl_accept, wl_instruction, wl_start,
            compute_ready, compute_done,
            head_ctx, head_group_idx,
            compute_start, compute_instruction,
            stream_ready, stream_start, stream_done,
            done, error, st
        );

        std::printf("%8d | %5d | %-16s | %6d | %6d | %6d | %9d | %9d | %10d | %13d |         0x%08X | %11d | %7d | %6d\n",
                    cycle, reset ? 1 : 0, sched_state_name(st),
                    axis_in_valid ? 1 : 0, axis_in_last ? 1 : 0, axis_in_ready ? 1 : 0,
                    axis_in_start ? 1 : 0, wl_start ? 1 : 0, wl_accept ? 1 : 0,
                    wl_ready ? 1 : 0, wl_instruction,
                    compute_start ? 1 : 0,
                    done ? 1 : 0, error ? 1 : 0);
    }
}

static void run_compute_tb() {
    std::printf("\n=== compute_controller dedicated tb ===\n");

    ControlMemSpace ctrl = make_ctrl();
    uint8_t in_buf[compute_buf::IN_BUF_BYTES]{};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]{};

    for (int i = 0; i < D_MODEL; ++i) {
        compute_buf::write_i8(in_buf, compute_buf::INLayerNormLayout::X + i, static_cast<int8_t>((i * 3) - 10));
        compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), 1024);
    }
    compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::EPS, 1);

    bool compute_start = false;
    uint32_t compute_instruction = pack_compute_instruction(CMP_LN0, 0, -1, -1);
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

    bool sent_mem_done_for_read = false;
    bool sent_mem_done_for_write = false;

    std::printf("%8s | %5s | %-10s | %11s | %13s | %9s | %9s | %9s | %13s | %10s | %6s\n",
                "cycle", "reset", "cmp_state", "cmp_start", "cmp_ready", "mr", "mw", "mem_done", "req_instr", "cmp_done", "error");

    for (int cycle = 0; cycle < 20; ++cycle) {
        const bool reset = (cycle < 2);
        ctrl.control = reset ? 0u : CTRL_RESETN_BIT;

        compute_start = (cycle == 3);

        mem_transfer_done = false;
        if (mem_read_request && !sent_mem_done_for_read) {
            mem_transfer_done = true;
            sent_mem_done_for_read = true;
        } else if (mem_write_request && !sent_mem_done_for_write) {
            mem_transfer_done = true;
            sent_mem_done_for_write = true;
        }

        compute_controller(
            ctrl,
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

        std::printf("%8d | %5d | %-10s | %11d | %13d | %9d | %9d | %9d |   0x%08X | %10d | %6d\n",
                    cycle, reset ? 1 : 0, compute_state_name(dbg_state),
                    compute_start ? 1 : 0, compute_ready ? 1 : 0,
                    mem_read_request ? 1 : 0, mem_write_request ? 1 : 0, mem_transfer_done ? 1 : 0,
                    dbg_req_instruction, compute_done ? 1 : 0, error ? 1 : 0);
    }
}

static void run_headed_compute_tb() {
    std::printf("\n=== drive_headed_compute_controller dedicated tb ===\n");

    ComputeHeadCtx ctx[HEADS_PARALLEL]{};
    uint8_t in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES]{};
    uint8_t out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES]{};

    for (int h = 0; h < D_HEADS; ++h) {
        compute_buf::write_i8(in_buf[0], head_buf::INAttScoresLayout::Q + h, static_cast<int8_t>(10 + h));
    }
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        for (int h = 0; h < D_HEADS; ++h) {
            const int idx = t * D_HEADS + h;
            compute_buf::write_i8(in_buf[0], head_buf::INAttScoresLayout::K_CACHE + idx, static_cast<int8_t>(20 + idx));
        }
    }

    bool error = false;
    bool read_done_sent = false;
    bool write_done_sent = false;

    std::printf("%8s | %5s | %4s | %-7s | %-7s | %-7s | %-7s | %-10s | %-10s | %-10s\n",
                "cycle", "reset", "lane", "phase", "c_start", "c_ready", "mr", "mw", "mem_done", "c_done");

    for (int cycle = 0; cycle < 20; ++cycle) {
        const bool reset_n = (cycle >= 2);
        const uint16_t token_pos = static_cast<uint16_t>(cycle);

        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            ctx[lane].compute_start = false;
            ctx[lane].mem_transfer_done = false;
        }

        if (cycle == 3) {
            ctx[0].compute_instruction = pack_compute_instruction(CMP_ATT_SCORES, 0, 0, -1);
            ctx[0].compute_start = true;
        }

        if (ctx[0].mem_read_request && !read_done_sent) {
            ctx[0].mem_transfer_done = true;
            read_done_sent = true;
        } else if (ctx[0].mem_write_request && !write_done_sent) {
            ctx[0].mem_transfer_done = true;
            write_done_sent = true;
        }

        drive_headed_compute_controller(ctx, reset_n, token_pos, in_buf, out_buf, error);

        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            std::printf("%8d | %5d | %4d | %-7s | %-7d | %-7d | %-7d | %-10d | %-10d | %-10d\n",
                        cycle,
                        reset_n ? 0 : 1,
                        lane,
                        compute_state_name(ctx[lane].state),
                        ctx[lane].compute_start ? 1 : 0,
                        ctx[lane].compute_ready ? 1 : 0,
                        ctx[lane].mem_read_request ? 1 : 0,
                        ctx[lane].mem_write_request ? 1 : 0,
                        ctx[lane].mem_transfer_done ? 1 : 0,
                        ctx[lane].compute_done ? 1 : 0);
        }
    }
}

static void run_mmu_tb() {
    std::printf("\n=== mmu_fsm dedicated tb ===\n");

    ControlMemSpace ctrl = make_ctrl();
    uint16_t token_pos = 0;

    bool dma_ready = true;
    bool dma_done = false;
    static uint32_t dma_rx_buf[DMA_BUF_WORDS]{};
    static uint32_t dma_tx_buf[DMA_BUF_WORDS]{};
    bool dma_start = false;
    uint32_t dma_addr = 0;
    uint32_t dma_len = 0;
    bool dma_is_write = false;

    bool axis_in_ready = false;
    bool axis_in_start = false;
    bool stream_start = false;
    uint8_t stream_in_buf[STREAM_IN_BUF_BYTES]{};
    uint8_t stream_out_buf[STREAM_OUT_BUF_BYTES]{};

    bool mmu_dma_req_start = false;
    uint32_t mmu_dma_instruction = 0;
    bool mmu_req_ready = false;
    bool main_wl_accept = false;
    bool main_dma_done = false;

    bool mem_read_request = false;
    bool mem_write_request = false;
    uint32_t mem_op = 0;
    bool mem_transfer_done = false;

    HeadCtx head_ctx[NUM_HEADS]{};
    ComputeHeadCtx head_compute_ctx[HEADS_PARALLEL]{};
    uint8_t in_buf[compute_buf::IN_BUF_BYTES]{};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES]{};
    uint8_t head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES]{};
    uint8_t head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES]{};
    Status status{};

    int dma_resp_timer = -1;
    uint32_t dma_last_len = 0;

    std::printf("%8s | %5s | %-10s | %10s | %10s | %10s | %9s | %10s | %10s | %10s | %12s | %12s\n",
                "cycle", "reset", "mmu_state", "req_start", "req_ready", "wl_accept", "dma_st", "dma_done", "dma_write", "dma_len", "error_code", "region_cnt");

    for (int cycle = 0; cycle < 26; ++cycle) {
        const bool reset_n = (cycle >= 2);

        mmu_dma_req_start = (cycle >= 3 && !main_wl_accept);
        mmu_dma_instruction = pack_dma_instruction(DMASEL_WQ, 0, 0, -1);

        axis_in_start = false;
        stream_start = false;
        mem_read_request = false;
        mem_write_request = false;
        mem_op = 0;
        token_pos = static_cast<uint16_t>((cycle < CONTEXT_LENGTH) ? cycle : (CONTEXT_LENGTH - 1));

        dma_done = false;
        if (dma_resp_timer >= 0) {
            dma_resp_timer--;
            if (dma_resp_timer == 0) {
                for (uint32_t i = 0; i < dma_last_len && i < DMA_BUF_BYTES; ++i) {
                    dma_word_set_byte(dma_rx_buf, i, static_cast<uint8_t>(0x10u + (i & 0x7Fu)));
                }
                dma_done = true;
                dma_resp_timer = -1;
            }
        }

        mmu_fsm(
            reset_n,
            ctrl,
            token_pos,
            dma_ready,
            dma_done,
            dma_rx_buf,
            dma_tx_buf,
            dma_start,
            dma_addr,
            dma_len,
            dma_is_write,
            axis_in_ready,
            axis_in_start,
            stream_start,
            stream_in_buf,
            stream_out_buf,
            mmu_dma_req_start,
            mmu_dma_instruction,
            mmu_req_ready,
            main_wl_accept,
            main_dma_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            mem_transfer_done,
            head_ctx,
            head_compute_ctx,
            in_buf,
            out_buf,
            head_in_buf,
            head_out_buf,
            status
        );

        if (dma_start) {
            dma_last_len = dma_len;
            dma_resp_timer = 1;
        }

        std::printf("%8d | %5d | %-10s | %10d | %10d | %10d | %9d | %10d | %10d | %10u |   0x%08X | %12u\n",
                    cycle,
                    reset_n ? 0 : 1,
                    state_name(status.state),
                    mmu_dma_req_start ? 1 : 0,
                    mmu_req_ready ? 1 : 0,
                    main_wl_accept ? 1 : 0,
                    dma_start ? 1 : 0,
                    dma_done ? 1 : 0,
                    dma_is_write ? 1 : 0,
                    dma_len,
                    status.error_code,
                    static_cast<unsigned>(status.region_count));
    }
}

int main() {
    run_scheduler_tb();
    run_compute_tb();
    run_headed_compute_tb();
    run_mmu_tb();
    std::printf("\n[TB] top module unit-level dedicated runs complete.\n");
    return 0;
}
