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
    bool        wl_ready,                 // [INPUT]  Weight loader ready for a new request
    bool        &wl_start,                // [OUTPUT] Start weight load request
    DmaSel      &wl_addr_sel,             // [OUTPUT] Select weight matrix/tile
    int         &wl_layer,                // [OUTPUT] Layer index for DMA
    int         &wl_head,                 // [OUTPUT] Head index (or -1 for non-head ops)
    int         &wl_tile,                 // [OUTPUT] Tile index for large matrices
    bool compute_ready,                 // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,                  // [INPUT]  Compute operation finished (one-shot)
    bool &compute_start,                // [OUTPUT] Trigger compute engine
    uint32_t &compute_op,               // [OUTPUT] Packed op|layer|head|tile for compute
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]   Per-head context (in/out) - includes DMA signals, head records and compute signals
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence     
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interfaceo
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface
    bool &irq_ps,                       // [OUTPUT] Interrupt signal

    
    SchedState  &dbg_state,
    ControlMemSpace &dbg_ctrl_mem,
    StatusMemSpace &dbg_status_mem,
    uint32_t &control_reg,
    uint32_t &irq_status_reg,
    uint32_t &irq_mask_reg,
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
    
    bool &dbg_done,
    bool &dbg_error
);
