#pragma once

#include "../../top_params.hpp"
#include <cstdint>

using int4_t = ap_int<4>;

constexpr int max2_constexpr(int a, int b) {
    return (a > b) ? a : b;
}
constexpr int min2_constexpr(int a, int b) {
    return (a < b) ? a : b;
}

constexpr int VECTOR_MAX = max2_constexpr(D_MODEL, D_FFN);
constexpr int ACCUM_MAX = max2_constexpr(D_TILE_WO, max2_constexpr(D_TILE_W1, D_TILE_W2));
constexpr int MATRIX_MAX = VECTOR_MAX * ACCUM_MAX;
constexpr int MAX_CYCLIC_SIZE = 16;

constexpr int MAC_VEC_UNROLL = min2_constexpr(VECTOR_MAX, MAX_CYCLIC_SIZE);
constexpr int MAC_OUT_UNROLL = min2_constexpr(ACCUM_MAX, MAX_CYCLIC_SIZE);

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

    // Debug visibility
    ComputeState &dbg_state,
    uint32_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint8_t     &dbg_req_tile,
    bool        &dbg_mac_start,
    bool        &dbg_mac_ready,
    bool        &dbg_mac_complete,

    bool        &error               // [OUTPUT] Error flag on invalid_request
);
