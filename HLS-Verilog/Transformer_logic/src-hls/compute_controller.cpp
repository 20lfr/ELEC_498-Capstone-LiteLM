#include "compute_controller.hpp"
#include <ap_fixed.h>
#include <hls_math.h>

// ---------------------------------------------------------------------------
// Compute kernels
// ---------------------------------------------------------------------------
void OUT_PROJ(
    const int8_t vectorA[D_MODEL],
    const int4_t matrixB[D_MODEL * D_TILE_WO],
    const int4_t bias[D_TILE_WO],
    int32_t out[D_TILE_WO]
) {
#pragma HLS INLINE off
    /*
    y =         ^ [] *+ []     ...     [] ^        =     [] ^
                ^ []    []     ...     [] ^              [] ^
        D_MODEL ^ ..    ..     ...     .. ^ D_MODEL      .. ^ D_MODEL
                ^ []    []     ...     [] ^              [] ^
                ^ []    []     ...     [] ^              [] ^
                            <-D_MODEL->
    */

    for (int t = 0; t < D_TILE_WO; ++t) {
#pragma HLS UNROLL
        int32_t acc = static_cast<int32_t>(bias[t]);
        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
            const int4_t w = matrixB[t * D_MODEL + i];
            acc += static_cast<int32_t>(vectorA[i]) * static_cast<int32_t>(w);
        }
        out[t] = acc;
    }
}

void REQUANT_D_MODEL_int32_to_int8(
    const int32_t x32[D_MODEL],   // input vector
    const int32_t M,              // integer multiplier               (Provided by PS)
    const int32_t n,              // right shift                      (Provided by PS)
    const int32_t z_out,          // output zero-point (int8 range)   (Provided by PS)

    int8_t y8[D_MODEL]      // output vector
) {

    // Original Integer Requant Formula (for each element in vector):
    /*
         y[t] = saturate_to_int8( (x[t] * M) + 2^(n-1)/(2^n) + z_out )
    */
    for (int t = 0; t < D_MODEL; ++t) {
#pragma HLS UNROLL
        int64_t product = static_cast<int64_t>(x32[t]) * static_cast<int64_t>(M);
        int64_t rounded = 1LL << (n - 1);
        int32_t scaled = static_cast<int32_t>((product + rounded) >> n);
        int32_t shifted = scaled + z_out;

        if (shifted > 127) {
            y8[t] = 127;
        } else if (shifted < -128) {
            y8[t] = -128;
        } else {
            y8[t] = static_cast<int8_t>(shifted);
        }
    }   
}

void LAYER_NORM(
    const int8_t x[D_MODEL],        // input vector
    const int32_t gamma[D_MODEL],   // scale parameter
    const int32_t beta[D_MODEL],    // shift parameter
    const int32_t epsilon,          // Divide variance avoid parameter
    int32_t y[D_MODEL]               // output vector
) {
#pragma HLS INLINE off

    // Calculte mean:
    int32_t sum = 0;
    int32_t square = 0;

    for (int i = 0; i < D_MODEL; ++i) {
        sum += static_cast<int32_t>(x[i]);
        square += static_cast<int32_t>(x[i]) * static_cast<int32_t>(x[i]);
    }
    // mean     = sum / D_MODEL;
    // variance = (square / D_MODEL) - (mean * mean);

    ap_fixed<32, 16> sum_fx = sum;
    ap_fixed<32, 16> square_fx = square;
    ap_fixed<32, 16> mean = sum_fx / D_MODEL;
    ap_fixed<32, 16> square_mean = square_fx / D_MODEL;
    ap_fixed<32, 16> variance = square_mean - mean * mean;
    ap_fixed<32, 16> v = (variance * variance) + ap_fixed<32, 16>(epsilon);
    ap_fixed<32, 16> inv_std = ap_fixed<32, 16>(1) / hls::sqrt(v);

    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL          
        ap_fixed<32, 16> normalized = (ap_fixed<32, 16>(x[i]) - mean) * inv_std;
        ap_fixed<32, 16> scaled = (normalized * ap_fixed<32, 16>(gamma[i])) + ap_fixed<32, 16>(beta[i]);
        y[i] = static_cast<int32_t>(scaled);
    }
}

// Assume int4_t is a signed 4-bit type, e.g. typedef ap_int<4> int4_t;
void FFN_PRE_ACT(
    const int8_t  input[D_MODEL],              // activations (int8)
    const int4_t  weights[D_MODEL * D_TILE_W1],    // weights (int4)
    const int4_t  bias[D_TILE_W1],                 // bias per output neuron
    const int16_t scale[D_TILE_W1],                // per-neuron scale in Q0.15
    int16_t       output[D_TILE_W1]                // pre-activation in int16 (e.g. Q1.15-ish)
) {
    const int16_t ACT_MIN = -32768;   // clamp range for pre-activation
    const int16_t ACT_MAX =  32767;
    for (int i = 0; i < D_TILE_W1; ++i) {
#pragma HLS PIPELINE II=1
        int32_t acc = static_cast<int32_t>(bias[i]);
        for (int j = 0; j < D_MODEL; ++j) {
#pragma HLS UNROLL factor=4  // or tune this based on resources
            const int4_t w = weights[i * D_MODEL + j];
            acc += static_cast<int32_t>(input[j]) * static_cast<int32_t>(w);
        }
        int32_t scaled = (acc * static_cast<int32_t>(scale[i])) >> 15;
        if (scaled > ACT_MAX)       scaled = ACT_MAX;
        else if (scaled < ACT_MIN)  scaled = ACT_MIN;
        output[i] = static_cast<int16_t>(scaled);
    }
}

void FFN_ACT_RELU(
    const int16_t input[D_FFN],   // pre-activation in some Q format (e.g., Q1.15-ish)
    int16_t       output[D_FFN]   // same format, just clamped at 0
) {
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
        int16_t v = input[i];
        if (v < 0) {
            output[i] = 0;
        } else {
            output[i] = v;
        }
    }
}
 
void FFN_POST_ACT(
    const int16_t input[D_FFN],               // ReLU'ed activations (int16, fixed-point)
    const int4_t  weights[D_FFN * D_TILE_W2],   // W2, stored as [D_TILE_W2 x D_FFN]
    const int4_t  bias[D_TILE_W2],              // bias for each output dim
    const int16_t scale[D_TILE_W2],             // per-output scale in Q0.15
    int32_t        output[D_TILE_W2]             // back to int8 activations
) {
#pragma HLS INLINE off
    for (int i = 0; i < D_TILE_W2; ++i) {
#pragma HLS PIPELINE II=1
        int32_t acc = static_cast<int32_t>(bias[i]);
        for (int j = 0; j < D_FFN; ++j) {
#pragma HLS UNROLL factor=4   // tune this based on area/timing
            const int4_t w = weights[i * D_FFN + j];  // row-major: row i, col j
            acc += static_cast<int32_t>(input[j]) * static_cast<int32_t>(w);
        } 

        // Apply scaling
        int32_t scaled = (acc * static_cast<int32_t>(scale[i]));
        output[i] = static_cast<int32_t>(scaled); 
    }
}

void RES_ADD(
    const int8_t input[D_MODEL],
    const int8_t residual[D_MODEL],
    int8_t output[D_MODEL]
) { 
    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
        output[i] = input[i] + residual[i];
    }
}


// ---------------------------------------------------------------------------
// Top-level compute controller
// ---------------------------------------------------------------------------
void compute_controller(
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

    // Common requirements
    int8_t      int8_activation[D_MODEL],               // [INPUT] Input activations for functions

    // OUT_PROJ requirements          
    int4_t      OUT_PROJ_valueB[D_MODEL * D_TILE_WO],   // [INPUT] Weights for OUT_PROJ
    int4_t      OUT_PROJ_bias[D_TILE_WO],               // [INPUT] Bias for OUT_PROJ
    int32_t     OUT_PROJ_accum[D_TILE_WO],              // [OUTPUT] Output accumulators for OUT_PROJ

    // FFN-PRE_ACT requirements
    int4_t      FFN1_weights1[D_MODEL * D_TILE_W1],          // [INPUT] Weights for FFN PRE-ACT
    int4_t      FFN1_biases[D_TILE_W1],
    int16_t     FFN1_scale[D_TILE_W1],
    int16_t     FFN1_output[D_TILE_W1],

    // FFN-RELU requirements
    int16_t     RELU_input[D_FFN],
    int16_t     RELU_output[D_FFN],

    // FFN-POST_ACT requirements
    int16_t     FFN2_input[D_FFN],                      // [INPUT] Intermediate activations for FFN POST-ACT
    int4_t      FFN2_weights2[D_TILE_W2 * D_FFN],       // [INPUT] Weights for FFN PRE-ACT
    int4_t      FFN2_biases[D_TILE_W2],
    int16_t     FFN2_scale[D_TILE_W2],
    int32_t     FFN2_output[D_MODEL],
 
    // REQUANT requirements
    int32_t     requant_activation[D_MODEL],
    int32_t     requant_scale,                              // [INPUT] Used for REQUANT input
    int32_t     requant_shift,                              // [INPUT] Used for REQUANT input
    int32_t     requant_zero_point,                         // [INPUT] Used for REQU
    int8_t      requant_output[D_MODEL],               // [OUTPUT] Used for REQUANT output

    // layer norm requirements
    int32_t     layerNorm_gamma[D_MODEL],            // [INPUT] LayerNorm scale parameter
    int32_t     layerNorm_beta[D_MODEL],             // [INPUT] LayerNorm shift parameter
    int32_t     layerNorm_epsilon,                   // [INPUT] LayerNorm variance
    int32_t     layerNorm_out[D_MODEL],

    // residual add requirements
    int8_t      residualAdd_residual[D_MODEL], 
    int8_t      residualAdd_output[D_MODEL],

    bool        &error               // [OUTPUT] Error flag on invalid request
) {
#pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=OUT_PROJ_valueA complete dim=1
// #pragma HLS ARRAY_PARTITION variable=OUT_PROJ_valueB complete dim=1
// #pragma HLS ARRAY_PARTITION variable=OUT_PROJ_accum complete dim=1

    static ComputeState state = ComputeState::IDLE;
    static PendingRequest req;

    // Outputs based on current state (before any transition).
    compute_ready = (state == ComputeState::IDLE);
    compute_done  = (state == ComputeState::DONE);
    mem_read_request   = false;
    mem_write_request  = false;
    // mem_op        = 0;

    if (reset) {
        state = ComputeState::IDLE;
        error = false;
        compute_ready = true;
        compute_done  = false;
        mem_read_request   = false;
        mem_write_request = false;
        mem_op        = 0;
        return;
    }

    ComputeState next_state = state;

    switch (state) {
        case ComputeState::IDLE: {
            if (compute_start) {
                req.instruction    = compute_instruction;
                req.op            = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx     = (compute_instruction >> 8) & 0xFFu;
                req.head_idx      = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx      = (compute_instruction >> 24) & 0xFFu;

                // Check from proper op request
                if (req.op == ComputeOp::CMP_OUT_PROJ || 
                    req.op == ComputeOp::CMP_REQUANT1 || 
                    req.op == ComputeOp::CMP_RESID0 || 
                    req.op == ComputeOp::CMP_LN0 || 
                    req.op == ComputeOp::CMP_REQUANT3 || 
                    req.op == ComputeOp::CMP_FFN_W1 || 
                    req.op == ComputeOp::CMP_FFN_ACT || 
                    req.op == ComputeOp::CMP_FFN_W2 || 
                    req.op == ComputeOp::CMP_REQUANT4 || 
                    req.op == ComputeOp::CMP_RESID1 || 
                    req.op == ComputeOp::CMP_LN1 || 
                    req.op == ComputeOp::CMP_DEQUANT || 
                    req.op == ComputeOp::CMP_LOGITS) {
                    
                    error = false; // Clear stale errors on a new request.
                    next_state = ComputeState::WAIT_MEM;
                } else {
                    error = true;
                    next_state = ComputeState::DONE;
                }
            }
            break;
        }
        case ComputeState::WAIT_MEM: {
            mem_read_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_read_request = false;
                // mem_op = 0;
                next_state = ComputeState::EXECUTE;
            }
            break;
        }
        case ComputeState::EXECUTE: {
            switch (req.op) {
                case ComputeOp::CMP_OUT_PROJ: {
                    OUT_PROJ(int8_activation, OUT_PROJ_valueB, OUT_PROJ_bias, OUT_PROJ_accum);
                    break;
                }
                case ComputeOp::CMP_REQUANT1:{
                    REQUANT_D_MODEL_int32_to_int8(
                        requant_activation,
                        requant_scale, 
                        requant_shift, 
                        requant_zero_point,
                        requant_output      // Reusing input_embedding as output
                    );
                    break;
                }
                case ComputeOp::CMP_RESID0: {
                    RES_ADD(int8_activation, residualAdd_residual, residualAdd_output);
                    break;
                }
                case ComputeOp::CMP_LN0: {
                    LAYER_NORM(int8_activation, layerNorm_gamma, layerNorm_beta, layerNorm_epsilon, layerNorm_out);
                    break;
                }
                case ComputeOp::CMP_REQUANT2:{
                    REQUANT_D_MODEL_int32_to_int8(
                        requant_activation,
                        requant_scale, 
                        requant_shift, 
                        requant_zero_point,
                        requant_output      // Reusing input_embedding as output
                    );
                    break;
                }    
                case ComputeOp::CMP_FFN_W1: {
                    FFN_PRE_ACT(int8_activation, FFN1_weights1, FFN1_biases, FFN1_scale, FFN1_output);
                    break;
                }
                case ComputeOp::CMP_FFN_ACT: {
                    FFN_ACT_RELU(RELU_input, RELU_output);
                    break;
                }
                case ComputeOp::CMP_FFN_W2: {
                    FFN_POST_ACT(FFN2_input, FFN2_weights2, FFN2_biases, FFN2_scale, FFN2_output);
                    break;
                }
                case ComputeOp::CMP_REQUANT3: {
                    REQUANT_D_MODEL_int32_to_int8(
                        requant_activation,
                        requant_scale, 
                        requant_shift, 
                        requant_zero_point,
                        requant_output      // Reusing input_embedding as output
                    );
                    break;
                }
                case ComputeOp::CMP_RESID1: {
                    RES_ADD(int8_activation, residualAdd_residual, residualAdd_output);
                    break;
                }
                case ComputeOp::CMP_LN1: {
                    LAYER_NORM(int8_activation, layerNorm_gamma, layerNorm_beta, layerNorm_epsilon, layerNorm_out);
                    break;
                }
                case ComputeOp::CMP_REQUANT4: {
                    REQUANT_D_MODEL_int32_to_int8(
                        requant_activation,
                        requant_scale, 
                        requant_shift, 
                        requant_zero_point,
                        requant_output      // Reusing input_embedding as output
                    );
                    break;
                }
                case ComputeOp::CMP_DEQUANT: {}
                case ComputeOp::CMP_LOGITS: {}
                default:
                    error = true;
                    break;
            }
            next_state = ComputeState::MEM_WRITEBACK;
            break;
        }
        case ComputeState::MEM_WRITEBACK: {
            mem_write_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_write_request = false;
                mem_op = 0;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::DONE: {
            // One-cycle done pulse; fall back to idle.
            next_state = ComputeState::IDLE;
            break;
        }
    }

    state = next_state;
}
