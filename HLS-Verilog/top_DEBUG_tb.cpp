// Minimal testbench for Simple_Scheduler_FSM.
// Mirrors the style of Scheduler_tb_minimal.cpp but against the simplified scheduler interface.
#include <cstdio>
#include <cstdint>
#include <string>

#include "top.hpp"

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
    case CMP_REQUANT2:     return "RQ2";
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
    case HeadPhase::REQUANT2:          return "RQ2";
    case HeadPhase::DONE:              return "DONE";
    default:                           return "UNK";
    }
}

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
    bool        &ctrl_read_en,
    bool        &ctrl_write_en,
    bool        &ctrl_chip_en,
    bool        &ctrl_resetn_in
) {
    ctrl_addr      = addr;
    ctrl_data_in   = 0;
    ctrl_read_en   = true;
    ctrl_chip_en   = true;
    ctrl_write_en  = false;
    ctrl_resetn_in = resetn_in;
}

int main() {
    const int MAX_CYCLES = 750;
    const int COMP_LAT   = 3;
    const int DMA_LAT    = 3;
    const int AXIS_BEATS = 3;


    bool wl_ready        = true;
    bool wl_start        = false;
    DmaSel wl_addr_sel   = DmaSel::DMASEL_NONE;
    int  wl_layer        = 0;
    int  wl_head         = 0;
    int  wl_tile         = 0;
    HeadCtx head_ctx_ref[NUM_HEADS];
    bool dma_done        = false;
    bool memory_request  = false;
    uint32_t dma_address = 0;

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    bool axis_in_ready   = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;

    bool compute_ready   = true;
    bool compute_done    = false;
    bool compute_start   = false;
    ComputeOp  compute_op      = ComputeOp::CMP_NONE;

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

    bool dbg_done            = false;
    uint32_t debug_compute_done = 0;
    SchedState dbg_state     = S_IDLE;
    bool irq_ps              = false;
    bool irq_interupt_flagged = false;
    uint32_t   interupt_data = 0;
    // Debug mirrors
    bool dbg_wl_ready = false;
    bool dbg_wl_start = false;
    DmaSel dbg_wl_addr_sel = DmaSel::DMASEL_NONE;
    int dbg_wl_layer = 0;
    int dbg_wl_head = 0;
    int dbg_wl_tile = 0;
    bool dbg_error = false;

    bool comp_busy       = false;
    int  comp_timer      = 0;
    bool dma_busy        = false;
    int  dma_timer       = 0;
    bool stream_busy     = false;
    bool reset_released  = false;
    bool start_pulsed    = false;
    bool pending_start_clear = false;
    bool assign_base_addresses = false;
    bool seen_stream_out = false;
    int  idle_after_stream = 0;
    bool seen_done       = false;
    int  post_done_cycles= 0;
    bool seen_idle_after = false;
    bool seen_attn       = false;
    bool seen_concat     = false;
    int  base_assign_step = 0;
    enum class CtrlInitStage { AssertReset, DeassertReset, ProgramBases, AssertStart, ClearStart, Done };
    CtrlInitStage ctrl_stage = CtrlInitStage::AssertReset;



    // DEBUG - UNUSED
    ControlReg ctrl_addr = ControlReg::CONTROL;
    uint32_t ctrl_data_in = 0;
    uint32_t ctrl_data_out = 0;
    bool ctrl_read_en    = false;
    bool ctrl_write_en   = false;
    bool ctrl_chip_en    = false; // gate writes until used
    bool ctrl_resetn_in  = false;
    uint32_t ctrl_shadow_control = 0;
    int ctrl_gap_cycles = 0; // spacing between control bus transactions
    bool seen_irq_done = false;

    ControlMemSpace dbg_ctrl_mem{};

    uint32_t control_reg    = 0;
    uint32_t irq_status_reg     = 0;
    uint32_t irq_enable_reg     = 0;
    uint32_t wq_base_addr   = 0;
    uint32_t wk_base_addr   = 0;
    uint32_t wv_base_addr   = 0;
    uint32_t wo_base_addr   = 0;
    uint32_t w1_base_addr   = 0;
    uint32_t w2_base_addr   = 0;
    uint32_t wq_head_stride     = 0;
    uint32_t wk_head_stride     = 0;
    uint32_t wv_head_stride     = 0;
    uint32_t wo_tile_stride     = 0;
    uint32_t w1_tile_stride     = 0;
    uint32_t w2_tile_stride     = 0;

    std::printf("%-8s %-6s %-6s | %-10s | %-10s %-10s %-8s %-8s %-8s %-8s | %-16s %-8s %-10s %-8s %-6s %-10s %-10s %-10s | %-10s %-10s %-10s | wl{%s %s %s %s %s %s} err=%s dma_req=%s dma_done=%s dma_addr=%s\n",
                "Cycle", "Start", "Reset",
                "CtrlAddr",
                "CtrlDin", "CtrlDout", "Rd", "Wr", "CE", "RstN",
                "DbgState", "MemReq", "DMA_Addr", "DbgDone", "Seen", "IRQ", "IRQFlag", "IRQData",
                "MemCtrl", "MemIRQ", "MemIRQEn",
                "WLrdy", "WLstrt", "WLSel", "Layer", "Head", "Tile",
                "Err", "DMAReq", "DMADone", "DMAAddr");

    auto dash_or = [](bool v) { return v ? "1" : "-"; };

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Default idle control signals each cycle
        ctrl_addr     = ControlReg::STATUS;
        ctrl_data_in  = 0;
        ctrl_read_en  = false;
        ctrl_write_en = false;
        ctrl_chip_en  = false;

        // Space out control transactions to model multi-cycle AXI-lite access
        if (ctrl_gap_cycles > 0) {
            ctrl_gap_cycles--;
        } else if (ctrl_stage == CtrlInitStage::AssertReset) {
            ctrl_write(ControlReg::CONTROL, 0x00000000, false,
                       ctrl_addr, ctrl_data_in, ctrl_data_out,
                       ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            ctrl_shadow_control = 0;
            ctrl_resetn_in = false;
            ctrl_stage = CtrlInitStage::DeassertReset;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::DeassertReset) {
            ctrl_write(ControlReg::CONTROL, CTRL_RESETN_BIT, true,
                       ctrl_addr, ctrl_data_in, ctrl_data_out,
                       ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            ctrl_stage = CtrlInitStage::ProgramBases;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ProgramBases) {
            // Program control-space base addresses and strides with reset asserted
            switch (base_assign_step) {
            case 0:
                ctrl_write(ControlReg::LAYER_STRIDE, 0x00001000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 1:
                ctrl_write(ControlReg::WQ_HEAD_STRIDE, 0x00000100, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 2:
                ctrl_write(ControlReg::WK_HEAD_STRIDE, 0x00000100, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 3:
                ctrl_write(ControlReg::WV_HEAD_STRIDE, 0x00000100, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 4:
                ctrl_write(ControlReg::K_CACHE_STRIDE, 0x00000400, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 5:
                ctrl_write(ControlReg::V_CACHE_STRIDE, 0x00000400, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 6:
                ctrl_write(ControlReg::WO_TILE_STRIDE, 0x00000100, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 7:
                ctrl_write(ControlReg::W1_TILE_STRIDE, 0x00000300, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 8:
                ctrl_write(ControlReg::W2_TILE_STRIDE, 0x00000800, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 9:
                ctrl_write(ControlReg::WQ_BASE_ADDR, 0x10000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 10:
                ctrl_write(ControlReg::WK_BASE_ADDR, 0x20000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 11:
                ctrl_write(ControlReg::WV_BASE_ADDR, 0x30000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 12:
                ctrl_write(ControlReg::K_CACHE_ADDR, 0x40000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 13:
                ctrl_write(ControlReg::V_CACHE_ADDR, 0x50000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 14:
                ctrl_write(ControlReg::WO_BASE_ADDR, 0x60000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 15:
                ctrl_write(ControlReg::W1_BASE_ADDR, 0x70000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                break;
            case 16:
                ctrl_write(ControlReg::W2_BASE_ADDR, 0x80000000, ctrl_resetn_in,
                           ctrl_addr, ctrl_data_in, ctrl_data_out,
                           ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
                assign_base_addresses = true;
                ctrl_stage = CtrlInitStage::AssertStart;
                break;
            default:
                assign_base_addresses = true;
                ctrl_stage = CtrlInitStage::AssertStart;
                break;
            }
            if (!assign_base_addresses) {
                base_assign_step++;
            }
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::AssertStart) {
            ctrl_write(ControlReg::CONTROL, CTRL_RESETN_BIT | CTRL_START_BIT, true,
                       ctrl_addr, ctrl_data_in, ctrl_data_out,
                       ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            ctrl_shadow_control = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_resetn_in = true;
            reset_released = true;
            start_pulsed   = true;
            pending_start_clear = true;
            ctrl_stage = CtrlInitStage::ClearStart;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ClearStart) {
            ctrl_write(ControlReg::CONTROL, CTRL_RESETN_BIT, ctrl_resetn_in,
                       ctrl_addr, ctrl_data_in, ctrl_data_out,
                       ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            ctrl_shadow_control = CTRL_RESETN_BIT;
            pending_start_clear = false;
            ctrl_stage = CtrlInitStage::Done;
            ctrl_gap_cycles = 1;
        } else if(seen_irq_done){
            ctrl_write(ControlReg::IRQ_STATUS, IRQ_CLEAR_BIT, ctrl_resetn_in,
                       ctrl_addr, ctrl_data_in, ctrl_data_out,
                       ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            ctrl_gap_cycles = 1;
            seen_irq_done = false;
        }
        else if(irq_ps){
            ctrl_read(ControlReg::IRQ_STATUS, ctrl_resetn_in,
                      ctrl_addr, ctrl_data_in,
                      ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            ctrl_gap_cycles = 1;
            irq_interupt_flagged = true;
            interupt_data = ctrl_data_out;
        } 
        else {
            // Periodically read status to observe scheduler (one transaction at a time)
            ctrl_read(ControlReg::STATUS, ctrl_resetn_in,
                      ctrl_addr, ctrl_data_in,
                      ctrl_read_en, ctrl_write_en, ctrl_chip_en, ctrl_resetn_in);
            ctrl_gap_cycles = 1;
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
        if (!axis_feed_done && (axis_drive || (((ctrl_shadow_control & CTRL_RESETN_BIT) != 0) && start_pulsed))) {
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
            dma_address,
            memory_request,
            compute_ready,
            compute_done,
            compute_start,
            compute_op,
            head_ctx_ref,
            stream_ready,
            stream_start,
            stream_done,
            ctrl_addr,
            ctrl_data_in,
            ctrl_data_out,
            ctrl_read_en,
            ctrl_write_en,
            ctrl_chip_en,
            ctrl_resetn_in,
            irq_ps,
            dbg_state, 
            dbg_ctrl_mem,
            control_reg,
            irq_status_reg,
            irq_enable_reg,
            wq_base_addr,
            wk_base_addr,
            wv_base_addr,
            wo_base_addr,
            w1_base_addr,
            w2_base_addr,
            wq_head_stride,
            wk_head_stride,
            wv_head_stride,
            wo_tile_stride,
            w1_tile_stride,
            w2_tile_stride,
            dbg_wl_ready,
            dbg_wl_start,
            dbg_wl_addr_sel,
            dbg_wl_layer,
            dbg_wl_head,
            dbg_wl_tile,
            dbg_done,
            dbg_error
        );

        const bool cntrl_start   = ((ctrl_shadow_control & CTRL_START_BIT) != 0);
        const bool cntrl_reset_n = ((ctrl_shadow_control & CTRL_RESETN_BIT) != 0);
        std::printf("%-8d %-6d %-6d | %-10u | %-10u %-10u %-8s %-8s %-8s %-8s | %-16s %-8s 0x%08X %-8s %-6s %-10s %-10s 0x%08X | %-10u %-10u %-10u | wl{%d %d %d %d %d %d} err=%d dma_req=%d dma_done=%d dma_addr=0x%08X\n",
                    cycle,
                    cntrl_start ? 1 : 0,
                    cntrl_reset_n ? 1 : 0,
                    static_cast<unsigned>(ctrl_addr),
                    ctrl_data_in,
                    ctrl_data_out,
                    dash_or(ctrl_read_en),
                    dash_or(ctrl_write_en),
                    dash_or(ctrl_chip_en),
                    dash_or(ctrl_resetn_in),
                    state_name(dbg_state),
                    dash_or(memory_request),
                    dma_address,
                    dash_or(dbg_done),
                    dash_or(seen_done),
                    dash_or(irq_ps),
                    dash_or(irq_interupt_flagged),
                    interupt_data,
                    dbg_ctrl_mem.control,
                    dbg_ctrl_mem.irq_status,
                    dbg_ctrl_mem.irq_enable,
                    dbg_wl_ready,
                    dbg_wl_start,
                    static_cast<int>(dbg_wl_addr_sel),
                    dbg_wl_layer,
                    dbg_wl_head,
                    dbg_wl_tile,
                    dbg_error,
                    memory_request ? 1 : 0,
                    dma_done ? 1 : 0,
                    dma_address);

        // Track the tail of the sequence: once we hit STREAM_OUT, watch for 4 idle cycles
        if (dbg_state == S_STREAM_OUT) {
            seen_stream_out = true;
            idle_after_stream = 0;
        } else if (seen_stream_out && dbg_state == S_IDLE) {
            idle_after_stream++;
        } else if (seen_stream_out) {
            idle_after_stream = 0;
        }

        // Launch head compute requests onto their dedicated lanes
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            if (head_ctx_ref[i].compute_start && !head_lane_busy[lane]) {
                head_lane_busy[lane] = true;
                head_lane_timer[lane] = COMP_LAT - 1;
                head_lane_active_idx[lane] = i;
                ComputeOp launched_op = head_ctx_ref[i].compute_op;
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
            if (compute_op == CMP_CONCAT) seen_concat = true;
        }
        // Fulfill DMA requests: when memory_request is asserted, capture address and return dma_done after a fixed latency.
        if (memory_request && !dma_busy) {
            dma_busy  = true;
            dma_timer = DMA_LAT - 1;
            dma_done  = false;
        } else if (dma_busy) {
            if (dma_timer == 0) {
                dma_busy = false;
                dma_done = true; // single-cycle pulse
            } else {
                dma_timer--;
                dma_done = false;
            }
        } else {
            dma_done = false;
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

        if (irq_interupt_flagged && (interupt_data & IRQ_INFER_DONE_BIT)) {
            seen_done = true;
            irq_interupt_flagged = false;
            interupt_data = 0;
            seen_irq_done = true;
        }
        else if (seen_done){
            post_done_cycles++;
            if (post_done_cycles >= 2) {
                seen_idle_after = true;
                seen_irq_done = false;
            }
        }

        if (!cntrl_start && seen_done && seen_idle_after && seen_stream_out && idle_after_stream >= 4) {
            break;
        }
    }

    bool ok = seen_stream_out && (idle_after_stream >= 4) && seen_attn && seen_concat;
    if (!ok) {
        if (!seen_stream_out) std::fprintf(stderr, "ERROR: STREAM_OUT state never reached\n");
        if (idle_after_stream < 4) std::fprintf(stderr, "ERROR: Did not remain in IDLE for 4 cycles after STREAM_OUT\n");
        if (!seen_attn)       std::fprintf(stderr, "ERROR: ATT_SCORES compute op never issued\n");
        if (!seen_concat)     std::fprintf(stderr, "ERROR: CONCAT compute op never issued\n");
        return 1;
    }

    std::printf("PASS: STREAM_OUT reached and FSM stayed IDLE for %d cycles after.\n",
                idle_after_stream);
    return 0;
}
