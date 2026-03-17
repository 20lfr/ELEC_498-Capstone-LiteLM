#pragma once

#include <cstdint>
#include "../../top_params.hpp"

// ------------------------------------------------------------
// MatMul-mode instruction-driven scheduler FSM.
//
// Protocol (per invocation):
//   1) PS writes 32-bit INSTR to ctrl_mem.instr:
//        [3:0]    = op
//        [11:4]   = layer (8-bit)
//        [19:12]  = head  (8-bit)
//        [31:20]  = reserved (0)
//      No tile field; all tiling is managed entirely on-chip.
//   2) PS asserts cntrl_start (CTRL_START_BIT in ctrl_mem.control).
//   3) Scheduler enters S_STREAM_IN.
//   4) PS streams activation via AXIS; scheduler waits for axis_token_complete.
//   5) Scheduler enters S_DECODE, decodes op/layer/head, computes tile_end on-chip.
//   6) Scheduler (S_MATMUL) iterates all tiles: DMA → compute → stream-out per tile.
//   7) done pulse after last tile; back to S_IDLE.
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
    bool      &stream_is_final,  // [OUTPUT] true = assert TLAST on this burst

    // Per-tile writeback handshake (non-LOGITS ops only)
    bool      &tile_wb_start,  // [OUTPUT] pulse: copy mmu_out_buf → full_out_buf[offset]
    bool      tile_wb_done,    // [INPUT]  ack: writeback complete, advance to next tile

    // Status outputs
    bool      &done,
    bool      &error,
    uint32_t  &layer_index_out,
    SchedState &STATE
);
