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
    case S_LAYER_NORM_0:    return "S_LN_0";
    case S_REQUANT2:        return "S_RQ2";
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
    case CMP_REQUANT2:     return "RQ2";
    case CMP_FFN_W1:       return "FFN_W1";
    case CMP_FFN_ACT:      return "FFN_ACT";
    case CMP_FFN_W2:       return "FFN_W2";
    case CMP_REQUANT3:     return "RQ3";
    case CMP_RESID1:       return "RESID1";
    case CMP_LN1:          return "LN1";
    case CMP_REQUANT4:     return "RQ4";
    case CMP_DEQUANT:      return "DEQUANT";
    case CMP_LOGITS:       return "LOGITS";
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

static uint32_t compute_wl_address(
    DmaSel sel,
    int layer,
    int head,
    int tile,
    const ControlMemSpace &ctrl
) {
    if (layer < 0) {
        return 0;
    }
    const uint32_t layer_u = static_cast<uint32_t>(layer);
    switch (sel) {
    case DMASEL_WQ:
        if (head < 0) return 0;
        return ctrl.wq_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.wq_head_stride;
    case DMASEL_WK:
        if (head < 0) return 0;
        return ctrl.wk_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.wk_head_stride;
    case DMASEL_WV:
        if (head < 0) return 0;
        return ctrl.wv_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.wv_head_stride;
    case DMASEL_CTX_K:
        if (head < 0) return 0;
        return ctrl.k_cache_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.k_cache_stride;
    case DMASEL_CTX_V:
        if (head < 0) return 0;
        return ctrl.v_cache_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.v_cache_stride;
    case DMASEL_WO:
        if (tile < 0) return 0;
        return ctrl.wo_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(tile) * ctrl.wo_tile_stride;
    case DMASEL_W1:
        if (tile < 0) return 0;
        return ctrl.w1_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(tile) * ctrl.w1_tile_stride;
    case DMASEL_W2:
        if (tile < 0) return 0;
        return ctrl.w2_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(tile) * ctrl.w2_tile_stride;
    default:
        return 0;
    }
}

// Helper to decode status register bits
static const char *status_name(uint32_t status) {
    if (status & STATUS_ERROR)    return "ERROR";
    if (status & STATUS_BUSY_BIT) return "BUSY";
    if (status & STATUS_IDLE)     return "IDLE";
    return "-";
}

static const char *irq_name(uint32_t irq) {
    if (irq & IRQ_ERROR_BIT)        return "ERROR";
    if (irq & IRQ_INFER_DONE_BIT)   return "DONE";
    return "-";
}

ControlMemSpace ctrl_mem_init(bool init) {
    ControlMemSpace ctrl_mem{};
    if(init) {
        ctrl_mem.control = CTRL_RESETN_BIT;
        ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
        ctrl_mem.irq_clear = 0;
        // DMA lengths (non-zero required)
        ctrl_mem.dma_layer_len = 0x00000100;
        ctrl_mem.dma_head_len  = 0x00000100;
        ctrl_mem.dma_tile_len  = 0x00000100;
        // Strides (non-zero required) - match OG testbench values
        ctrl_mem.layer_stride    = 0x00001000;
        ctrl_mem.wq_head_stride  = 0x00000100;
        ctrl_mem.wk_head_stride  = 0x00000100;
        ctrl_mem.wv_head_stride  = 0x00000100;
        ctrl_mem.k_cache_stride  = 0x00000400;
        ctrl_mem.v_cache_stride  = 0x00000400;
        ctrl_mem.wo_tile_stride  = 0x00000100;
        ctrl_mem.w1_tile_stride  = 0x00000300;
        ctrl_mem.w2_tile_stride  = 0x00000800;
        // Base addresses - MUST be 64-byte aligned (& 0x3F == 0)
        ctrl_mem.wq_base_addr = 0x10000000;
        ctrl_mem.wk_base_addr = 0x20000000;
        ctrl_mem.wv_base_addr = 0x30000000;
        ctrl_mem.wo_base_addr = 0x60000000;
        ctrl_mem.w1_base_addr = 0x70000000;
        ctrl_mem.w2_base_addr = 0x80000000;
        ctrl_mem.k_cache_addr = 0x40000000;
        ctrl_mem.v_cache_addr = 0x50000000;
        // Quantization params
        ctrl_mem.logit_scale_qv = 0x00000100;
        ctrl_mem.scale_q        = 0x00000100;
        ctrl_mem.zero_point_q   = 0x00000000;
        ctrl_mem.scale_k        = 0x00000100;
        ctrl_mem.zero_point_k   = 0x00000000;
        ctrl_mem.scale_v        = 0x00000100;
        ctrl_mem.zero_point_v   = 0x00000000;
    }
    return ctrl_mem;
}

int main() {
    const int MAX_CYCLES = 800;
    const int COMP_LAT   = 3;
    const int DMA_LAT    = 3;
    const int AXIS_BEATS = 3;


    bool wl_ready        = false;
    bool wl_start        = false;
    DmaSel wl_addr_sel   = DmaSel::DMASEL_NONE;
    int  wl_layer        = 0;
    int  wl_head         = 0;
    int  wl_tile         = 0;
    HeadCtx head_ctx_ref[NUM_HEADS];
    bool dma_done        = false;
    bool wl_dma_request  = false;
    uint32_t wl_dma_address = 0;

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

    uint32_t debug_compute_done = 0;
    SchedState dbg_state     = S_IDLE;
    bool irq_ps              = false;
    bool irq_interupt_flagged = false;
    uint32_t interupt_data = 0;

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
    enum class CtrlInitStage { 
        TestCtrlInit,           // 0: Initialize with valid config
        TestDmaZeroLen,         // 1: Test DMA zero-length error
        TestDmaZeroLenCheck,    // 2: Verify error was flagged
        TestDmaZeroLenClear,    // 3: Clear the error
        TestZeroStride,         // 4: Test zero-stride error  
        TestZeroStrideCheck,    // 5: Verify error was flagged
        TestZeroStrideClear,    // 6: Clear the error
        TestAlignment,          // 7: Test misaligned address error
        TestAlignmentCheck,     // 8: Verify error was flagged
        TestAlignmentClear,     // 9: Clear the error
        AssertReset,            // 10: Normal operation begins
        DeassertReset, 
        ProgramBases, 
        AssertStart, 
        ClearStart, 
        Done 
    };
    CtrlInitStage ctrl_stage = CtrlInitStage::TestCtrlInit;
    // Test tracking
    bool test_error_detected = false;
    int  test_errors_passed = 0;
    int  test_errors_failed = 0;
    bool dbg_done = false;
    bool dbg_error = false;

    ControlMemSpace ctrl_mem{};
    StatusMemSpace status_mem{};

    uint32_t ctrl_data_in = 0;
    uint32_t ctrl_data_out = 0;
    uint32_t ctrl_shadow_control = 0;
    bool ctrl_resetn_in = false;
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

    std::printf("%-8s %-6s %-6s %-10s %-6s %-6s | %-10s | %-16s %-8s %-10s %-6s %-10s %-10s %-10s | %-10s %-10s %-10s %-6s %-6s | wl{%s %s %s %s %s %s} dma_done=%s dma_addr=%s\n",
                "Cycle", "Start", "Reset", "CompOp", "C_St", "C_Dn",
                "CtrlDin", 
                "DbgState", "WlReq", "WlAddr", "Seen", "IRQ", "IRQFlag", "IRQData",
                "MemCtrl", "MemIRQ", "MemIRQMsk", "Status", "ErrCd",
                "WLrdy", "WLstrt", "WLSel", "Layer", "Head", "Tile",
                "DMADone", "DMAAddr");

    auto dash_or = [](bool v) { return v ? "1" : "-"; };

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Space out control transactions to model multi-cycle AXI-lite access
        if (ctrl_gap_cycles > 0) {
            ctrl_gap_cycles--;
        } else if (ctrl_stage == CtrlInitStage::TestCtrlInit) {
            // Start with valid config
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            std::printf("[TEST] Starting ControlMemInterface error tests...\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLen;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLen) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.dma_layer_len = 0;      // Inject error: zero length
            std::printf("[TEST 1] Injecting dma_layer_len=0 (expect ERR_DMA_ZERO_LEN)\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLenCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenCheck) {
            // Check if error was detected
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ZERO_LEN) {
                std::printf("[TEST 1] PASS: ERR_DMA_ZERO_LEN detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 1] FAIL: Expected ERR_DMA_ZERO_LEN (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            // Clear the error
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestDmaZeroLenClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenClear) {
            ctrl_mem.irq_clear = 0;  // One-shot clear
            ctrl_mem = ctrl_mem_init(true);  // Restore valid config
            ctrl_stage = CtrlInitStage::TestZeroStride;
            ctrl_gap_cycles = 1;
        
        // ========== TEST 2: Zero Stride ==========
        } else if (ctrl_stage == CtrlInitStage::TestZeroStride) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.layer_stride = 0;       // Inject error: zero stride
            std::printf("[TEST 2] Injecting layer_stride=0 (expect ERR_DMA_ZERO_LEN)\n");
            ctrl_stage = CtrlInitStage::TestZeroStrideCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestZeroStrideCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ZERO_LEN) {
                std::printf("[TEST 2] PASS: Zero stride error detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 2] FAIL: Expected zero stride error (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestZeroStrideClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestZeroStrideClear) {
            ctrl_mem.irq_clear = 0;
            ctrl_mem = ctrl_mem_init(true);
            ctrl_stage = CtrlInitStage::TestAlignment;
            ctrl_gap_cycles = 1;
        
        // ========== TEST 3: Address Alignment ==========
        } else if (ctrl_stage == CtrlInitStage::TestAlignment) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.wq_base_addr = 0x10000001;  // Inject error: not 64-byte aligned
            std::printf("[TEST 3] Injecting wq_base_addr=0x10000001 (expect ERR_DMA_ALIGNMENT)\n");
            ctrl_stage = CtrlInitStage::TestAlignmentCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestAlignmentCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ALIGNMENT) {
                std::printf("[TEST 3] PASS: ERR_DMA_ALIGNMENT detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 3] FAIL: Expected ERR_DMA_ALIGNMENT (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestAlignmentClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestAlignmentClear) {
            ctrl_mem.irq_clear = 0;
            ctrl_mem = ctrl_mem_init(false);  
            std::printf("[TEST] Error tests complete: %d passed, %d failed\n", 
                        test_errors_passed, test_errors_failed);
            ctrl_stage = CtrlInitStage::AssertReset;  // Continue to normal operation
            ctrl_gap_cycles = 1;
        
        // ========== NORMAL OPERATION ==========
        } else if (ctrl_stage == CtrlInitStage::AssertReset) {
            ctrl_mem = ctrl_mem_init(false); // Restore default config
            ctrl_mem.control = 0x00000000;
            ctrl_data_in = 0x00000000;
            ctrl_shadow_control = 0x00000000;
            ctrl_resetn_in = false;
            ctrl_stage = CtrlInitStage::DeassertReset;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::DeassertReset) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            ctrl_stage = CtrlInitStage::ProgramBases;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ProgramBases) {
            // Program control-space base addresses and strides with reset asserted
            switch (base_assign_step) {
            case 0:
                // Clear any pending interrupts during programming
                ctrl_mem.irq_clear = IRQ_ERROR_BIT;
                ctrl_data_in  = IRQ_ERROR_BIT;
                break;
            case 1:
                ctrl_mem.dma_layer_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 2:
                ctrl_mem.dma_head_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 3:
                ctrl_mem.dma_tile_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 4:
                ctrl_mem.layer_stride = 0x00001000;
                ctrl_data_in  = 0x00001000;
                break;
            case 5:
                ctrl_mem.wq_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 6:
                ctrl_mem.wk_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 7:
                ctrl_mem.wv_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 8:
                ctrl_mem.k_cache_stride = 0x00000400;
                ctrl_data_in  = 0x00000400;
                break;
            case 9:
                ctrl_mem.v_cache_stride = 0x00000400;
                ctrl_data_in  = 0x00000400;
                break;
            case 10:
                ctrl_mem.wo_tile_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 11:
                ctrl_mem.w1_tile_stride = 0x00000300;
                ctrl_data_in  = 0x00000300;
                break;
            case 12:
                ctrl_mem.w2_tile_stride = 0x00000800;
                ctrl_data_in  = 0x00000800;
                break;
            case 13:
                ctrl_mem.wq_base_addr = 0x10000000;
                ctrl_data_in  = 0x10000000;
                break;
            case 14:
                ctrl_mem.wk_base_addr = 0x20000000;
                ctrl_data_in  = 0x20000000;
                break;
            case 15:
                ctrl_mem.wv_base_addr = 0x30000000;
                ctrl_data_in  = 0x30000000;
                break;
            case 16:
                ctrl_mem.k_cache_addr = 0x40000000;
                ctrl_data_in  = 0x40000000;
                break;
            case 17:
                ctrl_mem.v_cache_addr = 0x50000000;
                ctrl_data_in  = 0x50000000;
                break;
            case 18:
                ctrl_mem.wo_base_addr = 0x60000000;
                ctrl_data_in  = 0x60000000;
                break;
            case 19:
                ctrl_mem.w1_base_addr = 0x70000000;
                ctrl_data_in  = 0x70000000;
                break;
            case 20:
                ctrl_mem.w2_base_addr = 0x80000000;
                ctrl_data_in  = 0x80000000;
                break;
            case 21:
                // Disabled interrupt clearing
                ctrl_mem.irq_clear = 0;
                ctrl_data_in  = 0;
                break;
            case 22:
                // Enable interrupts
                ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
                ctrl_data_in  = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
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
            ctrl_mem.control = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_data_in = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_resetn_in = true;
            reset_released = true;
            start_pulsed   = true;
            pending_start_clear = true;
            ctrl_stage = CtrlInitStage::ClearStart;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ClearStart) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            pending_start_clear = false;
            ctrl_stage = CtrlInitStage::Done;
            ctrl_gap_cycles = 1;
        } else if(seen_irq_done){
            ctrl_mem.irq_clear = IRQ_INFER_DONE_BIT;
            ctrl_data_in = IRQ_INFER_DONE_BIT;
            ctrl_gap_cycles = 1;
            seen_irq_done = false;
        }
        else if(irq_ps){
            ctrl_gap_cycles = 1;
            irq_interupt_flagged = true;
            interupt_data = status_mem.irq_status;
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
        wl_ready = !dma_busy;
        wl_dma_request = false;

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
            wl_ready,
            wl_start,
            wl_addr_sel,
            wl_layer,
            wl_head,
            wl_tile,
            compute_ready,
            compute_done,
            compute_start,
            compute_op,
            head_ctx_ref,
            stream_ready,
            stream_start,
            stream_done,
            ctrl_mem,
            status_mem,
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
            dbg_done,
            dbg_error
        );

        if (wl_start && !dma_busy) {
            wl_dma_request = true;
            wl_dma_address = compute_wl_address(wl_addr_sel, wl_layer, wl_head, wl_tile,
                                                ctrl_mem);
            dma_busy  = true;
            dma_timer = DMA_LAT - 1;
        }

        const bool cntrl_start   = ((ctrl_shadow_control & CTRL_START_BIT) != 0);
        const bool cntrl_reset_n = ((ctrl_shadow_control & CTRL_RESETN_BIT) != 0);
        std::printf("%-8d %-6d %-6d 0x%08X %-6s %-6s | %-10u | %-16s %-8s 0x%08X %-6s %-10s %-10s 0x%08X | %-10u %-10s %-10u %-6s 0x%04X | wl{%s %s %s %d %d %d} dma_done=%s dma_addr=0x%08X",
                    cycle,
                    cntrl_start ? 1 : 0,
                    cntrl_reset_n ? 1: 0,
                    compute_op,
                    dash_or(compute_start),
                    dash_or(compute_done),
                    ctrl_data_in,
                    state_name(dbg_state),
                    dash_or(wl_dma_request),
                    wl_dma_address,
                    dash_or(seen_done),
                    dash_or(irq_ps),
                    dash_or(irq_interupt_flagged),
                    interupt_data,
                    dbg_ctrl_mem.control,
                    irq_name(status_mem.irq_status),
                    dbg_ctrl_mem.irq_mask,
                    status_name(status_mem.status),
                    status_mem.error_code,
                    dash_or(wl_ready),
                    dash_or(wl_start),
                    dma_name(wl_addr_sel),
                    wl_layer,
                    wl_head,
                    wl_tile,
                    dash_or(dma_done),
                    wl_dma_address);
        for (int i = 0; i < NUM_HEADS; ++i) {
            char buf[128];
            std::snprintf(buf, sizeof(buf), "%d:%-6s %-2s %-2s 0x%08X %-2s %-4s %-2s",
                          i,
                          phase_name(head_ctx_ref[i].phase),
                          dash_or(head_ctx_ref[i].compute_start),
                          dash_or(head_ctx_ref[i].compute_done),
                          head_ctx_ref[i].compute_op,
                          dash_or(head_ctx_ref[i].wl_start),
                          dma_name(head_ctx_ref[i].wl_addr_sel),
                          dash_or(head_ctx_ref[i].dma_done));
            std::printf(" %s", buf);
        }
        std::printf("\n");

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
    bool error_tests_ok = (test_errors_passed == 3) && (test_errors_failed == 0);
    
    if (!error_tests_ok) {
        std::fprintf(stderr, "ERROR: ControlMemInterface error tests: %d passed, %d failed (expected 3/0)\n",
                     test_errors_passed, test_errors_failed);
    }
    
    if (!ok) {
        if (!seen_stream_out) std::fprintf(stderr, "ERROR: STREAM_OUT state never reached\n");
        if (idle_after_stream < 4) std::fprintf(stderr, "ERROR: Did not remain in IDLE for 4 cycles after STREAM_OUT\n");
        if (!seen_attn)       std::fprintf(stderr, "ERROR: ATT_SCORES compute op never issued\n");
        if (!seen_concat)     std::fprintf(stderr, "ERROR: CONCAT compute op never issued\n");
        return 1;
    }
    
    if (!error_tests_ok) {
        return 1;
    }

    std::printf("PASS: All ControlMemInterface error tests passed (%d/3)\n", test_errors_passed);
    std::printf("PASS: STREAM_OUT reached and FSM stayed IDLE for %d cycles after.\n",
                idle_after_stream);
    return 0;
}
