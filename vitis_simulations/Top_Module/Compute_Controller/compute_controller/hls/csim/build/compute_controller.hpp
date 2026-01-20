#pragma once

#include "../../top_params.hpp"
#include "compute_buffer_layout.hpp"
#include <cstdint>

using int4_t = ap_int<4>;

void compute_controller(
    bool        reset,               // [INPUT] Reset signal

    // FSM communication signals
    bool        compute_start,       // [INPUT] Start signal for compute
    uint32_t    compute_op,          // [INPUT] Compute operation [7:0]=op [15:8]=layer [23:16]=head [31:24]=tile
    bool        &compute_ready,      // [OUTPUT] Compute engine ready for new operation
    bool        &compute_done,       // [OUTPUT] Compute operation finished

    // Memory manager handshake
    bool        mem_transfer_done,   // [INPUT] Memory manager transfer complete
    bool        &mem_read_request,   // [OUTPUT] Request memory manager read
    bool        &mem_write_request,  // [OUTPUT] Request memory manager write
    uint32_t    &mem_op,             // [OUTPUT] Opcode for memory manager

    // Flat input/output buffers
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t       out_buf[compute_buf::OUT_BUF_BYTES],

    bool        &error               // [OUTPUT] Error flag on invalid request
);
