#include "compute_controller.hpp"
#include <ap_fixed.h>
#include <hls_math.h>
#include <cstdio>


// MAC Architecture
void MAC_ARCHITECTURE(
    bool start,
    bool &ready,
    const int16_t vectorA[VECTOR_MAX],
    const int4_t matrixB[MATRIX_MAX],
    const int32_t bias[ACCUM_MAX],
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
            int32_t acc = bias[out];
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
        How to calculate M and n (offline, from quantization params)

        Notation:
          S_x   = input activation scale (int8)  -> max_abs_x / 127
          S_w   = weight scale (int4)            -> max_abs_w / 7
          S_out = desired output activation scale (int8) from calibration

        Example: weighted matmul output (int32 accum -> int8)
          S_accum = S_x * S_w
          real_scale = S_accum / S_out
          M = round(real_scale * 2^n)
          n = chosen so M fits int32 (typically 0..31)

        Example: RMS/LayerNorm output requant (fixed-point -> int8)
          S_fixed = 2^-F (e.g., Q19.13 => F=13)
          real_scale = S_fixed / S_out
          M = round(real_scale * 2^n)
          n = chosen so M fits int32

        Runtime formula:
          y[t] = saturate_to_int8( (x[t] * M + 2^(n-1)) >> n + z_out )
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

void RMS_NORM(
    const int8_t x[D_MODEL],        // input vector
    const int32_t gamma[D_MODEL],   // scale parameter
    const int32_t epsilon,          // divide-by-zero guard
    int32_t y[D_MODEL]              // output vector
) {
#pragma HLS INLINE off

    int32_t square = 0;

    for (int i = 0; i < D_MODEL; ++i) {
        square += static_cast<int32_t>(x[i]) * static_cast<int32_t>(x[i]);
    }

    ap_fixed<32, 19> square_fx = square; // Q19.13     (123.123 * scale) >> 13, 
    ap_int<32> square_fx_bits = square_fx.range(31, 0);
    std::printf("square_fx: %f 0x%08x (signed=%d)\n",
                (float)square_fx,
                (unsigned)square_fx_bits,
                (int)square_fx_bits);

    ap_fixed<32, 19> mean_square = square_fx / D_MODEL;
    ap_int<32> mean_square_bits = mean_square.range(31, 0);
    std::printf("mean_square: %f 0x%08x (signed=%d)\n",
                (float)mean_square,
                (unsigned)mean_square_bits,
                (int)mean_square_bits);

    if (mean_square < 0) {
        mean_square = 0;
    }

    ap_fixed<32, 19> v = mean_square + ap_fixed<32, 19>(epsilon);
    ap_int<32> v_bits = v.range(31, 0);
    std::printf("v: %f 0x%08x (signed=%d)\n",
                (float)v,
                (unsigned)v_bits,
                (int)v_bits);

    ap_fixed<32, 19> inv_rms = ap_fixed<32, 19>(1) / hls::sqrt(v);
    ap_int<32> inv_rms_bits = inv_rms.range(31, 0);
    std::printf("inv_rms: %f 0x%08x (signed=%d)\n",
                (float)inv_rms,
                (unsigned)inv_rms_bits,
                (int)inv_rms_bits);


    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL          
        ap_fixed<32, 19> normalized = ap_fixed<32, 19>(x[i]) * inv_rms;
        ap_int<32> normalized_bits = normalized.range(31, 0);
        std::printf("ln_cycle[%d] normalized: %f 0x%08x (signed=%d)\n",
                    i,
                    (float)normalized,
                    (unsigned)normalized_bits,
                    (int)normalized_bits);

        ap_fixed<32, 19> scaled = normalized * ap_fixed<32, 19>(gamma[i]);
        ap_int<32> scaled_bits = scaled.range(31, 0);
        std::printf("ln_cycle[%d] scaled: %f 0x%08x (signed=%d)\n",
                    i,
                    (float)scaled,
                    (unsigned)scaled_bits,
                    (int)scaled_bits);
        
        
        y[i] = (int32_t)scaled_bits; // Store raw fixed-point bits (Q19.13)
        std::printf("ln_cycle[%d] y_raw: %d 0x%08x\n",
                    i,
                    y[i],
                    static_cast<unsigned>(y[i]));
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
 

void RES_ADD(
    const int8_t input[D_MODEL],
    const int8_t residual[D_MODEL],
    int8_t output[D_MODEL]
) { 
    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
        const int16_t sum = static_cast<int16_t>(input[i]) + static_cast<int16_t>(residual[i]);
        int16_t sat = sum;
        if (sat > 127) {
            sat = 127;
        } else if (sat < -128) {
            sat = -128;
        }
        output[i] = static_cast<int8_t>(sat);
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

    // For MAC operations!!
    static int16_t vectorA[VECTOR_MAX];
    static int4_t matrixB[MATRIX_MAX];
    static int32_t bias[ACCUM_MAX];
    static int16_t scale[ACCUM_MAX];
    static int32_t out[ACCUM_MAX];
#pragma HLS ARRAY_PARTITION variable=vectorA cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matrixB cyclic factor=MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=scale cyclic factor=MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=out cyclic factor=MAC_OUT_UNROLL dim=1
    bool mac_start = false;
    static bool mac_ready = true;
    static bool mac_complete = false;
    static bool capture_pending = false;

    


    // For Layer Norms!!!
    static int8_t x_act[D_MODEL];
    static int32_t ln_gamma[D_MODEL];
    static int32_t ln_epsilon;
    static int32_t y_act[D_MODEL];
    static int8_t y_resid[D_MODEL];
#pragma HLS ARRAY_PARTITION variable=x_act cyclic factor=MAX_CYCLIC_SIZE dim=1
#pragma HLS ARRAY_PARTITION variable=ln_gamma cyclic factor=MAX_CYCLIC_SIZE dim=1
#pragma HLS ARRAY_PARTITION variable=y_act cyclic factor=MAX_CYCLIC_SIZE dim=1
#pragma HLS ARRAY_PARTITION variable=y_resid cyclic factor=MAX_CYCLIC_SIZE dim=1

    // For Residual Add!!!
    static int8_t residual[D_MODEL];
#pragma HLS ARRAY_PARTITION variable=residual cyclic factor=MAX_CYCLIC_SIZE dim=1

    // For Requant!!!
    static int32_t x32[D_MODEL];
    static int8_t   y8[D_MODEL];
#pragma HLS ARRAY_PARTITION variable=x32 cyclic factor=MAX_CYCLIC_SIZE dim=1
#pragma HLS ARRAY_PARTITION variable=y8 cyclic factor=MAX_CYCLIC_SIZE dim=1

    // For FFN activation (ReLU)!!!
    static int16_t ffn_intermediate[D_FFN];
    static int16_t ffn_act_out[D_FFN];
#pragma HLS ARRAY_PARTITION variable=ffn_intermediate cyclic factor=MAX_CYCLIC_SIZE dim=1
#pragma HLS ARRAY_PARTITION variable=ffn_act_out cyclic factor=MAX_CYCLIC_SIZE dim=1


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
            scale[i] = 0;
            out[i] = 0;
        }
        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
            x_act[i] = 0;
            ln_gamma[i] = 0;
            y_act[i] = 0;
            y_resid[i] = 0;
            residual[i] = 0;
            x32[i] = 0;
            y8[i] = 0;
        }
        ln_epsilon = 0;
        for (int i = 0; i < D_FFN; ++i) {
#pragma HLS UNROLL
            ffn_intermediate[i] = 0;
            ffn_act_out[i] = 0;
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
                    scale[i] = 0;
                    out[i] = 0;
                }
                for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
                    x_act[i] = 0;
                    ln_gamma[i] = 0;
                    y_act[i] = 0;
                    y_resid[i] = 0;
                    residual[i] = 0;
                    x32[i] = 0;
                    y8[i] = 0;
                }
                ln_epsilon = 0;
                for (int i = 0; i < D_FFN; ++i) {
#pragma HLS UNROLL
                    ffn_intermediate[i] = 0;
                    ffn_act_out[i] = 0;
                }
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
                req.op == ComputeOp::CMP_REQUANT2 || 
                req.op == ComputeOp::CMP_FFN_W1 || 
                req.op == ComputeOp::CMP_FFN_ACT || 
                req.op == ComputeOp::CMP_FFN_W2 || 
                req.op == ComputeOp::CMP_REQUANT3 || 
                req.op == ComputeOp::CMP_RESID1 || 
                req.op == ComputeOp::CMP_LN1 || 
                req.op == ComputeOp::CMP_REQUANT4 || 
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
                            compute_buf::read_i8(in_buf, compute_buf::FfnW1Layout::X + i));
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
                        bias[i] = compute_buf::read_i32(in_buf, compute_buf::OutProjLayout::B + (i * 4));
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
                case ComputeOp::CMP_REQUANT2:
                case ComputeOp::CMP_REQUANT3:
                case ComputeOp::CMP_REQUANT4: {
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        x32[i] = compute_buf::read_i32(in_buf, compute_buf::RequantLayout::X + (i * 4));
                    }
                    const int32_t M = compute_buf::read_i32(in_buf, compute_buf::RequantLayout::M);
                    const int32_t n = compute_buf::read_i32(in_buf, compute_buf::RequantLayout::N);
                    const int32_t z_out = compute_buf::read_i32(in_buf, compute_buf::RequantLayout::Z);

                    REQUANT_D_MODEL_int32_to_int8(
                        x32,
                        M,
                        n,
                        z_out,
                        y8
                    );
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i8(out_buf, compute_buf::RequantLayout::X + i, y8[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_RESID0:
                case ComputeOp::CMP_RESID1:{
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        x_act[i] = static_cast<int8_t>(compute_buf::read_i8(in_buf, compute_buf::ResidLayout::X + i));
                        residual[i] = static_cast<int8_t>(compute_buf::read_i8(in_buf, compute_buf::ResidLayout::R + i));
                    }

                    RES_ADD(
                        x_act,
                        residual,
                        y_resid
                    );
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i8(out_buf, compute_buf::ResidLayout::X + i, y_resid[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_LN0:
                case ComputeOp::CMP_LN1: {
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        // Setup X
                        x_act[i] = static_cast<int8_t>(compute_buf::read_i8(in_buf, compute_buf::LayerNormLayout::X + i));
                        // Setup GAMMA
                        ln_gamma[i] = static_cast<int32_t>(compute_buf::read_i32(in_buf, compute_buf::LayerNormLayout::GAMMA + (i * 4)));
                    }
                    // Setup EPSILON
                    ln_epsilon = static_cast<int32_t>(compute_buf::read_i32(in_buf, compute_buf::LayerNormLayout::EPS));

                    RMS_NORM(
                        x_act,
                        ln_gamma,
                        ln_epsilon,
                        y_act
                    );
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i32(out_buf, compute_buf::LayerNormLayout::X + (i * 4), y_act[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_FFN_W1:{
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
                            if (out_idx < D_TILE_W1 && i < D_MODEL) {
                                const int w_idx = (out_idx * D_MODEL) + i;
                                matrixB[(out_idx * VECTOR_MAX) + i] = compute_buf::read_i4(
                                    in_buf,
                                    (compute_buf::FfnW1Layout::W * 2) + w_idx);
                            } else {
                                matrixB[(out_idx * VECTOR_MAX) + i] = 0;
                            }
                        }
                    }
                    for (int i = 0; i < D_TILE_W1; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = compute_buf::read_i32(in_buf, compute_buf::FfnW1Layout::B + (i * 4));
                    }
                    for (int i = D_TILE_W1; i < ACCUM_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = 0;
                    }
                    for (int i = 0; i < D_TILE_W1; ++i) {
#pragma HLS PIPELINE II=1
                        scale[i] = compute_buf::read_i16(in_buf, compute_buf::FfnW1Layout::S + (i * 2));
                    }
                    for (int i = D_TILE_W1; i < ACCUM_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        scale[i] = 0;
                    }
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {

                        // Do Scaling before RELU 
                        for (int t = 0; t < D_TILE_W1; ++t) {
                            const int64_t prod = static_cast<int64_t>(out[t]) * static_cast<int64_t>(scale[t]);
                            const int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
                            int32_t scaled = static_cast<int32_t>(rounded >> 15);
                            if (scaled > 32767) {
                                scaled = 32767;
                            } else if (scaled < -32768) {
                                scaled = -32768;
                            }
                            compute_buf::write_i16(out_buf, t * 2, static_cast<int16_t>(scaled));
                        }
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_FFN_ACT:{
                    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
                        ffn_intermediate[i] = compute_buf::read_i16(in_buf, compute_buf::FfnActLayout::X + (i * 2));
                    }
                    FFN_ACT_RELU(
                        ffn_intermediate,
                        ffn_act_out
                    );
                    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i16(out_buf, compute_buf::FfnActLayout::X + (i * 2), ffn_act_out[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_FFN_W2:{
                    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
                        vectorA[i] = compute_buf::read_i16(
                            in_buf, compute_buf::FfnW2Layout::X + (i * 2));
                    }
                    for (int i = D_FFN; i < VECTOR_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        vectorA[i] = 0;
                    }
                    for (int out_idx = 0; out_idx < ACCUM_MAX; ++out_idx) { 
                        for (int i = 0; i < VECTOR_MAX; ++i) {
// #pragma HLS UNROLL factor=MAC_VEC_UNROLL
                            if (out_idx < D_TILE_W2 && i < D_FFN) {
                                const int w_idx = (out_idx * D_FFN) + i;
                                matrixB[(out_idx * VECTOR_MAX) + i] = compute_buf::read_i4(
                                    in_buf,
                                    (compute_buf::FfnW2Layout::W * 2) + w_idx);
                            } else {
                                matrixB[(out_idx * VECTOR_MAX) + i] = 0;
                            }
                        }
                    }
                    for (int i = 0; i < D_TILE_W2; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = compute_buf::read_i32(in_buf, compute_buf::FfnW2Layout::B + (i * 4));
                    }
                    for (int i = D_TILE_W2; i < ACCUM_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = 0;
                    }
                    for (int i = 0; i < D_TILE_W2; ++i) {
#pragma HLS PIPELINE II=1
                        scale[i] = compute_buf::read_i16(in_buf, compute_buf::FfnW2Layout::S + (i * 2));
                    }
                    for (int i = D_TILE_W2; i < ACCUM_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        scale[i] = 0;
                    }
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {
                        for (int t = 0; t < D_TILE_W2; ++t) {
                            const int64_t prod = static_cast<int64_t>(out[t]) * static_cast<int64_t>(scale[t]);
                            const int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
                            int32_t scaled = static_cast<int32_t>(rounded >> 15);
                            compute_buf::write_i32(out_buf, t * 4, scaled);
                        }
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_DEQUANT:{
                    break;
                }
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
