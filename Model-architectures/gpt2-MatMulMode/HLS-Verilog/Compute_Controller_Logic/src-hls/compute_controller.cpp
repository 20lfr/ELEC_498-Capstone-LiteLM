#include "compute_controller.hpp"
#include <cstdint>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

// ---------------------------------------------------------------------------
// Instruction decode helpers
// bits [7:0]   = op
// bits [15:8]  = layer
// bits [23:16] = head
// bits [55:24] = tile
// ---------------------------------------------------------------------------
static inline void unpack_instruction(uint64_t instr,
    ComputeOp &op, uint8_t &layer, uint8_t &head, uint16_t &tile) {
#pragma HLS INLINE
    op    = static_cast<ComputeOp>(static_cast<uint8_t>(instr & 0xFFu));
    layer = static_cast<uint8_t>((instr >>  8) & 0xFFu);
    head  = static_cast<uint8_t>((instr >> 16) & 0xFFu);
    tile  = static_cast<uint16_t>((instr >> 24) & 0xFFFFu);
}

static inline uint64_t pack_mem_op(ComputeOp op, uint8_t layer, uint8_t head, uint16_t tile) {
#pragma HLS INLINE
    return static_cast<uint64_t>(op)
         | (static_cast<uint64_t>(layer) <<  8)
         | (static_cast<uint64_t>(head)  << 16)
         | (static_cast<uint64_t>(tile)  << 24);
}

// ---------------------------------------------------------------------------
// write_i32 helper (LE byte order into uint8_t buffer)
// ---------------------------------------------------------------------------
static inline void write_i32_out(uint8_t *buf, int byte_addr, int32_t value) {
#pragma HLS INLINE
    const uint32_t v = static_cast<uint32_t>(value);
    buf[byte_addr + 0] = static_cast<uint8_t>(v        & 0xFFu);
    buf[byte_addr + 1] = static_cast<uint8_t>((v >>  8) & 0xFFu);
    buf[byte_addr + 2] = static_cast<uint8_t>((v >> 16) & 0xFFu);
    buf[byte_addr + 3] = static_cast<uint8_t>((v >> 24) & 0xFFu);
}

static inline int8_t  read_i8_in (const uint8_t *buf, int i) {
#pragma HLS INLINE
    return static_cast<int8_t>(buf[i]);
}

static inline int32_t read_i32_in(const uint8_t *buf, int byte_addr) {
#pragma HLS INLINE
    const uint32_t v =
        static_cast<uint32_t>(buf[byte_addr + 0]) |
        (static_cast<uint32_t>(buf[byte_addr + 1]) << 8) |
        (static_cast<uint32_t>(buf[byte_addr + 2]) << 16) |
        (static_cast<uint32_t>(buf[byte_addr + 3]) << 24);
    return static_cast<int32_t>(v);
}

static inline int16_t read_i16_in(const uint8_t *buf, int byte_addr) {
#pragma HLS INLINE
    const uint16_t v =
        static_cast<uint16_t>(buf[byte_addr + 0]) |
        (static_cast<uint16_t>(buf[byte_addr + 1]) << 8);
    return static_cast<int16_t>(v);
}

#ifndef __SYNTHESIS__
static const char *compute_op_name(ComputeOp op) {
    switch (op) {
        case CMP_NONE: return "CMP_NONE";
        case CMP_Q: return "CMP_Q";
        case CMP_K: return "CMP_K";
        case CMP_V: return "CMP_V";
        case CMP_ATT_SCORES: return "CMP_ATT_SCORES";
        case CMP_ATT_VALUE: return "CMP_ATT_VALUE";
        case CMP_OUT_PROJ: return "CMP_OUT_PROJ";
        case CMP_FFN_W1: return "CMP_FFN_W1";
        case CMP_FFN_W2: return "CMP_FFN_W2";
        case CMP_LOGITS: return "CMP_LOGITS";
        default: return "CMP_UNKNOWN";
    }
}

static void print_i8_prefix(const char *label, const uint8_t *buf, int byte_offset, int count, int max_print = 16) {
    const int to_print = (count < max_print) ? count : max_print;
    std::printf("  %s @%d i8[%d]:", label, byte_offset, count);
    for (int i = 0; i < to_print; ++i) {
        std::printf(" %d", static_cast<int>(read_i8_in(buf, byte_offset + i)));
    }
    if (to_print < count) {
        std::printf(" ...");
    }
    std::printf("\n");
}

static void print_i32_prefix(const char *label, const uint8_t *buf, int byte_offset, int count, int max_print = 16) {
    const int to_print = (count < max_print) ? count : max_print;
    std::printf("  %s @%d i32[%d]:", label, byte_offset, count);
    for (int i = 0; i < to_print; ++i) {
        std::printf(" %d", read_i32_in(buf, byte_offset + i * 4));
    }
    if (to_print < count) {
        std::printf(" ...");
    }
    std::printf("\n");
}

static void print_i16_prefix(const char *label, const uint8_t *buf, int byte_offset, int count, int max_print = 16) {
    const int to_print = (count < max_print) ? count : max_print;
    std::printf("  %s @%d i16[%d]:", label, byte_offset, count);
    for (int i = 0; i < to_print; ++i) {
        std::printf(" %d", static_cast<int>(read_i16_in(buf, byte_offset + i * 2)));
    }
    if (to_print < count) {
        std::printf(" ...");
    }
    std::printf("\n");
}

static void trace_matmul_io(const PendingRequest &req,
                            const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
                            const uint8_t out_buf[compute_buf::OUT_BUF_BYTES]) {
    std::printf("[COMPUTE IO] op=%s layer=%u head=%u tile=%u\n",
                compute_op_name(req.op),
                static_cast<unsigned>(req.layer_idx),
                static_cast<unsigned>(req.head_idx),
                static_cast<unsigned>(req.tile_idx));

    switch (req.op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V:
            std::printf("  INQkvLayout: ACT=%d W=%d B=%d\n",
                        mm_buf::INQkvLayout::ACT, mm_buf::INQkvLayout::W, mm_buf::INQkvLayout::B);
            print_i8_prefix("IN.ACT", in_buf, mm_buf::INQkvLayout::ACT, D_MODEL);
            print_i8_prefix("IN.W",   in_buf, mm_buf::INQkvLayout::W, D_HEAD_TILE_QKV * D_MODEL);
            print_i32_prefix("IN.B",  in_buf, mm_buf::INQkvLayout::B, D_HEAD_TILE_QKV, D_HEAD_TILE_QKV);
            print_i32_prefix("OUT",   out_buf, 0, D_HEAD_TILE_QKV, D_HEAD_TILE_QKV);
            break;

        case CMP_ATT_SCORES:
            std::printf("  INAttScoresLayout: ACT=%d W=%d\n",
                        mm_buf::INAttScoresLayout::ACT, mm_buf::INAttScoresLayout::W);
            print_i8_prefix("IN.ACT(Q)", in_buf, mm_buf::INAttScoresLayout::ACT, D_HEADS);
            print_i8_prefix("IN.W(K)",   in_buf, mm_buf::INAttScoresLayout::W, ATT_CTX_BLOCK * D_HEADS);
            print_i32_prefix("OUT(scores)", out_buf, 0, ATT_CTX_BLOCK);
            break;

        case CMP_ATT_VALUE:
            std::printf("  INAttValueLayout: ACT=%d W=%d\n",
                        mm_buf::INAttValueLayout::ACT, mm_buf::INAttValueLayout::W);
            print_i16_prefix("IN.ACT(weights)", in_buf, mm_buf::INAttValueLayout::ACT, CONTEXT_LENGTH);
            print_i8_prefix("IN.W(V)",          in_buf, mm_buf::INAttValueLayout::W, CONTEXT_LENGTH * D_HEAD_TILE_ATT_VALUE);
            print_i32_prefix("OUT(values)", out_buf, 0, D_HEAD_TILE_ATT_VALUE, D_HEAD_TILE_ATT_VALUE);
            break;

        case CMP_OUT_PROJ:
            std::printf("  INOutProjLayout: ACT=%d W=%d B=%d\n",
                        mm_buf::INOutProjLayout::ACT, mm_buf::INOutProjLayout::W, mm_buf::INOutProjLayout::B);
            print_i8_prefix("IN.ACT", in_buf, mm_buf::INOutProjLayout::ACT, D_MODEL);
            print_i8_prefix("IN.W",   in_buf, mm_buf::INOutProjLayout::W, D_TILE_WO * D_MODEL);
            print_i32_prefix("IN.B",  in_buf, mm_buf::INOutProjLayout::B, D_TILE_WO, D_TILE_WO);
            print_i32_prefix("OUT",   out_buf, 0, D_TILE_WO, D_TILE_WO);
            break;

        case CMP_FFN_W1:
            std::printf("  INW1Layout: ACT=%d W=%d B=%d\n",
                        mm_buf::INW1Layout::ACT, mm_buf::INW1Layout::W, mm_buf::INW1Layout::B);
            print_i8_prefix("IN.ACT", in_buf, mm_buf::INW1Layout::ACT, D_MODEL);
            print_i8_prefix("IN.W",   in_buf, mm_buf::INW1Layout::W, D_TILE_W1 * D_MODEL);
            print_i32_prefix("IN.B",  in_buf, mm_buf::INW1Layout::B, D_TILE_W1, D_TILE_W1);
            print_i32_prefix("OUT",   out_buf, 0, D_TILE_W1, D_TILE_W1);
            break;

        case CMP_FFN_W2:
            std::printf("  INW2Layout: ACT=%d W=%d B=%d\n",
                        mm_buf::INW2Layout::ACT, mm_buf::INW2Layout::W, mm_buf::INW2Layout::B);
            print_i8_prefix("IN.ACT", in_buf, mm_buf::INW2Layout::ACT, D_FFN);
            print_i8_prefix("IN.W",   in_buf, mm_buf::INW2Layout::W, D_TILE_W2 * D_FFN);
            print_i32_prefix("IN.B",  in_buf, mm_buf::INW2Layout::B, D_TILE_W2, D_TILE_W2);
            print_i32_prefix("OUT",   out_buf, 0, D_TILE_W2, D_TILE_W2);
            break;

        case CMP_LOGITS:
            std::printf("  INLogitsLayout: ACT=%d W=%d\n",
                        mm_buf::INLogitsLayout::ACT, mm_buf::INLogitsLayout::W);
            print_i8_prefix("IN.ACT", in_buf, mm_buf::INLogitsLayout::ACT, D_MODEL);
            print_i8_prefix("IN.W",   in_buf, mm_buf::INLogitsLayout::W, D_TILE_LOGIT * D_MODEL);
            print_i32_prefix("OUT",   out_buf, 0, D_TILE_LOGIT, D_TILE_LOGIT);
            break;

        default:
            std::printf("  (no trace for this op)\n");
            break;
    }
}
#endif

// ---------------------------------------------------------------------------
// MATMUL_QKV
//
// Computes one tile of Q, K, or V projection.
// in_buf layout (mm_buf::INQkvLayout):
//   [ACT]  int8[D_MODEL]                — activation from stream-in
//   [W]    int8[D_HEAD_TILE_QKV*D_MODEL] — weight tile from DMA
//   [B]    int32[D_HEAD_TILE_QKV]        — bias tile from DMA
// out_buf:
//   int32[D_HEAD_TILE_QKV]              — raw int32 dot products
// ---------------------------------------------------------------------------
static void MATMUL_QKV(
    const uint8_t in_buf[mm_buf::IN_BUF_BYTES],
    uint8_t       out_buf[mm_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE off
    constexpr int OUT_LANES = D_HEAD_TILE_QKV;
    int8_t  act[D_MODEL];
    int8_t  w_lane[OUT_LANES][D_MODEL];
    int32_t bias_lane[OUT_LANES];
    int32_t acc_lane[OUT_LANES];
#pragma HLS ARRAY_PARTITION variable=act  cyclic factor=QKV_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=w_lane complete dim=1
#pragma HLS ARRAY_PARTITION variable=bias_lane complete dim=1
#pragma HLS ARRAY_PARTITION variable=acc_lane  complete dim=1
#pragma HLS bind_storage variable=act type=RAM_2P impl=LUTRAM
#pragma HLS bind_storage variable=w_lane type=RAM_2P impl=LUTRAM

    // Stage 1: activation
    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
        act[i] = read_i8_in(in_buf, mm_buf::INQkvLayout::ACT + i);
    }

    // Stage 2: weight tile
    for (int lane = 0; lane < OUT_LANES; ++lane) {
        for (int k = 0; k < D_MODEL; ++k) {
#pragma HLS PIPELINE II=1
            w_lane[lane][k] = read_i8_in(in_buf, mm_buf::INQkvLayout::W + lane * D_MODEL + k);
        }
    }

    // Stage 3: bias tile
    for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS PIPELINE II=1
        bias_lane[lane] = read_i32_in(in_buf, mm_buf::INQkvLayout::B + lane * 4);
    }

    // Compute (local only): acc[d] = bias[d] + dot(act, w[d][..])
    for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL
        acc_lane[lane] = bias_lane[lane];
    }
    for (int k_idx = 0; k_idx < D_MODEL; ++k_idx) {
#pragma HLS PIPELINE II=1
        const int32_t a = static_cast<int32_t>(act[k_idx]);
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL
            acc_lane[lane] += a * static_cast<int32_t>(w_lane[lane][k_idx]);
        }
    }

    // Write raw int32 output (out_buf access must be pipelined, not unrolled)
    for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS PIPELINE II=1
        write_i32_out(out_buf, lane * 4, acc_lane[lane]);
    }
}

// ---------------------------------------------------------------------------
// MATMUL_ATT_SCORES
//
// Computes attention scores for one context block:
//   scores[t] = dot(Q[D_HEAD], K_cache[t][D_HEAD])  for t in [0, ATT_CTX_BLOCK)
//
// in_buf layout (mm_buf::INAttScoresLayout):
//   [ACT] int8[D_HEADS]                       — Q vector from stream-in
//   [W]   int8[ATT_CTX_BLOCK * D_HEADS]       — K cache tile from DMA
// out_buf:
//   int32[ATT_CTX_BLOCK]                       — raw dot products
// ---------------------------------------------------------------------------
static void MATMUL_ATT_SCORES(
    const uint8_t in_buf[mm_buf::IN_BUF_BYTES],
    uint8_t       out_buf[mm_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE off
    constexpr int T_LANES  = ATT_SCORES_TO_BUF_OUT_UNROLL;
    constexpr int T_GROUPS = ATT_CTX_BLOCK / T_LANES;
    int8_t  q[D_HEADS];
    int8_t  k_lane[T_LANES][T_GROUPS][D_HEADS];
#pragma HLS ARRAY_PARTITION variable=q   cyclic factor=ATT_SCORES_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=k_lane complete dim=1
#pragma HLS bind_storage variable=q type=RAM_2P impl=LUTRAM
#pragma HLS bind_storage variable=k_lane type=RAM_2P impl=LUTRAM

    // Stage 1: activation (Q)
    for (int d = 0; d < D_HEADS; ++d) {
#pragma HLS PIPELINE II=1
        q[d] = read_i8_in(in_buf, mm_buf::INAttScoresLayout::ACT + d);
    }

    // Stage 2: weight tile (K cache)
    for (int t = 0; t < ATT_CTX_BLOCK; ++t) {
        const int lane = t % T_LANES;
        const int tgrp = t / T_LANES;
        for (int d = 0; d < D_HEADS; ++d) {
#pragma HLS PIPELINE II=1
            k_lane[lane][tgrp][d] =
                read_i8_in(in_buf, mm_buf::INAttScoresLayout::W + t * D_HEADS + d);
        }
    }

    // Compute (local only): t-grouped dot products.
    // This avoids HLS flattening an inner "t" loop into a huge pipelined body.
    for (int tgrp = 0; tgrp < T_GROUPS; ++tgrp) {
#pragma HLS LOOP_FLATTEN off
        int32_t acc_lane[T_LANES];
#pragma HLS ARRAY_PARTITION variable=acc_lane complete dim=1
        for (int lane = 0; lane < T_LANES; ++lane) {
#pragma HLS UNROLL
            acc_lane[lane] = 0;
        }
        for (int d = 0; d < D_HEADS; ++d) {
#pragma HLS PIPELINE II=1
            const int32_t qd = static_cast<int32_t>(q[d]);
            for (int lane = 0; lane < T_LANES; ++lane) {
#pragma HLS UNROLL
                acc_lane[lane] += qd * static_cast<int32_t>(k_lane[lane][tgrp][d]);
            }
        }
        // Write this group
        for (int lane = 0; lane < T_LANES; ++lane) {
#pragma HLS PIPELINE II=1
            const int t = tgrp * T_LANES + lane;
            write_i32_out(out_buf, t * 4, acc_lane[lane]);
        }
    }

    // Note: out_buf writes performed per t-group above.
}

// ---------------------------------------------------------------------------
// MATMUL_ATT_VALUE
//
// Computes the full-context weighted sum of V for one d-tile (no ctx chunking).
//
//   out[d] = sum_{t in [0, CONTEXT_LENGTH)} weights[t] * V_tile[d][t]
//
// in_buf layout (mm_buf::INAttValueLayout):
//   [ACT] int16[CONTEXT_LENGTH]                         — softmax weights (full context) from stream-in
//   [W]   int8[CONTEXT_LENGTH * D_HEAD_TILE_ATT_VALUE]   — V cache tile from DMA
//                                                         layout: V[d][t] at W + d*CONTEXT_LENGTH + t
// out_buf:
//   int32[D_HEAD_TILE_ATT_VALUE]                        — full-context sums for this d-tile
// ---------------------------------------------------------------------------
static void MATMUL_ATT_VALUE(
    const uint8_t in_buf[mm_buf::IN_BUF_BYTES],
    uint8_t       out_buf[mm_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE off
    constexpr int OUT_LANES = D_HEAD_TILE_ATT_VALUE;
    int16_t weights[CONTEXT_LENGTH];
    int8_t  v_lane[OUT_LANES][CONTEXT_LENGTH];
    int32_t acc_lane[OUT_LANES];
#pragma HLS ARRAY_PARTITION variable=weights cyclic factor=ATT_VALUE_TO_BUF_CTX_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=v_lane  complete dim=1
#pragma HLS ARRAY_PARTITION variable=acc_lane cyclic factor=ATT_VALUE_TO_BUF_OUT_UNROLL dim=1
#pragma HLS bind_storage variable=weights type=RAM_2P impl=LUTRAM
#pragma HLS bind_storage variable=v_lane  type=RAM_2P impl=LUTRAM

    // Stage 1: activation (softmax weights)
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
        weights[t] = read_i16_in(in_buf, mm_buf::INAttValueLayout::ACT + t * 2);
    }

    // Stage 2: weight tile (V cache)
    for (int lane = 0; lane < OUT_LANES; ++lane) {
        for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
            v_lane[lane][t] =
                read_i8_in(in_buf, mm_buf::INAttValueLayout::W + lane * CONTEXT_LENGTH + t);
        }
    }

    // Compute (local only)
    for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL factor=ATT_VALUE_TO_BUF_OUT_UNROLL
        acc_lane[lane] = 0;
    }
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
#pragma HLS PIPELINE II=1
        const int32_t wt = static_cast<int32_t>(weights[t]);
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL factor=ATT_VALUE_TO_BUF_OUT_UNROLL
            acc_lane[lane] += wt * static_cast<int32_t>(v_lane[lane][t]);
        }
    }

    // Write raw int32 output (out_buf access must be pipelined, not unrolled)
    for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS PIPELINE II=1
        write_i32_out(out_buf, lane * 4, acc_lane[lane]);
    }
}

// ---------------------------------------------------------------------------
// MATMUL_OUT_PROJ
//
// in_buf: mm_buf::INOutProjLayout = [ACT(int8[D_MODEL]) | W(int8[D_TILE_WO*D_MODEL]) | B(int32[D_TILE_WO])]
// out_buf: int32[D_TILE_WO]
// ---------------------------------------------------------------------------
static void MATMUL_SHARED(
    const uint8_t in_buf[mm_buf::IN_BUF_BYTES],
    uint8_t       out_buf[mm_buf::OUT_BUF_BYTES], 
    ComputeOp op
) {
#pragma HLS INLINE off
    constexpr int OUT_LANES = MAC_OP_TO_BUF_OUT_UNROLL;
    int8_t  act_local[D_MODEL];
    int8_t  w_lane[OUT_LANES][D_MODEL];
    int32_t bias_lane[OUT_LANES];
    int32_t acc_lane[OUT_LANES];
#pragma HLS ARRAY_PARTITION variable=act_local  cyclic factor=MAC_OP_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=w_lane     complete dim=1
#pragma HLS ARRAY_PARTITION variable=bias_lane  complete dim=1
#pragma HLS ARRAY_PARTITION variable=acc_lane   complete dim=1
#pragma HLS bind_storage variable=act_local type=RAM_2P impl=LUTRAM
#pragma HLS bind_storage variable=w_lane    type=RAM_2P impl=LUTRAM

    // Stage 1: activation
    for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS PIPELINE II=1
        act_local[i] = read_i8_in(in_buf, mm_buf::INOutProjLayout::ACT + i);
    }

    // Stage/compute/write in output-lane groups to prevent HLS from forcing a full unroll
    // across D_TILE_SHARED inside a pipelined k-loop.
    const bool has_bias = (op != CMP_LOGITS);
    for (int base = 0; base < D_TILE_SHARED; base += OUT_LANES) {
#pragma HLS LOOP_FLATTEN off
        // Stage 2: weights (only this group's lanes)
        for (int lane = 0; lane < OUT_LANES; ++lane) {
            for (int k_idx = 0; k_idx < D_MODEL; ++k_idx) {
#pragma HLS PIPELINE II=1
                const int d = base + lane;
                w_lane[lane][k_idx] =
                    read_i8_in(in_buf, mm_buf::INOutProjLayout::W + d * D_MODEL + k_idx);
            }
        }

        // Stage 3: bias (CMP_LOGITS has no bias — zero-fill)
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS PIPELINE II=1
            const int d = base + lane;
            bias_lane[lane] = has_bias ? read_i32_in(in_buf, mm_buf::INOutProjLayout::B + d * 4) : 0;
        }

        // Compute (local only)
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL factor=MAC_OP_TO_BUF_OUT_UNROLL
            acc_lane[lane] = bias_lane[lane];
        }
        for (int k_idx = 0; k_idx < D_MODEL; ++k_idx) {
#pragma HLS PIPELINE II=1
            const int32_t a = static_cast<int32_t>(act_local[k_idx]);
            for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL factor=MAC_OP_TO_BUF_OUT_UNROLL
                acc_lane[lane] += a * static_cast<int32_t>(w_lane[lane][k_idx]);
            }
        }

        // Write raw int32 output (out_buf access must be pipelined, not unrolled)
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS PIPELINE II=1
            const int d = base + lane;
            write_i32_out(out_buf, d * 4, acc_lane[lane]);
        }
    }
}

// ---------------------------------------------------------------------------
// MATMUL_W2
//
// W2 tile:
//   in_buf  = [ACT(int8[D_FFN]) | W(int8[D_TILE_W2*D_FFN]) | B(int32[D_TILE_W2])]
//   out_buf = int32[D_TILE_W2]
// ---------------------------------------------------------------------------
static void MATMUL_W2(
    const uint8_t in_buf[mm_buf::IN_BUF_BYTES],
    uint8_t       out_buf[mm_buf::OUT_BUF_BYTES]
) {
#pragma HLS INLINE off
    constexpr int OUT_LANES = MAC_OP_TO_BUF_OUT_UNROLL;
    int8_t  act_local[D_FFN];
    int8_t  w_lane[OUT_LANES][D_FFN];
    int32_t bias_lane[OUT_LANES];
    int32_t acc_lane[OUT_LANES];
#pragma HLS ARRAY_PARTITION variable=act_local  cyclic factor=MAC_OP_TO_BUF_VEC_UNROLL dim=1
#pragma HLS ARRAY_PARTITION variable=w_lane     complete dim=1
#pragma HLS ARRAY_PARTITION variable=bias_lane  complete dim=1
#pragma HLS ARRAY_PARTITION variable=acc_lane   complete dim=1
#pragma HLS bind_storage variable=act_local type=RAM_2P impl=LUTRAM
#pragma HLS bind_storage variable=w_lane    type=RAM_2P impl=LUTRAM

    // Stage 1: activation
    for (int i = 0; i < D_FFN; ++i) {
#pragma HLS PIPELINE II=1
        act_local[i] = read_i8_in(in_buf, mm_buf::INW2Layout::ACT + i);
    }

    for (int base = 0; base < D_TILE_W2; base += OUT_LANES) {
#pragma HLS LOOP_FLATTEN off
        // Stage 2: weights (only this group's lanes)
        for (int lane = 0; lane < OUT_LANES; ++lane) {
            for (int k_idx = 0; k_idx < D_FFN; ++k_idx) {
#pragma HLS PIPELINE II=1
                const int d = base + lane;
                w_lane[lane][k_idx] =
                    read_i8_in(in_buf, mm_buf::INW2Layout::W + d * D_FFN + k_idx);
            }
        }

        // Stage 3: bias
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS PIPELINE II=1
            const int d = base + lane;
            bias_lane[lane] = read_i32_in(in_buf, mm_buf::INW2Layout::B + d * 4);
        }

        // Compute (local only)
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL factor=MAC_OP_TO_BUF_OUT_UNROLL
            acc_lane[lane] = bias_lane[lane];
        }
        for (int k_idx = 0; k_idx < D_FFN; ++k_idx) {
#pragma HLS PIPELINE II=1
            const int32_t a = static_cast<int32_t>(act_local[k_idx]);
            for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS UNROLL factor=MAC_OP_TO_BUF_OUT_UNROLL
                acc_lane[lane] += a * static_cast<int32_t>(w_lane[lane][k_idx]);
            }
        }

        // Write raw int32 output (out_buf access must be pipelined, not unrolled)
        for (int lane = 0; lane < OUT_LANES; ++lane) {
#pragma HLS PIPELINE II=1
            const int d = base + lane;
            write_i32_out(out_buf, d * 4, acc_lane[lane]);
        }
    }
}

// ---------------------------------------------------------------------------
// compute_controller — MatMul-only FSM
//
// States:
//   IDLE              — wait for compute_start
//   CAPTURE_INSTRUCTION — latch and decode instruction
//   WAIT_MEM          — request in_buf fill from MMU
//   EXECUTE           — run matmul kernel
//   MEM_WRITEBACK     — signal MMU result is in out_buf (triggers stream-out)
//   DONE              — pulse compute_done, return to IDLE
// ---------------------------------------------------------------------------
void compute_controller(
    bool cntrl_reset_n,
    bool        compute_start,
    uint64_t    compute_instruction,
    bool        &compute_ready,
    bool        &compute_done,
    bool        mem_transfer_done,
    bool        &mem_read_request,
    bool        &mem_write_request,
    uint64_t    &mem_op,
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t       out_buf[compute_buf::OUT_BUF_BYTES],
    ComputeState &dbg_state,
    uint64_t    &dbg_req_instruction,
    uint8_t     &dbg_req_op,
    uint8_t     &dbg_req_layer,
    uint8_t     &dbg_req_head,
    uint16_t    &dbg_req_tile,
    bool        &dbg_mac_start,
    bool        &dbg_mac_ready,
    bool        &dbg_mac_complete,
    bool        &error
) {
#pragma HLS INLINE off

    static ComputeState state;
#pragma HLS reset variable=state
    static PendingRequest req;
#pragma HLS reset variable=req
    static bool mac_busy;
#pragma HLS reset variable=mac_busy
    static bool mac_ready;
#pragma HLS reset variable=mac_ready
    static bool mac_complete;
#pragma HLS reset variable=mac_complete
    static bool error_latched;
#pragma HLS reset variable=error_latched

    const bool reset = !cntrl_reset_n;

    if (reset) {
        state          = ComputeState::IDLE;
        req            = PendingRequest{};
        mac_busy       = false;
        mac_ready      = true;
        mac_complete   = false;
        error_latched  = false;
        compute_ready  = true;
        compute_done   = false;
        mem_read_request  = false;
        mem_write_request = false;
        mem_op         = 0;
        error          = false;
        dbg_state      = state;
        dbg_req_instruction = 0;
        dbg_req_op = 0; dbg_req_layer = 0; dbg_req_head = 0; dbg_req_tile = 0;
        dbg_mac_start = false; dbg_mac_ready = true; dbg_mac_complete = false;
        return;
    }

    // Default: deassert one-shot outputs
    compute_done      = false;
    mem_read_request  = false;
    mem_write_request = false;

    switch (state) {

        // -------------------------------------------------------------------
        case ComputeState::IDLE: {
            compute_ready = true;
            mac_ready     = true;
            if (compute_start) {
                req.instruction = compute_instruction;
                unpack_instruction(compute_instruction,
                    req.op, req.layer_idx, req.head_idx, req.tile_idx);
                compute_ready = false;
                state = ComputeState::CAPTURE_INSTRUCTION;
            }
            break;
        }

        // -------------------------------------------------------------------
        case ComputeState::CAPTURE_INSTRUCTION: {
            compute_ready = false;
            // Validate op
            if (req.op == CMP_NONE) {
                error_latched = true;
                state = ComputeState::DONE;
            } else {
                state = ComputeState::WAIT_MEM;
            }
            break;
        }

        // -------------------------------------------------------------------
        // Request MMU to fill in_buf with activation + weight tile.
        // The MMU uses mem_op to know which regions to stage.
        // -------------------------------------------------------------------
        case ComputeState::WAIT_MEM: {
            compute_ready     = false;
            mem_read_request  = true;
            mem_op = pack_mem_op(req.op, req.layer_idx, req.head_idx, req.tile_idx);
            if (mem_transfer_done) {
                mem_read_request = false;
                mac_busy         = true;
                mac_ready        = false;
                mac_complete     = false;
                state            = ComputeState::EXECUTE;
            }
            break;
        }

        // -------------------------------------------------------------------
        // Execute the matmul kernel.
        // Kernels are multi-cycle (pipelined) and only access in_buf/out_buf
        // from pipelined loops; state advances after kernel completes.
        // -------------------------------------------------------------------
        case ComputeState::EXECUTE: {
            compute_ready = false;
            mac_busy      = true;

            switch (req.op) {
                case CMP_Q:
                case CMP_K:
                case CMP_V:
                    MATMUL_QKV(in_buf, out_buf);
                    break;

                case CMP_ATT_SCORES:
                    MATMUL_ATT_SCORES(in_buf, out_buf);
                    break;

                case CMP_ATT_VALUE:
                    MATMUL_ATT_VALUE(in_buf, out_buf);
                    break;

                case CMP_OUT_PROJ:
                case CMP_FFN_W1:
                case CMP_LOGITS:
                    MATMUL_SHARED(in_buf, out_buf, req.op);
                    break;

                case CMP_FFN_W2:
                    MATMUL_W2(in_buf, out_buf);
                    break;

                default:
                    error_latched = true;
                    break;
            }

#ifndef __SYNTHESIS__
            trace_matmul_io(req, in_buf, out_buf);
#endif

            mac_busy     = false;
            mac_complete = true;
            state        = ComputeState::MEM_WRITEBACK;
            break;
        }

        // -------------------------------------------------------------------
        // Signal MMU that out_buf contains the result; MMU streams it to PS.
        // -------------------------------------------------------------------
        case ComputeState::MEM_WRITEBACK: {
            compute_ready     = false;
            mem_write_request = true;
            mem_op = pack_mem_op(req.op, req.layer_idx, req.head_idx, req.tile_idx);
            if (mem_transfer_done) {
                mem_write_request = false;
                mac_complete      = false;
                state             = ComputeState::DONE;
            }
            break;
        }

        // -------------------------------------------------------------------
        case ComputeState::DONE: {
            compute_done  = true;
            compute_ready = false;
            error         = error_latched;
            state         = ComputeState::IDLE;
            break;
        }

        default:
            state = ComputeState::IDLE;
            break;
    }

    // Debug mirrors
    dbg_state           = state;
    dbg_req_instruction = req.instruction;
    dbg_req_op          = static_cast<uint8_t>(req.op);
    dbg_req_layer       = req.layer_idx;
    dbg_req_head        = req.head_idx;
    dbg_req_tile        = req.tile_idx;
    dbg_mac_start       = compute_start;
    dbg_mac_ready       = mac_ready;
    dbg_mac_complete    = mac_complete;
}
