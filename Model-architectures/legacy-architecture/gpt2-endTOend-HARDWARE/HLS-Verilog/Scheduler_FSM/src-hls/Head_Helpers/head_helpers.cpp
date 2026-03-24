// Simplified, single-head helper flow that only exercises compute.
// Each head has its own "resource" (no shared arbitration).
#include "head_helpers.hpp"

static inline uint64_t pack_compute_op(ComputeOp op, int layer, int head, int tile) {
    #pragma HLS INLINE
    const uint64_t op_field    = static_cast<uint64_t>(static_cast<uint8_t>(op));
    const uint64_t layer_field = static_cast<uint64_t>(static_cast<uint8_t>(layer));
    const uint64_t head_field  = static_cast<uint64_t>(static_cast<uint8_t>(head));
    const uint64_t tile_field  = static_cast<uint64_t>(static_cast<uint32_t>(tile));
    return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}

static inline uint64_t pack_dma_op(DmaSel op, int layer, int head, int tile) {
#pragma HLS INLINE
    const uint64_t op_field    = static_cast<uint64_t>(static_cast<uint8_t>(op));
    const uint64_t layer_field = static_cast<uint64_t>(static_cast<uint8_t>(layer));
    const uint64_t head_field  = static_cast<uint64_t>(static_cast<uint8_t>(head));
    const uint64_t tile_field  = static_cast<uint64_t>(static_cast<uint32_t>(tile));
    return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}

static inline ComputeOp unpack_compute_op(uint64_t packed_op) {
    #pragma HLS INLINE
    return static_cast<ComputeOp>(packed_op & 0xFFu);
}

static inline void begin_tile_phase(HeadCtx &ctx, int tile_count) {
#pragma HLS INLINE
    ctx.active_tile_target = tile_count;
    ctx.in_multi_tile_phase = (tile_count > 1);
}

static inline void end_tile_phase(HeadCtx &ctx) {
#pragma HLS INLINE
    ctx.active_tile_target = 1;
    ctx.in_multi_tile_phase = false;
}

void init_head_ctx(HeadCtx &ctx, int layer_idx, int head_idx) {
    ctx.layer_stamp   = layer_idx;
    ctx.head_idx      = head_idx;
    ctx.phase         = HeadPhase::IDLE;
    ctx.compute_ready = false;
    ctx.compute_done  = false;
    ctx.compute_start = false;
    ctx.compute_op    = pack_compute_op(ComputeOp::CMP_NONE, layer_idx, head_idx, -1);
    ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_NONE, layer_idx, head_idx, -1);
    ctx.last_wl_addr  = DmaSel::DMASEL_NONE;
    ctx.wl_ready      = false;
    ctx.wl_accept     = false;
    ctx.wl_start      = false;
    ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, head_idx, -1);
    ctx.dma_done      = false;
    ctx.start_head    = false;
    ctx.q_started          = false;
    ctx.k_started          = false;
    ctx.v_started          = false;
    ctx.att_scores_started = false;
    ctx.val_scale_started  = false;
    ctx.softmax_started    = false;
    ctx.att_value_started  = false;
    ctx.k_writeback_started = false;
    ctx.v_writeback_started = false;
    ctx.head_requant_started   = false;

    ctx.q_compute_done          = false;
    ctx.k_compute_done          = false;
    ctx.v_compute_done          = false;
    ctx.att_scores_compute_done = false;
    ctx.val_scale_compute_done  = false;
    ctx.softmax_compute_done    = false;
    ctx.att_value_compute_done  = false;
    ctx.head_requant_compute_done   = false;
    ctx.q_dma_done              = false;
    ctx.k_dma_done              = false;
    ctx.k_writeback_dma_done    = false;
    ctx.v_dma_done              = false;
    ctx.v_writeback_dma_done    = false;
    ctx.att_scores_dma_done     = false;
    ctx.att_value_dma_done      = false;
    ctx.qkv_tile_idx            = 0;
    ctx.att_ctx_block_idx       = 0;
    ctx.att_value_tile_idx      = 0;
    ctx.active_tile_target      = 1;
    ctx.in_multi_tile_phase     = false;
}

// NOTE: Head &ctx originate outside this logic, so it must be reset outside of it
// 
/*
    FUNCTIONALITY NOTES:
        ctx.compute_done:   Becuase the hardware intention is for this signal to be a pulse, it is
                            the externals logic's responsiblity to hold this signal long enough to be caught 
                            by the if condition that blocks the next phase. LOOK HERE IF HAVING TIMING ISSUES!
*/
// Return: true when ctx reaches DONE and is not waiting on compute; false otherwise.
bool run_single_head(
    HeadCtx &ctx,           // [BOTH]   Persistent head state (phase, flags, last layer stamp, compute handshake bits).
    int      layer_idx,     // [INPUT]: Current layer stamp; if changed, ctx re-initializes to IDLE.
    bool     start          // [INPUT]: Kick from IDLE into Q (independent of compute_ready).
)
{
#pragma HLS INLINE
    // Initialize context if layer changes
    if (ctx.layer_stamp != layer_idx) {
        init_head_ctx(ctx, layer_idx, ctx.head_idx);
    }
    if (ctx.wl_accept && ctx.wl_start){
        ctx.wl_start      = false;
        ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, ctx.head_idx, -1);
    }

    if (!ctx.compute_ready && ctx.compute_start){
        ctx.compute_start = false;
        ctx.compute_op    = pack_compute_op(ComputeOp::CMP_NONE, layer_idx, ctx.head_idx, -1);
    }

    // Sticky capture of compute_done per phase so single-cycle pulses are retained temporarily
    if (ctx.dma_done) {
        if (ctx.q_started          && ctx.last_wl_addr == DmaSel::DMASEL_WQ)    ctx.q_dma_done = true; // ctx.dma_done && ctx.q_started
        if (ctx.k_started          && ctx.last_wl_addr == DmaSel::DMASEL_WK)    ctx.k_dma_done = true;
        if (ctx.k_writeback_started && ctx.last_wl_addr == DmaSel::DMASEL_K_WRITE) ctx.k_writeback_dma_done = true;
        if (ctx.v_started          && ctx.last_wl_addr == DmaSel::DMASEL_WV)    ctx.v_dma_done = true;
        if (ctx.v_writeback_started && ctx.last_wl_addr == DmaSel::DMASEL_V_WRITE) ctx.v_writeback_dma_done = true;
        if (ctx.att_scores_started && ctx.last_wl_addr == DmaSel::DMASEL_CTX_K) ctx.att_scores_dma_done = true;
        if (ctx.att_value_started  && ctx.last_wl_addr == DmaSel::DMASEL_CTX_V) ctx.att_value_dma_done  = true;
    }


    // Sticky capture of compute_done per phase so single-cycle pulses are retained
    if (ctx.compute_done && !ctx.compute_start) {
        const ComputeOp last_op = unpack_compute_op(ctx.last_compute_op);
        if (ctx.q_started && last_op == ComputeOp::CMP_Q)                       ctx.q_compute_done = true;
        if (ctx.k_started && last_op == ComputeOp::CMP_K)                       ctx.k_compute_done = true;
        if (ctx.v_started && last_op == ComputeOp::CMP_V)                       ctx.v_compute_done = true;
        if (ctx.att_scores_started && last_op == ComputeOp::CMP_ATT_SCORES)     ctx.att_scores_compute_done = true;
        if (ctx.val_scale_started && last_op == ComputeOp::CMP_VALUE_SCALE)     ctx.val_scale_compute_done  = true;
        if (ctx.softmax_started && last_op == ComputeOp::CMP_SOFTMAX)           ctx.softmax_compute_done    = true;
        if (ctx.att_value_started && last_op == ComputeOp::CMP_ATT_VALUE)       ctx.att_value_compute_done  = true;
        if (ctx.head_requant_started && last_op == ComputeOp::CMP_HEAD_REQUANT)         ctx.head_requant_compute_done   = true;
    }

    // Drive phase machine
    switch (ctx.phase) {
        case HeadPhase::IDLE: { // wait for explicit start to kick off Q
            if (start) {
                // Clear any stale handshakes when starting a new sequence
                ctx.compute_ready = false;
                ctx.compute_done  = false;
                ctx.compute_start = false;
                ctx.wl_start      = false;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, ctx.head_idx, -1);
                ctx.q_started = false;
                ctx.k_started = false;
                ctx.v_started = false;
                ctx.att_scores_started = false;
                ctx.val_scale_started  = false;
                ctx.softmax_started    = false;
                ctx.att_value_started  = false;
                ctx.k_writeback_started = false;
                ctx.v_writeback_started = false;
                ctx.head_requant_started   = false;
                ctx.q_compute_done          = false;
                ctx.k_compute_done          = false;
                ctx.v_compute_done          = false;
                ctx.att_scores_compute_done = false;
                ctx.val_scale_compute_done  = false;
                ctx.softmax_compute_done    = false;
                ctx.att_value_compute_done  = false;
                ctx.head_requant_compute_done   = false;
                ctx.q_dma_done          = false;
                ctx.k_dma_done          = false;
                ctx.k_writeback_dma_done = false;
                ctx.v_dma_done          = false;
                ctx.v_writeback_dma_done = false;
                ctx.att_scores_dma_done = false;
                ctx.att_value_dma_done  = false;
                ctx.qkv_tile_idx = 0;
                ctx.att_ctx_block_idx = 0;
                ctx.att_value_tile_idx = 0;
                end_tile_phase(ctx);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_NONE, layer_idx, ctx.head_idx, -1);
                ctx.last_wl_addr  = DmaSel::DMASEL_NONE;
                ctx.phase = HeadPhase::Q;

                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, ctx.head_idx, -1);
            }
            break;
        }
        case HeadPhase::Q: { // Q — per-tile DMA (ATT_SCORES pattern)
            if (!ctx.q_started && ctx.wl_ready) {
                if (ctx.qkv_tile_idx == 0) {
                    begin_tile_phase(ctx, NUM_QKV_HEAD_TILES);
                }
                ctx.wl_start = true;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_WQ, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
                ctx.last_wl_addr = DmaSel::DMASEL_WQ;
                ctx.q_started = true;
                ctx.q_dma_done = false;
                ctx.q_compute_done = false;
            }

            else if (ctx.q_started && ctx.compute_ready &&
                     !ctx.compute_start && ctx.q_dma_done &&
                     !ctx.q_compute_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_Q, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_Q, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
            } else if (ctx.q_compute_done && ctx.q_started) {
                ctx.q_started = false;
                ctx.q_compute_done = false;
                ctx.q_dma_done = false;
                if (ctx.qkv_tile_idx + 1 < NUM_QKV_HEAD_TILES) {
                    ctx.qkv_tile_idx++;
                } else {
                    ctx.phase = HeadPhase::K;
                    ctx.qkv_tile_idx = 0;
                    end_tile_phase(ctx);
                }
            }
            break;
        }
        case HeadPhase::K: { // K — per-tile DMA (ATT_SCORES pattern)
            if (!ctx.k_started && ctx.wl_ready) {
                if (ctx.qkv_tile_idx == 0) {
                    begin_tile_phase(ctx, NUM_QKV_HEAD_TILES);
                }
                ctx.wl_start = true;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_WK, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
                ctx.last_wl_addr = DmaSel::DMASEL_WK;
                ctx.k_started = true;
                ctx.k_dma_done = false;
                ctx.k_compute_done = false;
            }

            else if (ctx.k_started && ctx.compute_ready &&
                     !ctx.compute_start && ctx.k_dma_done &&
                     !ctx.k_compute_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_K, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_K, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
            } else if (ctx.k_compute_done && ctx.k_started) {
                ctx.k_started = false;
                ctx.k_compute_done = false;
                ctx.k_dma_done = false;
                if (ctx.qkv_tile_idx + 1 < NUM_QKV_HEAD_TILES) {
                    ctx.qkv_tile_idx++;
                } else {
                    ctx.phase = HeadPhase::K_WRITEBACK;
                    ctx.qkv_tile_idx = 0;
                    end_tile_phase(ctx);
                }
            }
            break;
        }
        case HeadPhase::K_WRITEBACK: {
            if (ctx.wl_ready && !ctx.k_writeback_started) {
                ctx.wl_start = true;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_K_WRITE, layer_idx, ctx.head_idx, -1);
                ctx.last_wl_addr = DmaSel::DMASEL_K_WRITE;
                ctx.k_writeback_started = true;
            } else if (ctx.k_writeback_dma_done && ctx.k_writeback_started) {
                ctx.phase = HeadPhase::V;
                ctx.k_writeback_started = false;
            }
            break;
        }
        case HeadPhase::V: { // V — per-tile DMA (ATT_SCORES pattern)
            if (!ctx.v_started && ctx.wl_ready) {
                if (ctx.qkv_tile_idx == 0) {
                    begin_tile_phase(ctx, NUM_QKV_HEAD_TILES);
                }
                ctx.wl_start = true;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_WV, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
                ctx.last_wl_addr = DmaSel::DMASEL_WV;
                ctx.v_started = true;
                ctx.v_dma_done = false;
                ctx.v_compute_done = false;
            }

            else if (ctx.v_started && ctx.compute_ready &&
                     !ctx.compute_start && ctx.v_dma_done &&
                     !ctx.v_compute_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_V, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_V, layer_idx, ctx.head_idx, ctx.qkv_tile_idx);
            } else if (ctx.v_compute_done && ctx.v_started) {
                ctx.v_started = false;
                ctx.v_compute_done = false;
                ctx.v_dma_done = false;
                if (ctx.qkv_tile_idx + 1 < NUM_QKV_HEAD_TILES) {
                    ctx.qkv_tile_idx++;
                } else {
                    ctx.phase = HeadPhase::V_WRITEBACK;
                    ctx.qkv_tile_idx = 0;
                    end_tile_phase(ctx);
                }
            }
            break;
        }
        case HeadPhase::V_WRITEBACK: {
            if (ctx.wl_ready && !ctx.v_writeback_started) {
                ctx.wl_start = true;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_V_WRITE, layer_idx, ctx.head_idx, -1);
                ctx.last_wl_addr = DmaSel::DMASEL_V_WRITE;
                ctx.v_writeback_started = true;
            } else if (ctx.v_writeback_dma_done && ctx.v_writeback_started) {
                ctx.phase = HeadPhase::ATT_SCORES;
                ctx.v_writeback_started = false;
            }
            break;
        }
        case HeadPhase::ATT_SCORES: {
            if (!ctx.att_scores_started && ctx.wl_ready) {
                if (ctx.att_ctx_block_idx == 0) {
                    begin_tile_phase(ctx, NUM_ATT_CTX_BLOCKS);
                }
                ctx.wl_start = true;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_CTX_K, layer_idx, ctx.head_idx, ctx.att_ctx_block_idx);
                ctx.last_wl_addr = DmaSel::DMASEL_CTX_K;
                ctx.att_scores_started = true;
                ctx.att_scores_dma_done = false;
                ctx.att_scores_compute_done = false;
            }

            else if (ctx.att_scores_started && ctx.compute_ready &&
                     !ctx.compute_start && ctx.att_scores_dma_done &&
                     !ctx.att_scores_compute_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_ATT_SCORES, layer_idx, ctx.head_idx, ctx.att_ctx_block_idx);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_ATT_SCORES, layer_idx, ctx.head_idx, ctx.att_ctx_block_idx);
            } else if (ctx.att_scores_compute_done && ctx.att_scores_started) {
                ctx.att_scores_started = false;
                ctx.att_scores_compute_done = false;
                ctx.att_scores_dma_done = false;
                if (ctx.att_ctx_block_idx + 1 < NUM_ATT_CTX_BLOCKS) {
                    ctx.att_ctx_block_idx++;
                } else {
                    ctx.phase = HeadPhase::VALUE_SCALE_CLAMP;
                    ctx.att_ctx_block_idx = 0;
                    end_tile_phase(ctx);
                }
            }
            break;
        }
        case HeadPhase::VALUE_SCALE_CLAMP: {
            if (ctx.compute_ready && !ctx.compute_start && !ctx.val_scale_started) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_VALUE_SCALE, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_VALUE_SCALE, layer_idx, ctx.head_idx, -1);
                ctx.val_scale_started = true;
            } else if (ctx.val_scale_compute_done && ctx.val_scale_started) {
                ctx.phase = HeadPhase::ATT_SOFTMAX;
                ctx.val_scale_started = false;
            }
            break;
        }
        case HeadPhase::ATT_SOFTMAX: {
            if (ctx.compute_ready && !ctx.compute_start && !ctx.softmax_started) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_SOFTMAX, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_SOFTMAX, layer_idx, ctx.head_idx, -1);
                ctx.softmax_started = true;
            } else if (ctx.softmax_compute_done && ctx.softmax_started) {
                ctx.phase = HeadPhase::ATT_VALUE;
                ctx.softmax_started = false;
            }
            break;
        }
        case HeadPhase::ATT_VALUE: { // ATT_VALUE — per-tile DMA over d_heads (ATT_SCORES pattern)
            if (!ctx.att_value_started && ctx.wl_ready) {
                if (ctx.att_value_tile_idx == 0) {
                    begin_tile_phase(ctx, NUM_ATT_VALUE_HEAD_TILES);
                }
                ctx.wl_start = true;
                ctx.wl_instruction = pack_dma_op(DmaSel::DMASEL_CTX_V, layer_idx, ctx.head_idx, ctx.att_value_tile_idx);
                ctx.last_wl_addr = DmaSel::DMASEL_CTX_V;
                ctx.att_value_started = true;
                ctx.att_value_dma_done = false;
                ctx.att_value_compute_done = false;
            }

            else if (ctx.att_value_started && ctx.compute_ready &&
                     !ctx.compute_start && ctx.att_value_dma_done &&
                     !ctx.att_value_compute_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_ATT_VALUE, layer_idx, ctx.head_idx, ctx.att_value_tile_idx);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_ATT_VALUE, layer_idx, ctx.head_idx, ctx.att_value_tile_idx);
            } else if (ctx.att_value_compute_done && ctx.att_value_started) {
                ctx.att_value_started = false;
                ctx.att_value_compute_done = false;
                ctx.att_value_dma_done = false;
                if (ctx.att_value_tile_idx + 1 < NUM_ATT_VALUE_HEAD_TILES) {
                    ctx.att_value_tile_idx++;
                } else {
                    ctx.phase = HeadPhase::HEAD_REQUANT;
                    ctx.att_value_tile_idx = 0;
                    end_tile_phase(ctx);
                }
            }
            break;
        }
        case HeadPhase::HEAD_REQUANT: {
            if (ctx.compute_ready && !ctx.compute_start && !ctx.head_requant_started) {
                ctx.compute_start   = true;
                ctx.compute_op      = pack_compute_op(ComputeOp::CMP_HEAD_REQUANT, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_HEAD_REQUANT, layer_idx, ctx.head_idx, -1);
                ctx.head_requant_started = true;
                end_tile_phase(ctx);
            } else if (ctx.head_requant_compute_done && ctx.head_requant_started) {
                ctx.phase = HeadPhase::DONE;
                ctx.head_requant_started = false;
            }
            break;
        }
        case HeadPhase::DONE: // DONE
            break;
        default:
            break;
    }

    return (ctx.phase == HeadPhase::DONE);
}



bool drive_group_head_phase(
    HeadCtx     (&head_ctx_ref)[HEADS_PARALLEL], // [BOTH]: Active lane context array
    int         group_base,                      // [INPUT]: Base head index of active group
    int         layer_idx,                      // [INPUT]: Current Layer ID
    bool        start                           // [INPUT]: Start the driving phase
){
#pragma HLS INLINE

    bool group_finished = true; // assume finished unless any head is still active

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
// #pragma HLS UNROLL
        HeadCtx &ctx = head_ctx_ref[lane];

        int abs_head = ctx.head_idx;
        if (abs_head < 0) {
            abs_head = group_base + lane;
        }
        if (abs_head < 0 || abs_head >= NUM_HEADS) {
            ctx.start_head = false;
            continue;
        }
        ctx.head_idx = abs_head;

        // One-cycle start pulse only when idle
        ctx.start_head = start && (ctx.phase == HeadPhase::IDLE);

        if (ctx.phase != HeadPhase::DONE) {
            const bool head_done = run_single_head(
                ctx,
                layer_idx,
                ctx.start_head);
            if (!head_done) group_finished = false;
        }

        
    }
    return group_finished;
}
