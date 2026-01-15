#pragma once

#include "../../top_params.hpp"
#include <cstdint>

using int4_t = ap_int<4>;

// Simple MAC for Q/K/V projection: vector (int8) × weights (int4) → int32 accum per head.
void MAC_QKV(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_HEADS],
    int32_t accum_out[D_HEADS]
);

void headed_compute_controller(
    bool        reset,               // [INPUT] Reset signal

    // FSM communication signals
    bool        compute_start,       // [INPUT] Start signal for compute
    uint32_t    compute_instruction,          // [INPUT] Compute operation [7:0]=op [15:8]=layer [23:16]=head [31:24]=tile
    bool        &compute_ready,      // [OUTPUT] Compute engine ready for new operation
    bool        &compute_done,       // [OUTPUT] Compute operation finished

    // Memory manager handshake
    bool        mem_transfer_done,
    bool        &mem_read_request,        // [OUTPUT] Request memory manager
    bool        &mem_write_request,        // [OUTPUT] Request memory manager
    uint32_t     &mem_op,             // [OUTPUT] Full Intruction Identifier for memory manager

    // Data location INPUT signals from Memory Controller
    int8_t      QKV_valueA[D_MODEL],                // [INPUT] Input actiQKV_vations for OUT_PROJ
    int4_t      QKV_valueB[D_MODEL * D_HEADS],     // [INPUT] Weights for OUT_PROJ
    int32_t     QKV_accum[D_TILE_WO],               // [OUTPUT] Output accumulators for OUT_PROJ
    
    bool        &error               // [OUTPUT] Error flag on invalid request
);
