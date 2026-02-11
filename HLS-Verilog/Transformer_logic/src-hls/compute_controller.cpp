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
          y[t] = saturate_to_int8( (x[t] * M + 2^(n-1)) >> n )
    */
    for (int t = 0; t < D_MODEL; ++t) {
#pragma HLS UNROLL
        int64_t product = static_cast<int64_t>(x32[t]) * static_cast<int64_t>(M);
        int64_t rounded = 1LL << (n - 1);
        int32_t scaled = static_cast<int32_t>((product + rounded) >> n);

        if (scaled > 127) {
            y8[t] = 127;
        } else if (scaled < -128) {
            y8[t] = -128;
        } else {
            y8[t] = static_cast<int8_t>(scaled);
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
    ap_fixed<32, 19> mean_square = square_fx / D_MODEL;
    if (mean_square < 0) {
        mean_square = 0;
    }
    ap_fixed<32, 19> v = mean_square + ap_fixed<32, 19>(epsilon);
    ap_fixed<32, 19> inv_rms = ap_fixed<32, 19>(1) / hls::sqrt(v); //  NEED TO FIX THIS!!!
    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL          
        ap_fixed<32, 19> normalized = ap_fixed<32, 19>(x[i]) * inv_rms;
        // ap_int<32> normalized_bits = normalized.range(31, 0);
        // std::printf("ln_cycle[%d] normalized: %f 0x%08x (signed=%d)\n",
        //             i,
        //             (float)normalized,
        //             (unsigned)normalized_bits,
        //             (int)normalized_bits);

        ap_fixed<32, 19> scaled = normalized * ap_fixed<32, 19>(gamma[i]);
        ap_int<32> scaled_bits = scaled.range(31, 0); 
        // std::printf("ln_cycle[%d] scaled: %f 0x%08x (signed=%d)\n",
        //             i,
        //             (float)scaled,
        //             (unsigned)scaled_bits,
        //             (int)scaled_bits);
        y[i] = (int32_t)scaled_bits; // Store raw fixed-point bits (Q19.13)
        // std::printf("ln_cycle[%d] y_raw: %d 0x%08x\n",
        //             i,
        //             y[i],
        //             static_cast<unsigned>(y[i]));
    }
}


// Approximate exp(x) for x in Q1.15, clamped to [-1.0, 0.0], output in Q1.15.
static inline uint16_t exp_approx_q15(int16_t x_q15) {
#pragma HLS INLINE
    static const uint16_t exp_lut_q15[257] = {
        12055, 12102, 12149, 12197, 12245, 12292, 12341, 12389,
        12437, 12486, 12535, 12584, 12633, 12683, 12732, 12782,
        12832, 12882, 12933, 12983, 13034, 13085, 13136, 13188,
        13239, 13291, 13343, 13396, 13448, 13501, 13553, 13606,
        13660, 13713, 13767, 13821, 13875, 13929, 13984, 14038,
        14093, 14149, 14204, 14259, 14315, 14371, 14428, 14484,
        14541, 14598, 14655, 14712, 14770, 14828, 14886, 14944,
        15002, 15061, 15120, 15179, 15239, 15298, 15358, 15418,
        15479, 15539, 15600, 15661, 15722, 15784, 15846, 15908,
        15970, 16032, 16095, 16158, 16221, 16285, 16349, 16413,
        16477, 16541, 16606, 16671, 16736, 16802, 16868, 16934,
        17000, 17066, 17133, 17200, 17268, 17335, 17403, 17471,
        17539, 17608, 17677, 17746, 17816, 17885, 17955, 18026,
        18096, 18167, 18238, 18310, 18381, 18453, 18525, 18598,
        18671, 18744, 18817, 18891, 18965, 19039, 19113, 19188,
        19263, 19339, 19414, 19490, 19567, 19643, 19720, 19797,
        19875, 19953, 20031, 20109, 20188, 20267, 20346, 20426,
        20506, 20586, 20667, 20747, 20829, 20910, 20992, 21074,
        21157, 21239, 21323, 21406, 21490, 21574, 21658, 21743,
        21828, 21914, 21999, 22085, 22172, 22259, 22346, 22433,
        22521, 22609, 22698, 22787, 22876, 22965, 23055, 23145,
        23236, 23327, 23418, 23510, 23602, 23694, 23787, 23880,
        23974, 24067, 24162, 24256, 24351, 24446, 24542, 24638,
        24735, 24831, 24929, 25026, 25124, 25222, 25321, 25420,
        25520, 25620, 25720, 25821, 25922, 26023, 26125, 26227,
        26330, 26433, 26536, 26640, 26744, 26849, 26954, 27060,
        27166, 27272, 27379, 27486, 27593, 27701, 27810, 27919,
        28028, 28138, 28248, 28358, 28469, 28581, 28693, 28805,
        28918, 29031, 29144, 29259, 29373, 29488, 29603, 29719,
        29836, 29952, 30070, 30187, 30305, 30424, 30543, 30663,
        30783, 30903, 31024, 31146, 31267, 31390, 31513, 31636,
        31760, 31884, 32009, 32134, 32260, 32386, 32513, 32640,
        32767
    };
    if (x_q15 >= 0) {
        return 32767;
    }
    if (x_q15 <= -32768) {
        return exp_lut_q15[0];
    }
    const uint16_t idx = static_cast<uint16_t>((static_cast<int32_t>(x_q15) - (-32768)) >> 7);
    return exp_lut_q15[idx];
}

static inline int16_t sigmoid_q15(int16_t x_q15) {
#pragma HLS INLINE
    if (x_q15 >= 0) {
        const int16_t neg = static_cast<int16_t>(-static_cast<int32_t>(x_q15));
        const uint16_t e = exp_approx_q15(neg);
        const uint32_t denom = static_cast<uint32_t>(e) + (1u << 15);
        const uint32_t num = (1u << 30);
        const uint32_t sig = (num + (denom / 2)) / denom;
        return static_cast<int16_t>(sig > 32767 ? 32767 : sig);
    }
    const uint16_t e = exp_approx_q15(x_q15);
    const uint32_t denom = static_cast<uint32_t>(e) + (1u << 15);
    const uint32_t num = static_cast<uint32_t>(e) << 15;
    const uint32_t sig = (num + (denom / 2)) / denom;
    return static_cast<int16_t>(sig > 32767 ? 32767 : sig);
}

void FFN_ACT_Silu(
    const int16_t input_up[D_FFN],
    const int16_t input_gate[D_FFN],
    int16_t       output[D_FFN]
) {
    int16_t sig_raw[D_FFN];
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
        const int16_t sig = sigmoid_q15(input_gate[i]);
        const int32_t prod = static_cast<int32_t>(input_up[i]) * static_cast<int32_t>(sig);
        int32_t scaled = prod >> 15;
        if (scaled > 32767) {
            scaled = 32767;
        } else if (scaled < -32768) {
            scaled = -32768;
        }
        sig_raw[i] = sig;
        const int16_t out = scaled;
        output[i] = out;
    }

    std::printf("FFN_ACT gate:");
    for (int i = 0; i < D_FFN; ++i) {
        std::printf(" %d", static_cast<int>(input_gate[i]));
    }
    std::printf("\nFFN_ACT sigmoid:");
    for (int i = 0; i < D_FFN; ++i) {
        std::printf(" %d", static_cast<int>(sig_raw[i]));
    }
    std::printf("\nFFN_ACT up:");
    for (int i = 0; i < D_FFN; ++i) {
        std::printf(" %d", static_cast<int>(input_up[i]));
    }
    std::printf("\nFFN_ACT out:");
    for (int i = 0; i < D_FFN; ++i) {
        std::printf(" %d", static_cast<int>(output[i]));
    }
    std::printf("\n");
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
    ControlMemSpace ctrl_mem,          // [INPUT] Control memory snapshot

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

    const bool reset_n = (ctrl_mem.control & CTRL_RESETN_BIT) != 0;

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
    static bool clear_pending = false;

    


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

    // For FFN activation (SwiGLU)!!!
    static int16_t ffn_gate[D_FFN];
    static int16_t ffn_up[D_FFN];
    static int16_t ffn_act_out[D_FFN];
#pragma HLS ARRAY_PARTITION variable=ffn_gate cyclic factor=MAX_CYCLIC_SIZE dim=1
#pragma HLS ARRAY_PARTITION variable=ffn_up cyclic factor=MAX_CYCLIC_SIZE dim=1
#pragma HLS ARRAY_PARTITION variable=ffn_act_out cyclic factor=MAX_CYCLIC_SIZE dim=1


    if (!mac_ready && mac_start && !mac_complete) {
        mac_start = false;
    } 
    

    if (!reset_n) {
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
        clear_pending = false;

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
            ffn_gate[i] = 0;
            ffn_up[i] = 0;
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
                    ffn_gate[i] = 0;
                    ffn_up[i] = 0;
                    ffn_act_out[i] = 0;
                }
                req.instruction     = compute_instruction;
                req.op              = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx       = (compute_instruction >> 8) & 0xFFu;
                req.head_idx        = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx        = (compute_instruction >> 24) & 0xFFu;
                next_state = ComputeState::CAPTURE_INSTRUCTION;
            }
            // Clear output buffer when idling
            if (clear_pending && !compute_start) {
                for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                    out_buf[i] = 0;
                }
                clear_pending = false;
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
                req.op == ComputeOp::CMP_FINAL_NORM || 
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
                case ComputeOp::CMP_OUT_PROJ:       // Q0.7   -> Qacc   [After Headed Attention]
                {
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        vectorA[i] = static_cast<int16_t>(
                            compute_buf::read_i8(in_buf, compute_buf::INFfnW1Layout::X + i));
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
                                    (compute_buf::INOutProjLayout::W * 2) + w_idx);
                            } else {
                                matrixB[(out_idx * VECTOR_MAX) + i] = 0;
                            }
                        }
                    }
                    for (int i = 0; i < D_TILE_WO; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = compute_buf::read_i32(in_buf, compute_buf::INOutProjLayout::B + (i * 4));
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
                case ComputeOp::CMP_REQUANT1:       // Q19.13 -> Q0.7    [After RMSNorm0]
                case ComputeOp::CMP_REQUANT2:       // Qacc   -> Q0.7    [After OutputProj]
                case ComputeOp::CMP_REQUANT3:       // Q19.13 -> Q0.7    [After RMSNorm1]
                case ComputeOp::CMP_REQUANT4: {     // Qacc   -> Q0.7    [After FFN final stage] 
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        x32[i] = compute_buf::read_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4));
                    }
                    int32_t M = 1;
                    int32_t n = 0;

                    // M and N mux
                    switch (req.op) {
                        case ComputeOp::CMP_REQUANT1:
                            M = requant_params::REQUANT1_M;
                            n = requant_params::REQUANT1_N;
                            break;
                        case ComputeOp::CMP_REQUANT2:
                            M = requant_params::REQUANT2_M;
                            n = requant_params::REQUANT2_N;
                            break;
                        case ComputeOp::CMP_REQUANT3:
                            M = requant_params::REQUANT3_M;
                            n = requant_params::REQUANT3_N;
                            break;
                        case ComputeOp::CMP_REQUANT4:
                            M = requant_params::REQUANT4_M;
                            n = requant_params::REQUANT4_N;
                            break;
                        default:
                            break;
                    }
                    REQUANT_D_MODEL_int32_to_int8(
                        x32,
                        M,
                        n,
                        y8
                    );
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i8(out_buf, compute_buf::INRequantLayout::X + i, y8[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_RESID0:         // Q0.7   -> Q0.7    [After OutputProj] 
                case ComputeOp::CMP_RESID1:{        // Q0.7   -> Q0.7    [After FFN] 
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        x_act[i] = static_cast<int8_t>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::X + i));
                        residual[i] = static_cast<int8_t>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::R + i));
                    }

                    RES_ADD(
                        x_act,
                        residual,
                        y_resid
                    );
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i8(out_buf, compute_buf::INResidLayout::X + i, y_resid[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_LN0:            // Q0.7    -> Q19.13
                case ComputeOp::CMP_LN1:            // Q0.7    -> Q19.13
                case ComputeOp::CMP_FINAL_NORM: {   // Q0.7    -> Q19.13
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        // Setup X
                        x_act[i] = static_cast<int8_t>(compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i));
                        // Setup GAMMA
                        ln_gamma[i] = static_cast<int32_t>(compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4)));
                    }
                    // Setup EPSILON
                    ln_epsilon = static_cast<int32_t>(compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::EPS));

                    RMS_NORM(
                        x_act,
                        ln_gamma,
                        ln_epsilon,
                        y_act
                    );
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i32(out_buf, compute_buf::INLayerNormLayout::X + (i * 4), y_act[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_FFN_W1:{        // Q0.7    -> Qacc     -> Q1.15    [First FFN stage]
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        vectorA[i] = static_cast<int16_t>(
                            compute_buf::read_i8(in_buf, compute_buf::INOutProjLayout::ACT + i));
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
                                    (compute_buf::INFfnW1Layout::W * 2) + w_idx);
                            } else {
                                matrixB[(out_idx * VECTOR_MAX) + i] = 0;
                            }
                        }
                    }
                    for (int i = 0; i < D_TILE_W1; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = compute_buf::read_i32(in_buf, compute_buf::INFfnW1Layout::B + (i * 4));
                    }
                    for (int i = D_TILE_W1; i < ACCUM_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = 0;
                    }
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {

                        // Do Scaling before Activation 
                        for (int t = 0; t < D_TILE_W1; ++t) {
                            const int64_t prod =
                                static_cast<int64_t>(out[t]) *
                                static_cast<int64_t>(requant_scales::FFN_W1_SCALE_Q15);
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
                case ComputeOp::CMP_FFN_ACT:{       // Q1.15   -> Q1.15     [FFN SwiGLU activation]
                    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
                        ffn_gate[i] = compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2));
                        ffn_up[i] = compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::UP + (i * 2));
                    }
                    FFN_ACT_Silu(ffn_up, ffn_gate, ffn_act_out);
                    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i16(out_buf, compute_buf::INFfnActLayout::OUT + (i * 2), ffn_act_out[i]);
                    }
                    next_state = ComputeState::MEM_WRITEBACK;
                    break;
                }
                case ComputeOp::CMP_FFN_W2:{        // Q1.15   -> Qacc      [Second FFN stage]
                    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
                        vectorA[i] = compute_buf::read_i16(
                            in_buf, compute_buf::INFfnW2Layout::X + (i * 2));
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
                                    (compute_buf::INFfnW2Layout::W * 2) + w_idx);
                            } else {
                                matrixB[(out_idx * VECTOR_MAX) + i] = 0;
                            }
                        }
                    }
                    for (int i = 0; i < D_TILE_W2; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = compute_buf::read_i32(in_buf, compute_buf::INFfnW2Layout::B + (i * 4));
                    }
                    for (int i = D_TILE_W2; i < ACCUM_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        bias[i] = 0;
                    }
                    // MAC pulse control
                    if(mac_ready && !mac_start && !mac_complete) {
                        mac_start = true;
                    }
                    if (mac_complete) {
                        for (int t = 0; t < D_TILE_W2; ++t) {
                            const int64_t prod =
                                static_cast<int64_t>(out[t]) *
                                static_cast<int64_t>(requant_scales::FFN_W2_SCALE_Q15);
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
                clear_pending = true;
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
