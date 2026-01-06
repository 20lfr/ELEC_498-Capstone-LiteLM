// Simplified, single-head helper flow that only exercises compute.
// Each head has its own "resource" (no shared arbitration).
#include "head_helpers.hpp"
#include "../../../Weight_Loader-Stager/Weight_stager.hpp"

static inline uint32_t pack_compute_op(ComputeOp op, int layer, int head, int tile) {
    #pragma HLS INLINE
    const uint32_t op_field = static_cast<uint32_t>(op) & 0xFFu;
    const uint32_t layer_field = static_cast<uint32_t>(layer) & 0xFFu;
    const uint32_t head_field = static_cast<uint32_t>(head) & 0xFFu;
    const uint32_t tile_field = static_cast<uint32_t>(tile) & 0xFFu;
    return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}

static inline ComputeOp unpack_compute_op(uint32_t packed_op) {
    #pragma HLS INLINE
    return static_cast<ComputeOp>(packed_op & 0xFFu);
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
    ctx.wl_start      = false;
    ctx.wl_addr_sel   = DmaSel::DMASEL_NONE;
    ctx.wl_layer      = -1;
    ctx.wl_head       = -1;
    ctx.dma_done      = false;
    ctx.start_head    = false;
    ctx.q_started          = false;
    ctx.k_started          = false;
    ctx.v_started          = false;
    ctx.att_scores_started = false;
    ctx.val_scale_started  = false;
    ctx.softmax_started    = false;
    ctx.att_value_started  = false;
    ctx.k_requant_started  = false;
    ctx.v_requant_started  = false;
    ctx.requant_q_started  = false;
    ctx.requant2_started   = false;

    ctx.q_compute_done          = false;
    ctx.k_compute_done          = false;
    ctx.v_compute_done          = false;
    ctx.att_scores_compute_done = false;
    ctx.val_scale_compute_done  = false;
    ctx.softmax_compute_done    = false;
    ctx.att_value_compute_done  = false;
    ctx.k_requant_compute_done  = false;
    ctx.v_requant_compute_done  = false;
    ctx.requant_q_compute_done  = false;
    ctx.requant2_compute_done   = false;
    ctx.q_dma_done              = false;
    ctx.k_dma_done              = false;
    ctx.v_dma_done              = false;
    ctx.att_scores_dma_done     = false;
    ctx.att_value_dma_done      = false;
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
    bool     start,          // [INPUT]: Kick from IDLE into Q (independent of compute_ready).
    ControlMemSpace ctrl_mem,  // [BOTH]: Control memory space for WL
    bool     &error         // [OUTPUT]: Error flag from weight_stager
)
{
#pragma HLS INLINE
    // Initialize context if layer changes
    if (ctx.layer_stamp != layer_idx) {
        init_head_ctx(ctx, layer_idx, ctx.head_idx);
    }
    if (!ctx.wl_ready && ctx.wl_start){
        ctx.wl_start      = false;
        ctx.wl_addr_sel   = DmaSel::DMASEL_NONE;
    }

    if (!ctx.compute_ready && ctx.compute_start){
        ctx.compute_start = false;
        ctx.compute_op    = pack_compute_op(ComputeOp::CMP_NONE, layer_idx, ctx.head_idx, -1);
    }

    // Sticky capture of compute_done per phase so single-cycle pulses are retained temporarily
    if (ctx.dma_done && !ctx.wl_start) {
        if (ctx.q_started          && ctx.last_wl_addr == DmaSel::DMASEL_WQ)    ctx.q_dma_done = true; // ctx.dma_done && ctx.q_started
        if (ctx.k_started          && ctx.last_wl_addr == DmaSel::DMASEL_WK)    ctx.k_dma_done = true;
        if (ctx.v_started          && ctx.last_wl_addr == DmaSel::DMASEL_WV)    ctx.v_dma_done = true;
        if (ctx.att_scores_started && ctx.last_wl_addr == DmaSel::DMASEL_CTX_K) ctx.att_scores_dma_done = true;
        if (ctx.att_value_started  && ctx.last_wl_addr == DmaSel::DMASEL_CTX_V) ctx.att_value_dma_done  = true;
    } else {
        if (ctx.q_started)          ctx.q_dma_done = false;
        if (ctx.k_started)          ctx.k_dma_done = false;
        if (ctx.v_started)          ctx.v_dma_done = false;
        if (ctx.att_scores_started) ctx.att_scores_dma_done = false;
        if (ctx.att_value_started)  ctx.att_value_dma_done  = false;
    }


    // Sticky capture of compute_done per phase so single-cycle pulses are retained
    if (ctx.compute_done && !ctx.compute_start) {
        const ComputeOp last_op = unpack_compute_op(ctx.last_compute_op);
        if (ctx.q_started && last_op == ComputeOp::CMP_Q)                       ctx.q_compute_done = true;
        if (ctx.k_started && last_op == ComputeOp::CMP_K)                       ctx.k_compute_done = true;
        if (ctx.k_requant_started && last_op == ComputeOp::CMP_K_REQUANT)       ctx.k_requant_compute_done  = true;
        if (ctx.v_started && last_op == ComputeOp::CMP_V)                       ctx.v_compute_done = true;
        if (ctx.v_requant_started && last_op == ComputeOp::CMP_V_REQUANT)       ctx.v_requant_compute_done  = true;
        if (ctx.requant_q_started && last_op == ComputeOp::CMP_REQUANT_Q)       ctx.requant_q_compute_done  = true;
        if (ctx.att_scores_started && last_op == ComputeOp::CMP_ATT_SCORES)     ctx.att_scores_compute_done = true;
        if (ctx.val_scale_started && last_op == ComputeOp::CMP_VALUE_SCALE)     ctx.val_scale_compute_done  = true;
        if (ctx.softmax_started && last_op == ComputeOp::CMP_SOFTMAX)           ctx.softmax_compute_done    = true;
        if (ctx.att_value_started && last_op == ComputeOp::CMP_ATT_VALUE)       ctx.att_value_compute_done  = true;
        if (ctx.requant2_started && last_op == ComputeOp::CMP_REQUANT2)         ctx.requant2_compute_done   = true;
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
                ctx.wl_addr_sel   = DmaSel::DMASEL_NONE;
                ctx.q_started = false;
                ctx.k_started = false;
                ctx.v_started = false;
                ctx.att_scores_started = false;
                ctx.val_scale_started  = false;
                ctx.softmax_started    = false;
                ctx.att_value_started  = false;
                ctx.k_requant_started  = false;
                ctx.v_requant_started  = false;
                ctx.requant_q_started  = false;
                ctx.requant2_started   = false;
                ctx.q_compute_done          = false;
                ctx.k_compute_done          = false;
                ctx.v_compute_done          = false;
                ctx.att_scores_compute_done = false;
                ctx.val_scale_compute_done  = false;
                ctx.softmax_compute_done    = false;
                ctx.att_value_compute_done  = false;
                ctx.k_requant_compute_done  = false;
                ctx.v_requant_compute_done  = false;
                ctx.requant_q_compute_done  = false;
                ctx.requant2_compute_done   = false;
                ctx.q_dma_done          = false;
                ctx.k_dma_done          = false;
                ctx.v_dma_done          = false;
                ctx.att_scores_dma_done = false;
                ctx.att_value_dma_done  = false;
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_NONE, layer_idx, ctx.head_idx, -1);
                ctx.last_wl_addr  = DmaSel::DMASEL_NONE;
                ctx.phase = HeadPhase::Q;

                ctx.wl_layer = layer_idx;
                ctx.wl_head = ctx.head_idx;
            }
            break;
        }
        case HeadPhase::Q: { // Q
            if (ctx.wl_ready && !ctx.q_started){
                ctx.wl_start = true;
                ctx.wl_addr_sel = DmaSel::DMASEL_WQ;
                ctx.last_wl_addr = DmaSel::DMASEL_WQ;
                ctx.q_started = true;
            }
            
            else if (ctx.compute_ready && ctx.q_dma_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_Q, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_Q, layer_idx, ctx.head_idx, -1);
            }
            else if (ctx.q_compute_done && ctx.q_started) {
                ctx.phase = HeadPhase::K;
                ctx.q_started = false;
            }
            break;
        }
        case HeadPhase::K: {// K 
            if (ctx.wl_ready && !ctx.k_started) {
                ctx.wl_start = true;
                ctx.wl_addr_sel = DmaSel::DMASEL_WK;
                ctx.last_wl_addr = DmaSel::DMASEL_WK;
                ctx.k_started = true;
            }

            else if (ctx.compute_ready && ctx.k_dma_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_K, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_K, layer_idx, ctx.head_idx, -1);
            }
            else if (ctx.k_compute_done && ctx.k_started) {
                ctx.phase = HeadPhase::K_REQUANT;
                ctx.k_started = false;            
            }
            break;
        }
        case HeadPhase::K_REQUANT: {
            if (ctx.compute_ready && !ctx.k_requant_started) {
                ctx.compute_start   = true;
                ctx.compute_op      = pack_compute_op(ComputeOp::CMP_K_REQUANT, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_K_REQUANT, layer_idx, ctx.head_idx, -1);
                ctx.k_requant_started = true;
            } else if (ctx.k_requant_compute_done && ctx.k_requant_started) {
                ctx.phase = HeadPhase::K_WRITEBACK;
                ctx.k_requant_started = false;
            }
            break;
        }
        case HeadPhase::K_WRITEBACK: {
            ctx.phase = HeadPhase::V;
            break;
        }
        case HeadPhase::V: {// V
            if (ctx.wl_ready && !ctx.v_started) {
                ctx.wl_start = true;
                ctx.wl_addr_sel = DmaSel::DMASEL_WV;
                ctx.last_wl_addr = DmaSel::DMASEL_WV;
                ctx.v_started = true;
            }

            else if (ctx.compute_ready && ctx.v_dma_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_V, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_V, layer_idx, ctx.head_idx, -1);
            }
            else if (ctx.v_compute_done && ctx.v_started) {
                ctx.phase = HeadPhase::V_REQUANT;
                ctx.v_started = false;
            }
            break;
        }
        case HeadPhase::V_REQUANT: {
            if (ctx.compute_ready && !ctx.v_requant_started) {
                ctx.compute_start   = true;
                ctx.compute_op      = pack_compute_op(ComputeOp::CMP_V_REQUANT, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_V_REQUANT, layer_idx, ctx.head_idx, -1);
                ctx.v_requant_started = true;
            } else if (ctx.v_requant_compute_done && ctx.v_requant_started) {
                ctx.phase = HeadPhase::V_WRITEBACK;
                ctx.v_requant_started = false;
            }
            break;
        }
        case HeadPhase::V_WRITEBACK: {
            ctx.phase = HeadPhase::REQUANT_Q;
            break;
        }
        case HeadPhase::REQUANT_Q: {
            if (ctx.compute_ready && !ctx.requant_q_started) {
                ctx.compute_start   = true;
                ctx.compute_op      = pack_compute_op(ComputeOp::CMP_REQUANT_Q, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_REQUANT_Q, layer_idx, ctx.head_idx, -1);
                ctx.requant_q_started = true;
            } else if (ctx.requant_q_compute_done && ctx.requant_q_started) {
                ctx.phase = HeadPhase::ATT_SCORES;
                ctx.requant_q_started = false;
            }
            break;
        }
        case HeadPhase::ATT_SCORES: {
            if (ctx.wl_ready && !ctx.att_scores_started) {
                ctx.wl_start = true;
                ctx.wl_addr_sel = DmaSel::DMASEL_CTX_K;
                ctx.last_wl_addr = DmaSel::DMASEL_CTX_K;
                ctx.att_scores_started = true;
            }

            else if (ctx.compute_ready && ctx.att_scores_dma_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_ATT_SCORES, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_ATT_SCORES, layer_idx, ctx.head_idx, -1);
            } else if (ctx.att_scores_compute_done && ctx.att_scores_started) {
                ctx.phase = HeadPhase::VALUE_SCALE_CLAMP;
                ctx.att_scores_started = false;
            }
            break;
        }
        case HeadPhase::VALUE_SCALE_CLAMP: {
            if (ctx.compute_ready && !ctx.val_scale_started) {
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
            if (ctx.compute_ready && !ctx.softmax_started) {
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
        case HeadPhase::ATT_VALUE: {
            if (ctx.wl_ready && !ctx.att_value_started) {
                ctx.wl_start = true;
                ctx.wl_addr_sel = DmaSel::DMASEL_CTX_V;
                ctx.last_wl_addr = DmaSel::DMASEL_CTX_V;
                ctx.att_value_started = true;
            }

            else if (ctx.compute_ready && ctx.att_value_dma_done) {
                ctx.compute_start = true;
                ctx.compute_op    = pack_compute_op(ComputeOp::CMP_ATT_VALUE, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_ATT_VALUE, layer_idx, ctx.head_idx, -1);
            } else if (ctx.att_value_compute_done && ctx.att_value_started) {
                ctx.phase = HeadPhase::REQUANT2;
                ctx.att_value_started = false;
            }
            break;
        }
        case HeadPhase::REQUANT2: {
            if (ctx.compute_ready && !ctx.requant2_started) {
                ctx.compute_start   = true;
                ctx.compute_op      = pack_compute_op(ComputeOp::CMP_REQUANT2, layer_idx, ctx.head_idx, -1);
                ctx.last_compute_op = pack_compute_op(ComputeOp::CMP_REQUANT2, layer_idx, ctx.head_idx, -1);
                ctx.requant2_started = true;
            } else if (ctx.requant2_compute_done && ctx.requant2_started) {
                ctx.phase = HeadPhase::DONE;
                ctx.requant2_started = false;
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
    HeadCtx     (&head_ctx_ref)[HEADS_PARALLEL], // [BOTH]:  Tracks current group only
    int         base_head_idx,                  // [INPUT]: Global base index of this group
    int         layer_idx,                      // [INPUT]: Current Layer ID
    bool        start,                          // [INPUT]: Start the driving phase
    ControlMemSpace ctrl_mem,                   // [INPUT]: Control memory space for WL
    bool     &error                             // [OUTPUT]: Error flag from weight_stager
){
#pragma HLS ARRAY_PARTITION variable=head_ctx_ref complete dim=1
    (void)base_head_idx; // placeholder until per-lane re-init uses this

    bool group_finished = true; // assume finished unless any head is still active

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        HeadCtx &ctx = head_ctx_ref[lane]; // Current head in this group

        // Re-init when this lane targets a new head or layer
        // if (ctx.head_idx != lane_head_idx || ctx.layer_stamp != layer_idx) {
        //     init_head_ctx(ctx, layer_idx, lane_head_idx);
        // }

        // One-cycle start pulse only when idle
        ctx.start_head = start && (ctx.phase == HeadPhase::IDLE);

        if (ctx.phase != HeadPhase::DONE) {
            const bool head_done = run_single_head(
                ctx,
                layer_idx,
                ctx.start_head,
                ctrl_mem,
                error);
            if (!head_done) group_finished = false;
        }

        
    }
    return group_finished;
}
