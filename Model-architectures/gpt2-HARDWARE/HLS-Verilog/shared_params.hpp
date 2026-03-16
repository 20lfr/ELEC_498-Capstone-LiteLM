#pragma once
#include <cstdint>

// LiteLM Shared Parameters — single source of truth for HLS and firmware.

// GPT-2 small model parameters
constexpr int MODEL_LAYERS            = 12;
constexpr int MODEL_HEADS             = 12;
constexpr int MODEL_HIDDEN_SIZE       = 768;
constexpr int MODEL_HEAD_DIMENSTION   = 64;
constexpr int MODEL_INTERMEDIATE_SIZE = 3072;
constexpr int MODEL_CONTEXT_LENGTH    = 1024;
constexpr int MODEL_VOCAB_SIZE        = 50257;
constexpr int16_t ATTN_SCALE_Q15      = 8192; // Q1.15: round((1/sqrt(64)) * 2^15 * 2) = 8192 (0x2000)
// NOTE: factor-of-2 vs naive formula because Q0.7 inputs contribute 2^14 per raw dot product unit,
// so correct mapping to Q1.15 is raw_dot/4 (>>2), not raw_dot/8 (>>3).

constexpr int max2_constexpr(int a, int b) { return (a > b) ? a : b; }
constexpr int min2_constexpr(int a, int b) { return (a < b) ? a : b; }
constexpr int div_ceil_constexpr(int a, int b) { return (a + b - 1) / b; }

// ------------------------------------------------------------
// Tunable architecture parameters::
// ------------------------------------------------------------
#define FULL_MODEL_TEST

#ifdef FULL_MODEL_TEST
    // Architecture params
    constexpr int NUM_LAYERS    = 12;
    constexpr int D_MODEL       = 768;
    constexpr int D_FFN         = 3072;
    constexpr int D_VOCAB       = 50257;
    constexpr int CONTEXT_LENGTH = 1024;
    constexpr int D_HEADS       = 64;
    constexpr int NUM_HEADS     = D_MODEL / D_HEADS;
    // Tile widths (primary — tile counts derived below)
    // NOTE: These tile widths strongly affect compute_buf::IN_BUF_BYTES (mmu_in_buf).
    // Chosen to minimize mmu_in_buf (driven by LOGITS_IN_BYTES vs ARGMAX_IN_BYTES tradeoff).
    constexpr int D_TILE_WO            = 16;  // 48 tiles over D_MODEL=768
    constexpr int D_TILE_W1            = 16;  // 192 tiles over D_FFN=3072
    constexpr int D_TILE_W2            = 8;   // 96 tiles over D_MODEL=768; increased from 4 to unlock MAC_OP_TO_BUF_OUT_UNROLL=8
    constexpr int D_TILE_LOGIT         = 16;  // 3142 tiles over D_VOCAB=50257 (ceil); must be divisible by MAC_OP_TO_BUF_OUT_UNROLL_TARGET
    constexpr int D_HEAD_TILE_QKV      = 4;   // 16 tiles over D_HEADS=64
    constexpr int ATT_CTX_BLOCK        = 64;
    constexpr int D_HEAD_TILE_ATT_VALUE = 4;  // 16 tiles over D_HEADS=64
#else
    // Architecture params
    constexpr int NUM_LAYERS    = 4;
    constexpr int D_MODEL       = 16;
    constexpr int D_FFN         = 24;
    constexpr int D_VOCAB       = 32;
    constexpr int CONTEXT_LENGTH = 16;
    constexpr int D_HEADS       = 4;
    constexpr int NUM_HEADS     = D_MODEL / D_HEADS;
    // Tile widths (primary — tile counts derived below)
    constexpr int D_TILE_WO            = 4;
    constexpr int D_TILE_W1            = 3;
    constexpr int D_TILE_W2            = 4;
    constexpr int D_TILE_LOGIT         = 16;
    constexpr int D_HEAD_TILE_QKV      = 2;
    constexpr int ATT_CTX_BLOCK        = 8;
    constexpr int D_HEAD_TILE_ATT_VALUE = 2;
#endif

// Derived tile counts (from tile widths above)
constexpr int NUM_WO_TILES             = D_MODEL / D_TILE_WO;
constexpr int NUM_W1_TILES             = D_FFN   / D_TILE_W1;
constexpr int NUM_W2_TILES             = D_MODEL / D_TILE_W2;
constexpr int NUM_LOGIT_TILES          = div_ceil_constexpr(D_VOCAB, D_TILE_LOGIT);
constexpr int NUM_QKV_HEAD_TILES       = D_HEADS / D_HEAD_TILE_QKV;
constexpr int NUM_ATT_VALUE_HEAD_TILES = D_HEADS / D_HEAD_TILE_ATT_VALUE;


// Per-function cyclic unroll targets — one named constant per function per parallelized dimension.
// Naming: {FUNCTION_NAME}_{VEC|OUT|CTX}_UNROLL_TARGET
//   VEC = inner dot-product / input dimension
//   OUT = output tile / accumulation dimension
//   CTX = CONTEXT_LENGTH dimension

// compute_controller.cpp
constexpr int MAC_OP_TO_BUF_VEC_UNROLL_TARGET         = 16;  // vectorA / matrixB inner dim       | D_MODEL=768%16=0, D_FFN=3072%16=0
constexpr int MAC_OP_TO_BUF_OUT_UNROLL_TARGET         =  8;  // bias / accum_vector output tile   | ACCUM_MAX=16%8=0 (unlocked by D_TILE_W2=8, D_TILE_LOGIT=16)
constexpr int RES_ADD_TO_BUF_VEC_UNROLL_TARGET        =  8;  // x_local / r_local over D_MODEL    | adds = LUTs not DSPs, keep at 8
constexpr int FFN_ACT_TO_BUF_VEC_UNROLL_TARGET        = 16;  // gate_local over D_FFN             | D_FFN=3072%16=0

// headed_compute_controller.cpp
constexpr int VALUE_SCALE_CLAMP_CTX_UNROLL_TARGET         = 4;   // input / output over CONTEXT_LENGTH       | not major DSP consumer
constexpr int SOFTMAX_CTX_UNROLL_TARGET                   = 4;   // input / exp_buf / output over CONTEXT_LENGTH | not major DSP consumer
constexpr int VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL_TARGET  = 4;   // x_local over CONTEXT_LENGTH              | not major DSP consumer
constexpr int QKV_TO_BUF_VEC_UNROLL_TARGET                = 16;  // weight_tile inner dim over D_HEADS       | D_HEADS=64%16=0
constexpr int ATT_SCORES_TO_BUF_VEC_UNROLL_TARGET         = 16;  // q_local / k_local over D_HEADS           | D_HEADS=64%16=0
constexpr int ATT_SCORES_TO_BUF_OUT_UNROLL_TARGET         =  4;  // acc_tile over ATT_CTX_BLOCK              | ATT_CTX_BLOCK=64%4=0
constexpr int ATT_VALUE_TO_BUF_CTX_UNROLL_TARGET          =  8;  // weight_local / v_local over CONTEXT_LENGTH | CONTEXT_LENGTH=1024%8=0
constexpr int ATT_VALUE_TO_BUF_OUT_UNROLL_TARGET          =  4;  // acc_out over D_HEAD_TILE_ATT_VALUE        | D_HEAD_TILE_ATT_VALUE=4%4=0

// Specialized MAC datapaths — per-operand-width unroll targets.
// Each type gets its own VEC (input dim) and OUT (output tile) target.
// int8×int8:  CMP_OUT_PROJ (D_MODEL→D_TILE_WO),  CMP_FFN_W1 (D_MODEL→D_TILE_W1)
// int16×int8: CMP_FFN_W2   (D_FFN→D_TILE_W2)
// int32×int8: CMP_LOGITS   (D_MODEL→D_TILE_LOGIT)
constexpr int MAC_I8I8_VEC_UNROLL_TARGET   = 16;  // D_MODEL=768%16=0
constexpr int MAC_I8I8_OUT_UNROLL_TARGET   =  8;  // ACCUM_MAX_I8I8=max(D_TILE_WO,D_TILE_W1)=16, 16%8=0
constexpr int MAC_I16I8_VEC_UNROLL_TARGET  = 16;  // D_FFN=3072%16=0
constexpr int MAC_I16I8_OUT_UNROLL_TARGET  =  8;  // ACCUM_MAX_I16I8=D_TILE_W2=8, 8%8=0
constexpr int MAC_I32I8_VEC_UNROLL_TARGET  =  8;  // D_MODEL=768%8=0 (int32 muls are heavier, less unroll)
constexpr int MAC_I32I8_OUT_UNROLL_TARGET  =  8;  // ACCUM_MAX_I32I8=D_TILE_LOGIT=16, 16%8=0

// Non-MAC cyclic tile used by scalar/vector helper loops (legacy
// MAX_CYCLIC_SIZE use).
constexpr int NORM_TILE_SIZE  = 16;
constexpr int MAX_CYCLIC_SIZE = NORM_TILE_SIZE;

// Top-level lane parallelism
constexpr int HEADS_PARALLEL = 2;



constexpr int STREAM_IN_BUF_BYTES  = D_MODEL;
constexpr int STREAM_OUT_BUF_BYTES = 4;

static_assert((D_MODEL % D_TILE_WO) == 0,            "D_MODEL must be divisible by D_TILE_WO");
static_assert((D_FFN   % D_TILE_W1) == 0,            "D_FFN must be divisible by D_TILE_W1");
static_assert((D_MODEL % D_TILE_W2) == 0,            "D_MODEL must be divisible by D_TILE_W2");
static_assert((D_MODEL % D_HEADS) == 0,              "D_MODEL must be divisible by D_HEADS");
static_assert((D_HEADS % D_HEAD_TILE_QKV) == 0,      "D_HEADS must be divisible by D_HEAD_TILE_QKV");
static_assert((D_HEADS % D_HEAD_TILE_ATT_VALUE) == 0, "D_HEADS must be divisible by D_HEAD_TILE_ATT_VALUE");
static_assert((D_TILE_LOGIT > 0),                    "D_TILE_LOGIT must be positive");
static_assert(((D_TILE_LOGIT * NUM_LOGIT_TILES) >= D_VOCAB), "D_TILE_LOGIT*NUM_LOGIT_TILES must cover D_VOCAB");

// AXI-Full DDR beat sizing (one m_axi_gmem data beat).
// Keep this aligned with the top-level DDR port element type.
constexpr int NUM_ATT_CTX_BLOCKS      = CONTEXT_LENGTH / ATT_CTX_BLOCK;
constexpr int NUM_HEAD_GROUPS         = (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;
constexpr int AXI_GMEM_WORD_BYTES     = 4;
constexpr int AXI_GMEM_WORD_BITS      = AXI_GMEM_WORD_BYTES * 8;

static_assert((CONTEXT_LENGTH % ATT_CTX_BLOCK) == 0,
              "CONTEXT_LENGTH must be divisible by ATT_CTX_BLOCK");
static_assert((D_MODEL % 2) == 0,
              "D_MODEL must be even");
static_assert((AXI_GMEM_WORD_BITS % 8) == 0,
              "AXI_GMEM_WORD_BITS must be byte aligned");

// Precision
constexpr uint32_t INT4_BITS = 4;
constexpr uint32_t INT8_BITS = 8;

// Resource estimation (uses tunable params)
constexpr uint32_t RESIDUAL_BITS   = D_MODEL * INT8_BITS;
constexpr uint32_t RESIDUAL_KB     = RESIDUAL_BITS / 1024;
constexpr uint32_t HEAD_WEIGHT_COUNT  = D_MODEL * D_HEADS;
constexpr uint32_t HEAD_WEIGHT_BITS   = HEAD_WEIGHT_COUNT * INT8_BITS;
constexpr uint32_t HEAD_WEIGHT_KB     = HEAD_WEIGHT_BITS / 1024;
constexpr uint32_t HEAD_CONCAT_BITS   = NUM_HEADS * D_HEADS * INT8_BITS;
constexpr uint32_t HEAD_CONCAT_KB     = HEAD_CONCAT_BITS / 1024;
constexpr uint32_t W_QKVO_COUNT       = D_MODEL * D_MODEL;
constexpr uint32_t W_QKVO_BITS        = W_QKVO_COUNT * INT8_BITS;
constexpr uint32_t W_QKVO_KB          = W_QKVO_BITS / 1024;
constexpr uint32_t W_FFN_COUNT        = D_MODEL * D_FFN;
constexpr uint32_t W_FFN_BITS         = W_FFN_COUNT * INT8_BITS;
constexpr uint32_t W_FFN_KB           = W_FFN_BITS / 1024;
constexpr uint32_t W1_GATE_UP_KB      = W_FFN_KB;

// KV cache sizing
constexpr uint32_t KV_CACHE_HEAD_ITEMS  = CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t KV_CACHE_HEAD_BYTES  = KV_CACHE_HEAD_ITEMS;
constexpr uint32_t KV_CACHE_HEAD_KB     = KV_CACHE_HEAD_BYTES / 1024;
constexpr uint32_t KV_CACHE_LAYER_ITEMS = NUM_HEADS * CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t KV_CACHE_LAYER_BYTES = KV_CACHE_LAYER_ITEMS;
constexpr uint32_t KV_CACHE_TOTAL_ITEMS = NUM_LAYERS * NUM_HEADS * CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t KV_CACHE_TOTAL_BYTES = KV_CACHE_TOTAL_ITEMS;
constexpr uint32_t KV_PER_TOKEN         = 2 * NUM_LAYERS * NUM_HEADS * D_HEADS;

// DDR memory section sizes (bytes). The stored DDR image is packed using the
// implemented (compact) HLS dims (NUM_LAYERS / D_MODEL / D_FFN / D_VOCAB / CONTEXT_LENGTH).
constexpr uint32_t MEM_WQ      = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_MODEL * D_MODEL);
constexpr uint32_t MEM_WK      = MEM_WQ;
constexpr uint32_t MEM_WV      = MEM_WQ;
constexpr uint32_t MEM_WO      = MEM_WQ;
constexpr uint32_t MEM_W1_GATE = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_FFN * D_MODEL);
constexpr uint32_t MEM_W1_UP   = 0u;
constexpr uint32_t MEM_W2      = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_MODEL * D_FFN);
constexpr uint32_t MEM_EMBED   = 0u;

// Q/K/V bias slabs (packed as int32, typically Q16.16) used by headed Q/K/V compute.
// Included to match the reference ordering used by test_data/test_gpt2_int8.py.
constexpr uint32_t MEM_WQ_BIAS = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_MODEL * sizeof(int32_t));
constexpr uint32_t MEM_WK_BIAS = MEM_WQ_BIAS;
constexpr uint32_t MEM_WV_BIAS = MEM_WQ_BIAS;

constexpr uint32_t MEM_WO_BIAS          = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_MODEL * sizeof(int32_t));
constexpr uint32_t MEM_W1_BIAS          = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_FFN * sizeof(int32_t));
constexpr uint32_t MEM_W2_BIAS          = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_MODEL * sizeof(int32_t));
constexpr uint32_t MEM_LN0_GAMMA        = static_cast<uint32_t>(static_cast<uint64_t>(NUM_LAYERS) * D_MODEL * sizeof(int32_t));
constexpr uint32_t MEM_LN0_BETA         = MEM_LN0_GAMMA;
constexpr uint32_t MEM_LN1_GAMMA        = MEM_LN0_GAMMA;
constexpr uint32_t MEM_LN1_BETA         = MEM_LN1_GAMMA;
constexpr uint32_t MEM_FINAL_NORM_GAMMA = D_MODEL * sizeof(int32_t);
constexpr uint32_t MEM_FINAL_NORM_BETA  = MEM_FINAL_NORM_GAMMA;
constexpr uint32_t MEM_LN0_EPS          = NUM_LAYERS * sizeof(uint32_t);
constexpr uint32_t MEM_LN1_EPS          = MEM_LN0_EPS;
constexpr uint32_t MEM_FINAL_NORM_EPS   = sizeof(uint32_t);
constexpr uint32_t MEM_WLOGIT           = static_cast<uint32_t>(static_cast<uint64_t>(D_VOCAB) * D_MODEL);
constexpr uint32_t MEM_POS_EMBED        = static_cast<uint32_t>(static_cast<uint64_t>(CONTEXT_LENGTH) * D_MODEL);
constexpr uint32_t MEM_GAMMA            = MEM_LN0_GAMMA + MEM_LN0_BETA + MEM_LN1_GAMMA + MEM_LN1_BETA + MEM_FINAL_NORM_GAMMA + MEM_FINAL_NORM_BETA;
constexpr uint32_t MEM_BIAS             = MEM_WO_BIAS + MEM_W1_BIAS + MEM_W2_BIAS;
constexpr uint32_t MEM_K_CACHE          = KV_CACHE_TOTAL_BYTES;
constexpr uint32_t MEM_V_CACHE          = KV_CACHE_TOTAL_BYTES;

static_assert((NUM_W1_TILES > 0), "NUM_W1_TILES must be positive");

// ---- Cyclic-factor divisibility asserts ----
// Rule: array_size % cyclic_factor == 0 for every #pragma HLS ARRAY_PARTITION cyclic.
// When dim < TARGET, min() returns dim and dim%dim==0 — only the dim>=TARGET case needs checking.

// MAC_OP_TO_BUF — vector (column) dimension
static_assert(D_MODEL % MAC_OP_TO_BUF_VEC_UNROLL_TARGET == 0 || D_MODEL < MAC_OP_TO_BUF_VEC_UNROLL_TARGET,
    "D_MODEL must be divisible by MAC_OP_TO_BUF_VEC_UNROLL_TARGET for cyclic partition");
static_assert(D_FFN % MAC_OP_TO_BUF_VEC_UNROLL_TARGET == 0 || D_FFN < MAC_OP_TO_BUF_VEC_UNROLL_TARGET,
    "D_FFN must be divisible by MAC_OP_TO_BUF_VEC_UNROLL_TARGET for cyclic partition");

// MAC_OP_TO_BUF — accumulation (output tile) dimension
static_assert(D_TILE_WO % MAC_OP_TO_BUF_OUT_UNROLL_TARGET == 0 || D_TILE_WO < MAC_OP_TO_BUF_OUT_UNROLL_TARGET,
    "D_TILE_WO must be divisible by MAC_OP_TO_BUF_OUT_UNROLL_TARGET for cyclic partition");
static_assert(D_TILE_W1 % MAC_OP_TO_BUF_OUT_UNROLL_TARGET == 0 || D_TILE_W1 < MAC_OP_TO_BUF_OUT_UNROLL_TARGET,
    "D_TILE_W1 must be divisible by MAC_OP_TO_BUF_OUT_UNROLL_TARGET for cyclic partition");
static_assert(D_TILE_W2 % MAC_OP_TO_BUF_OUT_UNROLL_TARGET == 0 || D_TILE_W2 < MAC_OP_TO_BUF_OUT_UNROLL_TARGET,
    "D_TILE_W2 must be divisible by MAC_OP_TO_BUF_OUT_UNROLL_TARGET for cyclic partition");
static_assert(D_TILE_LOGIT % MAC_OP_TO_BUF_OUT_UNROLL_TARGET == 0 || D_TILE_LOGIT < MAC_OP_TO_BUF_OUT_UNROLL_TARGET,
    "D_TILE_LOGIT must be divisible by MAC_OP_TO_BUF_OUT_UNROLL_TARGET for cyclic partition");

// RES_ADD_TO_BUF / FFN_ACT_TO_BUF — vector dimension
static_assert(D_MODEL % RES_ADD_TO_BUF_VEC_UNROLL_TARGET == 0 || D_MODEL < RES_ADD_TO_BUF_VEC_UNROLL_TARGET,
    "D_MODEL must be divisible by RES_ADD_TO_BUF_VEC_UNROLL_TARGET for cyclic partition");
static_assert(D_FFN % FFN_ACT_TO_BUF_VEC_UNROLL_TARGET == 0 || D_FFN < FFN_ACT_TO_BUF_VEC_UNROLL_TARGET,
    "D_FFN must be divisible by FFN_ACT_TO_BUF_VEC_UNROLL_TARGET for cyclic partition");

// QKV_TO_BUF / ATT_SCORES_TO_BUF — vector (D_HEADS) dimension
static_assert(D_HEADS % QKV_TO_BUF_VEC_UNROLL_TARGET == 0 || D_HEADS < QKV_TO_BUF_VEC_UNROLL_TARGET,
    "D_HEADS must be divisible by QKV_TO_BUF_VEC_UNROLL_TARGET for cyclic partition");
static_assert(D_HEADS % ATT_SCORES_TO_BUF_VEC_UNROLL_TARGET == 0 || D_HEADS < ATT_SCORES_TO_BUF_VEC_UNROLL_TARGET,
    "D_HEADS must be divisible by ATT_SCORES_TO_BUF_VEC_UNROLL_TARGET for cyclic partition");

// ATT_SCORES_TO_BUF — output (context block) dimension
static_assert(ATT_CTX_BLOCK % ATT_SCORES_TO_BUF_OUT_UNROLL_TARGET == 0 || ATT_CTX_BLOCK < ATT_SCORES_TO_BUF_OUT_UNROLL_TARGET,
    "ATT_CTX_BLOCK must be divisible by ATT_SCORES_TO_BUF_OUT_UNROLL_TARGET for cyclic partition");

// ATT_VALUE_TO_BUF — output tile dimension
static_assert(D_HEAD_TILE_ATT_VALUE % ATT_VALUE_TO_BUF_OUT_UNROLL_TARGET == 0 || D_HEAD_TILE_ATT_VALUE < ATT_VALUE_TO_BUF_OUT_UNROLL_TARGET,
    "D_HEAD_TILE_ATT_VALUE must be divisible by ATT_VALUE_TO_BUF_OUT_UNROLL_TARGET for cyclic partition");

// Context-dimension functions (VALUE_SCALE_CLAMP, SOFTMAX, VALUE_SCALE_CLAMP_TO_BUF, ATT_VALUE_TO_BUF)
static_assert(CONTEXT_LENGTH % VALUE_SCALE_CLAMP_CTX_UNROLL_TARGET == 0 || CONTEXT_LENGTH < VALUE_SCALE_CLAMP_CTX_UNROLL_TARGET,
    "CONTEXT_LENGTH must be divisible by VALUE_SCALE_CLAMP_CTX_UNROLL_TARGET for cyclic partition");
static_assert(CONTEXT_LENGTH % SOFTMAX_CTX_UNROLL_TARGET == 0 || CONTEXT_LENGTH < SOFTMAX_CTX_UNROLL_TARGET,
    "CONTEXT_LENGTH must be divisible by SOFTMAX_CTX_UNROLL_TARGET for cyclic partition");
static_assert(CONTEXT_LENGTH % VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL_TARGET == 0 || CONTEXT_LENGTH < VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL_TARGET,
    "CONTEXT_LENGTH must be divisible by VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL_TARGET for cyclic partition");
static_assert(CONTEXT_LENGTH % ATT_VALUE_TO_BUF_CTX_UNROLL_TARGET == 0 || CONTEXT_LENGTH < ATT_VALUE_TO_BUF_CTX_UNROLL_TARGET,
    "CONTEXT_LENGTH must be divisible by ATT_VALUE_TO_BUF_CTX_UNROLL_TARGET for cyclic partition");

// Strides (bytes): addr = base + layer * layer_stride + head/tile * sub_stride
constexpr uint32_t STRIDE_WQ_LAYER      = D_MODEL * D_MODEL;
constexpr uint32_t STRIDE_WK_LAYER      = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_WV_LAYER      = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_WO_LAYER      = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_QKV_HEAD      = D_HEADS * D_MODEL;
constexpr uint32_t STRIDE_QKV_HEAD_TILE = D_HEAD_TILE_QKV * D_MODEL;
constexpr uint32_t STRIDE_QKV_HEAD_BIAS      = D_HEADS * sizeof(int32_t);
constexpr uint32_t STRIDE_QKV_HEAD_TILE_BIAS = D_HEAD_TILE_QKV * sizeof(int32_t);

constexpr uint32_t STRIDE_WO_TILE      = D_TILE_WO * D_MODEL;
constexpr uint32_t STRIDE_W1_TILE      = D_TILE_W1 * D_MODEL;
constexpr uint32_t STRIDE_W2_TILE      = D_TILE_W2 * D_FFN;
constexpr uint32_t STRIDE_WO_BIAS_TILE = D_TILE_WO * sizeof(int32_t);
constexpr uint32_t STRIDE_W1_BIAS_TILE = D_TILE_W1 * sizeof(int32_t);
constexpr uint32_t STRIDE_W2_BIAS_TILE = D_TILE_W2 * sizeof(int32_t);
constexpr uint32_t STRIDE_WLOGIT_TILE  = D_TILE_LOGIT * D_MODEL;
constexpr uint32_t STRIDE_LN0_GAMMA    = D_MODEL * sizeof(int32_t);
constexpr uint32_t STRIDE_LN1_GAMMA    = STRIDE_LN0_GAMMA;
constexpr uint32_t STRIDE_FINAL_NORM_GAMMA = D_MODEL * sizeof(int32_t);
constexpr uint32_t STRIDE_LN0_EPS          = sizeof(uint32_t);
constexpr uint32_t STRIDE_LN1_EPS          = sizeof(uint32_t);
constexpr uint32_t STRIDE_FINAL_NORM_EPS   = sizeof(uint32_t);
constexpr uint32_t STRIDE_W1_GATE_LAYER    = D_FFN * D_MODEL;
constexpr uint32_t STRIDE_W1_UP_LAYER      = 0u;
constexpr uint32_t STRIDE_W2_LAYER         = D_MODEL * D_FFN;
constexpr uint32_t STRIDE_WQ_BIAS_LAYER    = D_MODEL * sizeof(int32_t);
constexpr uint32_t STRIDE_WK_BIAS_LAYER    = STRIDE_WQ_BIAS_LAYER;
constexpr uint32_t STRIDE_WV_BIAS_LAYER    = STRIDE_WQ_BIAS_LAYER;
constexpr uint32_t STRIDE_WO_BIAS_LAYER    = D_MODEL * sizeof(int32_t);
constexpr uint32_t STRIDE_W1_BIAS_LAYER    = D_FFN * sizeof(int32_t);
constexpr uint32_t STRIDE_W2_BIAS_LAYER    = D_MODEL * sizeof(int32_t);
constexpr uint32_t STRIDE_KV_LAYER         = NUM_HEADS * CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t STRIDE_KV_HEAD          = CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t STRIDE_KV_CTX_BLOCK     = ATT_CTX_BLOCK * D_HEADS;
constexpr uint32_t STRIDE_KV_TOKEN         = D_HEADS;

// DDR Memory Offsets
constexpr uint64_t align64_u64(uint64_t v) { return (v + 63ull) & ~63ull; }
constexpr uint32_t align64_u32(uint32_t v) { return (v + 63u) & ~63u; }

// Packed DDR layout (64B-aligned) matching test_data/test_gpt2_int8.py::compute_layout().
// NOTE: Sections that are currently unused by hardware may remain zero-filled.
constexpr uint32_t WQ_OFF   = 0u;
constexpr uint32_t WK_OFF   = align64_u32(WQ_OFF + MEM_WQ);
constexpr uint32_t WV_OFF   = align64_u32(WK_OFF + MEM_WK);
constexpr uint32_t WO_OFF   = align64_u32(WV_OFF + MEM_WV);
constexpr uint32_t W1_OFF   = align64_u32(WO_OFF + MEM_WO);
constexpr uint32_t W2_OFF   = align64_u32(W1_OFF + MEM_W1_GATE);
constexpr uint32_t WLOGIT_OFF = align64_u32(W2_OFF + MEM_W2);

constexpr uint32_t WQ_BIAS_OFF = align64_u32(WLOGIT_OFF + MEM_WLOGIT);
constexpr uint32_t WK_BIAS_OFF = align64_u32(WQ_BIAS_OFF + MEM_WQ_BIAS);
constexpr uint32_t WV_BIAS_OFF = align64_u32(WK_BIAS_OFF + MEM_WK_BIAS);

constexpr uint32_t WO_BIAS_OFF = align64_u32(WV_BIAS_OFF + MEM_WV_BIAS);
constexpr uint32_t W1_BIAS_OFF = align64_u32(WO_BIAS_OFF + MEM_WO_BIAS);
constexpr uint32_t W2_BIAS_OFF = align64_u32(W1_BIAS_OFF + MEM_W1_BIAS);

constexpr uint32_t LN0_GAMMA_OFF = align64_u32(W2_BIAS_OFF + MEM_W2_BIAS);
constexpr uint32_t LN0_BETA_OFF  = align64_u32(LN0_GAMMA_OFF + MEM_LN0_GAMMA);
constexpr uint32_t LN1_GAMMA_OFF = align64_u32(LN0_BETA_OFF + MEM_LN0_BETA);
constexpr uint32_t LN1_BETA_OFF  = align64_u32(LN1_GAMMA_OFF + MEM_LN1_GAMMA);
constexpr uint32_t FINAL_NORM_GAMMA_OFF = align64_u32(LN1_BETA_OFF + MEM_LN1_BETA);
constexpr uint32_t FINAL_NORM_BETA_OFF  = align64_u32(FINAL_NORM_GAMMA_OFF + MEM_FINAL_NORM_GAMMA);

constexpr uint32_t LN0_EPS_OFF        = align64_u32(FINAL_NORM_BETA_OFF + MEM_FINAL_NORM_BETA);
constexpr uint32_t LN1_EPS_OFF        = align64_u32(LN0_EPS_OFF + MEM_LN0_EPS);
constexpr uint32_t FINAL_NORM_EPS_OFF = align64_u32(LN1_EPS_OFF + MEM_LN1_EPS);

constexpr uint32_t POS_EMBED_OFF = align64_u32(FINAL_NORM_EPS_OFF + MEM_FINAL_NORM_EPS);
constexpr uint32_t WEIGHTS_SIZE  = align64_u32(POS_EMBED_OFF + MEM_POS_EMBED);

constexpr uint32_t K_CACHE_OFF          = 0u;
constexpr uint32_t V_CACHE_OFF          = align64_u32(K_CACHE_OFF + MEM_V_CACHE);
constexpr uint32_t KV_SIZE              = align64_u32(V_CACHE_OFF + MEM_V_CACHE);

// ------------------------------------------------------------
// Control + IRQ bitfields
// ------------------------------------------------------------
// Bit positions: bit0 = reset_n, bit1 = start
constexpr uint32_t CTRL_RESETN_BIT     = 1u << 0;
constexpr uint32_t CTRL_START_BIT      = 1u << 1;
constexpr uint32_t CTRL_DEBUG_MODE_BIT = 1u << 3;

// IRQ Bits
constexpr uint32_t IRQ_ERROR_BIT      = 1u << 1;
constexpr uint32_t IRQ_INFER_DONE_BIT = 1u << 2;

// ------------------------------------------------------------
// Scheduler state + helper enums
// ------------------------------------------------------------
enum SchedState {
    S_IDLE,            // 0
    S_STREAM_IN,       // 1
    S_LAYER_COUNT,     // 2
    S_LAYER_NORM_0,    // 3
    S_ATTENTION_HEADS, // 4
    S_HEAD_CONCAT,     // 5
    S_OUT_PROJECTION,  // 6
    S_RES_ADD_1,       // 7
    S_LAYER_NORM_1,    // 8
    S_FFN,             // 9
    S_RES_ADD_2,       // 10
    S_LOOP_CHECK,      // 11
    S_FINAL_NORM,      // 12
    S_LOGITS,          // 13
    S_ARGMAX,          // 14
    S_STREAM_OUT,      // 15
    S_DEBUG            // 16
};

// Error Codes
constexpr uint32_t ERR_NONE = 0u;
constexpr uint32_t ERR_DMA_ALIGNMENT = 1u << 0;
constexpr uint32_t ERR_DMA_ZERO_LEN = 1u << 1;
constexpr uint32_t ERR_DMA_ZERO_STRIDE = 1u << 2;
constexpr uint32_t ERR_SCHEDULER_ERROR = 1u << 3;
constexpr uint32_t ERR_COMPUTE_ERROR = 1u << 4;
constexpr uint32_t ERR_MMU_INVALID = 1u << 5;
constexpr uint32_t ERR_MMU_OVERFLOW = 1u << 6;
constexpr uint32_t ERR_MMU_UNSUPPORTED_REQ_DMA = 1u << 7;
constexpr uint32_t ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED = 1u << 8;
constexpr uint32_t ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED = 1u << 9;
constexpr uint32_t ERR_MMU_BAD_DMA_PLAN = 1u << 11;
constexpr uint32_t ERR_MMU_BAD_DMA_ADDR = 1u << 12;
constexpr uint32_t ERR_MMU_REGION_ACCESS = 1u << 13;
constexpr uint32_t ERR_MMU_CONCAT_SOURCE = 1u << 14;
constexpr uint32_t ERR_MMU_WRITEBACK_SRC = 1u << 15;
constexpr uint32_t ERR_MMU_QUEUE_OVERFLOW = 1u << 16;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW = 1u << 17; // legacy/general
constexpr uint32_t ERR_MMU_STREAM_OUTPUT_MISSING = 1u << 18;
constexpr uint32_t ERR_MMU_MISSING_REGION_FULL_READ = 1u << 19;
constexpr uint32_t ERR_MMU_MISSING_REGION_PARTIAL_READ = 1u << 20;
constexpr uint32_t ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP = 1u << 21;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_STREAM_IN = 1u << 22;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_DMA_CONCAT = 1u << 23;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_DMA_STORE = 1u << 24;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE = 1u << 25;
constexpr uint32_t ERR_MMU_REGION_TABLE_FULL = 1u << 26;
constexpr uint32_t ERR_MMU_URAM_CHUNK_ALLOC_FAIL = 1u << 27;
constexpr uint32_t ERR_MMU_REGION_TOO_LARGE = 1u << 28;
constexpr uint32_t ERR_TOKEN_MAX = 1u << 29;

// MMU detailed subcodes (for richer debug than bitmask error_code alone)
constexpr uint32_t MMU_ERR_SUBCODE_NONE = 0;
constexpr uint32_t MMU_ERR_SUBCODE_UNSUPPORTED_REQ_DMA = 1;
constexpr uint32_t MMU_ERR_SUBCODE_UNSUPPORTED_REQ_COMPUTE_HEADED = 2;
constexpr uint32_t MMU_ERR_SUBCODE_UNSUPPORTED_REQ_COMPUTE_NONHEADED = 3;
constexpr uint32_t MMU_ERR_SUBCODE_BAD_DMA_PLAN = 4;
constexpr uint32_t MMU_ERR_SUBCODE_BAD_DMA_ADDR = 5;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_ACCESS = 6;
constexpr uint32_t MMU_ERR_SUBCODE_CONCAT_SOURCE = 7;
constexpr uint32_t MMU_ERR_SUBCODE_WRITEBACK_SRC = 8;
constexpr uint32_t MMU_ERR_SUBCODE_QUEUE_OVERFLOW = 9;
constexpr uint32_t MMU_ERR_SUBCODE_STREAM_OUTPUT_MISSING = 10;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_REGION_FULL_READ = 11;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_REGION_PARTIAL_READ = 12;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_REGION_COMPUTE_READ_PREP = 13;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_OVERFLOW_STREAM_IN = 14;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_OVERFLOW_DMA_CONCAT = 15;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_OVERFLOW_DMA_STORE = 16;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_OVERFLOW_COMPUTE_WRITE = 17;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_TABLE_FULL = 18;
constexpr uint32_t MMU_ERR_SUBCODE_URAM_CHUNK_ALLOC_FAIL = 19;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_TOO_LARGE = 20;
constexpr uint32_t MMU_ERR_SUBCODE_REGION_OVERFLOW_GENERIC = 21;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_STREAM_IN_TOKEN = 100;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN0_OUT = 101;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WQ_W = 102;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WQ_B = 103;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WK_W = 104;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WK_B = 105;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WV_W = 106;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WV_B = 107;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_Q_OUT = 108;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_CTX_K = 109;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_ATT_SCORES_OUT = 110;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_VALUE_SCALE_OUT = 111;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_SOFTMAX_OUT = 112;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_CTX_V = 113;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_ATT_VALUE_OUT = 114;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_HEAD_REQUANT_PACKED = 115;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_CONCAT_OUT = 116;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WO_W = 117;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_WO_B = 118;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_OUT_PROJ_PACKED = 119;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_RESID1_OUT = 120;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN1_OUT = 121;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W1_W = 122;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W1_B = 123;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FFN_W1_PACKED = 124;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FFN_ACT_OUT = 125;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W2_W = 126;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W2_B = 127;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FFN_W2_PACKED = 128;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_RESID2_OUT = 129;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN0_GAMMA = 130;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN0_EPS = 131;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN1_GAMMA = 132;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN1_EPS = 133;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LOGITS_W = 134;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LOGITS_PACKED = 135;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_ARGMAX_OUT = 136;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FINAL_NORM_GAMMA = 137;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FINAL_NORM_EPS = 138;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN0_BETA = 139;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN1_BETA = 140;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FINAL_NORM_BETA = 141;
