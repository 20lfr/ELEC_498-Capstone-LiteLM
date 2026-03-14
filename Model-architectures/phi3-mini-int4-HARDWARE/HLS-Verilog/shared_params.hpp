#pragma once
#include <cstdint>

// LiteLM Shared Parameters — single source of truth for HLS and firmware.

// REAL Full model layer count from fpga_requant_scales.json
constexpr int MODEL_LAYERS            = 32;
constexpr int MODEL_HEADS             = 32;
constexpr int MODEL_HIDDEN_SIZE       = 3072;
constexpr int MODEL_HEAD_DIMENSTION   = 96;
constexpr int MODEL_INTERMEDIATE_SIZE = 8192;
constexpr int MODEL_CONTEXT_LENGTH    = 2048;
constexpr int MODEL_VOCAB_SIZE        = 32064;
constexpr int16_t ATTN_SCALE_Q15      = 3344; // Q1.15: round((1/sqrt(96)) * 2^15) = 3344 (0x0D10)

constexpr int max2_constexpr(int a, int b) { return (a > b) ? a : b; }
constexpr int min2_constexpr(int a, int b) { return (a < b) ? a : b; }

// ------------------------------------------------------------
// Tunable architecture parameters::
// ------------------------------------------------------------
// Tiling controls
constexpr int NUM_WO_TILES             = 4;
constexpr int NUM_W1_TILES             = 8;
constexpr int NUM_W2_TILES             = 4;
constexpr int NUM_LOGIT_TILES          = 2;
constexpr int NUM_QKV_HEAD_TILES       = 2;
constexpr int ATT_CTX_BLOCK            = 8;
constexpr int NUM_ATT_VALUE_HEAD_TILES = 2;

// Parallelism controls
constexpr int MAIN_MAC_VEC_UNROLL_TARGET  = 8;
constexpr int MAIN_MAC_OUT_UNROLL_TARGET  = 4;
constexpr int HEAD_MAC_VEC_UNROLL_TARGET  = 8;
constexpr int HEAD_MAC_OUT_UNROLL_TARGET  = 2;
constexpr int CONTEXT_UNROLL_TARGET       = 4;

// Non-MAC cyclic tile used by scalar/vector helper loops (legacy
// MAX_CYCLIC_SIZE use).
constexpr int NORM_TILE_SIZE  = 16;
constexpr int MAX_CYCLIC_SIZE = NORM_TILE_SIZE;

// Top-level lane parallelism
constexpr int HEADS_PARALLEL = 2;

// Params used in architecture
constexpr int NUM_LAYERS           = 4;
constexpr int D_MODEL              = 16;
constexpr int D_FFN                = 24;
constexpr int D_VOCAB              = 32;
constexpr int CONTEXT_LENGTH       = 16;
constexpr int D_HEADS              = 4;
constexpr int NUM_HEADS            = D_MODEL / D_HEADS;

constexpr int D_HEAD_TILE_QKV      = D_HEADS / NUM_QKV_HEAD_TILES;
constexpr int D_TILE_WO            = D_MODEL / NUM_WO_TILES;
constexpr int D_TILE_W1            = D_FFN * 2 / NUM_W1_TILES;
constexpr int D_TILE_W2            = D_MODEL / NUM_W2_TILES;
constexpr int D_TILE_LOGIT         = D_VOCAB / NUM_LOGIT_TILES;
constexpr int STREAM_IN_BUF_BYTES  = D_MODEL;
constexpr int STREAM_OUT_BUF_BYTES = 4;

static_assert((D_HEADS % NUM_QKV_HEAD_TILES) == 0,
              "D_HEADS must divide NUM_QKV_HEAD_TILES");
static_assert((D_VOCAB % NUM_LOGIT_TILES) == 0,
              "D_VOCAB must divide NUM_LOGIT_TILES");
static_assert((D_MODEL % NUM_WO_TILES) == 0,
              "D_MODEL must divide NUM_WO_TILES");
static_assert(((D_FFN * 2) % NUM_W1_TILES) == 0,
              "2*D_FFN must divide NUM_W1_TILES");
static_assert((D_MODEL % NUM_W2_TILES) == 0,
              "D_MODEL must divide NUM_W2_TILES");

// AXI-Full DDR beat sizing (one m_axi_gmem data beat).
// Keep this aligned with the top-level DDR port element type.
constexpr int NUM_ATT_CTX_BLOCKS      = CONTEXT_LENGTH / ATT_CTX_BLOCK;
constexpr int D_HEAD_TILE_ATT_VALUE   = D_HEADS / NUM_ATT_VALUE_HEAD_TILES;
constexpr int NUM_HEAD_GROUPS         = (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;
constexpr int AXI_GMEM_WORD_BYTES     = 4;
constexpr int AXI_GMEM_WORD_BITS      = AXI_GMEM_WORD_BYTES * 8;

static_assert((CONTEXT_LENGTH % ATT_CTX_BLOCK) == 0,
              "CONTEXT_LENGTH must divide ATT_CTX_BLOCK");
static_assert((D_HEADS % NUM_ATT_VALUE_HEAD_TILES) == 0,
              "D_HEADS must divide NUM_ATT_VALUE_HEAD_TILES");
static_assert((D_MODEL % 2) == 0,
              "Head tiling expects D_MODEL to be nibble-aligned");
static_assert((AXI_GMEM_WORD_BITS % 8) == 0,
              "AXI_GMEM_WORD_BITS must be byte aligned");

// Precision
constexpr uint32_t INT4_BITS = 4;
constexpr uint32_t INT8_BITS = 8;

// Resource estimation (uses tunable params)
constexpr uint32_t RESIDUAL_BITS   = D_MODEL * INT8_BITS;
constexpr uint32_t RESIDUAL_KB     = RESIDUAL_BITS / 1024;
constexpr uint32_t HEAD_WEIGHT_COUNT  = D_MODEL * D_HEADS;
constexpr uint32_t HEAD_WEIGHT_BITS   = HEAD_WEIGHT_COUNT * INT4_BITS;
constexpr uint32_t HEAD_WEIGHT_KB     = HEAD_WEIGHT_BITS / 1024;
constexpr uint32_t HEAD_CONCAT_BITS   = NUM_HEADS * D_HEADS * INT8_BITS;
constexpr uint32_t HEAD_CONCAT_KB     = HEAD_CONCAT_BITS / 1024;
constexpr uint32_t W_QKVO_COUNT       = D_MODEL * D_MODEL;
constexpr uint32_t W_QKVO_BITS        = W_QKVO_COUNT * INT4_BITS;
constexpr uint32_t W_QKVO_KB          = W_QKVO_BITS / 1024;
constexpr uint32_t W_FFN_COUNT        = D_MODEL * D_FFN;
constexpr uint32_t W_FFN_BITS         = W_FFN_COUNT * INT4_BITS;
constexpr uint32_t W_FFN_KB           = W_FFN_BITS / 1024;
constexpr uint32_t W1_GATE_UP_KB      = W_FFN_KB * 2;

// KV cache sizing
constexpr uint32_t KV_CACHE_HEAD_ITEMS  = CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t KV_CACHE_HEAD_BYTES  = KV_CACHE_HEAD_ITEMS;
constexpr uint32_t KV_CACHE_HEAD_KB     = KV_CACHE_HEAD_BYTES / 1024;
constexpr uint32_t KV_CACHE_LAYER_ITEMS = NUM_HEADS * CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t KV_CACHE_LAYER_BYTES = KV_CACHE_LAYER_ITEMS;
constexpr uint32_t KV_CACHE_TOTAL_ITEMS = NUM_LAYERS * NUM_HEADS * CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t KV_CACHE_TOTAL_BYTES = KV_CACHE_TOTAL_ITEMS;
constexpr uint32_t KV_PER_TOKEN         = 2 * NUM_LAYERS * NUM_HEADS * D_HEADS;

// DDR memory section sizes (bytes, int4 packed = elems/2)
constexpr uint32_t MEM_WQ               = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_LAYERS) * MODEL_HIDDEN_SIZE * MODEL_HIDDEN_SIZE / 2ull);
constexpr uint32_t MEM_WK               = MEM_WQ;
constexpr uint32_t MEM_WV               = MEM_WQ;
constexpr uint32_t MEM_WO               = MEM_WQ;
constexpr uint32_t MEM_W1_GATE          = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_LAYERS) * MODEL_INTERMEDIATE_SIZE * MODEL_HIDDEN_SIZE / 2ull);
constexpr uint32_t MEM_W1_UP            = MEM_W1_GATE;
constexpr uint32_t MEM_W2               = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_LAYERS) * MODEL_HIDDEN_SIZE * MODEL_INTERMEDIATE_SIZE / 2ull);
constexpr uint32_t MEM_EMBED            = 0u;
constexpr uint32_t MEM_WO_BIAS          = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_LAYERS) * MODEL_HIDDEN_SIZE * sizeof(int32_t));
constexpr uint32_t MEM_W1_BIAS          = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_LAYERS) * (2 * MODEL_INTERMEDIATE_SIZE) * sizeof(int32_t));
constexpr uint32_t MEM_W2_BIAS          = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_LAYERS) * MODEL_HIDDEN_SIZE * sizeof(int32_t));
constexpr uint32_t MEM_LN0_GAMMA        = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_LAYERS) * MODEL_HIDDEN_SIZE * sizeof(int32_t));
constexpr uint32_t MEM_LN1_GAMMA        = MEM_LN0_GAMMA;
constexpr uint32_t MEM_FINAL_NORM_GAMMA = MODEL_HIDDEN_SIZE * sizeof(int32_t);
constexpr uint32_t MEM_LN0_EPS          = MODEL_LAYERS * sizeof(uint32_t);
constexpr uint32_t MEM_LN1_EPS          = MEM_LN0_EPS;
constexpr uint32_t MEM_FINAL_NORM_EPS   = sizeof(uint32_t);
constexpr uint32_t MEM_WLOGIT           = static_cast<uint32_t>(static_cast<uint64_t>(MODEL_VOCAB_SIZE) * MODEL_HIDDEN_SIZE / 2ull);
constexpr uint32_t MEM_GAMMA            = MEM_LN0_GAMMA + MEM_LN1_GAMMA + MEM_FINAL_NORM_GAMMA;
constexpr uint32_t MEM_BIAS             = MEM_WO_BIAS + MEM_W1_BIAS + MEM_W2_BIAS;
constexpr uint32_t MEM_K_CACHE          = KV_CACHE_TOTAL_BYTES;
constexpr uint32_t MEM_V_CACHE          = KV_CACHE_TOTAL_BYTES;

static_assert((NUM_W1_TILES % 2) == 0,
              "NUM_W1_TILES must split evenly between gate and up halves");

// Strides (bytes): addr = base + layer * layer_stride + head/tile * sub_stride
constexpr uint32_t STRIDE_WQ_LAYER         = MODEL_HIDDEN_SIZE * MODEL_HIDDEN_SIZE / 2u;
constexpr uint32_t STRIDE_WK_LAYER         = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_WV_LAYER         = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_WO_LAYER         = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_QKV_HEAD         = MODEL_HEAD_DIMENSTION * MODEL_HIDDEN_SIZE / 2u;
constexpr uint32_t STRIDE_QKV_HEAD_TILE    = (MODEL_HEAD_DIMENSTION / NUM_QKV_HEAD_TILES) * MODEL_HIDDEN_SIZE / 2u;

// Mirror /home/luka/Downloads/gen_layout.py:
// DTO=DM//4; DT1=DF*2//8; DT2=DM//4; DTL=VS//2
constexpr uint32_t MODEL_DTO              = MODEL_HIDDEN_SIZE / NUM_WO_TILES;
constexpr uint32_t MODEL_DT1              = (MODEL_INTERMEDIATE_SIZE * 2) / NUM_W1_TILES;
constexpr uint32_t MODEL_DT2              = MODEL_HIDDEN_SIZE / NUM_W2_TILES;
constexpr uint32_t MODEL_DTL              = MODEL_VOCAB_SIZE / NUM_LOGIT_TILES;

constexpr uint32_t STRIDE_WO_TILE          = MODEL_DTO * MODEL_HIDDEN_SIZE / 2u;
constexpr uint32_t STRIDE_W1_TILE          = MODEL_DT1 * MODEL_HIDDEN_SIZE / 2u;
constexpr uint32_t STRIDE_W2_TILE          = MODEL_DT2 * MODEL_INTERMEDIATE_SIZE / 2u;
constexpr uint32_t STRIDE_WO_BIAS_TILE     = MODEL_DTO * sizeof(int32_t);
constexpr uint32_t STRIDE_W1_BIAS_TILE     = MODEL_DT1 * sizeof(int32_t);
constexpr uint32_t STRIDE_W2_BIAS_TILE     = MODEL_DT2 * sizeof(int32_t);
constexpr uint32_t STRIDE_WLOGIT_TILE      = MODEL_DTL * sizeof(int32_t);
constexpr uint32_t STRIDE_LN0_GAMMA        = MODEL_HIDDEN_SIZE * sizeof(int32_t);
constexpr uint32_t STRIDE_LN1_GAMMA        = STRIDE_LN0_GAMMA;
constexpr uint32_t STRIDE_FINAL_NORM_GAMMA = MODEL_HIDDEN_SIZE * sizeof(int32_t);
constexpr uint32_t STRIDE_LN0_EPS          = sizeof(uint32_t);
constexpr uint32_t STRIDE_LN1_EPS          = sizeof(uint32_t);
constexpr uint32_t STRIDE_FINAL_NORM_EPS   = sizeof(uint32_t);
constexpr uint32_t STRIDE_W1_GATE_LAYER    = MODEL_INTERMEDIATE_SIZE * MODEL_HIDDEN_SIZE / 2u;
constexpr uint32_t STRIDE_W1_UP_LAYER      = STRIDE_W1_GATE_LAYER;
constexpr uint32_t STRIDE_W2_LAYER         = MODEL_HIDDEN_SIZE * MODEL_INTERMEDIATE_SIZE / 2u;
constexpr uint32_t STRIDE_WO_BIAS_LAYER    = MODEL_HIDDEN_SIZE * sizeof(int32_t);
constexpr uint32_t STRIDE_W1_BIAS_LAYER    = (2 * MODEL_INTERMEDIATE_SIZE) * sizeof(int32_t);
constexpr uint32_t STRIDE_W2_BIAS_LAYER    = MODEL_HIDDEN_SIZE * sizeof(int32_t);
constexpr uint32_t STRIDE_KV_LAYER         = NUM_HEADS * CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t STRIDE_KV_HEAD          = CONTEXT_LENGTH * D_HEADS;
constexpr uint32_t STRIDE_KV_CTX_BLOCK     = ATT_CTX_BLOCK * D_HEADS;
constexpr uint32_t STRIDE_KV_TOKEN         = D_HEADS;

// DDR Memory Offsets
constexpr uint64_t align64_u64(uint64_t v) { return (v + 63ull) & ~63ull; }
constexpr uint32_t align64_u32(uint32_t v) { return (v + 63u) & ~63u; }

// Active DDR layout mirrors /home/luka/Downloads/layout.txt exactly.
constexpr uint32_t WQ_OFF               = 0x00000000u;
constexpr uint32_t WK_OFF               = 0x09000000u;
constexpr uint32_t WV_OFF               = 0x12000000u;
constexpr uint32_t WO_OFF               = 0x1B000000u;
constexpr uint32_t W1_OFF               = 0x24000000u;
constexpr uint32_t W1_UP_OFF            = 0x3C000000u;
constexpr uint32_t W1_UP_REL_OFF        = 0x18000000u;
constexpr uint32_t W2_OFF               = 0x54000000u;
constexpr uint32_t WO_BIAS_OFF          = 0x6C000000u;
constexpr uint32_t W1_BIAS_OFF          = 0x6C060000u;
constexpr uint32_t W2_BIAS_OFF          = 0x6C260000u;
constexpr uint32_t LN0_GAMMA_OFF        = 0x6C2C0000u;
constexpr uint32_t LN1_GAMMA_OFF        = 0x6C320000u;
constexpr uint32_t FINAL_NORM_GAMMA_OFF = 0x6C380000u;
constexpr uint32_t LN0_EPS_OFF          = 0x6C383000u;
constexpr uint32_t LN1_EPS_OFF          = 0x6C383080u;
constexpr uint32_t FINAL_NORM_EPS_OFF   = 0x6C383100u;
constexpr uint32_t WLOGIT_OFF           = 0x6C383140u;
constexpr uint32_t WEIGHTS_SIZE         = 0x6F27B140u;

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
