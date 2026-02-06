#pragma once

#include "../../top_params.hpp"
#include <cstdint>

// Simple MAC for Q/K/V projection: vector (int8) × weights (int4) → int32 accum per head.
void MAC_QKV(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_HEADS],
    const int32_t bias[D_HEADS],
    int32_t accum_out[D_HEADS]
);

void headed_compute_controller(
    ComputeHeadCtx &ctx,            // [BOTH] Per-head persistent state
    bool        reset,               // [INPUT] Reset signal

    // Flat input/output buffers
    const uint8_t in_buf[head_buf::IN_BUF_BYTES],
    uint8_t       out_buf[head_buf::OUT_BUF_BYTES],

    // Debug visibility
    ComputeState &dbg_state,
    uint32_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint8_t     &dbg_req_tile,
    
    bool        &error               // [OUTPUT] Error flag on invalid request
);
