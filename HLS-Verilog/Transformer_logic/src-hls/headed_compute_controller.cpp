#include "headed_compute_controller.hpp"
#include <cstdio>


// LEGACY HEAD ARCHITECTURE BELOWvvvvvvvvvvvvvvvvvvvvvvv
void MAC_QKV(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_HEADS],
    const int32_t bias[D_HEADS],
    int32_t accum_out[D_HEADS]
) {
#pragma HLS INLINE
    /*
    y =         ^ [] *+ []     ...     [] ^        =     [] ^
                ^ []    []     ...     [] ^              [] ^
        D_MODEL ^ ..    ..     ...     .. ^ D_HEADS      .. ^ D_HEADS
                ^ []    []     ...     [] ^              [] ^
                ^ []    []     ...     [] ^              [] ^
                            <-D_MODEL->
    */
    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS UNROLL
        int32_t acc = bias[h];
        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
            const int4_t w = valueB[h * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        accum_out[h] = acc;
    }
}


void ATT_SCORES(
    const int8_t input[D_HEADS],                    // query vector q[d]
    const int8_t K_cache[CONTEXT_LENGTH * D_HEADS], // keys K[t][d], row-major by t
    int32_t output[CONTEXT_LENGTH]                  // logits per position t
) {
    /*
        K_cache layout (row-major by context position):

            t = 0      : K_cache[0 * D_HEADS + d] = K[0][d]
            t = 1      : K_cache[1 * D_HEADS + d] = K[1][d]
            ...
            t = T-1    : K_cache[t * D_HEADS + d] = K[t][d]

        score[t] = sum_{d=0}^{D_HEADS-1} input[d] * K_cache[t * D_HEADS + d]
    */

    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        int32_t acc = 0;
        for (int d = 0; d < D_HEADS; ++d) {
#pragma HLS PIPELINE II=1
            int8_t q = input[d];
            int8_t k = K_cache[t * D_HEADS + d];
            acc += static_cast<int32_t>(q) * static_cast<int32_t>(k);
        }
        output[t] = acc;
    }
}

void ATT_VALUES(
    const int8_t input[CONTEXT_LENGTH],              // attention weights over positions
    const int8_t V_cache[D_HEADS * CONTEXT_LENGTH],  // [D_HEADS][CONTEXT_LENGTH]
    int32_t output[D_HEADS]                          // one scalar per head
) {
    for (int h = 0; h < D_HEADS; ++h) {
        int32_t acc = 0;
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
            int8_t alpha = input[t];
            int8_t v     = V_cache[h * CONTEXT_LENGTH + t]; // row-major: head h, pos t
            acc += static_cast<int32_t>(alpha) * static_cast<int32_t>(v);
        }
        output[h] = acc;
    }
}

// LEGACY HEAD ARCHITECTURE ABOVE^^^^^^^^^^^^

static void print_head_buffers(
    const char *label,
    const int8_t vec[HEAD_VECTOR_MAX],
    const int8_t mat[HEAD_MATRIX_MAX],
    const int4_t bias[HEAD_ACCUM_MAX]
) {
    std::printf("%s head_vec[%d]:", label, HEAD_VECTOR_MAX);
    for (int i = 0; i < HEAD_VECTOR_MAX; ++i) {
        std::printf(" %d", static_cast<int>(vec[i]));
    }
    std::printf("\n%s head_mat[%d][%d]:\n", label, HEAD_ACCUM_MAX, HEAD_VECTOR_MAX);
    for (int r = 0; r < HEAD_ACCUM_MAX; ++r) {
        std::printf("  %02d:", r);
        for (int c = 0; c < HEAD_VECTOR_MAX; ++c) {
            std::printf(" %d", static_cast<int>(mat[r * HEAD_VECTOR_MAX + c]));
        }
        std::printf("\n");
    }
    std::printf("%s head_bias[%d]:", label, HEAD_ACCUM_MAX);
    for (int i = 0; i < HEAD_ACCUM_MAX; ++i) {
        std::printf(" %d", static_cast<int>(bias[i]));
    }
    std::printf("\n");
}





void MAC_HEAD_ARCHITECTURE(
    bool start,
    bool &ready,
    const int8_t vectorA[HEAD_VECTOR_MAX],
    const int8_t matrixB[HEAD_MATRIX_MAX],
    const int4_t bias[HEAD_ACCUM_MAX],
    bool &complete,
    int32_t accum_out[HEAD_ACCUM_MAX]
) {
#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=vectorA cyclic factor=HEAD_MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=matrixB cyclic factor=HEAD_MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=bias cyclic factor=HEAD_MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=accum_out cyclic factor=HEAD_MAC_OUT_UNROLL dim=1

    static bool busy = false;
    static bool compute_done = false;
#pragma HLS reset variable = busy
#pragma HLS reset variable = compute_done

    ready = (!busy) && (!start);
    complete = compute_done;

    const bool do_compute = (!busy && start);

    if (do_compute) {
        busy = true;
        compute_done = false;

        for (int out = 0; out < HEAD_ACCUM_MAX; ++out) {
            int32_t acc = static_cast<int32_t>(bias[out]);
            for (int i = 0; i < HEAD_VECTOR_MAX; ++i) {
                const int8_t w = matrixB[out * HEAD_VECTOR_MAX + i];
                acc += static_cast<int32_t>(vectorA[i]) * static_cast<int32_t>(w);
            }
            accum_out[out] = acc;
        }

        compute_done = true;
    } else if (compute_done) {
        compute_done = false;
        busy = false;
    }
}

void VALUE_SCALE_CLAMP(
    const int32_t input[CONTEXT_LENGTH],
    int16_t output[CONTEXT_LENGTH]         // Q1.15
) {
#pragma HLS INLINE
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
#pragma HLS PIPELINE II=1
        int64_t prod = static_cast<int64_t>(input[i]) * static_cast<int64_t>(ATTN_SCALE_Q15); // Q2.30
        int64_t rounded = prod + ((prod >= 0) ? (1LL << 14) : -(1LL << 14));
        int32_t scaled = static_cast<int32_t>(rounded >> 15); // back to Q1.15
        if (scaled > 32767) {
            scaled = 32767;
        } else if (scaled < -32768) {
            scaled = -32768;
        }
        output[i] = static_cast<int16_t>(scaled);
    }
}

// Approximate exp(x) for x in Q1.15, clamped to [-1.0, 0.0], output in Q1.15.
static uint16_t exp_approx_q15(int16_t x_q15) {
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
    uint16_t idx = static_cast<uint16_t>((static_cast<int32_t>(x_q15) - (-32768)) >> 7);
    return exp_lut_q15[idx];
}

void SOFTMAX(
    const int16_t input[CONTEXT_LENGTH],  // Q1.15 logits
    int16_t output[CONTEXT_LENGTH]        // Q1.15 probabilities (0..32767)
) {
#pragma HLS INLINE off

    const uint16_t ONE_Q15 = (1u << 15);     // 32768, ≈ 1.0
    const uint16_t MAX_Q15 = ONE_Q15 - 1;    // 32767

    // 1) Find max
    int16_t max_val = input[0];
    for (int i = 1; i < CONTEXT_LENGTH; ++i) {
#pragma HLS PIPELINE II=1
        if (input[i] > max_val) {
            max_val = input[i];
        }
    }
    
    // 2) Compute exp_approx and sum
    uint16_t exp_buf[CONTEXT_LENGTH];
#pragma HLS ARRAY_PARTITION variable=exp_buf complete dim=1

    uint32_t sum_exp = 0;
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
#pragma HLS PIPELINE II=1
        int16_t diff = static_cast<int16_t>(input[i] - max_val);
        printf("diff[%d] = %d\n", i, static_cast<int>(diff));
        uint16_t e_q15 = exp_approx_q15(diff);   // Q1.15
        exp_buf[i] = e_q15;
        sum_exp += e_q15;                        // up to CONTEXT_LENGTH * 32767
    }

    // 3) Compute reciprocal of sum_exp in fixed-point (Q1.15)
    //   output = (e_q15 * inv_sum_q15) >> 15  -> Q1.15 again
    uint32_t inv_sum_q15 = 0;
    if (sum_exp > 0) {
        uint64_t num = (1ULL << 30);               // 2^30 = 2^15 (Q1.15) * 2^15 (reciprocal scale)
        inv_sum_q15 = static_cast<uint32_t>((num + (sum_exp / 2)) / sum_exp); // rounded
    }
    

    // 4) Final probabilities
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
#pragma HLS PIPELINE II=1
        uint64_t tmp = static_cast<uint64_t>(exp_buf[i]) * static_cast<uint64_t>(inv_sum_q15); // Q1.15 * Q1.15 = Q2.30
        uint16_t prob_q15 = static_cast<uint16_t>(tmp >> 15);                   // -> Q1.15

        if (prob_q15 > MAX_Q15) prob_q15 = MAX_Q15;
        output[i] = static_cast<int16_t>(prob_q15); // still non-negative, just stored in int16_t
    }
}


void REQUANT_D_HEADS_int32_to_int8(
    int32_t x32[D_HEADS],   // input vector
    int32_t M,              // integer multiplier               (Provided by PS)
    int32_t n,              // right shift                      (Provided by PS)
    int8_t y8[D_HEADS]      // output vector
) {
#pragma HLS INLINE
#pragma HLS ARRAY_PARTITION variable=x32 cyclic factor=D_HEADS dim=1
#pragma HLS ARRAY_PARTITION variable=y8 cyclic factor=D_HEADS dim=1

    for (int t = 0; t < D_HEADS; ++t) {
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
) {
#pragma HLS INLINE off

    // Outputs based on current state (before any transition).
    ctx.compute_ready = (ctx.state == ComputeState::IDLE);
    ctx.compute_done  = (ctx.state == ComputeState::DONE);
    ctx.mem_read_request   = false;
    ctx.mem_write_request  = false;
    ctx.mac_start = false;

    static int8_t head_vec[HEAD_VECTOR_MAX];
    static int8_t head_mat[HEAD_MATRIX_MAX];
    static int4_t head_bias[HEAD_ACCUM_MAX];
    static int32_t head_out[HEAD_ACCUM_MAX];

    int32_t head_x32[D_HEADS];
    int8_t head_y8[D_HEADS];

    int32_t val_in[CONTEXT_LENGTH];
    int16_t val_scaled[CONTEXT_LENGTH];
    int16_t soft_in[CONTEXT_LENGTH];
    int16_t soft_out[CONTEXT_LENGTH];

#pragma HLS ARRAY_PARTITION variable=head_vec cyclic factor=HEAD_MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=head_mat cyclic factor=HEAD_MAC_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=head_bias cyclic factor=HEAD_MAC_OUT_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=head_out cyclic factor=HEAD_MAC_OUT_UNROLL dim=1
    //Head requant buffers
#pragma HLS ARRAY_PARTITION variable=head_x32 cyclic factor=D_HEADS dim=1
#pragma HLS ARRAY_PARTITION variable=head_y8 cyclic factor=D_HEADS dim=1

    if (reset) {
        ctx.state = ComputeState::IDLE;
        error = false;
        ctx.compute_ready = true;
        ctx.compute_done  = false;
        ctx.mem_read_request   = false;
        ctx.mem_write_request = false;
        ctx.mem_op        = 0;
        ctx.req = PendingRequest{};
        dbg_state = ctx.state;
        dbg_req_instruction = ctx.req.instruction;
        dbg_req_op = static_cast<uint8_t>(ctx.req.op);
        dbg_req_layer = ctx.req.layer_idx;
        dbg_req_head = ctx.req.head_idx;
        dbg_req_tile = ctx.req.tile_idx;

        ctx.mac_start = false;
        ctx.mac_ready = true;
        ctx.mac_complete = false;
        ctx.clear_pending = false;
        ctx.capture_pending = false;

        for (int i = 0; i < HEAD_VECTOR_MAX; ++i) {
#pragma HLS UNROLL
            head_vec[i] = 0;
        }
        for (int i = 0; i < HEAD_MATRIX_MAX; ++i) {
#pragma HLS UNROLL
            head_mat[i] = 0;
        }
        for (int i = 0; i < HEAD_ACCUM_MAX; ++i) {
#pragma HLS UNROLL
            head_bias[i] = int4_t(0);
            head_out[i] = 0;
        }
        for (int i = 0; i < D_HEADS; ++i) {
#pragma HLS UNROLL
            head_x32[i] = 0;
            head_y8[i] = 0;
        }
        for (int i = 0; i < CONTEXT_LENGTH; ++i) {
#pragma HLS UNROLL
            val_in[i] = 0;
            val_scaled[i] = 0;
            soft_in[i] = 0;
            soft_out[i] = 0;
        }
        return;
    }

    ComputeState next_state = ctx.state;

    switch (ctx.state) {
        case ComputeState::IDLE: {
            if (ctx.compute_start) {
                ctx.mac_start = false;
                ctx.mac_complete = false;
                ctx.req.instruction    = ctx.compute_instruction;
                ctx.req.op            = static_cast<ComputeOp>(ctx.compute_instruction & 0xFFu);
                ctx.req.layer_idx     = (ctx.compute_instruction >> 8) & 0xFFu;
                ctx.req.head_idx      = (ctx.compute_instruction >> 16) & 0xFFu;
                ctx.req.tile_idx      = (ctx.compute_instruction >> 24) & 0xFFu;
                next_state = ComputeState::CAPTURE_INSTRUCTION;
            }

            // look to clear while idling
            if (ctx.clear_pending && !ctx.compute_start) {
                for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                    out_buf[i] = 0;
                }
                ctx.clear_pending = false;
            }
            break;
        }
        case ComputeState::CAPTURE_INSTRUCTION: {
            if (!ctx.capture_pending && ctx.compute_instruction != ctx.req.instruction) {
                ctx.capture_pending = true;
                ctx.req.instruction    = ctx.compute_instruction;
                ctx.req.op            = static_cast<ComputeOp>(ctx.compute_instruction & 0xFFu);
                ctx.req.layer_idx     = (ctx.compute_instruction >> 8) & 0xFFu;
                ctx.req.head_idx      = (ctx.compute_instruction >> 16) & 0xFFu;
                ctx.req.tile_idx      = (ctx.compute_instruction >> 24) & 0xFFu;
                next_state = ComputeState::CAPTURE_INSTRUCTION;
                break;
            }
            ctx.capture_pending = false;
            if (ctx.req.op == ComputeOp::CMP_Q ||
                ctx.req.op == ComputeOp::CMP_K ||
                ctx.req.op == ComputeOp::CMP_V ||
                ctx.req.op == ComputeOp::CMP_K_REQUANT ||
                ctx.req.op == ComputeOp::CMP_V_REQUANT ||
                ctx.req.op == ComputeOp::CMP_REQUANT_Q ||
                ctx.req.op == ComputeOp::CMP_ATT_SCORES ||
                ctx.req.op == ComputeOp::CMP_VALUE_SCALE ||
                ctx.req.op == ComputeOp::CMP_SOFTMAX ||
                ctx.req.op == ComputeOp::CMP_ATT_VALUE ||
                ctx.req.op == ComputeOp::CMP_HEAD_REQUANT) {
                error = false; // Clear stale errors on a new request.
                next_state = ComputeState::WAIT_MEM;
            } else {
                error = true;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::WAIT_MEM: {
            ctx.mem_read_request = true;
            ctx.mem_op = ctx.req.instruction;
            if (ctx.mem_transfer_done) {
                ctx.mem_read_request = false;
                // ctx.mem_op = 0;
                next_state = ComputeState::EXECUTE;
            }
            break;
        }
        case ComputeState::EXECUTE: {
            next_state = ComputeState::MEM_WRITEBACK;
            switch (ctx.req.op) {
                case ComputeOp::CMP_Q:
                case ComputeOp::CMP_K:
                case ComputeOp::CMP_V: {
                    // INIT the Vector Buffer
                    for (int i = 0; i < HEAD_VECTOR_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        head_vec[i] = 0;
                    }
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        head_vec[i] = compute_buf::read_i8(in_buf, head_buf::QkvLayout::ACT + i);
                    }
                    
                    // INIT the Matrix Buffer
                    for (int i = 0; i < HEAD_MATRIX_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        head_mat[i] = 0;
                    }
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                            const int w_idx = (h * D_MODEL) + i;
                            head_mat[h * HEAD_VECTOR_MAX + i] = static_cast<int8_t>(compute_buf::read_i4(in_buf, (head_buf::QkvLayout::W * 2) + w_idx));
                        }
                    }
                    
                    // INIT the Bias Buffer
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        head_bias[h] = compute_buf::read_i4(in_buf, (head_buf::QkvLayout::B * 2) + h);
                    }
                    for (int h = D_HEADS; h < HEAD_ACCUM_MAX; ++h) {
#pragma HLS PIPELINE II=1
                        head_bias[h] = int4_t(0);
                    }
                    
                    if (ctx.mac_ready && !ctx.mac_start && !ctx.mac_complete) {
                        ctx.mac_start = true;
                        print_head_buffers("MAC_START QKV", head_vec, head_mat, head_bias);
                    }
                    if (ctx.mac_complete) {
                        for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                            compute_buf::write_i32(out_buf, h * 4, head_out[h]);
                        }
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_K_REQUANT:
                case ComputeOp::CMP_V_REQUANT:
                case ComputeOp::CMP_REQUANT_Q:
                case ComputeOp::CMP_HEAD_REQUANT: {
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        head_x32[h] = compute_buf::read_i32(in_buf, head_buf::HeadRequantLayout::X + (h * 4));
                    }
                    const int32_t M = compute_buf::read_i32(in_buf, head_buf::HeadRequantLayout::M);
                    const int32_t n = compute_buf::read_i32(in_buf, head_buf::HeadRequantLayout::N);
                    REQUANT_D_HEADS_int32_to_int8(head_x32, M, n, head_y8);
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i8(out_buf, head_buf::HeadRequantLayout::X + h, head_y8[h]);
                    }
                    break;
                }
                case ComputeOp::CMP_ATT_SCORES: {
                    // INIT the Vector Buffer
                    for (int i = 0; i < HEAD_VECTOR_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        head_vec[i] = 0;
                    }
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        head_vec[h] = compute_buf::read_i8(in_buf, head_buf::AttScoresLayout::Q + h);
                    }

                    // INIT K cache matrix buffer
                    for (int i = 0; i < HEAD_MATRIX_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        head_mat[i] = 0;
                    }
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                            const int k_idx = (t * D_HEADS) + h;
                            head_mat[t * HEAD_VECTOR_MAX + h] =
                                compute_buf::read_i8(in_buf, head_buf::AttScoresLayout::K_CACHE + k_idx);
                        }
                    }
                    
                    // INIT bias to zero
                    for (int h = 0; h < HEAD_ACCUM_MAX; ++h) {
#pragma HLS PIPELINE II=1
                        head_bias[h] = int4_t(0);
                    }
                    
                    if (ctx.mac_ready && !ctx.mac_start && !ctx.mac_complete) {
                        ctx.mac_start = true;
                        print_head_buffers("MAC_START ATT_SCORES", head_vec, head_mat, head_bias);
                    }
                    if (ctx.mac_complete) {
                        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                            compute_buf::write_i32(out_buf, t * 4, head_out[t]);
                        }
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                case ComputeOp::CMP_VALUE_SCALE: {
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        val_in[t] = compute_buf::read_i32(in_buf, head_buf::ValueScaleLayout::X + (t * 4));
                    }
                    VALUE_SCALE_CLAMP(val_in, val_scaled);
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i16(out_buf, t * 2, val_scaled[t]);
                    }
                    break;
                }
                case ComputeOp::CMP_SOFTMAX: {
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        soft_in[t] = compute_buf::read_i16(in_buf, head_buf::SoftmaxLayout::X + (t * 2));
                    }
                    SOFTMAX(soft_in, soft_out);
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i16(out_buf, t * 2, soft_out[t]);
                    }
                    break;
                }
                case ComputeOp::CMP_ATT_VALUE: {
                    // INIT the Vector Buffer
                    for (int i = 0; i < HEAD_VECTOR_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        head_vec[i] = 0;
                    }
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        head_vec[t] = compute_buf::read_i8(in_buf, head_buf::AttValueLayout::WEIGHTS + t);
                    }

                    // INIT V cache matrix buffer
                    for (int i = 0; i < HEAD_MATRIX_MAX; ++i) {
#pragma HLS PIPELINE II=1
                        head_mat[i] = 0;
                    }
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                            const int v_idx = (h * CONTEXT_LENGTH) + t;
                            head_mat[h * HEAD_VECTOR_MAX + t] =
                                compute_buf::read_i8(in_buf, head_buf::AttValueLayout::V_CACHE + v_idx);
                        }
                    }
                    
                    // INIT bias to zero
                    for (int h = 0; h < HEAD_ACCUM_MAX; ++h) {
#pragma HLS PIPELINE II=1
                        head_bias[h] = int4_t(0);
                    }


                    if (ctx.mac_ready && !ctx.mac_start && !ctx.mac_complete) {
                        ctx.mac_start = true;
                        print_head_buffers("MAC_START ATT_VALUE", head_vec, head_mat, head_bias);
                    }
                    if (ctx.mac_complete) {
                        for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                            compute_buf::write_i32(out_buf, h * 4, head_out[h]);
                        }
                        next_state = ComputeState::MEM_WRITEBACK;
                    } else {
                        next_state = ComputeState::EXECUTE;
                    }
                    break;
                }
                
                default:
                    error = true;
                    next_state = ComputeState::DONE;
                    break;
            }
            MAC_HEAD_ARCHITECTURE(ctx.mac_start, ctx.mac_ready, head_vec, head_mat, head_bias, ctx.mac_complete, head_out);
            break;
        }
        case ComputeState::MEM_WRITEBACK: {
            ctx.mem_write_request = true;
            ctx.mem_op = ctx.req.instruction;
            if (ctx.mem_transfer_done) {
                ctx.mem_write_request = false;
                ctx.mem_op = 0;
                ctx.mac_complete = false;
                ctx.clear_pending = true;
                next_state = ComputeState::DONE;
            }
            break;
        }
        case ComputeState::DONE: {
            // One-cycle done pulse; fall back to idle.
            ctx.req.instruction     = 0;
            ctx.req.op              = static_cast<ComputeOp>(0);
            ctx.req.layer_idx       = 0;
            ctx.req.head_idx        = 0;
            ctx.req.tile_idx        = 0;
            next_state = ComputeState::IDLE;
            break;
        }
    }

    ctx.state = next_state;

    dbg_state = ctx.state;
    dbg_req_instruction = ctx.req.instruction;
    dbg_req_op = static_cast<uint8_t>(ctx.req.op);
    dbg_req_layer = ctx.req.layer_idx;
    dbg_req_head = ctx.req.head_idx;
    dbg_req_tile = ctx.req.tile_idx;
}
