#pragma once
#include <cstdint>
#include "top_params.hpp"
#include "Scheduler_FSM/src-hls/Scheduler_FSM.hpp"
#include "ControlMemInterface/ControlMemInterface.hpp"
// IRQ_Wizard functionality now integrated into ControlMemInterface
// #include "Weight_Loader-Stager/Weight_stager.hpp"
#include "Transformer_logic/src-hls/compute_controller.hpp"
#include "Transformer_logic/src-hls/headed_compute_controller.hpp"

constexpr int TOP_DMA_BUF_BYTES = 65536;

// Top-level wrapper prototype
void transformer_top(
    bool axis_in_valid,                 // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,                  // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready,                // [OUTPUT] s_axis_in_tready

    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence     
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interfaceo
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface
    bool &irq_ps,                       // [OUTPUT] Interrupt signal
    bool dma_ready,                     // [INPUT] DMA command interface ready
    bool dma_done,                      // [INPUT] DMA completion pulse
    const uint8_t dma_rx_buf[TOP_DMA_BUF_BYTES], // [INPUT] DMA read payload into MMU
    uint8_t dma_tx_buf[TOP_DMA_BUF_BYTES],       // [OUTPUT] DMA write payload from MMU
    bool &dma_start,                    // [OUTPUT] Start DMA transfer
    uint32_t &dma_addr,                 // [OUTPUT] DMA address
    uint32_t &dma_len,                  // [OUTPUT] DMA transfer length
    bool &dma_is_write,                 // [OUTPUT] DMA direction (1=MMU->DDR)

    /*
        TEMPORARY OUTPUTS BELOW FOR DEBUGGING PURPOSES!!!!!!!!!!!!!
    */

    // Debug (scheduler)
    SchedState  &dbg_state,
    HeadCtx (&dbg_head_ctx_ref)[NUM_HEADS],              // [OUTPUT] Debug mirror: per-head scheduler context
    ComputeHeadCtx  (&dbg_head_compute_ctx)[HEADS_PARALLEL], // [OUTPUT] Debug mirror: per-lane headed compute context
    ControlMemSpace &dbg_ctrl_mem,
    uint32_t &control_reg,
    uint32_t &irq_status_reg,
    uint32_t &irq_mask_reg,
    uint32_t &irq_clear_reg,
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
    int      &dbg_head_group_idx,
    bool     &dbg_wl_ready,
    uint32_t &dbg_wl_instruction,
    bool     &dbg_wl_start,
    bool     &dbg_mem_transfer_done,
    bool     &dbg_mem_read_request,
    bool     &dbg_mem_write_request,
    uint32_t &dbg_mem_op,
    uint8_t  dbg_in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t  dbg_out_buf[compute_buf::OUT_BUF_BYTES],
    uint8_t  dbg_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES],
    uint8_t  dbg_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES],

    bool &dbg_done
);
