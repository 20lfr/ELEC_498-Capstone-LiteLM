#pragma once

#include "../../top_params.hpp"
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

    // Data location INPUT signals from Memory Controller

    // Common requirements
    int8_t      int8_activation[D_MODEL],               // [INPUT] Input activations for functions

    // OUT_PROJ requirements
    int4_t      OUT_PROJ_valueB[D_MODEL * D_TILE_WO],    // [INPUT] Weights for OUT_PROJ
    int32_t     OUT_PROJ_bias[D_TILE_WO],                // [INPUT] Bias for OUT_PROJ
    int32_t     OUT_PROJ_accum[D_TILE_WO],               // [OUTPUT] Output accumulators for OUT_PROJ

    // FFN-PRE_ACT requirements
    int4_t      FFN1_weights1[D_MODEL * D_TILE_W1],      // [INPUT] Weights for FFN PRE-ACT
    int4_t      FFN1_biases[D_TILE_W1],
    int16_t     FFN1_scale[D_TILE_W1],
    int16_t     FFN1_output[D_TILE_W1],

    // FFN-RELU requirements
    int16_t     RELU_input[D_FFN],
    int16_t     RELU_output[D_FFN],

    // FFN-POST_ACT requirements
    int16_t     FFN2_input[D_FFN],                       // [INPUT] Intermediate activations for FFN POST-ACT
    int4_t      FFN2_weights2[D_TILE_W2 * D_FFN],        // [INPUT] Weights for FFN PRE-ACT
    int4_t      FFN2_biases[D_TILE_W2],
    int16_t     FFN2_scale[D_TILE_W2],
    int32_t     FFN2_output[D_MODEL],

    // REQUANT requirements
    int32_t     requant_activation[D_MODEL],
    int32_t     requant_scale,                           // [INPUT] Used for REQUANT input
    int32_t     requant_shift,                           // [INPUT] Used for REQUANT input
    int32_t     requant_zero_point,                      // [INPUT] Used for REQUANT input
    int8_t      requant_output[D_MODEL],                 // [OUTPUT] Used for REQUANT output

    // layer norm requirements
    int32_t     layerNorm_gamma[D_MODEL],                // [INPUT] LayerNorm scale parameter
    int32_t     layerNorm_beta[D_MODEL],                 // [INPUT] LayerNorm shift parameter
    int32_t     layerNorm_epsilon,                       // [INPUT] LayerNorm variance
    int32_t     layerNorm_out[D_MODEL],

    // residual add requirements
    int8_t      residualAdd_residual[D_MODEL],
    int8_t      residualAdd_output[D_MODEL],

    bool        &error               // [OUTPUT] Error flag on invalid request
);
