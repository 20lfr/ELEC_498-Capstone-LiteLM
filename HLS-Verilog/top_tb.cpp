#include "top.hpp"
#include <cstdio>
#include <cstdint>

// Helpers to drive control interface transactions
void ctrl_write(
    ControlReg  addr,
    uint32_t    data_in,
    bool        resetn_in,
    ControlReg  &ctrl_addr,
    uint32_t    &ctrl_data_in,
    uint32_t    &ctrl_data_out,
    bool        &ctrl_read_en,
    bool        &ctrl_write_en,
    bool        &ctrl_chip_en,
    bool        &ctrl_resetn_in
) {
    ctrl_addr      = addr;
    ctrl_data_in   = data_in;
    ctrl_data_out  = 0;
    ctrl_read_en   = false;
    ctrl_write_en  = true;
    ctrl_chip_en   = true;
    ctrl_resetn_in = resetn_in;
}

void ctrl_read(
    ControlReg  addr,
    bool        resetn_in,
    ControlReg  &ctrl_addr,
    uint32_t    &ctrl_data_in,
    uint32_t    &ctrl_data_out,
    bool        &ctrl_read_en,
    bool        &ctrl_write_en,
    bool        &ctrl_chip_en,
    bool        &ctrl_resetn_in
) {
    ctrl_addr      = addr;
    ctrl_data_in   = 0;
    ctrl_data_out  = 0;
    ctrl_read_en   = true;
    ctrl_write_en  = false;
    ctrl_chip_en   = true;
    ctrl_resetn_in = resetn_in;
}

static const char *op_name(ComputeOp op) {
    switch (op) {
    case ComputeOp::CMP_NONE:      return "-";
    case ComputeOp::CMP_Q:         return "Q";
    case ComputeOp::CMP_K:         return "K";
    case ComputeOp::CMP_K_REQUANT: return "K_RQ";
    case ComputeOp::CMP_V:         return "V";
    case ComputeOp::CMP_V_REQUANT: return "V_RQ";
    case ComputeOp::CMP_REQUANT_Q: return "RQ_Q";
    case ComputeOp::CMP_ATT_SCORES:return "ATT_SCO";
    case ComputeOp::CMP_VALUE_SCALE:return "VAL_SCL";
    case ComputeOp::CMP_SOFTMAX:   return "SOFTMX";
    case ComputeOp::CMP_ATT_VALUE: return "ATT_VAL";
    case ComputeOp::CMP_REQUANT2:  return "RQ2";
    case ComputeOp::CMP_CONCAT:    return "CONCAT";
    case ComputeOp::CMP_OUT_PROJ:  return "OUT_PRJ";
    case ComputeOp::CMP_REQUANT1:  return "RQ1";
    case ComputeOp::CMP_RESID0:    return "RES0";
    case ComputeOp::CMP_LN0:       return "LN0";
    case ComputeOp::CMP_REQUANT3:  return "RQ3";
    case ComputeOp::CMP_FFN_W1:    return "FFN_W1";
    case ComputeOp::CMP_FFN_ACT:   return "FFN_ACT";
    case ComputeOp::CMP_FFN_W2:    return "FFN_W2";
    case ComputeOp::CMP_REQUANT4:  return "RQ4";
    case ComputeOp::CMP_RESID1:    return "RES1";
    case ComputeOp::CMP_LN1:       return "LN1";
    default:                       return "UNK";
    }
}

static const char *dma_name(DmaSel sel) {
    switch (sel) {
    case DMASEL_NONE:   return "-";
    case DMASEL_WQ:     return "WQ";
    case DMASEL_WK:     return "WK";
    case DMASEL_WV:     return "WV";
    case DMASEL_CTX_K:  return "CTX_K";
    case DMASEL_CTX_V:  return "CTX_V";
    case DMASEL_K_WRITE:return "K_WR";
    case DMASEL_V_WRITE:return "V_WR";
    case DMASEL_WO:     return "WO";
    case DMASEL_W1:     return "W1";
    case DMASEL_W2:     return "W2";
    case DMASEL_WLOGIT: return "WLOGIT";
    default:            return "UNK";
    }
}

static const char *state_name(SchedState st) {
    switch (st) {
    case S_IDLE:            return "S_IDLE";
    case S_STREAM_IN:       return "S_STREAM_IN";
    case S_LAYER_COUNT:     return "S_LAYER_COUNT";
    case S_ATTENTION_HEADS: return "S_ATT_HEADS";
    case S_HEAD_CONCAT:     return "S_HEAD_CONCAT";
    case S_OUT_PROJECTION:  return "S_OUT_PROJ";
    case S_REQUANT1:        return "S_RQ1";
    case S_RES_ADD_1:       return "S_RES_ADD_1";
    case S_LAYER_NORM_1:    return "S_LN_1";
    case S_REQUANT2:        return "S_RQ2";
    case S_FFN:             return "S_FFN";
    case S_REQUANT3:        return "S_RQ3";
    case S_RES_ADD_2:       return "S_RES_ADD_2";
    case S_LAYER_NORM_2:    return "S_LN_2";
    case S_REQUANT4:        return "S_RQ4";
    case S_LOOP_CHECK:      return "S_LOOP_CHECK";
    case S_STREAM_OUT:      return "S_STREAM_OUT";
    default:                return "UNKNOWN";
    }
}

static const char *phase_name(HeadPhase ph) {
    switch (ph) {
        case HeadPhase::IDLE:              return "IDLE";
        case HeadPhase::Q:                 return "Q";
        case HeadPhase::K:                 return "K";
        case HeadPhase::K_REQUANT:         return "K_RQ";
        case HeadPhase::K_WRITEBACK:       return "K_WR";
        case HeadPhase::V:                 return "V";
        case HeadPhase::V_REQUANT:         return "V_RQ";
        case HeadPhase::V_WRITEBACK:       return "V_WR";
        case HeadPhase::REQUANT_Q:         return "Q_RQ";
        case HeadPhase::ATT_SCORES:        return "ATT";
        case HeadPhase::VALUE_SCALE_CLAMP: return "SCL";
        case HeadPhase::ATT_SOFTMAX:       return "SMX";
        case HeadPhase::ATT_VALUE:         return "VAL";
        case HeadPhase::REQUANT2:          return "RQ2";
        case HeadPhase::DONE:              return "DONE";
        default:                           return "UNK";
    }
}

int main() {
    const int MAX_CYCLES = 50;
    const int COMP_LAT   = 3;
    const int DMA_LAT    = 3;
    const int AXIS_BEATS = 3;

    // Top I/O signals
    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    bool axis_in_ready   = false;
    bool dma_done        = false;
    bool compute_ready   = true;
    bool compute_done    = false;
    HeadCtx head_ctx_ref[NUM_HEADS];
    bool compute_start   = false;
    ComputeOp compute_op = ComputeOp::CMP_NONE;
    bool stream_ready    = true;
    bool stream_start    = false;
    bool stream_done     = false;
    bool wl_ready        = true;
    bool wl_start        = false;
    DmaSel wl_addr_sel   = DmaSel::DMASEL_NONE;
    int  wl_layer        = 0;
    int  wl_head         = 0;
    int  wl_tile         = 0;
    
    ControlReg ctrl_addr = ControlReg::CONTROL;
    uint32_t ctrl_data_in = 0;
    uint32_t ctrl_data_out = 0;
    bool ctrl_read_en    = false;
    bool ctrl_write_en   = false;
    bool ctrl_chip_en    = false; // gate writes until used
    bool ctrl_resetn_in  = true;


    // DEBUG signals
    SchedState dbg_state = S_IDLE;
    bool dbg_done = false;

    ControlMemSpace dbg_ctrl_mem {};
    dbg_ctrl_mem.control = CTRL_RESETN_BIT;





    // Simple latency models
    bool comp_busy = false;
    int  comp_timer = 0;
    bool dma_busy = false;
    int  dma_timer = 0;

    // Drive AXIS ingress
    int axis_sent = 0;
    bool axis_drive = false;
    bool axis_feed_done = false;

    // Drive AXIS outgress
    bool stream_busy     = false;


    // Reading Heads
    bool head_lane_busy[HEADS_PARALLEL] = {false};
    int  head_lane_timer[HEADS_PARALLEL] = {0};
    int  head_lane_active_idx[HEADS_PARALLEL] = {0};
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        head_lane_active_idx[lane] = -1;
    }
    bool head_dma_busy[HEADS_PARALLEL] = {false};
    int  head_dma_timer[HEADS_PARALLEL] = {0};
    int  head_dma_active_idx[HEADS_PARALLEL] = {0};
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        head_dma_active_idx[lane] = -1;
    }

    bool seen_idle_after = false;
    bool start_pulsed = false;
    bool seen_done = false;
    int  post_done_cycles= 0;


    uint32_t status_latched = 0;

    // std::printf("%-8s %-10s %-10s %-12s | %-10s %-10s %-10s %-10s %-10s %-10s\n",
    //             "Cycle",
    //             "ctrl_rstn_in",
    //             "start",
    //             "state",
    //             "ctrl_addr",
    //             "ctrl_din",
    //             "ctrl_dout",
    //             "rd_en",
    //             "wr_en",
    //             "chip_en");
    std::printf("%-8s %-6s %-6s %-8s | %-16s | %-10s %-10s %-10s %-10s | %s\n",
                "Cycle", "Start", "Reset", "Busy", "State",
                "CmpStart", "CmpReady", "CmpDone", "CmpOp",
                "Heads{idx:ph/cr/cs/cd/op/wlR/addr/qd/wlD}");
    auto dash_or = [](bool v) { return v ? "1" : "-"; };



    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Simple reset release at cycle 2
        if (cycle == 2) dbg_ctrl_mem.control |= CTRL_RESETN_BIT;
        const bool cntrl_busy = ((dbg_ctrl_mem.status & STATUS_BUSY_BIT) != 0);
        // Issue a single-cycle start pulse once after reset deasserts
        if (((dbg_ctrl_mem.control & CTRL_RESETN_BIT) != 0) && !start_pulsed) {
            dbg_ctrl_mem.control |= CTRL_START_BIT; // set start bit
            start_pulsed = true;
        } else if (cntrl_busy) {
            dbg_ctrl_mem.control &= ~CTRL_START_BIT; // clear start when busy
        }

        // Clear per-head compute_done pulse
        for (int i = 0; i < NUM_HEADS; ++i) {
            head_ctx_ref[i].compute_done = false;
            head_ctx_ref[i].dma_done = false;
        }

        // Complete outstanding per-head compute operations
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_lane_busy[lane]) {
                if (head_lane_timer[lane] == 0) {
                    int idx = head_lane_active_idx[lane];
                    if (idx >= 0 && idx < NUM_HEADS) {
                        head_ctx_ref[idx].compute_done = true;
                    }
                    head_lane_busy[lane] = false;
                    head_lane_active_idx[lane] = -1;
                } else {
                    --head_lane_timer[lane];
                }
            }
        }

        // Complete outstanding per-head DMA operations
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_dma_busy[lane]) {
                if (head_dma_timer[lane] == 0) {
                    int idx = head_dma_active_idx[lane];
                    if (idx >= 0 && idx < NUM_HEADS) {
                        head_ctx_ref[idx].dma_done = true;
                    }
                    head_dma_busy[lane] = false;
                    head_dma_active_idx[lane] = -1;
                } else {
                    --head_dma_timer[lane];
                }
            }
        }

        // Complete outstanding main compute operations
        compute_done = false;
        if (comp_busy) {
            if (comp_timer == 0) {
                compute_done = true;
                comp_busy    = false;
            } else {
                --comp_timer;
            }
        }

        // Complete outstanding DMA transfers
        dma_done = false;
        if (dma_busy) {
            if (dma_timer == 0) {
                dma_done = true;
                dma_busy = false;
            } else {
                --dma_timer;
            }
        }

        // Stream completion: single-cycle pulse after start
        stream_done = false;
        if (stream_busy) {
            stream_done = true;
            stream_busy = false;
        }

        // Ready signals depend on busy flags
        compute_ready = !comp_busy && !compute_done;
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            head_ctx_ref[i].compute_ready = !head_lane_busy[lane];
            head_ctx_ref[i].wl_ready      = !head_dma_busy[lane];
        }
        stream_ready  = !stream_busy;
        wl_ready      = !dma_busy;

        // Drive AXIS ingress: send a short burst when ready is asserted
        if (!axis_feed_done && (axis_drive || (((dbg_ctrl_mem.control & CTRL_RESETN_BIT) != 0) && start_pulsed))) {
            axis_drive = true;
            if (!axis_in_valid && axis_in_ready) {
                axis_in_valid = true;
                axis_in_last  = (axis_sent == AXIS_BEATS - 1);
            }
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        transformer_top(
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            dma_done,
            compute_ready,
            compute_done,
            head_ctx_ref,
            compute_start,
            compute_op,
            stream_ready,
            stream_start,
            stream_done,
            wl_ready,
            wl_start,
            wl_addr_sel,
            wl_layer,
            wl_head,
            wl_tile,
            ctrl_addr,
            ctrl_data_in,
            ctrl_data_out,
            ctrl_read_en,
            ctrl_write_en,
            ctrl_chip_en,
            ctrl_resetn_in,
            dbg_state, 
            dbg_ctrl_mem, 
            dbg_done
        );

        const bool cntrl_start   = ((dbg_ctrl_mem.control & CTRL_START_BIT) != 0);
        const bool cntrl_reset_n = ((dbg_ctrl_mem.control & CTRL_RESETN_BIT) != 0);
        std::printf("%-8d %-6d %-6d %-8s | %-16s | %-10s %-10s %-10s %-10s | ",
                    cycle,
                    cntrl_start ? 1 : 0,
                    cntrl_reset_n ? 1 : 0,
                    dash_or(cntrl_busy),
                    state_name(dbg_state),
                    dash_or(compute_start),
                    dash_or(compute_ready),
                    dash_or(compute_done),
                    (compute_op == CMP_NONE ? "-" : op_name(compute_op)));

        for (int i = 0; i < NUM_HEADS; ++i) {
            char buf[96];
            std::snprintf(buf, sizeof(buf), "%d:%-6s %-2s %-2s %-2s %-8s %-2s %-6s %-2s %-2s",
                          i,
                          phase_name(head_ctx_ref[i].phase),
                          dash_or(head_ctx_ref[i].compute_ready),
                          dash_or(head_ctx_ref[i].compute_start),
                          dash_or(head_ctx_ref[i].compute_done),
                          op_name(head_ctx_ref[i].compute_op),
                          dash_or(head_ctx_ref[i].wl_ready),
                          dma_name(head_ctx_ref[i].wl_addr_sel),
                          dash_or(head_ctx_ref[i].q_dma_done),
                          dash_or(head_ctx_ref[i].dma_done));
            std::printf("%-54s", buf);
        }
        std::printf("\n");

        // Launch head compute requests onto their dedicated lanes
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            if (head_ctx_ref[i].compute_start && !head_lane_busy[lane]) {
                head_lane_busy[lane] = true;
                head_lane_timer[lane] = COMP_LAT - 1;
                head_lane_active_idx[lane] = i;
                ComputeOp launched_op = head_ctx_ref[i].compute_op;
            }
            if (head_ctx_ref[i].wl_start && !head_dma_busy[lane]) {
                head_dma_busy[lane] = true;
                head_dma_timer[lane] = DMA_LAT - 1;
                head_dma_active_idx[lane] = i;
            }
        }

        // Launch main compute request (non-head)
        if (!comp_busy && compute_start) {
            comp_busy  = true;
            comp_timer = COMP_LAT - 1;
        }
        if (wl_start && wl_ready && !dma_busy) {
            dma_busy  = true;
            dma_timer = DMA_LAT - 1;
        }
        if (stream_start) {
            stream_busy = true;
        }

        // Consume AXIS transfer on handshake
        if (axis_in_valid && axis_in_ready) {
            axis_sent++;
            axis_in_valid = false;
            axis_in_last  = false;
            if (axis_sent >= AXIS_BEATS) {
                axis_feed_done = true;
                axis_drive     = false;
            }
        }

        if (dbg_done) {
            seen_done = true;
            dbg_ctrl_mem.control &= ~CTRL_START_BIT; // clear start bit
        }
        if (seen_done){
            post_done_cycles++;
            if (post_done_cycles >= 4) {
                seen_idle_after = true;
            }
        }

        if (!cntrl_busy && !cntrl_start && seen_done && seen_idle_after) {
            break;
        }
    }



    // TEMPORARY FOR NOW, WILL ENABLE LATER
    for (int cycle = 0; cycle < 0; ++cycle) {
        // Default: no control transaction
        ctrl_addr     = ControlReg::STATUS;
        ctrl_data_in  = 0;
        ctrl_write_en = false;
        ctrl_read_en  = false;
        ctrl_chip_en  = false;

        // Assert reset on cycle 1 via control write
        if (cycle == 1) {
            ctrl_write(ControlReg::CONTROL, 0, false,
                       ctrl_addr, ctrl_data_in, ctrl_data_out,
                       ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
        }

        // Release reset on cycle 4 and issue start
        if (cycle == 4) {
            ctrl_write(ControlReg::CONTROL, CTRL_RESETN_BIT | CTRL_START_BIT, true,
                       ctrl_addr, ctrl_data_in, ctrl_data_out,
                       ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            start_pulsed = true;
        } else {
            // Read status to observe busy
            ctrl_read(ControlReg::STATUS, ctrl_resetn_in,
                      ctrl_addr, ctrl_data_in, ctrl_data_out,
                      ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
        }

        const bool cntrl_busy    = (status_latched & STATUS_BUSY_BIT) != 0;
        const bool cntrl_start   = start_pulsed && !cntrl_busy;
        const bool cntrl_reset_n = ctrl_resetn_in;

        // Clear per-head compute_done pulse
        for (int i = 0; i < NUM_HEADS; ++i) {
            head_ctx_ref[i].compute_done = false;
            head_ctx_ref[i].dma_done = false;
        }

        // Complete outstanding per-head compute operations
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_lane_busy[lane]) {
                if (head_lane_timer[lane] == 0) {
                    int idx = head_lane_active_idx[lane];
                    if (idx >= 0 && idx < NUM_HEADS) {
                        head_ctx_ref[idx].compute_done = true;
                    }
                    head_lane_busy[lane] = false;
                    head_lane_active_idx[lane] = -1;
                } else {
                    --head_lane_timer[lane];
                }
            }
        }

        // Complete outstanding per-head DMA operations
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_dma_busy[lane]) {
                if (head_dma_timer[lane] == 0) {
                    int idx = head_dma_active_idx[lane];
                    if (idx >= 0 && idx < NUM_HEADS) {
                        head_ctx_ref[idx].dma_done = true;
                    }
                    head_dma_busy[lane] = false;
                    head_dma_active_idx[lane] = -1;
                } else {
                    --head_dma_timer[lane];
                }
            }
        }

        // Complete outstanding main compute operations
        compute_done = false;
        if (comp_busy) {
            if (comp_timer == 0) {
                compute_done = true;
                comp_busy    = false;
            } else {
                --comp_timer;
            }
        }

        // Complete outstanding DMA transfers
        dma_done = false;
        if (dma_busy) {
            if (dma_timer == 0) {
                dma_done = true;
                dma_busy = false;
            } else {
                --dma_timer;
            }
        }

        // Stream completion: single-cycle pulse after start
        stream_done = false;
        if (stream_busy) {
            stream_done = true;
            stream_busy = false;
        }

        // Ready signals depend on busy flags
        compute_ready = !comp_busy && !compute_done;
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            head_ctx_ref[i].compute_ready = !head_lane_busy[lane];
            head_ctx_ref[i].wl_ready      = !head_dma_busy[lane];
        }
        stream_ready  = !stream_busy;
        wl_ready      = !dma_busy;

        // Drive AXIS ingress: send a short burst when ready is asserted
        if (!axis_feed_done && (axis_drive || (cntrl_reset_n && start_pulsed))) {
            axis_drive = true;
            if (!axis_in_valid && axis_in_ready) {
                axis_in_valid = true;
                axis_in_last  = (axis_sent == AXIS_BEATS - 1);
            }
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        transformer_top(
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            dma_done,
            compute_ready,
            compute_done,
            head_ctx_ref,
            compute_start,
            compute_op,
            stream_ready,
            stream_start,
            stream_done,
            wl_ready,
            wl_start,
            wl_addr_sel,
            wl_layer,
            wl_head,
            wl_tile,
            ctrl_addr,
            ctrl_data_in,
            ctrl_data_out,
            ctrl_read_en,
            ctrl_write_en,
            ctrl_chip_en,
            ctrl_resetn_in,
            dbg_state, 
            dbg_ctrl_mem, 
            dbg_done
        );

        // Latch status on readback
        if (ctrl_read_en && ctrl_chip_en && ctrl_addr == ControlReg::STATUS) {
            status_latched = ctrl_data_out;
        }

        std::printf("%-8d %-10d %-10d %-12s | %-10d %-10u %-10u %-10d %-10d %-10d ",
                    cycle,
                    ctrl_resetn_in ? 1 : 0,
                    cntrl_start ? 1 : 0,
                    state_name(dbg_state),
                    static_cast<int>(ctrl_addr),
                    ctrl_data_in,
                    ctrl_data_out,
                    ctrl_read_en ? 1 : 0,
                    ctrl_write_en ? 1 : 0,
                    ctrl_chip_en ? 1 : 0);

        for (int i = 0; i < NUM_HEADS; ++i) {
            char buf[96];
            std::snprintf(buf, sizeof(buf), "%d:%-6s %-2s %-2s %-2s %-8s %-2s %-6s %-2s %-2s",
                          i,
                          phase_name(head_ctx_ref[i].phase),
                          dash_or(head_ctx_ref[i].compute_ready),
                          dash_or(head_ctx_ref[i].compute_start),
                          dash_or(head_ctx_ref[i].compute_done),
                          op_name(head_ctx_ref[i].compute_op),
                          dash_or(head_ctx_ref[i].wl_ready),
                          dma_name(head_ctx_ref[i].wl_addr_sel),
                          dash_or(head_ctx_ref[i].q_dma_done),
                          dash_or(head_ctx_ref[i].dma_done));
            std::printf("%-54s", buf);
        }
        std::printf("\n");

        // Launch head compute requests onto their dedicated lanes
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            if (head_ctx_ref[i].compute_start && !head_lane_busy[lane]) {
                head_lane_busy[lane] = true;
                head_lane_timer[lane] = COMP_LAT - 1;
                head_lane_active_idx[lane] = i;
                ComputeOp launched_op = head_ctx_ref[i].compute_op;
            }
            if (head_ctx_ref[i].wl_start && !head_dma_busy[lane]) {
                head_dma_busy[lane] = true;
                head_dma_timer[lane] = DMA_LAT - 1;
                head_dma_active_idx[lane] = i;
            }
        }

        // Launch main compute request (non-head)
        if (!comp_busy && compute_start) {
            comp_busy  = true;
            comp_timer = COMP_LAT - 1;
        }
        if (wl_start && wl_ready && !dma_busy) {
            dma_busy  = true;
            dma_timer = DMA_LAT - 1;
        }
        if (stream_start) {
            stream_busy = true;
        }

        // Consume AXIS transfer on handshake
        if (axis_in_valid && axis_in_ready) {
            axis_sent++;
            axis_in_valid = false;
            axis_in_last  = false;
            if (axis_sent >= AXIS_BEATS) {
                axis_feed_done = true;
                axis_drive     = false;
            }
        }

        if (dbg_done) {
            seen_done = true;
            ctrl_addr = ControlReg::CONTROL;
            ctrl_data_in = 1;
            ctrl_write_en = true;
            ctrl_chip_en = true;
        }
        if (seen_done){
            post_done_cycles++;
            if (post_done_cycles >= 4) {
                seen_idle_after = true;
            }
        }

        if (!cntrl_busy && !cntrl_start && seen_done && seen_idle_after) {
            break;
        }
    }

    bool ok = seen_done && seen_idle_after;
    if (!ok) {
        if (!seen_done)       std::fprintf(stderr, "ERROR: DONE never asserted\n");
        if (!seen_idle_after) std::fprintf(stderr, "ERROR: FSM did not return to IDLE after DONE\n");
        return 1;
    }

    std::printf("PASS: DONE observed and FSM returned to IDLE after %d post-done cycles.\n",
                post_done_cycles);
    return 0;
}
