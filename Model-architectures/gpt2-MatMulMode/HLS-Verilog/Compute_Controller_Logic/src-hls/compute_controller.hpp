#pragma once

#include "../../top_params.hpp"
#include <cstdint>

// MatMul-only compute controller.
// One invocation = one tiled matmul; output is raw int32 accumulators.
// Buffer sizes come from mm_buf (see top_params.hpp).

void compute_controller(
    bool cntrl_reset_n,

    // Scheduler handshake
    bool        compute_start,
    uint64_t    compute_instruction,  // [7:0]=op [15:8]=layer [23:16]=head [55:24]=tile
    bool        &compute_ready,
    bool        &compute_done,

    // Memory manager handshake
    bool        mem_transfer_done,
    bool        &mem_read_request,
    bool        &mem_write_request,
    uint64_t    &mem_op,

    // Flat I/O buffers — sized to match MMU interface (compute_buf dims).
    // MatMul kernels only access mm_buf-sized offsets; extra space is unused.
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t       out_buf[compute_buf::OUT_BUF_BYTES],

    // Debug visibility
    ComputeState &dbg_state,
    uint64_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint16_t    &dbg_req_tile,
    bool        &dbg_mac_start,
    bool        &dbg_mac_ready,
    bool        &dbg_mac_complete,

    bool        &error
);
