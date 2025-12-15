// Declarations for head helper utilities (compute-only).
#pragma once
#include <cstdint>

constexpr int NUM_HEADS      = 4;
constexpr int HEADS_PARALLEL = 2;

enum class HeadPhase : uint8_t {
    IDLE = 0,          // 0
    Q,                 // 1
    K,                 // 2
    K_REQUANT,         // 3
    K_WRITEBACK,       // 4
    V,                 // 5
    V_REQUANT,         // 6
    V_WRITEBACK,       // 7
    REQUANT_Q,         // 8
    ATT_SCORES,        // 9
    VALUE_SCALE_CLAMP, // 10
    ATT_SOFTMAX,       // 11
    ATT_VALUE,         // 12
    REQUANT2,          // 13
    DONE               // 14
};

enum ComputeOp : uint8_t {
    CMP_NONE = 0,           // 0 
    CMP_Q,                  // 1
    CMP_K,                  // 2
    CMP_K_REQUANT,          // 3
    CMP_V,                  // 4
    CMP_V_REQUANT,          // 5
    CMP_REQUANT_Q,          // 6
    CMP_ATT_SCORES,         // 7
    CMP_VALUE_SCALE,        // 8
    CMP_SOFTMAX,            // 9
    CMP_ATT_VALUE,          // 10
    CMP_REQUANT2,           // 11
    // Scheduler-level ops
    CMP_HEAD_REQUANT,       // 12
    CMP_CONCAT,             // 13
    CMP_OUT_PROJ,           // 14
    CMP_REQUANT1,           // 15
    CMP_RESID0,             // 16
    CMP_LN0,                // 17
    CMP_REQUANT3,           // 18
    CMP_FFN_W1,             // 19
    CMP_FFN_ACT,            // 20
    CMP_FFN_W2,             // 21
    CMP_REQUANT4,           // 22
    CMP_RESID1,             // 23
    CMP_LN1,                // 24
    CMP_DEQUANT,            // 25
    CMP_LOGITS,             // 26
    // LayerNorm micro-ops (three-phase: reduction, scalar, elementwise)
    // LayerNorm fine-grain micro-ops (per-step)
    CMP_LN0_SUM,            // 27
    CMP_LN0_SUMSQ,          // 28
    CMP_LN0_MEAN,           // 29
    CMP_LN0_EYY,            // 30
    CMP_LN0_VAR,            // 31
    CMP_LN0_VAR_EPS,        // 32
    CMP_LN0_INV_STD,        // 33
    CMP_LN0_NORM,           // 34
    CMP_LN0_SCALE,          // 35
    CMP_LN0_SHIFT,          // 36
    CMP_LN1_SUM,            // 37
    CMP_LN1_SUMSQ,          // 38
    CMP_LN1_MEAN,           // 39
    CMP_LN1_EYY,            // 40
    CMP_LN1_VAR,            // 41
    CMP_LN1_VAR_EPS,        // 42
    CMP_LN1_INV_STD,        // 43
    CMP_LN1_NORM,           // 44
    CMP_LN1_SCALE,          // 45
    CMP_LN1_SHIFT           // 46
};

enum DmaSel : uint8_t {
    DMASEL_NONE = 0,    // 0
    DMASEL_WQ,          // 1
    DMASEL_WK,          // 2
    DMASEL_WV,          // 3
    DMASEL_CTX_K,       // 4
    DMASEL_CTX_V,       // 5
    DMASEL_K_WRITE,     // 6
    DMASEL_V_WRITE,     // 7
    DMASEL_WO,          // 8
    DMASEL_W1,          // 9
    DMASEL_W2,          // 10
    DMASEL_WLOGIT       // 11
};

struct HeadCtx {
    int  layer_stamp   = -1;
    int  head_idx      = -1;
    HeadPhase  phase   = HeadPhase::IDLE; // start idle, then Q/K/V/DONE
    bool compute_ready = false;
    bool compute_done  = false;
    bool compute_start = false;
    ComputeOp  compute_op    = ComputeOp::CMP_NONE;
    ComputeOp  last_compute_op = ComputeOp::CMP_NONE; // Tracks last issued compute to gate done pulses
    DmaSel     last_wl_addr  = DmaSel::DMASEL_NONE;   // Tracks last issued WL request for dma_done attribution

    bool    wl_ready    = false;                  // INPUT FROM WL 
    bool    wl_start    = false;                  // OUTPUT signal for head
    DmaSel  wl_addr_sel = DmaSel::DMASEL_NONE; // OUTPUT signal for head
    int     wl_layer    = -1;                      // OUTPUT signal for head
    int     wl_head     = -1;                      // OUTPUT signal for head
    bool    dma_done    = false;                  // INPUT FROM WL 


    bool start_head = false;

    // Per-head bookkeeping for started phases
    bool q_started          = false;
    bool k_started          = false;
    bool k_requant_started  = false;
    bool v_started          = false;
    bool v_requant_started  = false;
    bool requant_q_started  = false;
    bool att_scores_started = false;
    bool val_scale_started  = false;
    bool softmax_started    = false;
    bool att_value_started  = false;
    bool requant2_started   = false;

    bool q_compute_done          = false;
    bool k_compute_done          = false;
    bool k_requant_compute_done  = false;
    bool v_compute_done          = false;
    bool v_requant_compute_done  = false;
    bool requant_q_compute_done  = false;
    bool att_scores_compute_done = false;
    bool val_scale_compute_done  = false;
    bool softmax_compute_done    = false;
    bool att_value_compute_done  = false;
    bool requant2_compute_done   = false;

    bool q_dma_done          = false;
    bool k_dma_done          = false;
    bool v_dma_done          = false;
    bool att_scores_dma_done = false;
    bool att_value_dma_done  = false;
};

void init_head_ctx(HeadCtx &ctx, int layer_idx, int head_idx);

// Single-head driver: issues compute_start when ready, advances on compute_done.
// Returns true when the head reaches DONE and is not waiting on compute.
bool run_single_head(
    HeadCtx     &ctx,
    int         layer_idx,
    bool        start
);

bool drive_group_head_phase(
    HeadCtx     (&head_ctx_ref)[HEADS_PARALLEL],
    int         group_idx,
    int         layer_idx,
    bool        start
);
