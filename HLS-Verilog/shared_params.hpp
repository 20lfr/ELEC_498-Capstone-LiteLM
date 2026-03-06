#pragma once
#include <cstdint>

// LiteLM Shared Parameters — single source of truth for HLS and firmware.

// Full model specification (target)
constexpr int MODEL_LAYERS = 32;
constexpr int MODEL_HEADS = 32;
constexpr int MODEL_HIDDEN_SIZE = 3072;
constexpr int MODEL_HEAD_DIM = 96;
constexpr int MODEL_INTERMEDIATE_SIZE = 8192;
constexpr int MODEL_CONTEXT_LENGTH = 2048;
constexpr int MODEL_VOCAB_SIZE = 32064;
constexpr int16_t ATTN_SCALE_Q15 = 3344; // Q1.15: 1/sqrt(96) * 2^15
constexpr uint32_t LOGIT_SCALE_QV = 3344;

// HLS tunable params — scaled down for sim, increase toward MODEL_* for
// production
constexpr int NUM_HEADS = 4;
constexpr int NUM_LAYERS = 4;
constexpr int D_MODEL = 16;
constexpr int D_FFN = 24;
constexpr int D_HEAD = D_MODEL / NUM_HEADS;
constexpr int CONTEXT_LENGTH = 16;
constexpr int NUM_WO_TILES = 4;
constexpr int NUM_W1_TILES = 8;
constexpr int NUM_W2_TILES = 4;
constexpr int NUM_LOGIT_TILES = 2;
constexpr int D_TILE_WO = D_MODEL / NUM_WO_TILES;
constexpr int D_TILE_W1 = D_FFN * 2 / NUM_W1_TILES;
constexpr int D_TILE_W2 = D_MODEL / NUM_W2_TILES;

constexpr int STREAM_IN_BUF_BYTES =
    D_MODEL; // Token ingress payload (int8 activations)
constexpr int STREAM_OUT_BUF_BYTES =
    D_MODEL * 4; // Streamed egress payload (e.g. final norm int32)

// Precision
constexpr uint32_t INT4_BITS = 4;
constexpr uint32_t INT8_BITS = 8;
constexpr uint32_t INT16_BITS = 16;
constexpr uint32_t INT32_BITS = 32;
constexpr uint32_t FP16_BITS = 16;

// Resource estimation (uses tunable params)
constexpr uint32_t RESIDUAL_BITS = D_MODEL * INT8_BITS;
constexpr uint32_t RESIDUAL_KB = RESIDUAL_BITS / 1024;
constexpr uint32_t HEAD_WEIGHT_COUNT = D_MODEL * D_HEAD;
constexpr uint32_t HEAD_WEIGHT_BITS = HEAD_WEIGHT_COUNT * INT4_BITS;
constexpr uint32_t HEAD_WEIGHT_KB = HEAD_WEIGHT_BITS / 1024;
constexpr uint32_t HEAD_CONCAT_BITS = NUM_HEADS * D_HEAD * INT8_BITS;
constexpr uint32_t HEAD_CONCAT_KB = HEAD_CONCAT_BITS / 1024;
constexpr uint32_t W_QKVO_COUNT = D_MODEL * D_MODEL;
constexpr uint32_t W_QKVO_BITS = W_QKVO_COUNT * INT4_BITS;
constexpr uint32_t W_QKVO_KB = W_QKVO_BITS / 1024;
constexpr uint32_t W_FFN_COUNT = D_MODEL * D_FFN;
constexpr uint32_t W_FFN_BITS = W_FFN_COUNT * INT4_BITS;
constexpr uint32_t W_FFN_KB = W_FFN_BITS / 1024;
constexpr uint32_t W1_GATE_UP_KB = W_FFN_KB * 2;

// KV cache sizing
constexpr uint32_t KV_CACHE_HEAD_ITEMS = CONTEXT_LENGTH * D_HEAD;
constexpr uint32_t KV_CACHE_HEAD_BYTES = KV_CACHE_HEAD_ITEMS;
constexpr uint32_t KV_CACHE_HEAD_KB = KV_CACHE_HEAD_BYTES / 1024;
constexpr uint32_t KV_CACHE_LAYER_ITEMS = NUM_HEADS * CONTEXT_LENGTH * D_HEAD;
constexpr uint32_t KV_CACHE_LAYER_BYTES = KV_CACHE_LAYER_ITEMS;
constexpr uint32_t KV_CACHE_TOTAL_ITEMS =
    NUM_LAYERS * NUM_HEADS * CONTEXT_LENGTH * D_HEAD;
constexpr uint32_t KV_CACHE_TOTAL_BYTES = KV_CACHE_TOTAL_ITEMS;
constexpr uint32_t KV_PER_TOKEN = 2 * NUM_LAYERS * NUM_HEADS * D_HEAD;

// DDR memory section sizes (bytes, int4 packed = elems/2)
constexpr uint32_t MEM_WQ = NUM_LAYERS * D_MODEL * D_MODEL / 2;
constexpr uint32_t MEM_WK = MEM_WQ;
constexpr uint32_t MEM_WV = MEM_WQ;
constexpr uint32_t MEM_WO = MEM_WQ;
constexpr uint32_t MEM_W1_GATE = NUM_LAYERS * D_FFN * D_MODEL / 2;
constexpr uint32_t MEM_W1_UP = MEM_W1_GATE;
constexpr uint32_t MEM_W2 = NUM_LAYERS * D_MODEL * D_FFN / 2;
constexpr uint32_t MEM_EMBED = MODEL_VOCAB_SIZE * D_MODEL * 2;
constexpr uint32_t MEM_GAMMA = (2 * NUM_LAYERS + 1) * D_MODEL * 2;
constexpr uint32_t MEM_BIAS =
    NUM_LAYERS * (D_MODEL * 4 + D_FFN * 2 + D_MODEL) * 4;
constexpr uint32_t MEM_K_CACHE = KV_CACHE_TOTAL_BYTES;
constexpr uint32_t MEM_V_CACHE = KV_CACHE_TOTAL_BYTES;

// DDR weight buffer offsets (64-byte aligned)
constexpr uint32_t ALIGN64(uint32_t v) { return (v + 63) & ~63; }

constexpr uint32_t WOFF_WQ = 0;
constexpr uint32_t WOFF_WK = ALIGN64(WOFF_WQ + MEM_WQ);
constexpr uint32_t WOFF_WV = ALIGN64(WOFF_WK + MEM_WK);
constexpr uint32_t WOFF_WO = ALIGN64(WOFF_WV + MEM_WV);
constexpr uint32_t WOFF_W1_GATE = ALIGN64(WOFF_WO + MEM_WO);
constexpr uint32_t WOFF_W1_UP = ALIGN64(WOFF_W1_GATE + MEM_W1_GATE);
constexpr uint32_t WOFF_W2 = ALIGN64(WOFF_W1_UP + MEM_W1_UP);
constexpr uint32_t WOFF_EMBED = ALIGN64(WOFF_W2 + MEM_W2);
constexpr uint32_t WOFF_GAMMA = ALIGN64(WOFF_EMBED + MEM_EMBED);
constexpr uint32_t WOFF_BIAS = ALIGN64(WOFF_GAMMA + MEM_GAMMA);
constexpr uint32_t WOFF_TOTAL = ALIGN64(WOFF_BIAS + MEM_BIAS);

// DDR KV cache / stream offsets (same dmabuf, after weights)
constexpr uint32_t COFF_K_CACHE = WOFF_TOTAL;
constexpr uint32_t COFF_V_CACHE = ALIGN64(COFF_K_CACHE + MEM_K_CACHE);
constexpr uint32_t COFF_INPUT = ALIGN64(COFF_V_CACHE + MEM_V_CACHE);
constexpr uint32_t COFF_OUTPUT = ALIGN64(COFF_INPUT + D_MODEL);
constexpr uint32_t COFF_TOTAL = ALIGN64(COFF_OUTPUT + D_MODEL);

// Strides (bytes): addr = base + layer * layer_stride + head/tile * sub_stride
constexpr uint32_t STRIDE_WQ_LAYER = D_MODEL * D_MODEL / 2;
constexpr uint32_t STRIDE_WK_LAYER = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_WV_LAYER = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_WO_LAYER = STRIDE_WQ_LAYER;
constexpr uint32_t STRIDE_W1_GATE_LAYER = D_FFN * D_MODEL / 2;
constexpr uint32_t STRIDE_W1_UP_LAYER = STRIDE_W1_GATE_LAYER;
constexpr uint32_t STRIDE_W2_LAYER = D_MODEL * D_FFN / 2;
constexpr uint32_t STRIDE_QKV_HEAD = D_HEAD * D_MODEL / 2;
constexpr uint32_t STRIDE_WO_TILE = D_TILE_WO * D_MODEL / 2;
constexpr uint32_t STRIDE_W1_TILE = D_TILE_W1 * D_MODEL / 2;
constexpr uint32_t STRIDE_W2_TILE = D_TILE_W2 * D_FFN / 2;
constexpr uint32_t STRIDE_KV_LAYER = NUM_HEADS * CONTEXT_LENGTH * D_HEAD;
constexpr uint32_t STRIDE_KV_HEAD = CONTEXT_LENGTH * D_HEAD;
constexpr uint32_t STRIDE_KV_TOKEN = D_HEAD;

// Control register bits (bit0 = reset_n, bit1 = start, bit2+ = FSM commands)
constexpr uint32_t CTRL_RESETN_BIT = 1u << 0;
constexpr uint32_t CTRL_START_BIT = 1u << 1;

// IRQ bits
constexpr uint32_t IRQ_ERROR_BIT = 1u << 1;
constexpr uint32_t IRQ_INFER_DONE_BIT = 1u << 2;

// Status bits
constexpr uint32_t STATUS_IDLE = 1u << 0;
constexpr uint32_t STATUS_BUSY = 1u << 2;

// Status FSM state bits
constexpr uint32_t STAT_IDLE_BIT = STATUS_IDLE;
constexpr uint32_t STAT_BUSY_BIT = STATUS_BUSY;

// Error codes (bitmask)
constexpr uint32_t ERR_NONE = 0;
constexpr uint32_t ERR_DMA_ALIGNMENT = 1;
constexpr uint32_t ERR_DMA_ZERO_LEN = 2;
constexpr uint32_t ERR_DMA_ZERO_STRIDE = 4;
constexpr uint32_t ERR_SCHEDULER_ERROR = 8;
constexpr uint32_t ERR_COMPUTE_ERROR = 16;
constexpr uint32_t ERR_MMU_INVALID = 32;
constexpr uint32_t ERR_MMU_OVERFLOW = 64;
constexpr uint32_t ERR_MMU_UNSUPPORTED_REQ_DMA = 128;
constexpr uint32_t ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED = 256;
constexpr uint32_t ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED = 512;
constexpr uint32_t ERR_MMU_BAD_DMA_PLAN = 2048;
constexpr uint32_t ERR_MMU_BAD_DMA_ADDR = 4096;
constexpr uint32_t ERR_MMU_REGION_ACCESS = 8192;
constexpr uint32_t ERR_MMU_CONCAT_SOURCE = 16384;
constexpr uint32_t ERR_MMU_WRITEBACK_SRC = 32768;
constexpr uint32_t ERR_MMU_QUEUE_OVERFLOW = 65536;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW = 131072;
constexpr uint32_t ERR_MMU_STREAM_OUTPUT_MISSING = 262144;
constexpr uint32_t ERR_MMU_MISSING_REGION_FULL_READ = 524288;
constexpr uint32_t ERR_MMU_MISSING_REGION_PARTIAL_READ = 1048576;
constexpr uint32_t ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP = 2097152;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_STREAM_IN = 4194304;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_DMA_CONCAT = 8388608;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_DMA_STORE = 16777216;
constexpr uint32_t ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE = 33554432;
constexpr uint32_t ERR_MMU_REGION_TABLE_FULL = 67108864;
constexpr uint32_t ERR_MMU_URAM_CHUNK_ALLOC_FAIL = 134217728;
constexpr uint32_t ERR_MMU_REGION_TOO_LARGE = 268435456;

// MMU debug subcodes
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

// MMU missing-region subcodes
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
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_RESID0_OUT = 120;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN1_OUT = 121;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W1_W = 122;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W1_B = 123;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FFN_W1_PACKED = 124;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FFN_ACT_OUT = 125;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W2_W = 126;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_W2_B = 127;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_FFN_W2_PACKED = 128;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_RESID1_OUT = 129;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN0_GAMMA = 130;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN0_EPS = 131;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN1_GAMMA = 132;
constexpr uint32_t MMU_ERR_SUBCODE_MISSING_LN1_EPS = 133;
