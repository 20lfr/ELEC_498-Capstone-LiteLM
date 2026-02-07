#pragma once

#include "../../top_params.hpp"
#include <cstdint>

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

void drive_headed_compute_controller(
    ComputeHeadCtx (&ctx)[HEADS_PARALLEL],
    bool        reset,
    const uint8_t in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES],
    uint8_t       out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES],
    int8_t        dbg_head_vec[HEADS_PARALLEL][HEAD_VECTOR_MAX],
    int32_t       dbg_head_out[HEADS_PARALLEL][HEAD_ACCUM_MAX],
    bool        &error
);
