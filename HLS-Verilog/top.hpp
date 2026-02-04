#pragma once
#include <cstdint>
#include "top_params.hpp"
#include "Scheduler_FSM/src-hls/Scheduler_FSM.hpp"
#include "ControlMemInterface/ControlMemInterface.hpp"
// IRQ_Wizard functionality now integrated into ControlMemInterface
#include "Transformer_logic/src-hls/compute_controller.hpp"
// #include "Weight_Loader-Stager/Weight_stager.hpp"


// Top-level wrapper prototype
void transformer_top(
    bool axis_in_valid,                 // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,                  // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready,                // [OUTPUT] s_axis_in_tready
    bool        dma_done,               // [INPUT]  DMA transfer completed (single-cycle pulse)
    bool        wl_ready,               // [INPUT]  Weight loader ready for a new request
    uint32_t    &wl_instruction,        // [OUTPUT] Packed dma op|layer|head|tile
    bool        &wl_start,              // [OUTPUT] Start weight load request

    // Compute Controller communication signals
    bool        mem_transfer_done,      // [INPUT] Memory manager transfer complete
    bool        &mem_read_request,      // [OUTPUT] Request memory manager read
    bool        &mem_write_request,     // [OUTPUT] Request memory manager write
    uint32_t    &mem_op,                // [OUTPUT] Opcode for memory manager
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t       out_buf[compute_buf::OUT_BUF_BYTES],

    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]   Per-head context (in/out)
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence     
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interfaceo
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface
    bool &irq_ps,                       // [OUTPUT] Interrupt signal

    // Debug (scheduler)
    SchedState  &dbg_state,
    ControlMemSpace &dbg_ctrl_mem,
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

    // Debug (compute controller)
    bool     &dbg_compute_start,
    uint32_t &dbg_compute_instruction,
    bool     &dbg_compute_ready,
    bool     &dbg_compute_done,
    ComputeState &dbg_compute_state,
    uint32_t &dbg_req_instruction,
    uint8_t  &dbg_req_op,
    uint8_t  &dbg_req_layer,
    uint8_t  &dbg_req_head,
    uint8_t  &dbg_req_tile,
    bool     &dbg_mac_start,
    bool     &dbg_mac_ready,
    bool     &dbg_mac_complete,
    bool     &dbg_ctrl_reset_asserted,

    bool &dbg_done,
    bool &dbg_error
);
