#pragma once
#include <cstdint>
#include <ap_int.h>

using int4_t = ap_int<4>;


/*
README: 
        This file  contains all the enums, structs and constant expressions required accross all modules
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
// Full model layer count from fpga_requant_scales.json
constexpr int MODEL_LAYERS    = 32;
constexpr int NUM_WO_TILES    = 4;
constexpr int NUM_W1_TILES    = 8;
constexpr int NUM_W2_TILES    = 4;
constexpr int NUM_LOGIT_TILES = 2;

constexpr int D_MODEL = 16; // Number of heads processed in parallel
constexpr int16_t ATTN_SCALE_Q15 = 3344; // Q1.15: round((1/sqrt(96)) * 2^15) = 3344 (0x0D10)
constexpr int D_FFN   = 24; // Feed-Forward hidden layer size
constexpr int D_HEADS = D_MODEL / NUM_HEADS; // Number of heads processed in parallel
constexpr int D_TILE_WO  = D_MODEL / NUM_WO_TILES; // Tile size for WO
constexpr int D_TILE_W1  = D_FFN * 2 / NUM_W1_TILES; // Tile size for W1
constexpr int D_TILE_W2  = D_MODEL   / NUM_W2_TILES;
constexpr int CONTEXT_LENGTH = 16; // Context window length
constexpr int MAX_CYCLIC_SIZE = 16; // << for UNROLL parallelism in MAC units
constexpr int HEADS_PARALLEL = 2;
constexpr int NUM_HEAD_GROUPS = (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;


// ------------------------------------------------------------
// Scheduler state + helper enums
// ------------------------------------------------------------
enum SchedState {
    S_IDLE,            // 0
    S_STREAM_IN,       // 1
    S_LAYER_COUNT,     // 2
    S_LAYER_NORM_0,    // 3
    S_REQUANT1,        // 4
    S_ATTENTION_HEADS, // 5
    S_HEAD_CONCAT,     // 6
    S_OUT_PROJECTION,  // 7
    S_REQUANT2,        // 8
    S_RES_ADD_1,       // 9
    S_LAYER_NORM_1,    // 10
    S_REQUANT3,        // 11
    S_FFN,             // 12
    S_REQUANT4,        // 13
    S_RES_ADD_2,       // 14
    S_LOOP_CHECK,      // 15
    S_FINAL_NORM,      // 16
    S_STREAM_OUT       // 17
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
    CMP_NONE      = 0,  // 0

    CMP_LN0       = 1, // 17
    CMP_REQUANT1  = 2, // 15

    // Attention ops
    CMP_Q         = 3,  // 1
    CMP_K         = 4,  // 2
    CMP_K_REQUANT = 5,  // 3
    CMP_V         = 6,  // 4
    CMP_V_REQUANT = 7,  // 5
    CMP_REQUANT_Q = 8,  // 6
    CMP_ATT_SCORES  = 9,  // 7
    CMP_VALUE_SCALE = 10,  // 8
    CMP_SOFTMAX     = 11,  // 9
    CMP_ATT_VALUE   = 12, // 10

    // Scheduler-level ops
    CMP_HEAD_REQUANT = 13, 
    CMP_CONCAT       = 14, // 13
    CMP_OUT_PROJ     = 15, // 14
    CMP_RESID0       = 16, // 16
    CMP_REQUANT2     = 17, // 18
    CMP_FFN_W1       = 18, // 19
    CMP_FFN_ACT      = 19, // 20
    CMP_FFN_W2       = 20, // 21
    CMP_REQUANT3     = 21, // 22
    CMP_RESID1       = 22, // 23
    CMP_LN1          = 23, // 24
    CMP_REQUANT4     = 24, // 25
    CMP_FINAL_NORM   = 25, // 26
    CMP_DEQUANT      = 26, // 26
    CMP_LOGITS       = 27, // 27
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
    DMASEL_WLOGIT,      // 11
    DMASEL_CONCAT       // 12
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
    uint32_t wl_instruction = 0;                  // OUTPUT packed DMA op|layer|head|tile
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
enum class ComputeState : uint8_t { 
            IDLE = 0, 
            CAPTURE_INSTRUCTION, 
            WAIT_MEM, 
            EXECUTE, 
            MEM_WRITEBACK, 
            DONE 
};

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
constexpr uint32_t ERR_NONE             = 0;
constexpr uint32_t ERR_DMA_ALIGNMENT    = 1;
constexpr uint32_t ERR_DMA_ZERO_LEN     = 2;
constexpr uint32_t ERR_DMA_ZERO_STRIDE  = 4;
constexpr uint32_t ERR_SCHEDULER_ERROR  = 8;
constexpr uint32_t ERR_COMPUTE_ERROR    = 16;



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
constexpr int max2_constexpr(int a, int b) {
    return (a > b) ? a : b;
}
constexpr int min2_constexpr(int a, int b) {
    return (a < b) ? a : b;
}

enum class BufDType : uint8_t {
    I4,
    I8,
    I16,
    I32,
};

// ---------------------------------------------------------------------------
// Requant configuration (compile-time)
// ---------------------------------------------------------------------------
namespace requant_scales {
// Fixed-point scale for Q19.13 outputs (RMSNorm/LN): 2^-13
constexpr double S_FIXED_Q19_13 = 1.0 / 8192.0;

// Per-layer requant scales (from fpga_requant_scales.json)
constexpr double S_out_ln0_L[MODEL_LAYERS] = {
    0.025282972440944882, 0.035796167568897641, 0.02991203248031496, 0.050923382135826784,
    0.067603407972440951, 0.066429810531496061, 0.079420767716535431, 0.073552780511811036,
    0.064165200541338605, 0.055206354576771657, 0.058502245324803151, 0.057757627952755915,
    0.066646222933070889, 0.069264333169291342, 0.063453401820866145, 0.077128383366141792,
    0.072885519192913431, 0.077384042814960682, 0.093486774114173291, 0.09779921259842525,
    0.10409522637795283, 0.10609799458661427, 0.10747139517716545, 0.10923702017716544,
    0.11581046998031504, 0.11394119094488193, 0.11804921259842524, 0.10271173720472447,
    0.10662475393700793, 0.091802042322834676, 0.076861774114173248, 0.061502552903543312,
};
constexpr double S_out_ln1_L[MODEL_LAYERS] = {
    0.0069617102915846465, 0.0094770853838582712, 0.064160925196850391, 0.020453986220472439,
    0.11312746062992125, 0.020961491141732284, 0.044045275590551179, 0.16658464566929135,
    0.028451033464566931, 0.027159202755905512, 0.026605561023622049, 0.026928518700787402,
    0.02883550688976378, 0.03546382874015748, 0.032418799212598423, 0.029865895669291338,
    0.028589443897637797, 0.028174212598425195, 0.029004675196850394, 0.035371555118110236,
    0.02868171751968504, 0.028235728346456691, 0.028235728346456691, 0.028958538385826772,
    0.031326894685039373, 0.036048228346456691, 0.038385826771653545, 0.046321358267716536,
    0.058624507874015748, 0.1814714566929134, 0.098794291338582682, 0.078186515748031496,
};
constexpr double S_act_outproj_in_L[MODEL_LAYERS] = {
    0.0041676919291338587, 0.0067473548228346534, 0.03531003937007874, 0.0063379521407480339,
    0.012189176304133863, 0.016788039800689016, 0.013586368110236224, 0.019473502091535439,
    0.01540615772637796, 0.021083830585629935, 0.021864173228346471, 0.01754235359251969,
    0.025661832554133863, 0.027077402189960676, 0.020073665108267722, 0.02311552657480315,
    0.021482960137795278, 0.022835706815944885, 0.035605591781496124, 0.031344918799212619,
    0.035559608759842536, 0.031004490649606305, 0.028439422367125988, 0.04676094980314964,
    0.039260580708661424, 0.037580462598425207, 0.044081600639763782, 0.057677503690944924,
    0.061414124015748056, 0.061342581200787435, 0.074891547736220504, 0.18331692913385828,
};
constexpr double S_w_wo_L[MODEL_LAYERS] = {
    0.13337053571428573, 0.11104910714285714, 0.17857142857142858, 0.11104910714285714,
    0.11439732142857142, 0.12555803571428573, 0.12555803571428573, 0.13895089285714285,
    0.10602678571428571, 0.098772321428571425, 0.10100446428571429, 0.089285714285714288,
    0.10267857142857142, 0.23660714285714285, 0.10212053571428571, 0.11049107142857142,
    0.094308035714285712, 0.0859375, 0.084821428571428575, 0.097098214285714288,
    0.10546875, 0.073102678571428575, 0.087611607142857137, 0.084263392857142863,
    0.13002232142857142, 0.09375, 0.10379464285714286, 0.11495535714285714,
    0.10491071428571429, 0.11272321428571429, 0.15513392857142858, 0.27232142857142855,
};
constexpr double S_out_outproj_L[MODEL_LAYERS] = {
    0.22212701217644926, 0.29942943474712885, 2.5197418268968299, 0.28126124633849636,
    0.55723204655087388, 0.84234571962497773, 0.68170073211507853, 1.0813126250954721,
    0.65276341502447632, 0.83220562957850885, 0.88250972427057528, 0.62591550275559993,
    1.0529635918603202, 2.5602402292540813, 0.81919186198011951, 1.0206500155187901,
    0.80963391522161998, 0.78422926437475526, 1.2068954815625463, 1.2162539464733972,
    1.498741190290531, 0.90574044618167593, 0.99569949916258293, 1.5745923469239773,
    2.0399546140111502, 1.4079241829139224, 1.8284292701594389, 2.6496074796851836,
    2.5747435328776884, 2.7632570134915695, 4.6428587036273932, 19.949419394307736,
};
constexpr double S_act_w2_in_L[MODEL_LAYERS] = {
    0.008842888779527559, 0.073236466535433087, 5.2677165354330713, 0.021886795644685045,
    4.8464566929133861, 0.028880182701771662, 0.038739142470472471, 0.78543307086614178,
    0.053221118356299273, 0.054488127460629927, 0.041606053149606324, 0.049643700787401622,
    0.054717058316929135, 0.15526574803149606, 0.05374034202755907, 0.056487204724409483,
    0.1114021899606301, 0.08858778297244102, 0.1061655388779528, 0.21739665354330709,
    0.19466892224409479, 0.14103075787401576, 0.14952263779527566, 0.13922502460629926,
    0.26100332185039427, 0.23103321850393713, 0.28481274606299217, 0.25938939468503946,
    0.40162942913385868, 3.8484251968503935, 0.38697539370078765, 1.4684458661417332,
};
constexpr double S_w_w2_L[MODEL_LAYERS] = {
    0.13560267857142858, 0.18415178571428573, 0.44642857142857145, 0.14397321428571427,
    0.36830357142857145, 0.1875, 0.17299107142857142, 0.4017857142857143,
    0.20535714285714285, 0.12834821428571427, 0.18861607142857142, 0.14620535714285715,
    0.16071428571428573, 0.4174107142857143, 0.2544642857142857, 0.13671875,
    0.13783482142857142, 0.140625, 0.14732142857142858, 0.17522321428571427,
    0.17410714285714285, 0.1640625, 0.14732142857142858, 0.21875,
    0.14229910714285715, 0.18973214285714285, 0.17410714285714285, 0.20200892857142858,
    0.19308035714285715, 0.41294642857142855, 0.25558035714285715, 0.3236607142857143,
};
constexpr double S_out_ffn_L[MODEL_LAYERS] = {
    0.78251499332038221, 8.8010310598430213, 1534.6332904321714, 2.0563361960900877,
    1164.8245171380063, 3.5337143891681602, 4.3732462054972805, 205.93677675418266,
    7.1322087549213071, 4.5637510977347722, 5.1211258783284856, 4.7365014206227345,
    5.7386198983614891, 42.293097059773196, 8.923957638034933, 5.0397431093381524,
    10.020350497956411, 8.129551844256957, 10.206567840874973, 24.858489396394013,
    22.11787756701564, 15.099181352689715, 14.374842934282722, 19.874472084934393,
    24.236976757941978, 28.605238725158628, 32.359831113915092, 34.194244870616089,
    50.605049959549042, 1037.0674426701337, 64.541798028751032, 310.15455648757148,
};
constexpr double S_act_q_in_L[MODEL_LAYERS] = {
    0.025282972440944882, 0.035796167568897641, 0.02991203248031496, 0.050923382135826784,
    0.067603407972440951, 0.066429810531496061, 0.079420767716535431, 0.073552780511811036,
    0.064165200541338605, 0.055206354576771657, 0.058502245324803151, 0.057757627952755915,
    0.066646222933070889, 0.069264333169291342, 0.063453401820866145, 0.077128383366141792,
    0.072885519192913431, 0.077384042814960682, 0.093486774114173291, 0.09779921259842525,
    0.10409522637795283, 0.10609799458661427, 0.10747139517716545, 0.10923702017716544,
    0.11581046998031504, 0.11394119094488193, 0.11804921259842524, 0.10271173720472447,
    0.10662475393700793, 0.091802042322834676, 0.076861774114173248, 0.061502552903543312,
};
constexpr double S_act_k_in_L[MODEL_LAYERS] = {
    0.025282972440944882, 0.035796167568897641, 0.02991203248031496, 0.050923382135826784,
    0.067603407972440951, 0.066429810531496061, 0.079420767716535431, 0.073552780511811036,
    0.064165200541338605, 0.055206354576771657, 0.058502245324803151, 0.057757627952755915,
    0.066646222933070889, 0.069264333169291342, 0.063453401820866145, 0.077128383366141792,
    0.072885519192913431, 0.077384042814960682, 0.093486774114173291, 0.09779921259842525,
    0.10409522637795283, 0.10609799458661427, 0.10747139517716545, 0.10923702017716544,
    0.11581046998031504, 0.11394119094488193, 0.11804921259842524, 0.10271173720472447,
    0.10662475393700793, 0.091802042322834676, 0.076861774114173248, 0.061502552903543312,
};
constexpr double S_act_v_in_L[MODEL_LAYERS] = {
    0.025282972440944882, 0.035796167568897641, 0.02991203248031496, 0.050923382135826784,
    0.067603407972440951, 0.066429810531496061, 0.079420767716535431, 0.073552780511811036,
    0.064165200541338605, 0.055206354576771657, 0.058502245324803151, 0.057757627952755915,
    0.066646222933070889, 0.069264333169291342, 0.063453401820866145, 0.077128383366141792,
    0.072885519192913431, 0.077384042814960682, 0.093486774114173291, 0.09779921259842525,
    0.10409522637795283, 0.10609799458661427, 0.10747139517716545, 0.10923702017716544,
    0.11581046998031504, 0.11394119094488193, 0.11804921259842524, 0.10271173720472447,
    0.10662475393700793, 0.091802042322834676, 0.076861774114173248, 0.061502552903543312,
};
constexpr double S_w_wq_L[MODEL_LAYERS] = {
    0.22991071428571427, 0.19754464285714285, 0.18191964285714285, 0.31919642857142855,
    0.35044642857142855, 0.29910714285714285, 0.2767857142857143, 0.24107142857142858,
    0.25558035714285715, 0.20424107142857142, 0.15401785714285715, 0.13950892857142858,
    0.13950892857142858, 0.11886160714285714, 0.1171875, 0.11049107142857142,
    0.099330357142857137, 0.13002232142857142, 0.11941964285714286, 0.11328125,
    0.12053571428571429, 0.11830357142857142, 0.13392857142857142, 0.13560267857142858,
    0.13727678571428573, 0.1484375, 0.12834821428571427, 0.12667410714285715,
    0.11495535714285714, 0.12165178571428571, 0.11272321428571429, 0.11104910714285714,
};
constexpr double S_w_wk_L[MODEL_LAYERS] = {
    0.31473214285714285, 0.17633928571428573, 0.15290178571428573, 0.11439732142857142,
    0.15959821428571427, 0.086495535714285712, 0.11997767857142858, 0.1171875,
    0.084821428571428575, 0.12276785714285714, 0.073102678571428575, 0.11383928571428571,
    0.071986607142857137, 0.069754464285714288, 0.065848214285714288, 0.062220982142857144,
    0.1484375, 0.067243303571428575, 0.08203125, 0.078683035714285712,
    0.087611607142857137, 0.081473214285714288, 0.084821428571428575, 0.071149553571428575,
    0.083705357142857137, 0.085379464285714288, 0.067522321428571425, 0.077008928571428575,
    0.070033482142857137, 0.068359375, 0.088727678571428575, 0.068917410714285712,
};
constexpr double S_w_wv_L[MODEL_LAYERS] = {
    0.0341796875, 0.032784598214285712, 0.088727678571428575, 0.038504464285714288,
    0.044363839285714288, 0.032505580357142856, 0.040736607142857144, 0.046037946428571432,
    0.035435267857142856, 0.033482142857142856, 0.060267857142857144, 0.029575892857142856,
    0.031808035714285712, 0.039341517857142856, 0.042131696428571432, 0.044084821428571432,
    0.039899553571428568, 0.039341517857142856, 0.038504464285714288, 0.037388392857142856,
    0.038504464285714288, 0.035016741071428568, 0.031668526785714288, 0.033063616071428568,
    0.035714285714285712, 0.041573660714285712, 0.036272321428571432, 0.038783482142857144,
    0.038225446428571432, 0.038504464285714288, 0.044642857142857144, 0.18303571428571427,
};
constexpr double S_out_q_L[MODEL_LAYERS] = {
    2.3229144328837865, 2.8258405935471727, 2.1745599686689792, 6.4956278320556633,
    9.4675171092999459, 7.9402772795328183, 8.7846329984340237, 7.0858296434313663,
    6.5534938924202226, 4.5058633941495465, 3.6007210848534137, 3.2200100163437075,
    3.7155526118818774, 3.2900093030483761, 2.9715433477492446, 3.4055501796528809,
    2.8931377973515411, 4.020825274150603, 4.4614066732768105, 4.4273031583814175,
    5.0140935235626722, 5.0159234641154864, 5.751908829341347, 5.9194858041979277,
    6.3531746778259528, 6.7588102840274225, 6.0547859672387601, 5.1994067893880835,
    4.8981618043820019, 4.4628953347727327, 3.4623394098008324, 2.7293176563192345,
};
constexpr double S_out_k_L[MODEL_LAYERS] = {
    3.1799119906467368, 2.5225017727709225, 1.8276976423782221, 2.3279785062437255,
    4.3116399574200397, 2.2961622729992297, 3.807855029563135, 3.4445005211124697,
    2.1749586717202489, 2.7084424773576514, 1.7090379062166565, 2.6275281733364655,
    1.9172251477310485, 1.9307566332443524, 1.6697243573067184, 1.9177719446025061,
    4.3234531128961233, 2.0794396804083592, 3.0646111260359397, 3.0751218981861079,
    3.644503162959905, 3.4543623856644383, 3.6428755919161868, 3.105903045412493,
    3.8738869986743611, 3.8875863663766759, 3.185343921895174, 3.1608728499363683,
    2.984074303155055, 2.5078196261910999, 2.7253067631600612, 1.6938227666101784,
};
constexpr double S_out_v_L[MODEL_LAYERS] = {
    0.34533618692750467, 0.46897778212117625, 1.0605982669275085, 0.78356349722349794,
    1.1985153028492768, 0.86291259614325877, 1.2928996146888783, 1.3531966332941845,
    0.90861760298839334, 0.73866613018845029, 1.4089778158122053, 0.68264212346486586,
    0.84714599550906788, 1.0889467411498148, 1.0683405845479428, 1.3587801221847353,
    1.162131193879973, 1.2166016387451395, 1.4384909367107472, 1.4612281360175123,
    1.6017243200269649, 1.4846660253455033, 1.3600867752713393, 1.4433314152210994,
    1.6528584527677275, 1.8929750607520412, 1.7111351646544324, 1.5918888628302725,
    1.6287576873794525, 1.4125677894464155, 1.3712235286339931, 4.4985738254910004,
};
constexpr double S_att_weights_L[MODEL_LAYERS] = {
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
    0.007874015748031496, 0.007874015748031496, 0.007874015748031496, 0.007874015748031496,
};
constexpr double S_v_cache_L[MODEL_LAYERS] = {
    0.34533618692750467, 0.46897778212117625, 1.0605982669275085, 0.78356349722349794,
    1.1985153028492768, 0.86291259614325877, 1.2928996146888783, 1.3531966332941845,
    0.90861760298839334, 0.73866613018845029, 1.4089778158122053, 0.68264212346486586,
    0.84714599550906788, 1.0889467411498148, 1.0683405845479428, 1.3587801221847353,
    1.162131193879973, 1.2166016387451395, 1.4384909367107472, 1.4612281360175123,
    1.6017243200269649, 1.4846660253455033, 1.3600867752713393, 1.4433314152210994,
    1.6528584527677275, 1.8929750607520412, 1.7111351646544324, 1.5918888628302725,
    1.6287576873794525, 1.4125677894464155, 1.3712235286339931, 4.4985738254910004,
};
constexpr double S_out_att_value_L[MODEL_LAYERS] = {
    0.26104152712630274, 0.35450289042230643, 0.80171207578772297, 0.5922999664051638,
    0.90596432341362654, 0.65228038763584917, 0.97730994496167178, 1.0228887936711946,
    0.68682905422744689, 0.55836179919756868, 1.0650540969919031, 0.51601294372147344,
    0.64036232731394105, 0.82314084370379703, 0.80756453635120085, 1.0271093836986975,
    0.87846137490139686, 0.91963588440577482, 1.0873632277498562, 1.1045504020289858,
    1.2107522419101464, 1.1222672317572309, 1.0280970899688862, 1.0910221721356343,
    1.2494048146905656, 1.4309102821432753, 1.2934565024159488, 1.2033175656039856,
    1.2311869132947042, 1.0677677778492589, 1.0365154232193963, 3.400496749977449,
};

// Backward-compatible single-layer aliases (layer 0)
constexpr double S_out_ln0 = S_out_ln0_L[0];
constexpr double S_out_ln1 = S_out_ln1_L[0];
constexpr double S_act_outproj_in = S_act_outproj_in_L[0];
constexpr double S_w_wo = S_w_wo_L[0];
constexpr double S_out_outproj = S_out_outproj_L[0];
constexpr double S_act_w2_in = S_act_w2_in_L[0];
constexpr double S_w_w2 = S_w_w2_L[0];
constexpr double S_out_ffn = S_out_ffn_L[0];
constexpr double S_act_q_in = S_act_q_in_L[0];
constexpr double S_act_k_in = S_act_k_in_L[0];
constexpr double S_act_v_in = S_act_v_in_L[0];
constexpr double S_w_wq = S_w_wq_L[0];
constexpr double S_w_wk = S_w_wk_L[0];
constexpr double S_w_wv = S_w_wv_L[0];
constexpr double S_out_q = S_out_q_L[0];
constexpr double S_out_k = S_out_k_L[0];
constexpr double S_out_v = S_out_v_L[0];
constexpr double S_att_weights = S_att_weights_L[0];
constexpr double S_v_cache = S_v_cache_L[0];
constexpr double S_out_att_value = S_out_att_value_L[0];

// FFN per-stage fixed-point scale (Q1.15)
constexpr int16_t FFN_W1_SCALE_Q15 = 0x4000; // 0.5
constexpr int16_t FFN_W2_SCALE_Q15 = 0x4000; // 0.5
} // namespace requant_scales

namespace requant_params {
    constexpr int32_t round_to_i32(double x) {
        return (x >= 0.0) ? static_cast<int32_t>(x + 0.5) : static_cast<int32_t>(x - 0.5);
    }
    // -------------------------------------------------------------------
    // Requant formula (symmetric, zero-point = 0):
    //   y = saturate( (x * M + 2^(N-1)) >> N )
    //
    // Where real_scale depends on the stage:
    //   * RMSNorm outputs (Q19.13 -> int8):
    //       real_scale = S_FIXED_Q19_13 / S_out_lnX
    //   * Matmul accum (int32 -> int8):
    //       real_scale = (S_act * S_w) / S_out
    //     (values provided in fpga_requant_scales.json as requant_mult)
    //
    // Choose N to maximize precision while keeping M in int32:
    //   N = floor(log2((2^31 - 1) / real_scale))
    //   M = round(real_scale * 2^N)
    // -------------------------------------------------------------------
    constexpr int32_t calc_m(double real_scale, int32_t n) {
        return round_to_i32(real_scale * static_cast<double>(1LL << n));
    }

    // Per-layer N values (computed to maximize precision while keeping M in int32)
    constexpr int32_t REQUANT1_N_L[MODEL_LAYERS] = {
        38, 39, 38, 39,
        40, 40, 40, 40,
        40, 39, 39, 39,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 39,
    };
    constexpr int32_t REQUANT2_N_L[MODEL_LAYERS] = {
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
    };
    constexpr int32_t REQUANT3_N_L[MODEL_LAYERS] = {
        36, 37, 40, 38,
        40, 38, 39, 41,
        38, 38, 38, 38,
        38, 39, 39, 38,
        38, 38, 38, 39,
        38, 38, 38, 38,
        39, 39, 39, 39,
        39, 41, 40, 40,
    };
    constexpr int32_t REQUANT4_N_L[MODEL_LAYERS] = {
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
        40, 40, 40, 40,
    };
    constexpr int32_t REQUANT_Q_N_L[MODEL_LAYERS] = {
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
    };
    constexpr int32_t REQUANT_K_N_L[MODEL_LAYERS] = {
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
    };
    constexpr int32_t REQUANT_V_N_L[MODEL_LAYERS] = {
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
        39, 39, 39, 39,
    };
    constexpr int32_t REQUANT_HEAD_N_L[MODEL_LAYERS] = {
        37, 37, 37, 37,
        37, 37, 37, 37,
        37, 37, 37, 37,
        37, 37, 37, 37,
        37, 37, 37, 37,
        37, 37, 37, 37,
        37, 37, 37, 37,
        37, 37, 37, 37,
    };

    // Per-layer M values (derived from fpga_requant_scales.json)
    constexpr int32_t REQUANT1_M_L[MODEL_LAYERS] = {
        1327155345, 1874749968, 1121770379, 1317839884,
        1985369259, 2020444239, 1689957575, 1824781158,
        2091752646, 1215600351, 1147116040, 1161904780,
        2013883489, 1937761065, 2115217217, 1740185936,
        1841486889, 1734436754, 1435686805, 1372380456,
        1289374476, 1265035485, 1248869318, 1228683534,
        1158942952, 1177956162, 1136964195, 1306741874,
        1258785817, 1462034227, 1746222092, 1091155746,
    };
    constexpr int32_t REQUANT2_M_L[MODEL_LAYERS] = {
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
    };
    constexpr int32_t REQUANT3_M_L[MODEL_LAYERS] = {
        1204963673, 1770292798, 2091892029, 1640483749,
        1186429248, 1600765507, 1523633650, 1611405751,
        1179374803, 1235471906, 1261181148, 1246055618,
        1163649806, 1892318635, 2070060139, 1123503289,
        1173665081, 1190962547, 1156862877, 1897255119,
        1169889215, 1188367857, 1188367857, 1158705994,
        2142212456, 1861641115, 1748271944, 1448767189,
        1144723707, 1479215855, 1358557526, 1716635237,
    };
    constexpr int32_t REQUANT4_M_L[MODEL_LAYERS] = {
        1684882386, 1684882386, 1684882386, 1684882386,
        1684882386, 1684882386, 1684882386, 1684882386,
        1684882386, 1684882386, 1684882386, 1684882386,
        1684882386, 1684882386, 1684882386, 1684882386,
        1684882386, 1684882386, 1684882386, 1684882386,
        1684882386, 1684882386, 1684882386, 1684882386,
        1684882386, 1684882386, 1684882386, 1684882386,
        1684882386, 1684882386, 1684882386, 1684882386,
    };
    constexpr int32_t REQUANT_Q_M_L[MODEL_LAYERS] = {
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
    };
    constexpr int32_t REQUANT_K_M_L[MODEL_LAYERS] = {
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
    };
    constexpr int32_t REQUANT_V_M_L[MODEL_LAYERS] = {
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
        1375700707, 1375700707, 1375700707, 1375700707,
    };
    constexpr int32_t REQUANT_HEAD_M_L[MODEL_LAYERS] = {
        1431655765, 1431655765, 1431655765, 1431655765,
        1431655765, 1431655765, 1431655765, 1431655765,
        1431655765, 1431655765, 1431655765, 1431655765,
        1431655765, 1431655765, 1431655765, 1431655765,
        1431655765, 1431655765, 1431655765, 1431655765,
        1431655765, 1431655765, 1431655765, 1431655765,
        1431655765, 1431655765, 1431655765, 1431655765,
        1431655765, 1431655765, 1431655765, 1431655765,
    };

    // Backward-compatible single-layer aliases (layer 0)
    constexpr int32_t REQUANT1_N = REQUANT1_N_L[0];
    constexpr int32_t REQUANT2_N = REQUANT2_N_L[0];
    constexpr int32_t REQUANT3_N = REQUANT3_N_L[0];
    constexpr int32_t REQUANT4_N = REQUANT4_N_L[0];
    constexpr int32_t REQUANT_Q_N = REQUANT_Q_N_L[0];
    constexpr int32_t REQUANT_K_N = REQUANT_K_N_L[0];
    constexpr int32_t REQUANT_V_N = REQUANT_V_N_L[0];
    constexpr int32_t REQUANT_HEAD_N = REQUANT_HEAD_N_L[0];
    constexpr int32_t REQUANT1_M = REQUANT1_M_L[0];
    constexpr int32_t REQUANT2_M = REQUANT2_M_L[0];
    constexpr int32_t REQUANT3_M = REQUANT3_M_L[0];
    constexpr int32_t REQUANT4_M = REQUANT4_M_L[0];
    constexpr int32_t REQUANT_Q_M = REQUANT_Q_M_L[0];
    constexpr int32_t REQUANT_K_M = REQUANT_K_M_L[0];
    constexpr int32_t REQUANT_V_M = REQUANT_V_M_L[0];
    constexpr int32_t REQUANT_HEAD_M = REQUANT_HEAD_M_L[0];
} // namespace requant_params



constexpr int VECTOR_MAX = max2_constexpr(D_MODEL, D_FFN);
constexpr int ACCUM_MAX = max2_constexpr(D_TILE_WO, max2_constexpr(D_TILE_W1, D_TILE_W2));
constexpr int MATRIX_MAX = VECTOR_MAX * ACCUM_MAX;

constexpr int MAC_VEC_UNROLL = min2_constexpr(VECTOR_MAX, MAX_CYCLIC_SIZE);
constexpr int MAC_OUT_UNROLL = min2_constexpr(ACCUM_MAX, MAX_CYCLIC_SIZE);

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

constexpr int REQUANT_IN_BYTES = (D_MODEL * 4);
constexpr int RESID_IN_BYTES = D_MODEL * 2;
constexpr int LN_IN_BYTES = D_MODEL + (D_MODEL * 4) + 4;

constexpr int FFN_W1_W_NIBBLES = D_MODEL * D_TILE_W1;
constexpr int FFN_W1_W_BYTES = div_ceil(FFN_W1_W_NIBBLES, 2);
constexpr int FFN_W1_B_BYTES = D_TILE_W1 * 4;
constexpr int FFN_W1_IN_BYTES = D_MODEL + FFN_W1_W_BYTES + FFN_W1_B_BYTES;

constexpr int FFN_ACT_IN_BYTES = (D_FFN * 2) * 2;

constexpr int FFN_W2_W_NIBBLES = D_FFN * D_TILE_W2;
constexpr int FFN_W2_W_BYTES = div_ceil(FFN_W2_W_NIBBLES, 2);
constexpr int FFN_W2_B_BYTES = D_TILE_W2 * 4;
constexpr int FFN_W2_IN_BYTES = (D_FFN * 2) + FFN_W2_W_BYTES + FFN_W2_B_BYTES;

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
struct INOutProjLayout {
    static constexpr int ACT_BYTES = OUT_PROJ_ACT_BYTES;
    static constexpr int W_BYTES = OUT_PROJ_W_BYTES;
    static constexpr int B_BYTES = OUT_PROJ_B_BYTES;
    static constexpr int TOTAL_BYTES = OUT_PROJ_IN_BYTES;
    static constexpr int ACT = 0;
    static constexpr int W = ACT + ACT_BYTES;
    static constexpr int B = W + W_BYTES;
};

struct INRequantLayout {
    static constexpr int X_BYTES = D_MODEL * 4;
    static constexpr int TOTAL_BYTES = REQUANT_IN_BYTES;
    static constexpr int X = 0;
};

struct INResidLayout {
    static constexpr int X_BYTES = D_MODEL;
    static constexpr int R_BYTES = D_MODEL;
    static constexpr int TOTAL_BYTES = RESID_IN_BYTES;
    static constexpr int X = 0;
    static constexpr int R = X + X_BYTES;
};

struct INLayerNormLayout {
    static constexpr int X_BYTES = D_MODEL;
    static constexpr int GAMMA_BYTES = D_MODEL * 4;
    static constexpr int EPS_BYTES = 4;
    static constexpr int TOTAL_BYTES = LN_IN_BYTES;
    static constexpr int X = 0;
    static constexpr int GAMMA = X + X_BYTES;
    static constexpr int EPS = GAMMA + GAMMA_BYTES;
};

struct INFfnW1Layout {
    static constexpr int X_BYTES = D_MODEL;
    static constexpr int W_BYTES = FFN_W1_W_BYTES;
    static constexpr int B_BYTES = FFN_W1_B_BYTES;
    static constexpr int TOTAL_BYTES = FFN_W1_IN_BYTES;
    static constexpr int X = 0;
    static constexpr int W = X + X_BYTES;
    static constexpr int B = W + W_BYTES;
};

struct INFfnActLayout {
    static constexpr int GATE_BYTES = D_FFN * 2;
    static constexpr int UP_BYTES = D_FFN * 2;
    static constexpr int OUT_BYTES = FFN_ACT_OUT_BYTES;
    static constexpr int TOTAL_BYTES = FFN_ACT_IN_BYTES;
    static constexpr int GATE = 0;
    static constexpr int UP = GATE + GATE_BYTES;
    static constexpr int OUT = 0;
    static constexpr int X = 0;
};

struct INFfnW2Layout {
    static constexpr int X_BYTES = D_FFN * 2;
    static constexpr int W_BYTES = FFN_W2_W_BYTES;
    static constexpr int B_BYTES = FFN_W2_B_BYTES;
    static constexpr int TOTAL_BYTES = FFN_W2_IN_BYTES;
    static constexpr int X = 0;
    static constexpr int W = X + X_BYTES;
    static constexpr int B = W + W_BYTES;
};

// -------------------------------
// Per-op output layouts (byte offsets)
// -------------------------------

struct OUTOutProjLayout {
    static constexpr int NUM_ELEMS = D_TILE_WO;
    static constexpr BufDType TYPE = BufDType::I32;
    static constexpr int TOTAL_BYTES = OUT_PROJ_OUT_BYTES;
    static constexpr int Y = 0;
};

struct OUTRequantLayout {
    static constexpr int NUM_ELEMS = D_MODEL;
    static constexpr BufDType TYPE = BufDType::I8;
    static constexpr int TOTAL_BYTES = REQUANT_OUT_BYTES;
    static constexpr int X = 0;
};

struct OUTResidLayout {
    static constexpr int NUM_ELEMS = D_MODEL;
    static constexpr BufDType TYPE = BufDType::I8;
    static constexpr int TOTAL_BYTES = RESID_OUT_BYTES;
    static constexpr int X = 0;
};

struct OUTLayerNormLayout {
    static constexpr int NUM_ELEMS = D_MODEL;
    static constexpr BufDType TYPE = BufDType::I32;
    static constexpr int TOTAL_BYTES = LN_OUT_BYTES;
    static constexpr int X = 0;
};

struct OUTFfnW1Layout {
    static constexpr int NUM_ELEMS = D_TILE_W1;
    static constexpr BufDType TYPE = BufDType::I16;
    static constexpr int TOTAL_BYTES = FFN_W1_OUT_BYTES;
    static constexpr int Y = 0;
};

struct OUTFfnActLayout {
    static constexpr int NUM_ELEMS = D_FFN;
    static constexpr BufDType TYPE = BufDType::I16;
    static constexpr int TOTAL_BYTES = FFN_ACT_OUT_BYTES;
    static constexpr int Y = 0;
};

struct OUTFfnW2Layout {
    static constexpr int NUM_ELEMS = D_TILE_W2;
    static constexpr BufDType TYPE = BufDType::I32;
    static constexpr int TOTAL_BYTES = FFN_W2_OUT_BYTES;
    static constexpr int Y = 0;
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

// ------------------------------------------------------------
// Headed MAC sizing (compile-time maxima)
// ------------------------------------------------------------
constexpr int HEAD_VECTOR_MAX = compute_buf::max2(D_MODEL, compute_buf::max2(D_HEADS, CONTEXT_LENGTH));
constexpr int HEAD_ACCUM_MAX = compute_buf::max2(D_HEADS, CONTEXT_LENGTH);
constexpr int HEAD_MATRIX_MAX = HEAD_VECTOR_MAX * HEAD_ACCUM_MAX;

constexpr int HEAD_MAC_VEC_UNROLL = min2_constexpr(HEAD_VECTOR_MAX, MAX_CYCLIC_SIZE);
constexpr int HEAD_MAC_OUT_UNROLL = min2_constexpr(HEAD_ACCUM_MAX, MAX_CYCLIC_SIZE);
constexpr int CONTEXT_UNROLL = min2_constexpr(CONTEXT_LENGTH, MAX_CYCLIC_SIZE);

struct ComputeHeadCtx {
    ComputeState state = ComputeState::IDLE;
    PendingRequest req{};
    bool mac_busy = false;
    bool mac_ready = true;
    bool mac_complete = false;
    bool clear_pending = false;
    bool capture_pending = false;
    bool mac_start = false;
    bool error_latched = false;

    // FSM communication signals
    bool compute_start = false;
    uint32_t compute_instruction = 0;
    bool compute_ready = false;
    bool compute_done = false;

    // Memory manager handshake
    bool mem_transfer_done = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    uint32_t mem_op = 0;

};
// ------------------------------------------------------------
// Headed attention buffer layouts
// ------------------------------------------------------------
namespace head_buf {

using OutDType = BufDType;

constexpr int QKV_W_NIBBLES = D_MODEL * D_HEADS;
constexpr int QKV_W_BYTES = compute_buf::div_ceil(QKV_W_NIBBLES, 2);
constexpr int QKV_B_NIBBLES = D_HEADS;
constexpr int QKV_B_BYTES = compute_buf::div_ceil(QKV_B_NIBBLES, 2);
constexpr int QKV_IN_BYTES = D_MODEL + QKV_W_BYTES + QKV_B_BYTES;
constexpr int QKV_OUT_BYTES = D_HEADS * 4;

constexpr int HEAD_REQUANT_IN_BYTES = (D_HEADS * 4);
constexpr int HEAD_REQUANT_OUT_BYTES = D_HEADS;

constexpr int ATT_SCORES_IN_BYTES = D_HEADS + (CONTEXT_LENGTH * D_HEADS);
constexpr int ATT_SCORES_OUT_BYTES = CONTEXT_LENGTH * 4;

constexpr int VALUE_SCALE_IN_BYTES = (CONTEXT_LENGTH * 4);
constexpr int VALUE_SCALE_OUT_BYTES = CONTEXT_LENGTH * 2;

constexpr int SOFTMAX_IN_BYTES = CONTEXT_LENGTH * 2;
constexpr int SOFTMAX_OUT_BYTES = CONTEXT_LENGTH * 2;

constexpr int ATT_VALUE_IN_BYTES = CONTEXT_LENGTH + (CONTEXT_LENGTH * D_HEADS);
constexpr int ATT_VALUE_OUT_BYTES = D_HEADS * 4;

constexpr int IN_BUF_BYTES = compute_buf::max2(
    QKV_IN_BYTES,
    compute_buf::max2(
        HEAD_REQUANT_IN_BYTES,
        compute_buf::max2(
            ATT_SCORES_IN_BYTES,
            compute_buf::max2(VALUE_SCALE_IN_BYTES,
                compute_buf::max2(SOFTMAX_IN_BYTES, ATT_VALUE_IN_BYTES)))));

constexpr int OUT_BUF_BYTES = compute_buf::max2(
    QKV_OUT_BYTES,
    compute_buf::max2(
        HEAD_REQUANT_OUT_BYTES,
        compute_buf::max2(
            ATT_SCORES_OUT_BYTES,
            compute_buf::max2(VALUE_SCALE_OUT_BYTES,
                compute_buf::max2(SOFTMAX_OUT_BYTES, ATT_VALUE_OUT_BYTES)))));

struct INQkvLayout {
    static constexpr int ACT_BYTES = D_MODEL;
    static constexpr int W_BYTES = QKV_W_BYTES;
    static constexpr int B_BYTES = QKV_B_BYTES;
    static constexpr int TOTAL_BYTES = QKV_IN_BYTES;
    static constexpr int ACT = 0;
    static constexpr int W = ACT + ACT_BYTES;
    static constexpr int B = W + W_BYTES;
};

struct INHeadRequantLayout {
    static constexpr int X_BYTES = D_HEADS * 4;
    static constexpr int TOTAL_BYTES = HEAD_REQUANT_IN_BYTES;
    static constexpr int X = 0;
};

struct INAttScoresLayout {
    static constexpr int Q_BYTES = D_HEADS;
    static constexpr int K_CACHE_BYTES = CONTEXT_LENGTH * D_HEADS;
    static constexpr int TOTAL_BYTES = ATT_SCORES_IN_BYTES;
    static constexpr int Q = 0;
    static constexpr int K_CACHE = Q + Q_BYTES;
};

struct INValueScaleLayout {
    static constexpr int X_BYTES = VALUE_SCALE_IN_BYTES;
    static constexpr int TOTAL_BYTES = VALUE_SCALE_IN_BYTES;
    static constexpr int X = 0;
};

struct INSoftmaxLayout {
    static constexpr int X_BYTES = SOFTMAX_IN_BYTES;
    static constexpr int TOTAL_BYTES = SOFTMAX_IN_BYTES;
    static constexpr int X = 0;
};

struct INAttValueLayout {
    static constexpr int WEIGHTS_BYTES = CONTEXT_LENGTH;
    static constexpr int V_CACHE_BYTES = CONTEXT_LENGTH * D_HEADS;
    static constexpr int TOTAL_BYTES = ATT_VALUE_IN_BYTES;
    static constexpr int WEIGHTS = 0;
    static constexpr int V_CACHE = WEIGHTS + WEIGHTS_BYTES;
};

// -------------------------------
// Per-op output layouts (byte offsets)
// -------------------------------
struct OUTQkvLayout {
    static constexpr int NUM_ELEMS = D_HEADS;
    static constexpr OutDType TYPE = OutDType::I32;
    static constexpr int TOTAL_BYTES = QKV_OUT_BYTES;
    static constexpr int Y = 0;
};

struct OUTHeadRequantLayout {
    static constexpr int NUM_ELEMS = D_HEADS;
    static constexpr OutDType TYPE = OutDType::I8;
    static constexpr int TOTAL_BYTES = HEAD_REQUANT_OUT_BYTES;
    static constexpr int X = 0;
};

struct OUTAttScoresLayout {
    static constexpr int NUM_ELEMS = CONTEXT_LENGTH;
    static constexpr OutDType TYPE = OutDType::I32;
    static constexpr int TOTAL_BYTES = ATT_SCORES_OUT_BYTES;
    static constexpr int X = 0;
};

struct OUTValueScaleLayout {
    static constexpr int NUM_ELEMS = CONTEXT_LENGTH;
    static constexpr OutDType TYPE = OutDType::I16;
    static constexpr int TOTAL_BYTES = VALUE_SCALE_OUT_BYTES;
    static constexpr int X = 0;
};

struct OUTSoftmaxLayout {
    static constexpr int NUM_ELEMS = CONTEXT_LENGTH;
    static constexpr OutDType TYPE = OutDType::I16;
    static constexpr int TOTAL_BYTES = SOFTMAX_OUT_BYTES;
    static constexpr int X = 0;
};

struct OUTAttValueLayout {
    static constexpr int NUM_ELEMS = D_HEADS;
    static constexpr OutDType TYPE = OutDType::I32;
    static constexpr int TOTAL_BYTES = ATT_VALUE_OUT_BYTES;
    static constexpr int Y = 0;
};

} // namespace head_buf
