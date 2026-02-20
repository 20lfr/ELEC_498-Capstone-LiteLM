#pragma once
#include <cstdint>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include "top_params.hpp"
#include "Scheduler_FSM/src-hls/Scheduler_FSM.hpp"
#include "ControlMemInterface/ControlMemInterface.hpp"
// IRQ_Wizard functionality now integrated into ControlMemInterface
// #include "Weight_Loader-Stager/Weight_stager.hpp"
#include "Compute_Controller_Logic/src-hls/compute_controller.hpp"
#include "Compute_Controller_Logic/src-hls/headed_compute_controller.hpp"
#include "MMU/mmu_luka.hpp"

constexpr int TOP_DMA_BUF_BYTES = 65536;
constexpr int TOP_DMA_BUF_WORDS = TOP_DMA_BUF_BYTES / static_cast<int>(sizeof(uint32_t));
static_assert((TOP_DMA_BUF_BYTES % static_cast<int>(sizeof(uint32_t))) == 0, "TOP_DMA_BUF_BYTES must be word-aligned");
using axis8_t = ap_axiu<8, 0, 0, 0>;

// Top-level wrapper prototype
void transformer_top(
    hls::stream<axis8_t> &s_axis_in,    // [INPUT]  AXI4-Stream ingress
    hls::stream<axis8_t> &m_axis_out,   // [OUTPUT] AXI4-Stream egress
    volatile uint32_t *ddr_mem,         // [BOTH]   AXI4-Full external memory
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interfaceo
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface
    bool &irq_ps,                       // [OUTPUT] Interrupt signal

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
    bool     &dbg_wl_accept,
    bool     &dbg_dma_done,
    bool     &dbg_mem_transfer_done,
    bool     &dbg_mem_read_request,
    bool     &dbg_mem_write_request,
    uint32_t &dbg_mem_op,
    uint8_t  dbg_in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t  dbg_out_buf[compute_buf::OUT_BUF_BYTES],
    uint8_t  dbg_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES],
    uint8_t  dbg_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES],
    uint8_t  dbg_stream_in_buf[STREAM_IN_BUF_BYTES],

    bool &dbg_error,
    uint32_t &dbg_error_code,
    bool &dbg_done,
    bool &dbg_axis_is_empty,
    bool &dbg_axis_in_ready_wire,
    bool &dbg_axis_in_last_wire,
    uint32_t &dbg_stream_in_counter
);
