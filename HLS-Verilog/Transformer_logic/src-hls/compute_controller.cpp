#include "compute_controller.hpp"

// ---------------------------------------------------------------------------
// Compute kernels
// ---------------------------------------------------------------------------
void OUT_PROJ(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_TILE_WO],
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
        int32_t acc = 0;
        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
            const int4_t w = valueB[t * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        out[t] = acc;
    }
}

void REQUANT_int32_to_int8(
    int32_t x32[D_MODEL],   // input vector
    int32_t M,              // integer multiplier               (Provided by PS)
    int32_t n,              // right shift                      (Provided by PS)
    int32_t z_out,          // output zero-point (int8 range)   (Provided by PS)

    int8_t y8[D_MODEL]      // output vector
) {

    // Original Integer Requant Formula (for each element in vector):
    /*
         y[t] = saturate_to_int8( (x[t] * M) + 2^(n-1)/(2^n) + z_out )
    */
    for (int t = 0; t < D_TILE_WO; ++t) {
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
    int8_t y[D_MODEL]               // output vector
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

    int32_t mean = sum / D_MODEL;
    int32_t variance = (square / D_MODEL) - (sum * sum) / (D_MODEL * D_MODEL);
    int32_t v = (variance * variance) + epsilon;
    int32_t inv_std = 1 / sqrt(v);

    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL          
        int32_t normalized = (static_cast<int32_t>(x[i]) - mean) * inv_std;
        int32_t scaled = (normalized * gamma[i]) + beta[i];

        // Saturate to int8 range
        if (scaled > 127) {
            y[i] = 127;
        } else if (scaled < -128) {
            y[i] = -128;
        } else {
            y[i] = static_cast<int8_t>(scaled);
        }
    }
}

void FFN_PRE_ACT(
    const int8_t input[D_MODEL],
    const int4_t weights[D_MODEL * D_FFN],
    int8_t output[D_FFN]
) {

    /*
    y =         ^ [] *+ []     ...     [] ^        =   [] ^
                ^ []    []     ...     [] ^            [] ^
        D_MODEL ^ ..    ..     ...     .. ^ D_FFN      .. ^ D_FFN
                ^ []    []     ...     [] ^            [] ^
                ^ []    []     ...     [] ^            [] ^
                            <-D_MODEL->
    */
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS UNROLL
        int32_t acc = 0;
        for (int j = 0; j < D_MODEL; ++j) {
#pragma HLS UNROLL
            const int4_t w = weights[i * D_MODEL + j];
            acc += static_cast<int32_t>(input[j]) * static_cast<int32_t>(w); 
        }
        output[i] = acc;
    }
}

void FFN_ACT_RELU(
    const int8_t input[D_FFN],
    int8_t output[D_FFN]
) { 
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS UNROLL
        if (input[i] < 0) {
            output[i] = 0;
        } else {
            output[i] = input[i];
        }
    }
}   

void FFN_POST_ACT(
    const int8_t input[D_FFN],
    const int4_t weights[D_FFN * D_MODEL],
    int8_t output[D_FFN]
) {
#pragma HLS INLINE off
    /*
    y =     ^ [] *+ []     ...     [] ^         =   [] ^
            ^ []    []     ...     [] ^             [] ^
      D_FNN ^ ..    ..     ...     .. ^ D_MODEL     .. ^ D_MODEL
            ^ []    []     ...     [] ^             [] ^
            ^ []    []     ...     [] ^             [] ^
                        <-D_FFN->
    */
    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
        int32_t acc = 0;
        for (int j = 0; j < D_FFN; ++j) {
#pragma HLS UNROLL
            const int4_t w = weights[i * D_FFN + j];
            acc += static_cast<int32_t>(input[j]) * static_cast<int32_t>(w); 
        }
        output[i] = acc;
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
    int8_t      OUT_PROJ_valueA[D_MODEL],                // [INPUT] Input activations for OUT_PROJ
    int4_t      OUT_PROJ_valueB[D_MODEL * D_TILE_WO],     // [INPUT] Weights for OUT_PROJ
    int32_t     OUT_PROJ_accum[D_TILE_WO],               // [OUTPUT] Output accumulators for OUT_PROJ


    bool        &error               // [OUTPUT] Error flag on invalid request


    
) {
    // TODO: Inputs for remaining non-head compute ops:
    // CMP_OUT_PROJ (14)
    // CMP_REQUANT1 (15)
    // CMP_RESID0 (16)
    // CMP_LN0 (17)
    // CMP_REQUANT3 (18)
    // CMP_FFN_W1 (19)
    // CMP_FFN_ACT (20)
    // CMP_FFN_W2 (21)
    // CMP_REQUANT4 (22)
    // CMP_RESID1 (23)
    // CMP_LN1 (24)
    // CMP_DEQUANT (25)
    // CMP_LOGITS (26)
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
        case ComputeState::IDLE:
            if (compute_start) {
                req.instruction    = compute_instruction;
                req.op            = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx     = (compute_instruction >> 8) & 0xFFu;
                req.head_idx      = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx      = (compute_instruction >> 24) & 0xFFu;
                if (req.op == ComputeOp::CMP_OUT_PROJ) {
                    error = false; // Clear stale errors on a new request.
                    next_state = ComputeState::WAIT_MEM;
                } else {
                    error = true;
                    next_state = ComputeState::DONE;
                }
            }
            break;

        case ComputeState::WAIT_MEM:
            mem_read_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_read_request = false;
                // mem_op = 0;
                next_state = ComputeState::EXECUTE;
            }
            break;

        case ComputeState::EXECUTE:
            if (req.op == ComputeOp::CMP_OUT_PROJ) {
                OUT_PROJ(OUT_PROJ_valueA, OUT_PROJ_valueB, OUT_PROJ_accum);
            } else {
                error = true;
            }
            next_state = ComputeState::MEM_WRITEBACK;
            break;
        case ComputeState::MEM_WRITEBACK:
            mem_write_request = true;
            mem_op = req.instruction;
            if (mem_transfer_done) {
                mem_write_request = false;
                mem_op = 0;
                next_state = ComputeState::DONE;
            }
            break;

        case ComputeState::DONE:
            // One-cycle done pulse; fall back to idle.
            next_state = ComputeState::IDLE;
            break;
    }

    state = next_state;
}
