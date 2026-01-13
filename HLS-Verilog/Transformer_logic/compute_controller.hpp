#pragma once

#include "../top_params.hpp"
#include <cstdint>

using int4_t = ap_int<4>;

// Top-level compute controller stub.
// - Latches a request from the scheduler (compute_start/compute_op + memory addrs/sizes)
// - Fetches the operands from BRAM/URAM (simulated here by reading valueA/valueB pointers)
// - Dispatches the operands to the appropriate compute kernel (OUT_PROJ supported for now)
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
    uint8_t     &mem_op,             // [OUTPUT] Opcode for memory manager

    // Data location INPUT signals from Memory Controller
    int8_t     valueA[D_MODEL],               // [INPUT] Input activations for OUT_PROJ
    int4_t     valueB[D_MODEL * D_TILE_WO],   // [INPUT] Weights for OUT_PROJ tile
    int32_t    out_accum[D_TILE_WO],          // [OUTPUT] Output accumulators for OUT_PROJ
    bool        &error               // [OUTPUT] Error flag on invalid request
);
