#pragma once

#include <cstdint>
#include "../../top_params.hpp"

// ------------------------------------------------------------
// MatMul-mode instruction-driven scheduler FSM.
//
// Protocol (per invocation):
//   1) PS writes 32-bit INSTR to ctrl_mem.instr:
//        [15:10] = head,  [9:4] = layer,  [3:0] = op
//        [31:16] is reserved/ignored (tile is handled internally by PL).
//   2) PS asserts cntrl_start (CTRL_START_BIT in ctrl_mem.control).
//   3) Scheduler enters S_STREAM_IN.
//   4) PS streams activation via AXIS; scheduler waits for axis_token_complete.
//   5) Scheduler enters S_DECODE, decodes INSTR, selects the op-specific matmul state.
//   6) Scheduler issues DMA request to MMU (weight/KV-cache tile).
//   7) Scheduler issues compute request to compute controller.
//   8) Scheduler enters S_STREAM_OUT; MMU streams int32 result to PS.
//   9) done pulse; back to S_IDLE.
// ------------------------------------------------------------
void scheduler_hls(
    // AXI4-Lite control
    bool      cntrl_reset_n,
    bool      cntrl_start,
    uint32_t  instr,              // Packed 32-bit instruction from PS

    // AXIS ingress completion
    bool      axis_token_complete,

    // MMU / weight-loader interface
    bool      dma_done,           // DMA transfer complete (single-cycle pulse)
    bool      wl_ready,           // MMU ready to accept new DMA request
    bool      wl_accept,          // MMU captured the request
    uint64_t  &wl_instruction,    // 64-bit packed DMA instruction to MMU
    bool      &wl_start,          // Start DMA request

    // Compute controller interface
    bool      compute_ready,
    bool      compute_done,
    bool      &compute_start,
    uint64_t  &compute_instruction,

    // AXIS egress
    bool      stream_ready,
    bool      &stream_start,
    bool      stream_done,

    // Status outputs
    bool      &done,
    bool      &error,
    uint32_t  &layer_index_out,
    SchedState &STATE
);
