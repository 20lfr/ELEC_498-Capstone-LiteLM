#pragma once
#include <cstdint>
#include <ap_int.h>


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

constexpr int D_MODEL = 192; // Number of heads processed in parallel
constexpr int D_FFN   = 22; // Feed-Forward hidden layer size
constexpr int D_HEADS = D_MODEL / NUM_HEADS; // Number of heads processed in parallel
constexpr int D_TILE_WO  = D_MODEL / NUM_WO_TILES; // Tile size for WO
constexpr int D_TILE_W1  = D_MODEL / NUM_W1_TILES; // Tile size for W1
constexpr int D_TILE_W2  = D_FFN   / NUM_W2_TILES;
constexpr int CONTEXT_LENGTH = 16; // Context window length
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
    S_HEAD_REQUANT,    // 9
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
    HEAD_REQUANT,      // 13
    DONE               // 14
};

enum ComputeOp : uint8_t {
    CMP_NONE = 0, // 0

    // Attention ops
    CMP_Q = 1,          // 1
    CMP_K = 2,          // 2
    CMP_K_REQUANT = 3,  // 3
    CMP_V = 4,          // 4
    CMP_V_REQUANT = 5,  // 5
    CMP_REQUANT_Q = 6,  // 6
    CMP_ATT_SCORES = 7, // 7
    CMP_VALUE_SCALE = 8, // 8
    CMP_SOFTMAX = 9,    // 9
    CMP_ATT_VALUE = 10, // 10

    // Scheduler-level ops
    CMP_HEAD_REQUANT = 11, // 11 (pre-FFN requant)
    // NOTE: opcode 12 reserved (legacy CMP_HEAD_REQUANT).
    CMP_CONCAT = 13,       // 13
    CMP_OUT_PROJ = 14,     // 14
    CMP_REQUANT1 = 15,     // 15
    CMP_RESID0 = 16,       // 16
    CMP_LN0 = 17,          // 17
    CMP_REQUANT3 = 18,     // 18
    CMP_FFN_W1 = 19,       // 19
    CMP_FFN_ACT = 20,      // 20
    CMP_FFN_W2 = 21,       // 21
    CMP_REQUANT4 = 22,     // 22
    CMP_RESID1 = 23,       // 23
    CMP_LN1 = 24,          // 24
    CMP_DEQUANT = 25,      // 25
    CMP_LOGITS = 26,       // 26

    // LayerNorm fine-grain micro-ops (per-step)
    CMP_LN0_SUM = 27,      // 27
    CMP_LN0_SUMSQ = 28,    // 28
    CMP_LN0_MEAN = 29,     // 29
    CMP_LN0_EYY = 30,      // 30
    CMP_LN0_VAR = 31,      // 31
    CMP_LN0_VAR_EPS = 32,  // 32
    CMP_LN0_INV_STD = 33,  // 33
    CMP_LN0_NORM = 34,     // 34
    CMP_LN0_SCALE = 35,    // 35
    CMP_LN0_SHIFT = 36,    // 36
    CMP_LN1_SUM = 37,      // 37
    CMP_LN1_SUMSQ = 38,    // 38
    CMP_LN1_MEAN = 39,     // 39
    CMP_LN1_EYY = 40,      // 40
    CMP_LN1_VAR = 41,      // 41
    CMP_LN1_VAR_EPS = 42,  // 42
    CMP_LN1_INV_STD = 43,  // 43
    CMP_LN1_NORM = 44,     // 44
    CMP_LN1_SCALE = 45,    // 45
    CMP_LN1_SHIFT = 46     // 46
};

enum DmaSel : uint8_t {
    DMASEL_NONE = 0,    // 0
    DMASEL_WQ,          // 1
    DMASEL_WK,          // 2
    DMASEL_K_WRITE,     // 3
    DMASEL_WV,          // 4
    DMASEL_V_WRITE,     // 5
    DMASEL_CTX_K,       // 6
    DMASEL_CTX_V,       // 7
    DMASEL_WO,          // 8
    DMASEL_W1,          // 9
    DMASEL_W2,          // 10
    DMASEL_WLOGIT       // 11
};

enum class ComputeErrorCodes {
    IncorrectRequest, 
    InvalidComputationForamt
};


struct HeadCtx {
    int  layer_stamp   = -1;
    int  head_idx      = -1;
    HeadPhase  phase   = HeadPhase::IDLE; // start idle, then Q/K/V/DONE
    bool compute_ready = false;
    bool compute_done  = false;
    bool compute_start = false;
    uint32_t   compute_op    = 0;
    uint32_t   last_compute_op = 0; // Packed compute op for done gating
    DmaSel     last_wl_addr  = DmaSel::DMASEL_NONE;   // Tracks last issued WL request for dma_done attribution

    bool    wl_ready    = false;                  // INPUT FROM WL 
    bool    wl_start    = false;                  // OUTPUT signal for head
    DmaSel  wl_addr_sel = DmaSel::DMASEL_NONE; // OUTPUT signal for head
    int     wl_layer    = -1;                      // OUTPUT signal for head
    int     wl_head     = -1;                      // OUTPUT signal for head
    bool    dma_done    = false;                  // INPUT FROM AXI-FULL 

    bool start_head = false;

    // Per-head bookkeeping for started phases
    bool q_started          = false;
    bool k_started          = false;
    bool k_requant_started  = false;
    bool k_writeback_started = false;
    bool v_started          = false;
    bool v_requant_started  = false;
    bool v_writeback_started = false;
    bool requant_q_started  = false;
    bool att_scores_started = false;
    bool val_scale_started  = false;
    bool softmax_started    = false;
    bool att_value_started  = false;
    bool head_requant_started   = false;

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
    bool head_requant_compute_done   = false;

    bool q_dma_done          = false;
    bool k_dma_done          = false;
    bool k_writeback_dma_done = false;
    bool v_dma_done          = false;
    bool v_writeback_dma_done = false;
    bool att_scores_dma_done = false;
    bool att_value_dma_done  = false;
};


// ------------------------------------------------------------
// MAC state + helper structs
// ------------------------------------------------------------

// Simple controller state machine.
enum class ComputeState : uint8_t { IDLE = 0, CAPTURE_INSTRUCTION, WAIT_MEM, EXECUTE, MEM_WRITEBACK, DONE };

// Captured request from the scheduler.
struct PendingRequest {
    uint32_t instruction    = 0x00000000;
    ComputeOp op            = ComputeOp::CMP_NONE;
    uint8_t layer_idx       = 0;
    uint8_t head_idx        = 0;
    uint8_t tile_idx        = 0;
};


// ------------------------------------------------------------
// Control + IRQ bitfields
// ------------------------------------------------------------
// Bit positions: bit0 = reset_n, bit1 = start
constexpr uint32_t CTRL_RESETN_BIT      = 1u << 0;
constexpr uint32_t CTRL_START_BIT       = 1u << 1;

// IRQ Bits
constexpr uint32_t IRQ_ERROR_BIT        = 1u << 1;
constexpr uint32_t IRQ_INFER_DONE_BIT   = 1u << 2;

// Status bits
constexpr uint32_t STATUS_IDLE          = 1u << 0;
constexpr uint32_t STATUS_ERROR         = 1u << 1;
constexpr uint32_t STATUS_BUSY_BIT      = 1u << 2;

// Error Codes
constexpr uint32_t ERR_NONE             = 0x0;
constexpr uint32_t ERR_DMA_ALIGNMENT    = 0x10;
constexpr uint32_t ERR_DMA_ZERO_LEN     = 0x11;

// Register Addr mapping is auto generated in a HLS project
// `mask_allowed/hel/impl/ip/drivers/<top_function>/src/x<top_function>_hw.h`

// Config (PS Writes -> PL Reads)
// Passed by value
struct ControlMemSpace {
    uint32_t control        = CTRL_RESETN_BIT;  // cntrl_reset | cntrl_start
    uint32_t irq_mask       = 0; // IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT for all Interrupts
    uint32_t irq_clear      = 0;

    uint32_t dma_layer_len  = 0;
    uint32_t dma_head_len   = 0;
    uint32_t dma_tile_len   = 0;

    uint32_t layer_stride   = 0;
    uint32_t wq_head_stride = 0;
    uint32_t wk_head_stride = 0;
    uint32_t wv_head_stride = 0;

    uint32_t k_cache_stride = 0;
    uint32_t v_cache_stride = 0;

    uint32_t wo_tile_stride = 0;
    uint32_t w1_tile_stride = 0;
    uint32_t w2_tile_stride = 0;

    // address size match ARM64 address space
    uint64_t wq_base_addr   = 0;
    uint64_t wk_base_addr   = 0;
    uint64_t wv_base_addr   = 0;
    uint64_t wo_base_addr   = 0;
    uint64_t w1_base_addr   = 0;
    uint64_t w2_base_addr   = 0;

    uint64_t k_cache_addr   = 0;
    uint64_t v_cache_addr   = 0;

    uint32_t logit_scale_qv = 0;
    uint32_t scale_q        = 0;
    uint32_t zero_point_q   = 0;
    uint32_t scale_k        = 0;
    uint32_t zero_point_k   = 0;
    uint32_t scale_v        = 0;
    uint32_t zero_point_v   = 0;
};

// Status (PS Reads <- PL Writes)
// Passed by reference
struct StatusMemSpace {
    uint32_t status = STATUS_IDLE;
    uint32_t irq_status     = 0;
    uint32_t error_code     = ERR_NONE;
    uint32_t layer_index    = 0;
};

// ---------------------------------------------------------------------------
// Compute buffer layout (moved from compute_buffer_layout.hpp)
// ---------------------------------------------------------------------------
namespace compute_buf {

constexpr int div_ceil(int a, int b) {
    return (a + b - 1) / b;
}

constexpr int max2(int a, int b) {
    return (a > b) ? a : b;
}

// -------------------------------
// Input buffer size calculations
// -------------------------------
constexpr int OUT_PROJ_ACT_BYTES = D_MODEL;
constexpr int OUT_PROJ_W_NIBBLES = D_MODEL * D_TILE_WO;
constexpr int OUT_PROJ_W_BYTES = div_ceil(OUT_PROJ_W_NIBBLES, 2);
constexpr int OUT_PROJ_B_BYTES = D_TILE_WO * 4;
constexpr int OUT_PROJ_IN_BYTES = OUT_PROJ_ACT_BYTES + OUT_PROJ_W_BYTES + OUT_PROJ_B_BYTES;

constexpr int REQUANT_IN_BYTES = (D_MODEL * 4) + 12;
constexpr int RESID_IN_BYTES = D_MODEL * 2;
constexpr int LN_IN_BYTES = D_MODEL + (D_MODEL * 4) + (D_MODEL * 4) + 4;

constexpr int FFN_W1_W_NIBBLES = D_MODEL * D_TILE_W1;
constexpr int FFN_W1_W_BYTES = div_ceil(FFN_W1_W_NIBBLES, 2);
constexpr int FFN_W1_B_BYTES = D_TILE_W1 * 4;
constexpr int FFN_W1_IN_BYTES = D_MODEL + FFN_W1_W_BYTES + FFN_W1_B_BYTES + (D_TILE_W1 * 2);

constexpr int FFN_ACT_IN_BYTES = D_FFN * 2;

constexpr int FFN_W2_W_NIBBLES = D_FFN * D_TILE_W2;
constexpr int FFN_W2_W_BYTES = div_ceil(FFN_W2_W_NIBBLES, 2);
constexpr int FFN_W2_B_BYTES = D_TILE_W2 * 4;
constexpr int FFN_W2_IN_BYTES = (D_FFN * 2) + FFN_W2_W_BYTES + FFN_W2_B_BYTES + (D_TILE_W2 * 2);

constexpr int IN_BUF_BYTES = max2(
    OUT_PROJ_IN_BYTES,
    max2(
        REQUANT_IN_BYTES,
        max2(
            RESID_IN_BYTES,
            max2(
                LN_IN_BYTES,
                max2(FFN_W1_IN_BYTES,
                    max2(FFN_ACT_IN_BYTES, FFN_W2_IN_BYTES))))));

// -------------------------------
// Output buffer size calculations
// -------------------------------
constexpr int OUT_PROJ_OUT_BYTES = D_TILE_WO * 4;
constexpr int REQUANT_OUT_BYTES = D_MODEL;
constexpr int RESID_OUT_BYTES = D_MODEL;
constexpr int LN_OUT_BYTES = D_MODEL * 4;
constexpr int FFN_W1_OUT_BYTES = D_TILE_W1 * 2;
constexpr int FFN_ACT_OUT_BYTES = D_FFN * 2;
constexpr int FFN_W2_OUT_BYTES = D_TILE_W2 * 4;

constexpr int OUT_BUF_BYTES = max2(
    OUT_PROJ_OUT_BYTES,
    max2(
        REQUANT_OUT_BYTES,
        max2(
            RESID_OUT_BYTES,
            max2(
                LN_OUT_BYTES,
                max2(FFN_W1_OUT_BYTES, max2(FFN_ACT_OUT_BYTES, FFN_W2_OUT_BYTES))))));

// -------------------------------
// Per-op layouts (byte offsets)
// -------------------------------
struct OutProjLayout {
    static constexpr int ACT = 0;
    static constexpr int W = ACT + OUT_PROJ_ACT_BYTES;
    static constexpr int B = W + OUT_PROJ_W_BYTES;
};

struct RequantLayout {
    static constexpr int X = 0;
    static constexpr int M = X + (D_MODEL * 4);
    static constexpr int N = M + 4;
    static constexpr int Z = N + 4;
};

struct ResidLayout {
    static constexpr int X = 0;
    static constexpr int R = X + D_MODEL;
};

struct LayerNormLayout {
    static constexpr int X = 0;
    static constexpr int GAMMA = X + D_MODEL;
    static constexpr int BETA = GAMMA + (D_MODEL * 4);
    static constexpr int EPS = BETA + (D_MODEL * 4);
};

struct FfnW1Layout {
    static constexpr int X = 0;
    static constexpr int W = X + D_MODEL;
    static constexpr int B = W + FFN_W1_W_BYTES;
    static constexpr int S = B + FFN_W1_B_BYTES;
};

struct FfnActLayout {
    static constexpr int X = 0;
};

struct FfnW2Layout {
    static constexpr int X = 0;
    static constexpr int W = X + (D_FFN * 2);
    static constexpr int B = W + FFN_W2_W_BYTES;
    static constexpr int S = B + FFN_W2_B_BYTES;
};


// -------------------------------
// Byte helpers (little-endian)
// -------------------------------
inline int8_t read_i8(const uint8_t *buf, int byte_addr) {
    return static_cast<int8_t>(buf[byte_addr]);
}

inline ap_int<4> read_i4(const uint8_t *buf, int nibble_idx) {
    const int byte_addr = nibble_idx / 2;
    const uint8_t byte_val = buf[byte_addr];
    const ap_uint<4> nibble = (nibble_idx & 1) ? ap_uint<4>(byte_val >> 4)
                                               : ap_uint<4>(byte_val & 0xF);
    return ap_int<4>(nibble);
}

inline int16_t read_i16(const uint8_t *buf, int byte_addr) {
    const uint16_t lo = buf[byte_addr];
    const uint16_t hi = buf[byte_addr + 1];
    const uint16_t v = static_cast<uint16_t>((hi << 8) | lo);
    return static_cast<int16_t>(v);
}

inline int32_t read_i32(const uint8_t *buf, int byte_addr) {
    const uint32_t b0 = buf[byte_addr + 0];
    const uint32_t b1 = buf[byte_addr + 1];
    const uint32_t b2 = buf[byte_addr + 2];
    const uint32_t b3 = buf[byte_addr + 3];
    const uint32_t v = (b3 << 24) | (b2 << 16) | (b1 << 8) | b0;
    return static_cast<int32_t>(v);
}

inline void write_i8(uint8_t *buf, int byte_addr, int8_t value) {
    buf[byte_addr] = static_cast<uint8_t>(value);
}

inline void write_i4(uint8_t *buf, int nibble_idx, ap_int<4> value) {
    const int byte_addr = nibble_idx / 2;
    const ap_uint<4> nibble = ap_uint<4>(value);
    uint8_t byte_val = buf[byte_addr];
    if (nibble_idx & 1) {
        byte_val = static_cast<uint8_t>((byte_val & 0x0F)
                                         | (static_cast<uint8_t>(nibble) << 4));
    } else {
        byte_val = static_cast<uint8_t>((byte_val & 0xF0) | static_cast<uint8_t>(nibble));
    }
    buf[byte_addr] = byte_val;
}

inline void write_i16(uint8_t *buf, int byte_addr, int16_t value) {
    const uint16_t v = static_cast<uint16_t>(value);
    buf[byte_addr + 0] = static_cast<uint8_t>(v & 0xFFu);
    buf[byte_addr + 1] = static_cast<uint8_t>((v >> 8) & 0xFFu);
}

inline void write_i32(uint8_t *buf, int byte_addr, int32_t value) {
    const uint32_t v = static_cast<uint32_t>(value);
    buf[byte_addr + 0] = static_cast<uint8_t>(v & 0xFFu);
    buf[byte_addr + 1] = static_cast<uint8_t>((v >> 8) & 0xFFu);
    buf[byte_addr + 2] = static_cast<uint8_t>((v >> 16) & 0xFFu);
    buf[byte_addr + 3] = static_cast<uint8_t>((v >> 24) & 0xFFu);
}

} // namespace compute_buf
