#include "compute_controller.hpp"
#include <ap_fixed.h>


// MAC Architecture
void MAC_ARCHITECTURE(
    bool start,
    bool &ready,
    const int16_t vectorA[VECTOR_MAX],
    const int4_t matrixB[MATRIX_MAX],
    const int4_t bias[ACCUM_MAX],
    bool &complete,
    int32_t accum_vector[ACCUM_MAX]
) {
#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=vectorA cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matrixB cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=accum_vector cyclic factor=MAC_OUT_UNROLL dim=1

    static bool busy = false;
    static bool compute_done = false;
#pragma HLS reset variable = busy
#pragma HLS reset variable = compute_done

    // Drop ready immediately when a start pulse is present
    ready = (!busy) && (!start);
    complete = compute_done;

    const bool do_compute = (!busy && start);

    if (do_compute) {
        busy = true;
        compute_done = false;
        
        // Perform the actual computation
        for (int out = 0; out < ACCUM_MAX; ++out) {
#pragma HLS UNROLL factor=MAC_OUT_UNROLL
            int32_t acc = static_cast<int32_t>(bias[out]);
            for (int i = 0; i < VECTOR_MAX; ++i) {
#pragma HLS UNROLL factor=MAC_VEC_UNROLL
                const int4_t w = matrixB[out * VECTOR_MAX + i];
                acc += static_cast<int32_t>(vectorA[i]) * static_cast<int32_t>(w);
            }
            accum_vector[out] = acc;
        }
        
        // Signal completion for next cycle
        compute_done = true;
    } else if (compute_done) {
        // Clear flags after complete pulse
        compute_done = false;
        busy = false;
    }
}

// ---------------------------------------------------------------------------
// Compute kernels
// ---------------------------------------------------------------------------

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
    // ap_fixed<32, 16> inv_std = ap_fixed<32, 16>(1) / hls::sqrt(v);
    ap_fixed<32, 16> inv_std = 1;


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

    bool        &error               // [OUTPUT] Error flag on invalid request
) {
#pragma HLS INLINE off

    static ComputeState state = ComputeState::IDLE;
#pragma HLS reset variable = state
    static PendingRequest req;


    // Outputs based on current state (before any transition).
    compute_ready = (state == ComputeState::IDLE);
    compute_done  = (state == ComputeState::DONE);
    
    // mem_op        = 0;
    static int16_t vectorA[VECTOR_MAX];
    static int4_t matrixB[MATRIX_MAX];
    static int4_t bias[ACCUM_MAX];
    static int32_t out[ACCUM_MAX];
#pragma HLS ARRAY_PARTITION variable=vectorA cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matrixB cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=out cyclic factor=MAC_OUT_UNROLL dim=1
    bool mac_start = false;
    static bool mac_ready = true;
    static bool mac_complete = false;
    static bool capture_pending = false;

    
    if (!mac_ready && mac_start && !mac_complete) {
        mac_start = false;
    } 
    

    if (reset) {
        state = ComputeState::IDLE;
        req = PendingRequest{};
        error = false;
        compute_ready = true;
        compute_done  = false;
        mem_read_request   = false;
        mem_write_request = false;
        mem_op        = 0;
        dbg_state = state;
        dbg_req_instruction = req.instruction;
        dbg_req_op = static_cast<uint8_t>(req.op);
        dbg_req_layer = req.layer_idx;
        dbg_req_head = req.head_idx;
        dbg_req_tile = req.tile_idx;

        mac_start = false;
        mac_ready = true;
        mac_complete = false;
        capture_pending = false;

        for (int i = 0; i < VECTOR_MAX; ++i) {
#pragma HLS UNROLL
            vectorA[i] = 0;
        }
        for (int i = 0; i < MATRIX_MAX; ++i) {
#pragma HLS UNROLL
            matrixB[i] = 0;
        }
        for (int i = 0; i < ACCUM_MAX; ++i) {
#pragma HLS UNROLL
            bias[i] = 0;
        }

        return;
    }

    ComputeState next_state = state;

    switch (state) {
        case ComputeState::IDLE: {
            capture_pending = false;
            if (compute_start) {
                mac_start = false;
                mac_complete = false;
                req.instruction     = compute_instruction;
                req.op              = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx       = (compute_instruction >> 8) & 0xFFu;
                req.head_idx        = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx        = (compute_instruction >> 24) & 0xFFu;
                next_state = ComputeState::CAPTURE_INSTRUCTION;
            }
            break;
        }
        case ComputeState::CAPTURE_INSTRUCTION: {
            if (!capture_pending && compute_instruction != req.instruction) {
                capture_pending = true;
                req.instruction     = compute_instruction;
                req.op              = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx       = (compute_instruction >> 8) & 0xFFu;
                req.head_idx        = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx        = (compute_instruction >> 24) & 0xFFu;
                next_state = ComputeState::CAPTURE_INSTRUCTION;
                break;
            }
            capture_pending = false;
            // This state is now merged into IDLE.
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
            break;
        }
        case ComputeState::WAIT_MEM: {
            mem_read_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_read_request = false;
                next_state = ComputeState::EXECUTE;
            }
            break;
        }
        case ComputeState::EXECUTE: {
            switch (req.op) {
                case ComputeOp::CMP_OUT_PROJ: {
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        vectorA[i] = static_cast<int16_t>(
                            compute_buf::read_i8(in_buf, compute_buf::OutProjLayout::ACT + i));
                    }
                    for (int i = D_MODEL; i < VECTOR_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        vectorA[i] = 0;
                    }
                    for (int out_idx = 0; out_idx < ACCUM_MAX; ++out_idx) {
                        for (int i = 0; i < VECTOR_MAX; ++i) {
// #pragma HLS UNROLL factor=MAC_VEC_UNROLL
                            if (out_idx < D_TILE_WO && i < D_MODEL) {
                                const int w_idx = (out_idx * D_MODEL) + i;
                                matrixB[(out_idx * VECTOR_MAX) + i] = compute_buf::read_i4(
                                    in_buf,
                                    (compute_buf::OutProjLayout::W * 2) + w_idx);
                            } else {
                                matrixB[(out_idx * VECTOR_MAX) + i] = 0;
                            }
                        }
                    }
                    for (int i = 0; i < D_TILE_WO; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = compute_buf::read_i4(in_buf, (compute_buf::OutProjLayout::B * 2) + i);
                    }
                    for (int i = D_TILE_WO; i < ACCUM_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = 0;
                    }
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {
                        for (int t = 0; t < D_TILE_WO; ++t) {
                            compute_buf::write_i32(out_buf, t * 4, out[t]);
                        }
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_REQUANT1:
                case ComputeOp::CMP_RESID0:
                case ComputeOp::CMP_LN0:
                case ComputeOp::CMP_REQUANT3:
                case ComputeOp::CMP_FFN_W1:
                case ComputeOp::CMP_FFN_ACT:
                case ComputeOp::CMP_FFN_W2:
                case ComputeOp::CMP_REQUANT4:
                case ComputeOp::CMP_RESID1:
                case ComputeOp::CMP_LN1:
                case ComputeOp::CMP_DEQUANT:
                case ComputeOp::CMP_LOGITS:
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                default:
                    error = true;
                    next_state = ComputeState::DONE;
                    break;
            }
            MAC_ARCHITECTURE(mac_start, mac_ready, vectorA, matrixB, bias, mac_complete, out);
            break;
        }
        case ComputeState::MEM_WRITEBACK: {
            mem_write_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_write_request = false;
                mem_op = 0;
                mac_complete = false;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::DONE: {
            // One-cycle done pulse; fall back to idle.
            req.instruction     = 0;
            req.op              = static_cast<ComputeOp>(0);
            req.layer_idx       = 0;
            req.head_idx        = 0;
            req.tile_idx        = 0;
            next_state = ComputeState::IDLE;
            break;
        }
    }

    state = next_state;

    dbg_state = state;
    dbg_req_instruction = req.instruction;
    dbg_req_op = static_cast<uint8_t>(req.op);
    dbg_req_layer = req.layer_idx;
    dbg_req_head = req.head_idx;
    dbg_req_tile = req.tile_idx;
    dbg_mac_start = mac_start;
    dbg_mac_ready = mac_ready;
    dbg_mac_complete = mac_complete;
}
