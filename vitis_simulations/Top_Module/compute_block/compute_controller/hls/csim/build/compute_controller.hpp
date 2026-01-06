#pragma once

#include "../top_params.hpp"
#include <cstdint>

using uint4_t = ap_uint<4>;

// Simple MAC for Q/K/V projection: vector (int8) × weights (int4) → int32 accum per head.
void MAC_QKV(
    const uint8_t valueA[D_MODEL],
    const uint4_t valueB[D_MODEL * D_HEADS],
    volatile int32_t accum_out[D_HEADS]
);

// Top-level compute controller stub.
// - Latches a request from the scheduler (compute_start/compute_op + memory addrs/sizes)
// - Fetches the operands from BRAM/URAM (simulated here by reading valueA/valueB pointers)
// - Dispatches the operands to the appropriate compute kernel (only MAC_QKV supported for now)
void compute_controller(
    bool        reset,               // [INPUT] Reset signal

    // FSM communication signals
    bool        compute_start,       // [INPUT] Start signal for compute
    ComputeOp   compute_op,          // [INPUT] Compute operation to perform
    bool        &compute_ready,      // [OUTPUT] Compute engine ready for new operation
    bool        &compute_done,       // [OUTPUT] Compute operation finished

    // Data location INPUT signals
    uint32_t    internal_addr_valueA,// [INPUT] The location in memory to read from for compute input A
    uint32_t    internal_addr_valueB,// [INPUT] The location in memory to read from for compute input B
    bool        BRAM_en_A,           // [INPUT] Read enable for BRAM A (value A is located in BRAM)
    bool        BRAM_en_B,           // [INPUT] Read enable for BRAM B (value B is located in BRAM)
    bool        URAM_en_A,           // [INPUT] Read enable for URAM A (value A is located in URAM)
    bool        URAM_en_B,           // [INPUT] Read enable for URAM B (value B is located in URAM)
    int32_t     sizeA,               // [INPUT] Number of elements to fetch for operand A
    uint32_t    sizeB,               // [INPUT] Number of elements to fetch for operand B

    uint8_t     valueA[D_MODEL],     // [INPUT] Backing storage for operand A (BRAM/URAM simulated)
    uint4_t     valueB[D_MODEL * D_HEADS], // [INPUT] Backing storage for operand B (BRAM/URAM simulated)

    bool        &error               // [OUTPUT] Error flag on invalid request
);
