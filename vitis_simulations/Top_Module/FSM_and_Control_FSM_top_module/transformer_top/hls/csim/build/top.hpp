#pragma once
#include <cstdint>
#include "top_params.hpp"
#include "Scheduler_FSM/src-hls/Scheduler_FSM.hpp"
#include "ControlMemInterface/ControlMemInterface.hpp"
#include "IRQ_Wizard/IRQ_Wizard.hpp"
// #include "Weight_Loader-Stager/Weight_stager.hpp"


// Top-level wrapper prototype
void transformer_top(
    bool axis_in_valid,                 // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,                  // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready,                // [OUTPUT] s_axis_in_tready
    bool        dma_done,               // [INPUT]  DMA transfer completed (single-cycle pulse)
    uint32_t    &dma_address,           // [OUTPUT] Address of completed DMA transfer
    bool        &memory_request,        // [OUTPUT] Request a DMA transfer-
    bool compute_ready,                 // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,                  // [INPUT]  Compute operation finished (one-shot)
    bool &compute_start,                // [OUTPUT] Trigger compute engine
    ComputeOp &compute_op,              // [OUTPUT] What operation to run (Wo, W1, W2, FFN, etc)
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]   Per-head context (in/out) - includes DMA signals, head records and compute signals
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence     
    ControlReg ctrl_addr,               // [INPUT]  AXI-lite address
    uint32_t   ctrl_data_in,            // [INPUT]  AXI-lite write data
    uint32_t   &ctrl_data_out,          // [OUTPUT] AXI-lite read data
    bool       ctrl_read_en,            // [INPUT]  AXI-lite read strobe
    bool       ctrl_write_en,           // [INPUT]  AXI-lite write strobe
    bool       ctrl_chip_en,            // [INPUT]  AXI-lite chip enable
    bool       ctrl_resetn_in,          // [INPUT]  AXI-lite active-low reset <- for clearing control mem ONLY
    bool        &irq_ps,

    
    SchedState  &dbg_state,
    ControlMemSpace &dbg_ctrl_mem,
    uint32_t &control_reg,
    uint32_t &irq_status_reg,
    uint32_t &irq_enable_reg,
    uint32_t &wq_base_addr,
    uint32_t &wk_base_addr,
    uint32_t &wv_base_addr,
    uint32_t &wo_base_addr,
    uint32_t &w1_base_addr,
    uint32_t &w2_base_addr,
    uint32_t &wq_head_stride,
    uint32_t &wk_head_stride,
    uint32_t &wv_head_stride,
    uint32_t &wo_tile_stride,
    uint32_t &w1_tile_stride,
    uint32_t &w2_tile_stride,
    // Debug mirrors
    bool &dbg_wl_ready,
    bool &dbg_wl_start,
    DmaSel &dbg_wl_addr_sel,
    int &dbg_wl_layer,
    int &dbg_wl_head,
    int &dbg_wl_tile,
    bool &dbg_done,
    bool &dbg_error
);
