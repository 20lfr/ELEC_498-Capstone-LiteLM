#include "headed_compute_controller.hpp"

void MAC_QKV(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_HEADS],
    int32_t accum_out[D_HEADS]
) {
#pragma HLS INLINE off
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
        int32_t acc = 0;
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

void VALUE_SCALE_CLAMP(
    const int32_t input[CONTEXT_LENGTH],
    const int16_t scale_q15,               // Q1.15
    int16_t output[CONTEXT_LENGTH]         // Q1.15
) {
#pragma HLS INLINE off
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
#pragma HLS PIPELINE II=1
        int64_t prod = static_cast<int64_t>(input[i]) * static_cast<int64_t>(scale_q15); // Q2.30
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
        uint16_t e_q15 = exp_approx_q15(diff);   // Q1.15
        exp_buf[i] = e_q15;
        sum_exp += e_q15;                        // up to CONTEXT_LENGTH * 32767
    }

    // 3) Compute reciprocal of sum_exp in fixed-point
    // We want inv_sum in Q1.30 so that:
    //   output = (e_q15 * inv_sum_q30) >> 30  -> Q1.15 again
    uint32_t inv_sum_q30 = 0;
    if (sum_exp > 0) {
        inv_sum_q30 = (static_cast<uint32_t>(1) << 30) / sum_exp;  // integer division only
    }

    // 4) Final probabilities
    for (int i = 0; i < CONTEXT_LENGTH; ++i) {
#pragma HLS PIPELINE II=1
        uint64_t tmp = static_cast<uint64_t>(exp_buf[i]) * static_cast<uint64_t>(inv_sum_q30); // Q1.15 * Q1.30 = Q2.45
        uint16_t prob_q15 = static_cast<uint16_t>(tmp >> 30);                   // -> Q1.15

        if (prob_q15 > MAX_Q15) prob_q15 = MAX_Q15;
        output[i] = static_cast<int16_t>(prob_q15); // still non-negative, just stored in int16_t
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

void REQUANT_D_HEADS_int32_to_int8(
    int32_t x32[D_HEADS],   // input vector
    int32_t M,              // integer multiplier               (Provided by PS)
    int32_t n,              // right shift                      (Provided by PS)
    int32_t z_out,          // output zero-point (int8 range)   (Provided by PS)

    int8_t y8[D_HEADS]      // output vector
) {
    for (int t = 0; t < D_HEADS; ++t) {
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


void headed_compute_controller(
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

    static ComputeState state = ComputeState::IDLE;
#pragma HLS reset variable = state
    static PendingRequest req;

    // Outputs based on current state (before any transition).
    compute_ready = (state == ComputeState::IDLE);
    compute_done  = (state == ComputeState::DONE);
    mem_read_request   = false;
    mem_write_request  = false;

    // Q/K/V projection buffers
    static int8_t qkv_x[D_MODEL];
    static int4_t qkv_w[D_MODEL * D_HEADS];
    static int32_t qkv_out[D_HEADS];
#pragma HLS ARRAY_PARTITION variable=qkv_x cyclic factor=D_HEADS dim=1
#pragma HLS ARRAY_PARTITION variable=qkv_out cyclic factor=D_HEADS dim=1

    // Head requant buffers
    static int32_t head_x32[D_HEADS];
    static int8_t head_y8[D_HEADS];
#pragma HLS ARRAY_PARTITION variable=head_x32 cyclic factor=D_HEADS dim=1
#pragma HLS ARRAY_PARTITION variable=head_y8 cyclic factor=D_HEADS dim=1

    // Attention score buffers
    static int8_t att_q[D_HEADS];
    static int8_t k_cache[CONTEXT_LENGTH * D_HEADS];
    static int32_t att_scores[CONTEXT_LENGTH];
#pragma HLS ARRAY_PARTITION variable=att_q cyclic factor=D_HEADS dim=1

    // Value scale / softmax buffers
    static int32_t val_in[CONTEXT_LENGTH];
    static int16_t val_scaled[CONTEXT_LENGTH];
    static int16_t soft_in[CONTEXT_LENGTH];
    static int16_t soft_out[CONTEXT_LENGTH];

    // Attention value buffers
    static int8_t att_w[CONTEXT_LENGTH];
    static int8_t v_cache[D_HEADS * CONTEXT_LENGTH];
    static int32_t att_out[D_HEADS];
#pragma HLS ARRAY_PARTITION variable=att_out cyclic factor=D_HEADS dim=1

    if (reset) {
        state = ComputeState::IDLE;
        error = false;
        compute_ready = true;
        compute_done  = false;
        mem_read_request   = false;
        mem_write_request = false;
        mem_op        = 0;
        req = PendingRequest{};
        dbg_state = state;
        dbg_req_instruction = req.instruction;
        dbg_req_op = static_cast<uint8_t>(req.op);
        dbg_req_layer = req.layer_idx;
        dbg_req_head = req.head_idx;
        dbg_req_tile = req.tile_idx;
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
                if (req.op == ComputeOp::CMP_Q ||
                    req.op == ComputeOp::CMP_K ||
                    req.op == ComputeOp::CMP_V ||
                    req.op == ComputeOp::CMP_K_REQUANT ||
                    req.op == ComputeOp::CMP_V_REQUANT ||
                    req.op == ComputeOp::CMP_REQUANT_Q ||
                    req.op == ComputeOp::CMP_ATT_SCORES ||
                    req.op == ComputeOp::CMP_VALUE_SCALE ||
                    req.op == ComputeOp::CMP_SOFTMAX ||
                    req.op == ComputeOp::CMP_ATT_VALUE ||
                    req.op == ComputeOp::CMP_HEAD_REQUANT) {
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
            next_state = ComputeState::MEM_WRITEBACK;
            switch (req.op) {
                case ComputeOp::CMP_Q:
                case ComputeOp::CMP_K:
                case ComputeOp::CMP_V: {
                    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
                        qkv_x[i] = compute_buf::read_i8(in_buf, head_buf::QkvLayout::ACT + i);
                    }
                    for (int i = 0; i < D_MODEL * D_HEADS; ++i) {
#pragma HLS PIPELINE II=1
                        qkv_w[i] = compute_buf::read_i4(in_buf, (head_buf::QkvLayout::W * 2) + i);
                    }
                    MAC_QKV(qkv_x, qkv_w, qkv_out);
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i32(out_buf, h * 4, qkv_out[h]);
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
                    const int32_t z_out = compute_buf::read_i32(in_buf, head_buf::HeadRequantLayout::Z);
                    REQUANT_D_HEADS_int32_to_int8(head_x32, M, n, z_out, head_y8);
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i8(out_buf, head_buf::HeadRequantLayout::X + h, head_y8[h]);
                    }
                    break;
                }
                case ComputeOp::CMP_ATT_SCORES: {
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        att_q[h] = compute_buf::read_i8(in_buf, head_buf::AttScoresLayout::Q + h);
                    }
                    for (int i = 0; i < CONTEXT_LENGTH * D_HEADS; ++i) {
#pragma HLS PIPELINE II=1
                        k_cache[i] = compute_buf::read_i8(in_buf, head_buf::AttScoresLayout::K_CACHE + i);
                    }
                    ATT_SCORES(att_q, k_cache, att_scores);
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i32(out_buf, t * 4, att_scores[t]);
                    }
                    break;
                }
                case ComputeOp::CMP_VALUE_SCALE: {
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        val_in[t] = compute_buf::read_i32(in_buf, head_buf::ValueScaleLayout::X + (t * 4));
                    }
                    const int16_t scale_q15 = compute_buf::read_i16(in_buf, head_buf::ValueScaleLayout::SCALE);
                    VALUE_SCALE_CLAMP(val_in, scale_q15, val_scaled);
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
                    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
                        att_w[t] = compute_buf::read_i8(in_buf, head_buf::AttValueLayout::WEIGHTS + t);
                    }
                    for (int i = 0; i < D_HEADS * CONTEXT_LENGTH; ++i) {
#pragma HLS PIPELINE II=1
                        v_cache[i] = compute_buf::read_i8(in_buf, head_buf::AttValueLayout::V_CACHE + i);
                    }
                    ATT_VALUES(att_w, v_cache, att_out);
                    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS PIPELINE II=1
                        compute_buf::write_i32(out_buf, h * 4, att_out[h]);
                    }
                    break;
                }
                default:
                    error = true;
                    next_state = ComputeState::DONE;
                    break;
            }
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
}
