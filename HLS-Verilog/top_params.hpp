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
constexpr uint32_t ERR_INPUT_STREAM     = 32;


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
    0.0252829724409448821, 0.0357421875000000014, 0.0299120324803149595, 0.0502648252952755947,
    0.0675818159448818845, 0.0663650344488188881, 0.0789025590551181016, 0.0728186515748031477,
    0.0630963951771653514, 0.0548932701771653528, 0.0582323449803149595, 0.0571530511811023587,
    0.0657609498031496015, 0.0692427411417322752, 0.062622108759842518, 0.0736952509842519754,
    0.0705751722440944862, 0.0740372785433070779, 0.0900104576771653397, 0.0938262795275590367,
    0.098654035433070858, 0.0998578986220472337, 0.101965428149606296, 0.104119709645669287,
    0.111168184055118108, 0.110745570866141729, 0.115285433070866139, 0.0992138287401574809,
    0.102910925196850384, 0.089772391732283463, 0.0754582923228346442, 0.0613837967519685057,
};
constexpr double S_out_ln1_L[MODEL_LAYERS] = {
    0.00691717673474409427, 0.00916400098425196839, 0.0641609251968503908, 0.0204539862204724393,
    0.113127460629921253, 0.0209614911417322844, 0.0440452755905511792, 0.166584645669291348,
    0.0284510334645669306, 0.0271592027559055121, 0.0266055610236220486, 0.0269285187007874023,
    0.0288355068897637803, 0.0354638287401574798, 0.0324187992125984231, 0.0298658956692913376,
    0.0285894438976377965, 0.0281742125984251954, 0.0290046751968503942, 0.0353715551181102358,
    0.0286817175196850405, 0.0282357283464566913, 0.0282357283464566913, 0.0289585383858267723,
    0.0313268946850393734, 0.0360482283464566913, 0.0383858267716535445, 0.0463213582677165364,
    0.058624507874015748, 0.181471456692913397, 0.0987942913385826821, 0.078186515748031496,
};
constexpr double S_act_outproj_in_L[MODEL_LAYERS] = {
    0.00416769192913385867, 0.00626153420275590497, 0.0353100393700787399, 0.0061814099409448816,
    0.0119246739665354335, 0.0143832277312992089, 0.0133704478346456691, 0.019230591781496064,
    0.0150282972440944872, 0.0202471395177165336, 0.0211300442913385823, 0.0173588213582677175,
    0.0254729023129921239, 0.0242650406003936982, 0.0196958046259842513, 0.0229859744094488179,
    0.0213318159448818885, 0.022679164616141733, 0.0316218626968503835, 0.0299846210629921214,
    0.0347607037401574739, 0.0305942421259842515, 0.0281965120570866132, 0.0449040354330708588,
    0.0388287401574803209, 0.0369758858267716511, 0.0438548843503936969, 0.0549677042322834625,
    0.0599458661417322861, 0.0595072588582677142, 0.0723652805118110143, 0.183316929133858275,
};
constexpr double S_w_wo_L[MODEL_LAYERS] = {
    0.133370535714285726, 0.111049107142857137, 0.178571428571428575, 0.111049107142857137,
    0.114397321428571425, 0.125558035714285726, 0.125558035714285726, 0.138950892857142849,
    0.106026785714285712, 0.0987723214285714246, 0.101004464285714288, 0.0892857142857142877,
    0.102678571428571425, 0.236607142857142849, 0.102120535714285712, 0.110491071428571425,
    0.0943080357142857123, 0.0859375, 0.0848214285714285754, 0.0970982142857142877,
    0.10546875, 0.0731026785714285754, 0.0876116071428571369, 0.0842633928571428631,
    0.130022321428571425, 0.09375, 0.103794642857142863, 0.114955357142857137,
    0.104910714285714288, 0.112723214285714288, 0.155133928571428575, 0.272321428571428548,
};
constexpr double S_out_outproj_L[MODEL_LAYERS] = {
    0.0201966966043307071, 0.0110266978346456688, 0.0220481668307086626, 0.00996462844488189142,
    0.0228083476870078704, 0.0246610482283464542, 0.0288050565944881903, 0.0374028051181102342,
    0.0403961614173228289, 0.0445730807086614153, 0.0324836983267716498, 0.0445054133858267739,
    0.0391375492125984256, 0.0630653297244094385, 0.0518276328740157471, 0.0530071973425196782,
    0.0509058193897637679, 0.054413139763779525, 0.0827202263779527464, 0.0600802780511811019,
    0.070210999015748024, 0.0746653543307086581, 0.108919783464566919, 0.109629060039370077,
    0.195056594488188961, 0.190879675196850368, 0.153613435039370083, 0.226951279527559058,
    0.274242125984251961, 0.324933562992126002, 0.448708169291338554, 4.8661417322834648,
};
constexpr double S_act_w2_in_L[MODEL_LAYERS] = {
    0.00884288877952755896, 0.072977362204724408, 5.26771653543307128, 0.0216330893208661439,
    4.8464566929133861, 0.0283133919783464562, 0.036936208169291336, 0.78543307086614178,
    0.0497124138779527491, 0.0540778789370078769, 0.0401377952755905543, 0.0468799212598425136,
    0.0547062623031496012, 0.155265748031496065, 0.0532437253937007859, 0.0544143700787401569,
    0.100303887795275576, 0.0842046013779527563, 0.103855191929133853, 0.217396653543307089,
    0.176142962598425185, 0.140253444881889761, 0.144340551181102339, 0.136590797244094481,
    0.2249446358267716, 0.224210137795275571, 0.281444389763779501, 0.250882135826771657,
    0.375546259842519659, 3.84842519685039353, 0.370738188976377891, 1.40591535433070858,
};
constexpr double S_w_w2_L[MODEL_LAYERS] = {
    0.135602678571428575, 0.184151785714285726, 0.446428571428571452, 0.143973214285714274,
    0.368303571428571452, 0.1875, 0.172991071428571425, 0.401785714285714302,
    0.205357142857142849, 0.128348214285714274, 0.188616071428571425, 0.146205357142857151,
    0.160714285714285726, 0.417410714285714302, 0.254464285714285698, 0.13671875,
    0.137834821428571425, 0.140625, 0.147321428571428575, 0.175223214285714274,
    0.174107142857142849, 0.1640625, 0.147321428571428575, 0.21875,
    0.142299107142857151, 0.189732142857142849, 0.174107142857142849, 0.202008928571428575,
    0.193080357142857151, 0.412946428571428548, 0.255580357142857151, 0.323660714285714302,
};
constexpr double S_out_ffn_L[MODEL_LAYERS] = {
    0.0267002952755905493, 0.118752460629921258, 17.4330708661417333, 0.013610359251968504,
    12.7322834645669296, 0.0392144438976377921, 0.0433686023622047237, 3.34055118110236204,
    0.0554373769685039333, 0.0515412770669291323, 0.0721795029527558946, 0.0677436023622047245,
    0.0789868356299212593, 0.458907480314960647, 0.106758120078740165, 0.0719506643700787291,
    0.092081692913385832, 0.0976193405511810997, 0.134411909448818895, 0.267962598425196874,
    0.150485974409448831, 0.187245324803149621, 0.129528789370078723, 0.146194635826771641,
    0.124287647637795262, 0.131393946850393711, 0.171494832677165365, 0.212303149606299202,
    0.279884350393700798, 27.0708661417322851, 1.12106299212598426, 4.05990157480314906,
};
constexpr double S_act_q_in_L[MODEL_LAYERS] = {
    0.0252829724409448821, 0.0357421875000000014, 0.0299120324803149595, 0.0502648252952755947,
    0.0675818159448818845, 0.0663650344488188881, 0.0789025590551181016, 0.0728186515748031477,
    0.0630963951771653514, 0.0548932701771653528, 0.0582323449803149595, 0.0571530511811023587,
    0.0657609498031496015, 0.0692427411417322752, 0.062622108759842518, 0.0736952509842519754,
    0.0705751722440944862, 0.0740372785433070779, 0.0900104576771653397, 0.0938262795275590367,
    0.098654035433070858, 0.0998578986220472337, 0.101965428149606296, 0.104119709645669287,
    0.111168184055118108, 0.110745570866141729, 0.115285433070866139, 0.0992138287401574809,
    0.102910925196850384, 0.089772391732283463, 0.0754582923228346442, 0.0613837967519685057,
};
constexpr double S_act_k_in_L[MODEL_LAYERS] = {
    0.0252829724409448821, 0.0357421875000000014, 0.0299120324803149595, 0.0502648252952755947,
    0.0675818159448818845, 0.0663650344488188881, 0.0789025590551181016, 0.0728186515748031477,
    0.0630963951771653514, 0.0548932701771653528, 0.0582323449803149595, 0.0571530511811023587,
    0.0657609498031496015, 0.0692427411417322752, 0.062622108759842518, 0.0736952509842519754,
    0.0705751722440944862, 0.0740372785433070779, 0.0900104576771653397, 0.0938262795275590367,
    0.098654035433070858, 0.0998578986220472337, 0.101965428149606296, 0.104119709645669287,
    0.111168184055118108, 0.110745570866141729, 0.115285433070866139, 0.0992138287401574809,
    0.102910925196850384, 0.089772391732283463, 0.0754582923228346442, 0.0613837967519685057,
};
constexpr double S_act_v_in_L[MODEL_LAYERS] = {
    0.0252829724409448821, 0.0357421875000000014, 0.0299120324803149595, 0.0502648252952755947,
    0.0675818159448818845, 0.0663650344488188881, 0.0789025590551181016, 0.0728186515748031477,
    0.0630963951771653514, 0.0548932701771653528, 0.0582323449803149595, 0.0571530511811023587,
    0.0657609498031496015, 0.0692427411417322752, 0.062622108759842518, 0.0736952509842519754,
    0.0705751722440944862, 0.0740372785433070779, 0.0900104576771653397, 0.0938262795275590367,
    0.098654035433070858, 0.0998578986220472337, 0.101965428149606296, 0.104119709645669287,
    0.111168184055118108, 0.110745570866141729, 0.115285433070866139, 0.0992138287401574809,
    0.102910925196850384, 0.089772391732283463, 0.0754582923228346442, 0.0613837967519685057,
};
constexpr double S_w_wq_L[MODEL_LAYERS] = {
    0.229910714285714274, 0.197544642857142849, 0.181919642857142849, 0.319196428571428548,
    0.350446428571428548, 0.299107142857142849, 0.276785714285714302, 0.241071428571428575,
    0.255580357142857151, 0.204241071428571425, 0.154017857142857151, 0.139508928571428575,
    0.139508928571428575, 0.118861607142857137, 0.1171875, 0.110491071428571425,
    0.0993303571428571369, 0.130022321428571425, 0.119419642857142863, 0.11328125,
    0.120535714285714288, 0.118303571428571425, 0.133928571428571425, 0.135602678571428575,
    0.137276785714285726, 0.1484375, 0.128348214285714274, 0.126674107142857151,
    0.114955357142857137, 0.121651785714285712, 0.112723214285714288, 0.111049107142857137,
};
constexpr double S_w_wk_L[MODEL_LAYERS] = {
    0.314732142857142849, 0.176339285714285726, 0.152901785714285726, 0.114397321428571425,
    0.159598214285714274, 0.0864955357142857123, 0.119977678571428575, 0.1171875,
    0.0848214285714285754, 0.122767857142857137, 0.0731026785714285754, 0.113839285714285712,
    0.0719866071428571369, 0.0697544642857142877, 0.0658482142857142877, 0.0622209821428571438,
    0.1484375, 0.0672433035714285754, 0.08203125, 0.0786830357142857123,
    0.0876116071428571369, 0.0814732142857142877, 0.0848214285714285754, 0.0711495535714285754,
    0.0837053571428571369, 0.0853794642857142877, 0.0675223214285714246, 0.0770089285714285754,
    0.0700334821428571369, 0.068359375, 0.0887276785714285754, 0.0689174107142857123,
};
constexpr double S_w_wv_L[MODEL_LAYERS] = {
    0.0341796875, 0.0327845982142857123, 0.0887276785714285754, 0.0385044642857142877,
    0.0443638392857142877, 0.0325055803571428562, 0.0407366071428571438, 0.0460379464285714315,
    0.0354352678571428562, 0.0334821428571428562, 0.0602678571428571438, 0.0295758928571428562,
    0.0318080357142857123, 0.0393415178571428562, 0.0421316964285714315, 0.0440848214285714315,
    0.0398995535714285685, 0.0393415178571428562, 0.0385044642857142877, 0.0373883928571428562,
    0.0385044642857142877, 0.0350167410714285685, 0.0316685267857142877, 0.0330636160714285685,
    0.0357142857142857123, 0.0415736607142857123, 0.0362723214285714315, 0.0387834821428571438,
    0.0382254464285714315, 0.0385044642857142877, 0.0446428571428571438, 0.183035714285714274,
};
constexpr double S_out_q_L[MODEL_LAYERS] = {
    0.0608390748031496092, 0.0607086614173228331, 0.0783027805118110126, 0.115618848425196846,
    0.101879306102362205, 0.108799212598425191, 0.113412893700787387, 0.12186454232283464,
    0.114508489173228353, 0.124144931102362202, 0.123676796259842514, 0.120589320866141728,
    0.126068528543307079, 0.114315944881889758, 0.12561515748031496, 0.123710629921259835,
    0.118372908464566926, 0.12726316437007873, 0.121504675196850404, 0.119458046259842521,
    0.129157234251968511, 0.120554872047244091, 0.120790477362204718, 0.126305364173228324,
    0.13476870078740158, 0.14102731299212598, 0.13578617125984252, 0.125231299212598429,
    0.147036171259842502, 0.136118356299212595, 0.165639763779527549, 0.183316929133858275,
};
constexpr double S_out_k_L[MODEL_LAYERS] = {
    0.0608390748031496092, 0.0607086614173228331, 0.0783027805118110126, 0.115618848425196846,
    0.101879306102362205, 0.108799212598425191, 0.113412893700787387, 0.12186454232283464,
    0.114508489173228353, 0.124144931102362202, 0.123676796259842514, 0.120589320866141728,
    0.126068528543307079, 0.114315944881889758, 0.12561515748031496, 0.123710629921259835,
    0.118372908464566926, 0.12726316437007873, 0.121504675196850404, 0.119458046259842521,
    0.129157234251968511, 0.120554872047244091, 0.120790477362204718, 0.126305364173228324,
    0.13476870078740158, 0.14102731299212598, 0.13578617125984252, 0.125231299212598429,
    0.147036171259842502, 0.136118356299212595, 0.165639763779527549, 0.183316929133858275,
};
constexpr double S_out_v_L[MODEL_LAYERS] = {
    0.0608390748031496092, 0.0607086614173228331, 0.0783027805118110126, 0.115618848425196846,
    0.101879306102362205, 0.108799212598425191, 0.113412893700787387, 0.12186454232283464,
    0.114508489173228353, 0.124144931102362202, 0.123676796259842514, 0.120589320866141728,
    0.126068528543307079, 0.114315944881889758, 0.12561515748031496, 0.123710629921259835,
    0.118372908464566926, 0.12726316437007873, 0.121504675196850404, 0.119458046259842521,
    0.129157234251968511, 0.120554872047244091, 0.120790477362204718, 0.126305364173228324,
    0.13476870078740158, 0.14102731299212598, 0.13578617125984252, 0.125231299212598429,
    0.147036171259842502, 0.136118356299212595, 0.165639763779527549, 0.183316929133858275,
};
constexpr double S_att_weights_L[MODEL_LAYERS] = {
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
    0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595, 0.00787401574803149595,
};
constexpr double S_v_cache_L[MODEL_LAYERS] = {
    0.0608390748031496092, 0.0607086614173228331, 0.0783027805118110126, 0.115618848425196846,
    0.101879306102362205, 0.108799212598425191, 0.113412893700787387, 0.12186454232283464,
    0.114508489173228353, 0.124144931102362202, 0.123676796259842514, 0.120589320866141728,
    0.126068528543307079, 0.114315944881889758, 0.12561515748031496, 0.123710629921259835,
    0.118372908464566926, 0.12726316437007873, 0.121504675196850404, 0.119458046259842521,
    0.129157234251968511, 0.120554872047244091, 0.120790477362204718, 0.126305364173228324,
    0.13476870078740158, 0.14102731299212598, 0.13578617125984252, 0.125231299212598429,
    0.147036171259842502, 0.136118356299212595, 0.165639763779527549, 0.183316929133858275,
};
constexpr double S_out_att_value_L[MODEL_LAYERS] = {
    0.00416769192913385867, 0.00626153420275590497, 0.0353100393700787399, 0.0061814099409448816,
    0.0119246739665354335, 0.0143832277312992089, 0.0133704478346456691, 0.019230591781496064,
    0.0150282972440944872, 0.0202471395177165336, 0.0211300442913385823, 0.0173588213582677175,
    0.0254729023129921239, 0.0242650406003936982, 0.0196958046259842513, 0.0229859744094488179,
    0.0213318159448818885, 0.022679164616141733, 0.0316218626968503835, 0.0299846210629921214,
    0.0347607037401574739, 0.0305942421259842515, 0.0281965120570866132, 0.0449040354330708588,
    0.0388287401574803209, 0.0369758858267716511, 0.0438548843503936969, 0.0549677042322834625,
    0.0599458661417322861, 0.0595072588582677142, 0.0723652805118110143, 0.183316929133858275,
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
        38, 39, 38, 39, 40, 40, 40, 40,
        40, 39, 39, 39, 40, 40, 40, 40,
        40, 40, 40, 40, 40, 40, 40, 40,
        40, 40, 40, 40, 40, 40, 40, 39,
    };
    constexpr int32_t REQUANT2_N_L[MODEL_LAYERS] = {
        36, 34, 32, 34, 35, 34, 35, 34,
        35, 35, 34, 35, 34, 34, 35, 35,
        35, 35, 35, 35, 35, 36, 36, 35,
        36, 36, 36, 36, 36, 36, 36, 37,
    };
    constexpr int32_t REQUANT3_N_L[MODEL_LAYERS] = {
        36, 37, 40, 38, 40, 38, 39, 41,
        38, 38, 38, 38, 38, 39, 39, 38,
        38, 38, 38, 39, 38, 38, 38, 38,
        39, 39, 39, 39, 39, 41, 40, 40,
    };
    constexpr int32_t REQUANT4_N_L[MODEL_LAYERS] = {
        35, 34, 33, 33, 33, 33, 33, 34,
        33, 33, 34, 34, 34, 33, 33, 34,
        33, 34, 34, 33, 33, 34, 33, 33,
        32, 32, 32, 33, 32, 35, 34, 34,
    };
    constexpr int32_t REQUANT_Q_N_L[MODEL_LAYERS] = {
        34, 34, 34, 33, 33, 33, 33, 33,
        33, 34, 34, 34, 34, 34, 35, 34,
        35, 34, 34, 34, 34, 34, 34, 34,
        34, 34, 34, 34, 34, 34, 35, 35,
    };
    constexpr int32_t REQUANT_K_N_L[MODEL_LAYERS] = {
        33, 34, 35, 35, 34, 35, 34, 34,
        35, 35, 35, 35, 35, 35, 35, 35,
        34, 35, 35, 35, 34, 34, 34, 35,
        34, 34, 35, 35, 35, 35, 35, 36,
    };
    constexpr int32_t REQUANT_V_N_L[MODEL_LAYERS] = {
        37, 36, 35, 36, 36, 36, 36, 36,
        36, 37, 36, 37, 36, 36, 36, 36,
        36, 36, 36, 36, 36, 36, 36, 36,
        36, 35, 36, 36, 36, 36, 36, 35,
    };
    constexpr int32_t REQUANT_HEAD_N_L[MODEL_LAYERS] = {
        34, 34, 36, 33, 34, 35, 34, 35,
        35, 35, 35, 35, 35, 35, 35, 35,
        35, 35, 36, 35, 36, 36, 35, 36,
        36, 36, 36, 36, 36, 36, 36, 37,
    };

    // Per-layer M values (derived from fpga_requant_scales.json)
    constexpr int32_t REQUANT1_M_L[MODEL_LAYERS] = {
        1327155345, 1877581332, 1121770379, 1335105884, 1986003574, 2022416309, 1701056716, 1843177882,
        2127185359, 1222533542, 1152432794, 1174195649, 2040994365, 1938365319, 2143296204, 1821253421,
        1901769755, 1812839837, 1491134824, 1430491848, 1360488980, 1344087246, 1316306227, 1289071286,
        1207339394, 1211946690, 1164221051, 1352812705, 1304212626, 1495089141, 1778700841, 1093266750,
    };
    constexpr int32_t REQUANT2_M_L[MODEL_LAYERS] = {
        1891276416, 1083353541, 1228280479, 1183481191, 2055031073, 1258082698, 2002495654, 1227353510,
        1355299011, 1541615730, 1128743756, 1196573058, 1148112575, 1564004706, 1333445550, 1646285336,
        1357872344, 1230710287, 1114117934, 1665051696, 1794142999, 2058418627, 1558583630, 1185901099,
        1778649693, 1247986881, 2036308397, 1913304188, 1575885866, 1418628174, 1719304928, 1409968712,
    };
    constexpr int32_t REQUANT3_M_L[MODEL_LAYERS] = {
        1212721363, 1830774138, 2091892029, 1640483749, 1186429248, 1600765507, 1523633650, 1611405751,
        1179374803, 1235471906, 1261181148, 1246055618, 1163649806, 1892318635, 2070060139, 1123503289,
        1173665081, 1190962547, 1156862877, 1897255119, 1169889215, 1188367857, 1188367857, 1158705994,
        2142212456, 1861641115, 1748271944, 1448767189, 1144723707, 1479215855, 1358557526, 1716635237,
    };
    constexpr int32_t REQUANT4_M_L[MODEL_LAYERS] = {
        1543107617, 1944201758, 1158751581, 1965714821, 1204242151, 1162885539, 1265582405, 1622950960,
        1581837433, 1156762395, 1801931071, 1738207922, 1912302809, 1213120586, 1090144860, 1776342592,
        1289713591, 2083926238, 1955582923, 1221125144, 1750554828, 2111211447, 1410190652, 1755609494,
        1106139011, 1390530952, 1227207518, 2050565864, 1112712021, 2017086212, 1452060238, 1925544278,
    };
    constexpr int32_t REQUANT_Q_M_L[MODEL_LAYERS] = {
        1641438417, 1998092460, 1193900646, 1192019660, 1996895665, 1567220895, 1654101614, 1237373666,
        1209718139, 1551504519, 1245853515, 1135932244, 1250210809, 1236883774, 2007320771, 1130783653,
        2034845656, 1299527569, 1519832061, 1528575778, 1581727687, 1683508697, 1942286710, 1920433503,
        1945397817, 2002564987, 1872097985, 1724118167, 1382249256, 1378365647, 1764434669, 1277662338,
    };
    constexpr int32_t REQUANT_K_M_L[MODEL_LAYERS] = {
        1123508819, 1783607959, 2006925012, 1708839373, 1818828536, 1812830139, 1433999384, 1203002176,
        1605914037, 1865196689, 1182658047, 1853841422, 1290217555, 1451741519, 1127923100, 1273559367,
        1520418384, 1344146541, 2087993579, 2123440243, 1149681698, 1159397499, 1230114916, 2015269725,
        1186218181, 1151851290, 1969772663, 2096284643, 1684196909, 1549080658, 1388837190, 1585842198,
    };
    constexpr int32_t REQUANT_V_M_L[MODEL_LAYERS] = {
        1952196175, 1326417311, 1164602470, 1150340651, 2022333826, 1362546524, 1947571256, 1890431990,
        1341783438, 2034760025, 1950031589, 1926541085, 1140192258, 1637564434, 1443359221, 1804685022,
        1634735555, 1572818774, 1960157238, 2018021224, 2021096488, 1993210769, 1837079513, 1873015392,
        2024479029, 1121737530, 2116284679, 2111475112, 1838525709, 1745086782, 1397572015, 2105895712,
    };
    constexpr int32_t REQUANT_HEAD_M_L[MODEL_LAYERS] = {
        1974709082, 1311553563, 1199927772, 1265106914, 1155727896, 2046517783, 1147446932, 1714473750,
        2061455838, 1658866526, 1583557898, 1879467165, 1338980897, 1274594134, 1725497947, 1456096730,
        1501310832, 1518174846, 2079130087, 1077861526, 2010510285, 2132166865, 1159000000, 1521992619,
        1878070388, 2063767491, 1675381423, 1232768164, 1327214350, 1237721325, 1238541250, 1082196484,
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
