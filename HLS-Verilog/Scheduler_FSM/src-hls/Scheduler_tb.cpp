// Minimal testbench for Simple_Scheduler_FSM.
// Mirrors the style of Scheduler_tb_minimal.cpp but against the simplified scheduler interface.
#include <cstdio>
#include <cstdint>
#include <string>

#include "Scheduler_FSM.hpp"

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
    case S_LAYER_NORM_0:    return "S_LN_0";
    case S_HEAD_REQUANT:    return "S_HEAD_RQ";
    case S_FFN:             return "S_FFN";
    case S_REQUANT3:        return "S_RQ3";
    case S_RES_ADD_2:       return "S_RES_ADD_2";
    case S_LAYER_NORM_1:    return "S_LN_1";
    case S_REQUANT4:        return "S_RQ4";
    case S_LOOP_CHECK:      return "S_LOOP_CHECK";
    case S_FINAL_NORM:      return "S_FINAL_NORM";
    case S_STREAM_OUT:      return "S_STREAM_OUT";
    default:                return "UNKNOWN";
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
    case CMP_CONCAT:       return "CONCAT";
    case CMP_OUT_PROJ:     return "OUT_PROJ";
    case CMP_REQUANT1:     return "RQ1";
    case CMP_RESID0:       return "RESID0";
    case CMP_LN0:          return "LN0";
    case CMP_REQUANT3:     return "RQ3";
    case CMP_FFN_W1:       return "FFN_W1";
    case CMP_FFN_ACT:      return "FFN_ACT";
    case CMP_FFN_W2:       return "FFN_W2";
    case CMP_REQUANT4:     return "RQ4";
    case CMP_RESID1:       return "RESID1";
    case CMP_LN1:          return "LN1";
    case CMP_DEQUANT:      return "DEQUANT";
    case CMP_LOGITS:       return "LOGITS";
    case CMP_LN0_SUM:      return "LN0_SUM";
    case CMP_LN0_SUMSQ:    return "LN0_Q";
    case CMP_LN0_MEAN:     return "LN0_MEAN";
    case CMP_LN0_EYY:      return "LN0_EYY";
    case CMP_LN0_VAR:      return "LN0_VAR";
    case CMP_LN0_VAR_EPS:  return "LN0_VEPS";
    case CMP_LN0_INV_STD:  return "LN0_INV";
    case CMP_LN0_NORM:     return "LN0_NORM";
    case CMP_LN0_SCALE:    return "LN0_SCL";
    case CMP_LN0_SHIFT:    return "LN0_SHF";
    case CMP_LN1_SUM:      return "LN1_SUM";
    case CMP_LN1_SUMSQ:    return "LN1_Q";
    case CMP_LN1_MEAN:     return "LN1_MEAN";
    case CMP_LN1_EYY:      return "LN1_EYY";
    case CMP_LN1_VAR:      return "LN1_VAR";
    case CMP_LN1_VAR_EPS:  return "LN1_VEPS";
    case CMP_LN1_INV_STD:  return "LN1_INV";
    case CMP_LN1_NORM:     return "LN1_NORM";
    case CMP_LN1_SCALE:    return "LN1_SCL";
    case CMP_LN1_SHIFT:    return "LN1_SHF";
    default:               return "UNK";
    }
}

static inline ComputeOp decode_op(uint32_t packed_op) {
    return static_cast<ComputeOp>(packed_op & 0xFFu);
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
    case HeadPhase::HEAD_REQUANT:     return "HEAD_RQ";
    case HeadPhase::DONE:              return "DONE";
    default:                           return "UNK";
    }
}


int main() {
    const int MAX_CYCLES = 1200;
    const int COMP_LAT   = 3;
    const int DMA_LAT    = 3;
    const int AXIS_BEATS = 3;

    ControlMemSpace ctrl_mem{};
    ctrl_mem.control = CTRL_RESETN_BIT; // reset_n high, start low
    ctrl_mem.layer_stride    = 0x1000;
    ctrl_mem.wq_head_stride  = 0x0100;
    ctrl_mem.wk_head_stride  = 0x0200;
    ctrl_mem.wv_head_stride  = 0x0300;
    ctrl_mem.k_cache_stride  = 0x0400;
    ctrl_mem.v_cache_stride  = 0x0500;
    ctrl_mem.wo_tile_stride  = 0x0600;
    ctrl_mem.w1_tile_stride  = 0x0700;
    ctrl_mem.w2_tile_stride  = 0x0800;

    ctrl_mem.wq_base_addr    = 0x10000000;
    ctrl_mem.wk_base_addr    = 0x20000000;
    ctrl_mem.wv_base_addr    = 0x30000000;
    ctrl_mem.k_cache_addr    = 0x40000000;
    ctrl_mem.v_cache_addr    = 0x50000000;
    ctrl_mem.wo_base_addr    = 0x60000000;
    ctrl_mem.w1_base_addr    = 0x70000000;
    ctrl_mem.w2_base_addr    = 0x80000000;

    bool      memory_request = false;
    uint32_t  dma_address    = 0;
    bool      error          = false;

    bool dbg_wl_ready    = false;
    bool dbg_wl_start    = false;
    DmaSel dbg_wl_addr_sel = DmaSel::DMASEL_NONE;
    int  dbg_wl_layer    = 0;
    int  dbg_wl_head     = 0;
    int  dbg_wl_tile     = 0;
    HeadCtx head_ctx_ref[NUM_HEADS];
    bool dma_done        = false;

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    bool axis_in_ready   = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;

    bool compute_ready   = true;
    bool compute_done    = false;
    bool compute_start   = false;
    uint32_t  compute_op      = 0;

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

    bool stream_ready    = true;
    bool stream_start    = false;
    bool stream_done     = false;

    bool done            = false;
    uint32_t debug_compute_done = 0;
    SchedState STATE     = S_IDLE;

    bool comp_busy       = false;
    int  comp_timer      = 0;
    bool dma_busy        = false;
    int  dma_timer       = 0;
    bool stream_busy     = false;
    bool start_pulsed    = false;
    bool seen_done       = false;
    int  post_done_cycles= 0;
    bool seen_idle_after = false;
    bool seen_attn       = false;
    bool seen_concat     = false;

    std::printf("%-8s %-6s %-6s %-8s | %-16s | %-10s %-10s %-10s %-10s | %-8s %-10s %-8s %-8s %-8s %-6s %-6s %-6s | %s\n",
                "Cycle", "Start", "Reset", "Busy", "State",
                "CmpStart", "CmpReady", "CmpDone", "CmpOp",
                "MemReq", "DmaAddr", "dbgWlR", "dbgWlS", "dbgAddr",
                "dbgLyr", "dbgHead", "dbgTile",
                "Heads{idx:ph/cr/cs/cd/op/wlR/addr/qd/wlD}");

    auto dash_or = [](bool v) { return v ? "1" : "-"; };

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Simple reset release at cycle 2
        if (cycle == 2) ctrl_mem.control |= CTRL_RESETN_BIT;
        const bool cntrl_busy = ((ctrl_mem.status & STATUS_BUSY_BIT) != 0);
        // Issue a single-cycle start pulse once after reset deasserts
        if (((ctrl_mem.control & CTRL_RESETN_BIT) != 0) && !start_pulsed) {
            ctrl_mem.control |= CTRL_START_BIT; // set start bit
            start_pulsed = true;
        } else if (cntrl_busy) {
            ctrl_mem.control &= ~CTRL_START_BIT; // clear start when busy
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
        if (memory_request && !dma_busy) {
            dma_busy  = true;
            dma_timer = DMA_LAT - 1;
        }
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

        // Drive AXIS ingress: send a short burst when ready is asserted
        if (!axis_feed_done && (axis_drive || (((ctrl_mem.control & CTRL_RESETN_BIT) != 0) && start_pulsed))) {
            axis_drive = true;
            if (!axis_in_valid && axis_in_ready) {
                axis_in_valid = true;
                axis_in_last  = (axis_sent == AXIS_BEATS - 1);
            }
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        scheduler_hls(
            ctrl_mem,
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            memory_request,
            dma_address,
            dma_done,
            compute_ready,
            compute_done,
            head_ctx_ref,
            compute_start,
            compute_op,
            stream_ready,
            stream_start,
            stream_done,
            done,
            error,
            STATE,
            dbg_wl_ready,
            dbg_wl_start,
            dbg_wl_addr_sel,
            dbg_wl_layer,
            dbg_wl_head,
            dbg_wl_tile);

        const bool cntrl_start   = ((ctrl_mem.control & CTRL_START_BIT) != 0);
        const bool cntrl_reset_n = ((ctrl_mem.control & CTRL_RESETN_BIT) != 0);
        std::printf("%-8d %-6d %-6d %-8s | %-16s | %-10s %-10s %-10s %-10s | %-8s 0x%08x %-8s %-8s %-8s %-6d %-6d %-6d | ",
                    cycle,
                    cntrl_start ? 1 : 0,
                    cntrl_reset_n ? 1 : 0,
                    dash_or(cntrl_busy),
                    state_name(STATE),
                    dash_or(compute_start),
                    dash_or(compute_ready),
                    dash_or(compute_done),
                    (decode_op(compute_op) == CMP_NONE ? "-" : op_name(decode_op(compute_op))),
                    dash_or(memory_request),
                    dma_address,
                    dash_or(dbg_wl_ready),
                    dash_or(dbg_wl_start),
                    dma_name(dbg_wl_addr_sel),
                    dbg_wl_layer,
                    dbg_wl_head,
                    dbg_wl_tile);

        for (int i = 0; i < NUM_HEADS; ++i) {
            char buf[96];
            std::snprintf(buf, sizeof(buf), "%d:%-6s %-2s %-2s %-2s %-8s %-2s %-6s %-2s %-2s",
                          i,
                          phase_name(head_ctx_ref[i].phase),
                          dash_or(head_ctx_ref[i].compute_ready),
                          dash_or(head_ctx_ref[i].compute_start),
                          dash_or(head_ctx_ref[i].compute_done),
                          op_name(decode_op(head_ctx_ref[i].compute_op)),
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
                ComputeOp launched_op = decode_op(head_ctx_ref[i].compute_op);
                if (launched_op == CMP_ATT_SCORES) seen_attn = true;
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
            if (decode_op(compute_op) == CMP_CONCAT) seen_concat = true;
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

        if (done) {
            seen_done = true;
            ctrl_mem.control &= ~CTRL_START_BIT; // clear start bit
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

    bool ok = seen_done && seen_idle_after && seen_attn && seen_concat;
    if (!ok) {
        if (!seen_done)       std::fprintf(stderr, "ERROR: DONE never asserted\n");
        if (!seen_idle_after) std::fprintf(stderr, "ERROR: FSM did not return to IDLE after DONE\n");
        if (!seen_attn)       std::fprintf(stderr, "ERROR: ATT_SCORES compute op never issued\n");
        if (!seen_concat)     std::fprintf(stderr, "ERROR: CONCAT compute op never issued\n");
        return 1;
    }

    std::printf("PASS: DONE observed and FSM returned to IDLE after %d post-done cycles. Layer=%u\n",
                post_done_cycles, ctrl_mem.layer_index);
    return 0;
}
