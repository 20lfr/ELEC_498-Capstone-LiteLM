#pragma once
#include <cstdint>


/*
README: 
        This file contains all the enums, structs and constant expressions required accross all modules
*/

/*
Model Features:=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
d_model  = 2048 params 
Total Parameters: 1.1 billion
Hidden Size ($d_{model}$): 2048
Number of Layers: 22
Number of Attention Heads: 32
Intermediate Size: 5504 
(This is the size of the hidden layer in the Feed-Forward Network).

(int8) Residual size   = 2048 values -> 16 Kb (16,384 bits)
(int4) Head size       = per-head Q/K/V weights: 2048 x 64 -> 131,072 weights -> 524,288 bits (512 Kb ≈ 0.5 Mb)
(int4) Head concat     = 32 heads (activations) -> 8 Kb (8,192 bits)
(int4) WQ dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) WK dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) WV dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) WO dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) W1 dimensions   = 2048 x 5504 -> 11,272,192 weights -> 45,088,768 bits (44,064 Kb ≈ 44.064 Mb)
(int4) W2 dimensions   = 5504 x 2048 -> 11,272,192 weights -> 45,088,768 bits (44,064 Kb ≈ 44.064 Mb)

Tiling Methods:
WO per tile = 2048 x 2048 -> 2048 x 64 (32 tiles)
W1 per tile = 2048 x 5504 -> 2048 x 64 (86 tiles)
W2 per tile = 5504 x 2048 -> 5504 x 64 (32 tiles)

URAM Features:=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
URAM total: 64 blocks × 288 Kb ≈ 18.4 Mb total on-chip URAM
Per Block : 288Kb ≈ 0.28125 Mb

== Tiles/Heads ==
Per Head     : 2 Blocks per head
Per Tile W0  : 2 Blocks per tile
Per Tile W1  : 2 blocks per tile
Per Tile W2  : 5 blocks per tile

== KV Cache ==
L = context window size
Per head:  
    K_cache_head = [L × 64] int8  
    V_cache_head = [L × 64] int8
All heads:  
    K_cache = [32 × L × 64] int8  
    V_cache = [32 × L × 64] int8

BRAM Features::=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BRAM total: 144 blocks × 36 Kb ≈ 5.1 Mb total on-chip BRAM

======================  ATTENTION PIPELINE  ======================
== Phase 0: Input / Residual ==
Stored:  x_in                = [2048] int8
Compute: int8 loaded into MACs

== Phase 1: Q/K/V Projections ==
Compute: int8 * int4 -> int32 accum (64 accs per head)
Stored per head:  
    Q_head = [64] int8  
    K_head = [64] int8  
    V_head = [64] int8
Stored all heads (optional):  
    Q_all = [2048] int8  
    K_all = [2048] int8  
    V_all = [2048] int8

== Phase 2: Attention Scores (QKᵀ) ==
Input: Q_head_now = [64] int8  
       K_cache_head = [L × 64] int8
Compute: dot(64) → int32 accum → clamp to int16 accum for softmax later
Stored: scores_head = [L] int16

== Phase 3: Scaling + Softmax ==
Input:              scores_head = [L] int16
Stored (Output):    probs_head = [L] int16

== Phase 4: Value Aggregation (S·V) ==
Input: probs_head = [L] int16  
       V_cache_head = [L × 64] int8
Compute: per-dim accumulate → int32
Stored per head: out_head = [64] int8
Stored concat:   attn_out = [2048] int8

== Phase 5: Output Projection (WO) ==
Input: attn_out = [2048] int8
Compute: int8 * int4 → int32 accum
Stored: attn_proj = [2048] int8
Final residual add: x_out = [2048] int8


======================  FEED-FORWARD NETWORK  ======================
== Phase 7: W1 Projection ==
Input: x_out = [2048] int8
Compute: int8 * int4 → int32
Stored: ffn_up = [5504] int8

== Phase 8: Activation (ReLU/GELU) ==
Stored: ffn_act = [5504] int8

== Phase 9: W2 Projection ==
Input: ffn_act = [5504] int8
Compute: int8 * int4 → int32
Stored: ffn_down = [2048] int8

== Phase 10: Residual Output ==
Stored: final_out = [2048] int8


*/




// ------------------------------------------------------------
// Tunable architecture parameters::
// ------------------------------------------------------------
constexpr int NUM_HEADS       = 4;
constexpr int NUM_LAYERS      = 2;
constexpr int NUM_WO_TILES    = 4;
constexpr int NUM_W1_TILES    = 4;
constexpr int NUM_W2_TILES    = 4;
constexpr int NUM_LOGIT_TILES = 2;

// ------------------------------------------------------------
// Scheduler state + helper enums
// ------------------------------------------------------------
enum SchedState {
    S_IDLE,            // 0
    S_STREAM_IN,       // 1
    S_LAYER_COUNT,     // 2
    S_ATTENTION_HEADS, // 3
    S_HEAD_CONCAT,     // 4
    S_OUT_PROJECTION,  // 5
    S_REQUANT1,        // 6
    S_RES_ADD_1,       // 7
    S_LAYER_NORM_1,    // 8
    S_REQUANT2,        // 9
    S_FFN,             // 10
    S_REQUANT3,        // 11
    S_RES_ADD_2,       // 12
    S_LAYER_NORM_2,    // 13
    S_REQUANT4,        // 14
    S_LOOP_CHECK,      // 15
    S_STREAM_OUT       // 16
};

// LayerNorm micro-FSM phases (numbered per algorithm steps)
enum class LnPhase : uint8_t {
    SUM = 0,      // 1) S = sum_i y_i
    SUMSQ,        // 2) Q = sum_i y_i^2
    MEAN,         // 3) mu = S / d
    EYY,          // 4) E[y^2] = Q / d
    VAR,          // 5) sigma2 = E[y^2] - mu^2
    VAR_EPS,      // 6) v = sigma2 + eps
    INV_STD,      // 7) inv_std = 1 / sqrt(v)
    NORM,         // 8) y_hat[i] = (y_i - mu) * inv_std
    SCALE,        // 9) z_i = gamma_i * y_hat[i]
    SHIFT,        // 10) o_i = z_i + beta_i
    DONE
};


// ------------------------------------------------------------
// Headed Attention and FSM enums
// ------------------------------------------------------------
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


// ------------------------------------------------------------
// Control + IRQ bitfields
// ------------------------------------------------------------
// Bit positions: bit0 = reset_n, bit1 = start
constexpr uint32_t CTRL_RESETN_BIT   = 1u << 0;
constexpr uint32_t CTRL_START_BIT    = 1u << 1;

constexpr uint32_t IRQ_CLEAR_BIT      = 1u << 0;
constexpr uint32_t IRQ_ERROR_BIT      = 1u << 1;
constexpr uint32_t IRQ_INFER_DONE_BIT = 1u << 2;

// Status register bits
constexpr uint32_t STATUS_INVALID_ADDR = 1u << 0;
constexpr uint32_t STATUS_INVALID_OP   = 1u << 1;
constexpr uint32_t STATUS_BUSY_BIT     = 1u << 2;


// ------------------------------------------------------------
// Control memory register map (AXI-Lite accessible)
// ------------------------------------------------------------
enum class ControlReg : uint32_t {
    CONTROL         = 0x00, // 0
    LAYER_INDEX     = 0x04, // 1
    STATUS          = 0x08, // 2
    IRQ_STATUS      = 0x0C, // 3
    IRQ_ENABLE      = 0x10, // 4

    DMA_LAYER_LEN   = 0x14, // 5
    DMA_HEAD_LEN    = 0x18, // 6
    DMA_TILE_LEN    = 0x1C, // 7

    LAYER_STRIDE    = 0x20, // 8
    WQ_HEAD_STRIDE  = 0x24, // 9
    WK_HEAD_STRIDE  = 0x28, // 10
    WV_HEAD_STRIDE  = 0x2C, // 11

    K_CACHE_STRIDE  = 0x30, // 12
    V_CACHE_STRIDE  = 0x34, // 13

    WO_TILE_STRIDE  = 0x38, // 14
    W1_TILE_STRIDE  = 0x3C, // 15
    W2_TILE_STRIDE  = 0x40, // 16

    WQ_BASE_ADDR    = 0x44, // 17
    WK_BASE_ADDR    = 0x48, // 18
    WV_BASE_ADDR    = 0x4C, // 19
    WO_BASE_ADDR    = 0x50, // 20
    W1_BASE_ADDR    = 0x54, // 21
    W2_BASE_ADDR    = 0x58, // 22

    K_CACHE_ADDR    = 0x5C, // 23
    V_CACHE_ADDR    = 0x60, // 24

    LOGIT_SCALE_QV  = 0x64, // 25
    SCALE_Q         = 0x68, // 26
    ZERO_POINT_Q    = 0x6C, // 27
    SCALE_K         = 0x70, // 28
    ZERO_POINT_K    = 0x74, // 29
    SCALE_V         = 0x78, // 30
    ZERO_POINT_V    = 0x7C, // 31

    RESERVED_DEBUG  = 0x80  // 32
};

// Structure that mirrors the AXI-lite accessible registers.
struct ControlMemSpace {
    uint32_t control        = CTRL_RESETN_BIT;  // cntrl_reset | cntrl_start
    uint32_t layer_index    = 0;
    uint32_t status         = 0;
    uint32_t irq_status     = 0;                // clear | error | inference_done
    uint32_t irq_enable     = IRQ_CLEAR_BIT | IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT; // clear | error | inference_done 

    uint32_t dma_layer_len  = 0;
    uint32_t dma_head_len   = 0;
    uint32_t dma_tile_len   = 0;

    uint32_t layer_stride   = 0;
    uint32_t wq_head_stride    = 0;
    uint32_t wk_head_stride    = 0;
    uint32_t wv_head_stride    = 0;

    uint32_t k_cache_stride   = 0;
    uint32_t v_cache_stride   = 0;

    uint32_t wo_tile_stride    = 0;
    uint32_t w1_tile_stride    = 0;
    uint32_t w2_tile_stride    = 0;

    uint32_t wq_base_addr   = 0;
    uint32_t wk_base_addr   = 0;
    uint32_t wv_base_addr   = 0;
    uint32_t wo_base_addr   = 0;
    uint32_t w1_base_addr   = 0;
    uint32_t w2_base_addr   = 0;

    uint32_t k_cache_addr   = 0;
    uint32_t v_cache_addr   = 0;

    uint32_t logit_scale_qv = 0;
    uint32_t scale_q        = 0;
    uint32_t zero_point_q   = 0;
    uint32_t scale_k        = 0;
    uint32_t zero_point_k   = 0;
    uint32_t scale_v        = 0;
    uint32_t zero_point_v   = 0;

    uint32_t reserved_debug = 0;
};
