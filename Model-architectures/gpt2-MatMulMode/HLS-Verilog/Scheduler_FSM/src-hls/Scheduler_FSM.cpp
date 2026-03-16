#include "Scheduler_FSM.hpp"
#include <cstdint>

// ------------------------------------------------------------
// Instruction packing helpers (64-bit internal format)
// bits [7:0]   = op    (ComputeOp / DmaSel)
// bits [15:8]  = layer (8-bit)
// bits [23:16] = head  (8-bit)
// bits [55:24] = tile  (32-bit)
// ------------------------------------------------------------
static inline uint64_t pack_dma_op(DmaSel op, uint8_t layer, uint8_t head, uint32_t tile) {
#pragma HLS INLINE
    return static_cast<uint64_t>(static_cast<uint8_t>(op))
         | (static_cast<uint64_t>(layer) << 8)
         | (static_cast<uint64_t>(head)  << 16)
         | (static_cast<uint64_t>(tile)  << 24);
}

static inline uint64_t pack_compute_instruction(ComputeOp op, uint8_t layer, uint8_t head, uint32_t tile) {
#pragma HLS INLINE
    return static_cast<uint64_t>(static_cast<uint8_t>(op))
         | (static_cast<uint64_t>(layer) << 8)
         | (static_cast<uint64_t>(head)  << 16)
         | (static_cast<uint64_t>(tile)  << 24);
}

// Decode 32-bit PS instruction:
//   [15:10]=head, [9:4]=layer, [3:0]=op
//   [31:16] reserved/ignored (tile is handled internally by PL)
static inline void decode_instr(uint32_t instr,
    uint8_t &op, uint8_t &layer, uint8_t &head, uint16_t &tile) {
#pragma HLS INLINE
    op    = static_cast<uint8_t> (instr & 0xFu);
    layer = static_cast<uint8_t> ((instr >>  4) & 0x3Fu);
    head  = static_cast<uint8_t> ((instr >> 10) & 0x3Fu);
    tile  = static_cast<uint16_t>((instr >> 16) & 0xFFFFu);
}

// Map ComputeOp to DmaSel for the weight/cache fetch.
// For ATT_VALUE the ctx_block_idx is carried in tile[15:4].
static inline DmaSel op_to_dmasel(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_Q:          return DMASEL_WQ;
        case CMP_K:          return DMASEL_WK;
        case CMP_V:          return DMASEL_WV;
        case CMP_ATT_SCORES: return DMASEL_CTX_K;
        case CMP_ATT_VALUE:  return DMASEL_CTX_V;
        case CMP_OUT_PROJ:   return DMASEL_WO;
        case CMP_FFN_W1:     return DMASEL_W1;
        case CMP_FFN_W2:     return DMASEL_W2;
        case CMP_LOGITS:     return DMASEL_WLOGIT;
        default:             return DMASEL_NONE;
    }
}

// For ATT_VALUE the tile field packs [15:4]=ctx_block_idx and [3:0]=d_tile_idx.
// The DMA instruction to the MMU for CTX_V uses the d_tile_idx portion.
static inline uint16_t att_value_d_tile(uint16_t tile) {
#pragma HLS INLINE
    return tile & 0xFu;
}

// For ATT_VALUE the compute instruction passes the full tile so the compute
// controller can unpack d_tile_idx from bits [3:0].
// (No extra decode needed here — just pass tile as-is.)

// Map SchedState target from decoded op.
static inline SchedState op_to_state(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_Q:          return S_MATMUL_Q;
        case CMP_K:          return S_MATMUL_K;
        case CMP_V:          return S_MATMUL_V;
        case CMP_ATT_SCORES: return S_MATMUL_ATTENTION_SCORES;
        case CMP_ATT_VALUE:  return S_MATMUL_ATTENTION_VALUES;
        case CMP_OUT_PROJ:   return S_MATMUL_OUT_PROJ;
        case CMP_FFN_W1:     return S_MATMUL_W1;
        case CMP_FFN_W2:     return S_MATMUL_W2;
        case CMP_LOGITS:     return S_MATMUL_W1;  // same path, different DMA sel
        default:             return S_IDLE;
    }
}

static inline uint16_t tile_end_for_op(ComputeOp op) {
#pragma HLS INLINE
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V:
            return static_cast<uint16_t>(NUM_QKV_HEAD_TILES);
        case CMP_ATT_SCORES:
            return static_cast<uint16_t>(NUM_ATT_CTX_BLOCKS);
        case CMP_ATT_VALUE:
            return static_cast<uint16_t>(NUM_ATT_VALUE_HEAD_TILES * NUM_ATT_CTX_BLOCKS);
        case CMP_OUT_PROJ:
            return static_cast<uint16_t>(NUM_WO_TILES);
        case CMP_FFN_W1:
            return static_cast<uint16_t>(NUM_W1_TILES);
        case CMP_FFN_W2:
            return static_cast<uint16_t>(NUM_W2_TILES);
        case CMP_LOGITS:
            return static_cast<uint16_t>(NUM_LOGIT_TILES);
        default:
            return 0;
    }
}

static inline uint16_t tile_payload_for_iter(ComputeOp op, uint16_t iter) {
#pragma HLS INLINE
    if (op != CMP_ATT_VALUE) {
        return iter;
    }
    // ATT_VALUE tile packs: [15:4]=ctx_block_idx, [3:0]=d_tile_idx
    // Iterate in d_tile-major order to avoid redundant DMA of CTX_V.
    const uint16_t d_tile = static_cast<uint16_t>(iter / static_cast<uint16_t>(NUM_ATT_CTX_BLOCKS));
    const uint16_t ctx = static_cast<uint16_t>(iter % static_cast<uint16_t>(NUM_ATT_CTX_BLOCKS));
    return static_cast<uint16_t>((ctx << 4) | (d_tile & 0xFu));
}

static inline bool need_dma_for_tile(ComputeOp op, uint16_t tile) {
#pragma HLS INLINE
    if (op != CMP_ATT_VALUE) {
        return true;
    }
    const uint16_t ctx = static_cast<uint16_t>(tile >> 4);
    return (ctx == 0);
}

// ---------------------------------------------------------------------------
// scheduler_hls — instruction-driven MatMul-only scheduler FSM
// ---------------------------------------------------------------------------
void scheduler_hls(
    bool      cntrl_reset_n,
    bool      cntrl_start,
    uint32_t  instr,
    bool      axis_token_complete,
    bool      dma_done,
    bool      wl_ready,
    bool      wl_accept,
    uint64_t  &wl_instruction,
    bool      &wl_start,
    bool      compute_ready,
    bool      compute_done,
    bool      &compute_start,
    uint64_t  &compute_instruction,
    bool      stream_ready,
    bool      &stream_start,
    bool      stream_done,
    bool      &done,
    bool      &error,
    uint32_t  &layer_index_out,
    SchedState &STATE
) {
#pragma HLS INLINE off

    // Persistent FSM state
    static SchedState st;
#pragma HLS reset variable=st

    // Decoded instruction fields (captured at S_IDLE on cntrl_start)
    static uint32_t captured_instr;
#pragma HLS reset variable=captured_instr
    static uint8_t  dec_op;
#pragma HLS reset variable=dec_op
    static uint8_t  dec_layer;
#pragma HLS reset variable=dec_layer
    static uint8_t  dec_head;
#pragma HLS reset variable=dec_head
    static uint16_t dec_tile;
#pragma HLS reset variable=dec_tile

    // Internal per-op tile loop
    static uint16_t tile_iter;
#pragma HLS reset variable=tile_iter
    static uint16_t tile_end;
#pragma HLS reset variable=tile_end
    static SchedState op_state;
#pragma HLS reset variable=op_state

    // Per-invocation handshake guards
    static bool dma_busy;
#pragma HLS reset variable=dma_busy
    static bool dma_done_seen;
#pragma HLS reset variable=dma_done_seen
    static bool comp_busy;
#pragma HLS reset variable=comp_busy
    static bool comp_done_seen;
#pragma HLS reset variable=comp_done_seen
    static bool stream_started;
#pragma HLS reset variable=stream_started
    static bool stream_done_seen;
#pragma HLS reset variable=stream_done_seen
    static bool error_latched;
#pragma HLS reset variable=error_latched

    const bool reset = !cntrl_reset_n;

    // -----------------------------------------------------------------------
    // Reset
    // -----------------------------------------------------------------------
    if (reset) {
        st              = S_IDLE;
        captured_instr  = 0;
        dec_op          = 0;
        dec_layer       = 0;
        dec_head        = 0;
        dec_tile        = 0;
        tile_iter       = 0;
        tile_end        = 0;
        op_state        = S_IDLE;
        dma_busy        = false;
        dma_done_seen   = false;
        comp_busy       = false;
        comp_done_seen  = false;
        stream_started  = false;
        stream_done_seen = false;
        error_latched   = false;

        wl_start            = false;
        wl_instruction      = pack_dma_op(DMASEL_NONE, 0, 0, 0);
        compute_start       = false;
        compute_instruction = pack_compute_instruction(CMP_NONE, 0, 0, 0);
        stream_start        = false;
        done                = false;
        error               = false;
        layer_index_out     = 0;
        STATE               = st;
        return;
    }

    // -----------------------------------------------------------------------
    // Default output de-assertion (driven high only in the right cycles)
    // -----------------------------------------------------------------------
    // Clear one-shot start pulses once they are accepted
    if (wl_accept && wl_start) {
        wl_start       = false;
        wl_instruction = pack_dma_op(DMASEL_NONE, 0, 0, 0);
    }
    if (!compute_ready && compute_start) {
        compute_start       = false;
        compute_instruction = pack_compute_instruction(CMP_NONE, 0, 0, 0);
    }
    stream_start = false;
    done         = false;

    // -----------------------------------------------------------------------
    // Sticky capture of single-cycle done pulses
    // -----------------------------------------------------------------------
    if (dma_done && dma_busy)       dma_done_seen  = true;
    if (compute_done && comp_busy)  comp_done_seen = true;
    if (stream_started && stream_done) stream_done_seen = true;

    // -----------------------------------------------------------------------
    // Main FSM
    // -----------------------------------------------------------------------
    switch (st) {

        // -------------------------------------------------------------------
        case S_IDLE: {
            if (cntrl_start) {
                // Capture PS instruction (decoded later in S_DECODE).
                captured_instr = instr;
                dec_op    = 0;
                dec_layer = 0;
                dec_head  = 0;
                dec_tile  = 0;
                tile_iter = 0;
                tile_end  = 0;
                op_state  = S_IDLE;

                // Reset per-invocation guards
                dma_busy        = false;
                dma_done_seen   = false;
                comp_busy       = false;
                comp_done_seen  = false;
                stream_started  = false;
                stream_done_seen = false;
                error_latched   = false;

                wl_start            = false;
                compute_start       = false;
                done                = false;
                error               = false;

                st = S_STREAM_IN;
            }
            break;
        }

        // -------------------------------------------------------------------
        // Wait for the PS to stream the activation payload via AXIS.
        // The top-level (or MMU) latches AXIS beats; we wait for the
        // completion flag.
        // -------------------------------------------------------------------
        case S_STREAM_IN: {
            if (axis_token_complete) {
                st = S_DECODE;
            }
            break;
        }

        // -------------------------------------------------------------------
        // Decode the captured 32-bit instruction after the activation is in.
        // Validates opcode and selects which MatMul state to enter next.
        // -------------------------------------------------------------------
        case S_DECODE: {
            uint8_t  op;
            uint8_t  layer;
            uint8_t  head;
            uint16_t tile;
            decode_instr(captured_instr, op, layer, head, tile);

            dec_op    = op;
            dec_layer = layer;
            dec_head  = head;
            (void)tile; // reserved/ignored (tile is handled internally by PL)

            // Validate: must be one of the MatMul ops [CMP_Q..CMP_LOGITS].
            if (op < static_cast<uint8_t>(CMP_Q) || op > static_cast<uint8_t>(CMP_LOGITS)) {
                error_latched = true;
                st = S_IDLE;
                break;
            }
            const ComputeOp cop = static_cast<ComputeOp>(dec_op);
            op_state = op_to_state(cop);
            tile_end = tile_end_for_op(cop);
            tile_iter = 0;
            dec_tile = tile_payload_for_iter(cop, tile_iter);

            if (op_state == S_IDLE || tile_end == 0) {
                error_latched = true;
                st = S_IDLE;
                break;
            }

            // Reset per-tile guards (tile 0). For ATT_VALUE, allow skipping DMA
            // for ctx>0 tiles; ctx=0 always issues DMA.
            dma_busy        = false;
            dma_done_seen   = false;
            comp_busy       = !need_dma_for_tile(cop, dec_tile);
            comp_done_seen  = false;
            stream_started  = false;
            stream_done_seen = false;

            wl_start      = false;
            compute_start = false;

            st = op_state;
            break;
        }

        // -------------------------------------------------------------------
        // Generic MatMul state body (shared by all 9 matmul states).
        // Phase 1: Issue DMA request → wait for dma_done.
        // Phase 2: Issue compute request → wait for compute_done.
        // → S_STREAM_OUT.
        //
        // All 9 states use the same pattern; they differ only in
        // dec_op/dec_layer/dec_head/dec_tile captured at S_DECODE.
        // -------------------------------------------------------------------
        case S_MATMUL_Q:
        case S_MATMUL_K:
        case S_MATMUL_V:
        case S_MATMUL_ATTENTION_SCORES:
        case S_MATMUL_ATTENTION_VALUES:
        case S_MATMUL_OUT_PROJ:
        case S_MATMUL_W1:
        case S_MATMUL_W2: {
            const ComputeOp cop   = static_cast<ComputeOp>(dec_op);
            const DmaSel    dsel  = op_to_dmasel(cop);
            const bool need_dma = need_dma_for_tile(cop, dec_tile);

            // For ATT_VALUE the MMU-side tile index is d_tile_idx (tile[3:0]).
            const uint32_t dma_tile =
                (cop == CMP_ATT_VALUE)
                ? static_cast<uint32_t>(att_value_d_tile(dec_tile))
                : static_cast<uint32_t>(dec_tile);

            // Phase 1: issue DMA request
            if (need_dma && !dma_busy && !dma_done_seen && wl_ready) {
                wl_start       = true;
                wl_instruction = pack_dma_op(dsel, dec_layer, dec_head, dma_tile);
                dma_busy = true;
            }

            // Latch DMA done
            if (need_dma && dma_busy && (dma_done || dma_done_seen)) {
                dma_busy      = false;
                dma_done_seen = false;
                comp_busy     = true;
            }

            // Phase 2: issue compute request once DMA done and compute idle
            if (comp_busy && !comp_done_seen && compute_ready) {
                compute_start       = true;
                compute_instruction = pack_compute_instruction(
                    cop,
                    dec_layer, dec_head,
                    static_cast<uint32_t>(dec_tile));
                comp_busy = false;
            }

            // Wait for compute done
            if (!comp_busy && (compute_done || comp_done_seen) && !compute_start) {
                comp_done_seen = false;
                st = S_STREAM_OUT;
            }
            break;
        }

        // -------------------------------------------------------------------
        case S_STREAM_OUT: {
            if (!stream_started && stream_ready) {
                stream_start   = true;
                stream_started = true;
            }
            if (stream_started && (stream_done || stream_done_seen)) {
                stream_started   = false;
                stream_done_seen = false;
                const ComputeOp cop = static_cast<ComputeOp>(dec_op);
                if (tile_end > 0 && static_cast<uint16_t>(tile_iter + 1) < tile_end) {
                    tile_iter = static_cast<uint16_t>(tile_iter + 1);
                    dec_tile = tile_payload_for_iter(cop, tile_iter);

                    // Reset per-tile guards for the next tile.
                    dma_busy        = false;
                    dma_done_seen   = false;
                    comp_busy       = !need_dma_for_tile(cop, dec_tile);
                    comp_done_seen  = false;
                    stream_started  = false;
                    stream_done_seen = false;

                    wl_start      = false;
                    compute_start = false;

                    st = op_state;
                } else {
                    done = true;
                    st   = S_IDLE;
                }
            }
            break;
        }

        default:
            st = S_IDLE;
            break;
    }

    layer_index_out = static_cast<uint32_t>(dec_layer);
    error           = error_latched;
    STATE           = st;
}
