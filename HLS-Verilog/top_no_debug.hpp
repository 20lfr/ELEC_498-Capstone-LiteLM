#pragma once
#include <cstdint>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include "top_params.hpp"
#include "Scheduler_FSM/src-hls/Scheduler_FSM.hpp"
#include "ControlMemInterface/ControlMemInterface.hpp"
#include "Compute_Controller_Logic/src-hls/compute_controller.hpp"
#include "Compute_Controller_Logic/src-hls/headed_compute_controller.hpp"
#include "MMU/mmu_luka.hpp"

constexpr int TOP_DMA_BUF_BYTES = DMA_BUF_BYTES;
constexpr int TOP_DMA_BUF_WORDS = TOP_DMA_BUF_BYTES / AXI_GMEM_WORD_BYTES;
static_assert((TOP_DMA_BUF_BYTES % AXI_GMEM_WORD_BYTES) == 0, "TOP_DMA_BUF_BYTES must be word-aligned");
static_assert(static_cast<int>(sizeof(axi_gmem_word_t)) == AXI_GMEM_WORD_BYTES,
              "axi_gmem_word_t width must match AXI_GMEM_WORD_BYTES");
using axis8_t = ap_axiu<8, 0, 0, 0>;

// Top-level wrapper prototype (reduced debug ports)
void transformer_top(
    hls::stream<axis8_t> &s_axis_in,    // [INPUT]  AXI4-Stream ingress
    hls::stream<axis8_t> &m_axis_out,   // [OUTPUT] AXI4-Stream egress
    volatile axi_gmem_word_t *ddr_mem,  // [BOTH]   AXI4-Full external memory
    ControlMemSpace ctrl_mem,           // [INPUT]  Control memory interface
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface
    bool &irq_ps,                       // [OUTPUT] Interrupt signal
    SchedState &dbg_state               // [OUTPUT] Scheduler state mirror
);
