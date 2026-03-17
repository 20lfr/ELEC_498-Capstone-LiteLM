#pragma once
#include "shared_params.hpp"
#include <ap_int.h>
#include <cstdint>

using int4_t = ap_int<4>;

/*
README:
        This file  contains all the enums, structs and constant expressions
required accross all modules
*/

using axi_gmem_word_t = ap_uint<AXI_GMEM_WORD_BITS>;

// MMU LN parameter source selection:
//   true  -> MMU hardcodes LN0 gamma/eps for bring-up
//   false -> MMU requires LN0 gamma/eps to exist in URAM regions
constexpr bool MMU_USE_HARDCODED_LN_PARAMS = false;

// Requant removed: MatMul-only mode streams raw int32 to PS; no on-PL requantization.

// MatMul-only opcodes — matches 4-bit op field in 32-bit INSTR register.
// op field = INSTR[3:0]. All ops produce raw int32 accumulators streamed to PS.
enum ComputeOp : uint8_t {
    CMP_NONE       = 0,
    CMP_Q          = 1,  // Q projection tile: int8[D_MODEL] x int8[D_HEAD_TILE_QKV x D_MODEL] -> int32[D_HEAD_TILE_QKV]
    CMP_K          = 2,  // K projection tile (same structure as Q)
    CMP_V          = 3,  // V projection tile (same structure as Q)
    CMP_ATT_SCORES = 4,  // Attention score tile: int8[D_HEAD] dot int8[ATT_CTX_BLOCK x D_HEAD] -> int32[ATT_CTX_BLOCK]
    CMP_ATT_VALUE  = 5,  // Attention value tile: int8[ATT_CTX_BLOCK] x int8[ATT_CTX_BLOCK x D_HEAD_TILE_ATT_VALUE] -> int32[D_HEAD_TILE_ATT_VALUE]
    CMP_OUT_PROJ   = 6,  // Output projection tile: int8[D_MODEL] x int8[D_TILE_WO x D_MODEL] -> int32[D_TILE_WO]
    CMP_FFN_W1     = 7,  // FFN W1 tile: int8[D_MODEL] x int8[D_TILE_W1 x D_MODEL] -> int32[D_TILE_W1]
    CMP_FFN_W2     = 8,  // FFN W2 tile: int8[D_FFN] x int8[D_TILE_W2 x D_FFN] -> int32[D_TILE_W2]
    CMP_LOGITS     = 9,  // Vocab proj tile: int8[D_MODEL] x int8[D_TILE_LOGIT x D_MODEL] -> int32[D_TILE_LOGIT]
};

// ---------------------------------------------------------------------------
// PS -> PL 32-bit INSTR format (ControlMemSpace::instr)
//
// MatMulMode instruction word. Tile iteration is managed entirely on-chip; PS
// only selects op/layer/head.
//
//   INSTR[3:0]    op    (ComputeOp)
//   INSTR[11:4]   layer (8-bit)
//   INSTR[19:12]  head  (8-bit)
//   INSTR[31:20]  reserved (0)
// ---------------------------------------------------------------------------
constexpr uint32_t PS_INSTR_OP_SHIFT    = 0u;
constexpr uint32_t PS_INSTR_LAYER_SHIFT = 4u;
constexpr uint32_t PS_INSTR_HEAD_SHIFT  = 12u;

constexpr uint32_t PS_INSTR_OP_MASK    = 0xFu;
constexpr uint32_t PS_INSTR_LAYER_MASK = 0xFFu;
constexpr uint32_t PS_INSTR_HEAD_MASK  = 0xFFu;

// MatMul-only DMA selectors — only weight tiles and KV-cache ctx blocks.
// K/V write-back to DDR is handled by PS after dequantizing the stream-out.
enum DmaSel : uint8_t {
    DMASEL_NONE   = 0,
    DMASEL_WQ     = 1,  // WQ weight tile (layer, head, qkv_tile)
    DMASEL_WK     = 2,  // WK weight tile (layer, head, qkv_tile)
    DMASEL_WV     = 3,  // WV weight tile (layer, head, qkv_tile)
    DMASEL_CTX_K  = 4,  // K-cache ctx block (layer, head, ctx_block_idx)
    DMASEL_CTX_V  = 5,  // V-cache ctx block (layer, head, ctx_block_idx)
    DMASEL_WO     = 6,  // WO weight tile (layer, tile)
    DMASEL_W1     = 7,  // W1 weight tile (layer, tile)
    DMASEL_W2     = 8,  // W2 weight tile (layer, tile)
    DMASEL_WLOGIT = 9,  // W_vocab weight tile (tile)
};

enum class ComputeErrorCodes { IncorrectRequest, InvalidComputationForamt };

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
    uint64_t instruction = 0;
    ComputeOp op = ComputeOp::CMP_NONE;
    uint8_t layer_idx = 0;
    uint8_t head_idx = 0;
    uint16_t tile_idx = 0;
};

// Register Addr mapping is auto generated in a HLS project
// `mask_allowed/hel/impl/ip/drivers/<top_function>/src/x<top_function>_hw.h`

// Config (PS Writes -> PL Reads)
// Passed by value
// NOTE: All offsets are in BYTES (matching AXI byte-addressing).
//       Burst read/write call sites convert to word index via /
//       sizeof(int32_t). Strides are derived inside PL from shared_params.hpp.
struct ControlMemSpace {
    uint32_t control = CTRL_RESETN_BIT; // bit0=reset_n, bit1=start
    // MatMul instruction (PS → PL):
    //   [3:0]=op, [11:4]=layer, [19:12]=head, [31:20]=reserved (0)
    uint32_t instr   = 0;
    uint32_t irq_mask = 0; // IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT for all Interrupts
    uint32_t irq_clear = 0;

    // Byte offsets relative to AXI Full base (set by PS)
    // wq=0, wk=size(wq), wv=size(wq)+size(wk), ...
    uint32_t wq_offset = 0;
    uint32_t wk_offset = 0;
    uint32_t wv_offset = 0;
    uint32_t wo_offset = 0;
    uint32_t w1_offset = 0;
    uint32_t w2_offset = 0;
    uint32_t k_cache_offset = 0;
    uint32_t v_cache_offset = 0;

    // Dedicated offset tables for bias and norm parameters.
    uint32_t wq_bias_offset = 0;
    uint32_t wk_bias_offset = 0;
    uint32_t wv_bias_offset = 0;
    uint32_t wo_bias_offset = 0;
    uint32_t w1_bias_offset = 0;
    uint32_t w2_bias_offset = 0;
    uint32_t ln0_gamma_offset = 0;
    uint32_t ln1_gamma_offset = 0;
    uint32_t final_norm_gamma_offset = 0;
    uint32_t ln0_beta_offset = 0;
    uint32_t ln1_beta_offset = 0;
    uint32_t final_norm_beta_offset = 0;
    uint32_t ln0_eps_offset = 0;
    uint32_t ln1_eps_offset = 0;
    uint32_t final_norm_eps_offset = 0;
    uint32_t wlogit_offset = 0;

    uint32_t token_position = 0;
    // Legacy/unused in MatMulMode (kept to preserve AXI-Lite register map).
    uint32_t compute_instruction = 0;
};

// Status (PS Reads <- PL Writes)
// Passed by reference
struct StatusMemSpace {
    uint32_t status = static_cast<uint32_t>(S_IDLE);
    uint32_t irq_status = 0;
    uint32_t error_code = ERR_NONE;
    uint32_t mmu_error_subcode = MMU_ERR_SUBCODE_NONE;
    uint32_t layer_index = 0;
    // Testing registers
    uint32_t head_index = 0;
    uint32_t token_index = 0;

    // Static build/config mirrors (readable by PS for sanity-checking bitstream parameters).
    uint32_t cfg_num_layers = 0;
    uint32_t cfg_d_model = 0;
    uint32_t cfg_d_ffn = 0;
    uint32_t cfg_d_vocab = 0;
    uint32_t cfg_context_length = 0;
    uint32_t cfg_d_heads = 0;
    uint32_t cfg_num_heads = 0;
    uint32_t cfg_d_tile_wo = 0;
    uint32_t cfg_d_tile_w1 = 0;
    uint32_t cfg_d_tile_w2 = 0;
    uint32_t cfg_d_tile_logit = 0;
    uint32_t cfg_d_head_tile_qkv = 0;
    uint32_t cfg_att_ctx_block = 0;
    uint32_t cfg_d_head_tile_att_value = 0;
};

// ---------------------------------------------------------------------------
// Compute buffer layout (moved from compute_buffer_layout.hpp)
// ---------------------------------------------------------------------------
enum class BufDType : uint8_t {
    NONE,
    I4,
    I8,
    I16,
    I32,
};

// For MAIN MAC unit input and output buffer sizing
constexpr int VECTOR_MAX = max2_constexpr(D_MODEL, D_FFN);
constexpr int ACCUM_MAX = max2_constexpr(
    D_TILE_WO,
    max2_constexpr(D_TILE_W1, max2_constexpr(D_TILE_W2, D_TILE_LOGIT)));
constexpr int MATRIX_MAX = VECTOR_MAX * ACCUM_MAX;

constexpr int MAC_OP_TO_BUF_VEC_UNROLL  = min2_constexpr(VECTOR_MAX, MAC_OP_TO_BUF_VEC_UNROLL_TARGET);
constexpr int MAC_OP_TO_BUF_OUT_UNROLL  = min2_constexpr(ACCUM_MAX,  MAC_OP_TO_BUF_OUT_UNROLL_TARGET);
constexpr int RES_ADD_TO_BUF_VEC_UNROLL = min2_constexpr(D_MODEL,    RES_ADD_TO_BUF_VEC_UNROLL_TARGET);
constexpr int FFN_ACT_TO_BUF_VEC_UNROLL = min2_constexpr(D_FFN,      FFN_ACT_TO_BUF_VEC_UNROLL_TARGET);
// Aliases kept for MAC_COMPUTE_CORE parameter pragma sizing (VECTOR_MAX / ACCUM_MAX arrays)
constexpr int MAC_VEC_UNROLL = MAC_OP_TO_BUF_VEC_UNROLL;
constexpr int MAC_OUT_UNROLL = MAC_OP_TO_BUF_OUT_UNROLL;

static_assert(VECTOR_MAX % MAC_OP_TO_BUF_VEC_UNROLL == 0,
    "VECTOR_MAX must be divisible by MAC_OP_TO_BUF_VEC_UNROLL (check D_MODEL, D_FFN vs MAC_OP_TO_BUF_VEC_UNROLL_TARGET)");
static_assert(ACCUM_MAX % MAC_OP_TO_BUF_OUT_UNROLL == 0,
    "ACCUM_MAX must be divisible by MAC_OP_TO_BUF_OUT_UNROLL (check tile sizes vs MAC_OP_TO_BUF_OUT_UNROLL_TARGET)");
static_assert(D_MODEL % RES_ADD_TO_BUF_VEC_UNROLL == 0,
    "D_MODEL must be divisible by RES_ADD_TO_BUF_VEC_UNROLL");
static_assert(D_FFN % FFN_ACT_TO_BUF_VEC_UNROLL == 0,
    "D_FFN must be divisible by FFN_ACT_TO_BUF_VEC_UNROLL");

// Per-type MAC dimensions — each specialized dispatch uses its own smallest arrays.
constexpr int VECTOR_MAX_I8I8   = D_MODEL;
constexpr int ACCUM_MAX_I8I8    = max2_constexpr(D_TILE_WO, D_TILE_W1);
constexpr int MATRIX_MAX_I8I8   = VECTOR_MAX_I8I8 * ACCUM_MAX_I8I8;

constexpr int VECTOR_MAX_I16I8  = D_FFN;
constexpr int ACCUM_MAX_I16I8   = D_TILE_W2;
constexpr int MATRIX_MAX_I16I8  = VECTOR_MAX_I16I8 * ACCUM_MAX_I16I8;

constexpr int VECTOR_MAX_I32I8  = D_MODEL;
constexpr int ACCUM_MAX_I32I8   = D_TILE_LOGIT;
constexpr int MATRIX_MAX_I32I8  = VECTOR_MAX_I32I8 * ACCUM_MAX_I32I8;

// Computed per-type unroll factors.
constexpr int MAC_I8I8_VEC_UNROLL   = min2_constexpr(VECTOR_MAX_I8I8,  MAC_I8I8_VEC_UNROLL_TARGET);
constexpr int MAC_I8I8_OUT_UNROLL   = min2_constexpr(ACCUM_MAX_I8I8,   MAC_I8I8_OUT_UNROLL_TARGET);
constexpr int MAC_I16I8_VEC_UNROLL  = min2_constexpr(VECTOR_MAX_I16I8, MAC_I16I8_VEC_UNROLL_TARGET);
constexpr int MAC_I16I8_OUT_UNROLL  = min2_constexpr(ACCUM_MAX_I16I8,  MAC_I16I8_OUT_UNROLL_TARGET);
constexpr int MAC_I32I8_VEC_UNROLL  = min2_constexpr(VECTOR_MAX_I32I8, MAC_I32I8_VEC_UNROLL_TARGET);
constexpr int MAC_I32I8_OUT_UNROLL  = min2_constexpr(ACCUM_MAX_I32I8,  MAC_I32I8_OUT_UNROLL_TARGET);

static_assert(VECTOR_MAX_I8I8  % MAC_I8I8_VEC_UNROLL  == 0, "VECTOR_MAX_I8I8 must be divisible by MAC_I8I8_VEC_UNROLL");
static_assert(ACCUM_MAX_I8I8   % MAC_I8I8_OUT_UNROLL  == 0, "ACCUM_MAX_I8I8 must be divisible by MAC_I8I8_OUT_UNROLL");
static_assert(VECTOR_MAX_I16I8 % MAC_I16I8_VEC_UNROLL == 0, "VECTOR_MAX_I16I8 must be divisible by MAC_I16I8_VEC_UNROLL");
static_assert(ACCUM_MAX_I16I8  % MAC_I16I8_OUT_UNROLL == 0, "ACCUM_MAX_I16I8 must be divisible by MAC_I16I8_OUT_UNROLL");
static_assert(VECTOR_MAX_I32I8 % MAC_I32I8_VEC_UNROLL == 0, "VECTOR_MAX_I32I8 must be divisible by MAC_I32I8_VEC_UNROLL");
static_assert(ACCUM_MAX_I32I8  % MAC_I32I8_OUT_UNROLL == 0, "ACCUM_MAX_I32I8 must be divisible by MAC_I32I8_OUT_UNROLL");

namespace compute_buf {

    constexpr int div_ceil(int a, int b) { return (a + b - 1) / b; }

    constexpr int max2(int a, int b) { return (a > b) ? a : b; }

    // -------------------------------
    // Input buffer size calculations
    // -------------------------------
    constexpr int OUT_PROJ_ACT_BYTES = D_MODEL;
	    constexpr int OUT_PROJ_W_BYTES = D_MODEL * D_TILE_WO;
    constexpr int OUT_PROJ_B_BYTES = D_TILE_WO * 4;
    constexpr int OUT_PROJ_IN_BYTES =
        OUT_PROJ_ACT_BYTES + OUT_PROJ_W_BYTES + OUT_PROJ_B_BYTES;

    constexpr int REQUANT_IN_BYTES = (D_MODEL * 4);
    constexpr int RESID_IN_BYTES = D_MODEL * 2;
    constexpr int LN_IN_BYTES = D_MODEL + (D_MODEL * 4) + (D_MODEL * 4) + 4;

	    constexpr int FFN_W1_W_BYTES = D_MODEL * D_TILE_W1;
    constexpr int FFN_W1_B_BYTES = D_TILE_W1 * 4;
    constexpr int FFN_W1_IN_BYTES = D_MODEL + FFN_W1_W_BYTES + FFN_W1_B_BYTES;

	    // GPT-2 FFN activation consumes a single D_FFN vector (Q1.15).
	    constexpr int FFN_ACT_IN_BYTES = D_FFN * 2;

	    constexpr int FFN_W2_W_BYTES = D_FFN * D_TILE_W2;
    constexpr int FFN_W2_B_BYTES = D_TILE_W2 * 4;
    constexpr int FFN_W2_IN_BYTES = (D_FFN * 2) + FFN_W2_W_BYTES + FFN_W2_B_BYTES;

	    constexpr int LOGITS_X_BYTES = D_MODEL * 4;
	    constexpr int LOGITS_W_BYTES = D_MODEL * D_TILE_LOGIT;
	    constexpr int LOGITS_IN_BYTES = LOGITS_X_BYTES + LOGITS_W_BYTES;
    constexpr int ARGMAX_IN_BYTES = NUM_LOGIT_TILES * 8;  // NUM_LOGIT_TILES pairs of (max_val: i32, local_idx: i32)

    constexpr int IN_BUF_BYTES = max2(
        OUT_PROJ_IN_BYTES,
        max2(REQUANT_IN_BYTES,
             max2(RESID_IN_BYTES,
                  max2(LN_IN_BYTES, max2(FFN_W1_IN_BYTES,
                                         max2(FFN_ACT_IN_BYTES,
                                              max2(FFN_W2_IN_BYTES,
                                                   max2(LOGITS_IN_BYTES,
                                                        ARGMAX_IN_BYTES))))))));

    // -------------------------------
    // Output buffer size calculations
    // -------------------------------
    constexpr int OUT_PROJ_OUT_BYTES = D_TILE_WO;
    constexpr int REQUANT_OUT_BYTES = D_MODEL;
    constexpr int RESID_OUT_BYTES = D_MODEL;
    constexpr int LN_OUT_BYTES = D_MODEL * 4;
    constexpr int FFN_W1_OUT_BYTES = D_TILE_W1 * 2;
    constexpr int FFN_ACT_OUT_BYTES = D_FFN * 2;
    constexpr int FFN_W2_OUT_BYTES = D_TILE_W2;
    constexpr int LOGITS_OUT_BYTES = 8;  // (max_val: i32, local_argmax_idx: i32)
    constexpr int ARGMAX_OUT_BYTES = 4;

    constexpr int OUT_BUF_BYTES =
        max2(OUT_PROJ_OUT_BYTES,
             max2(REQUANT_OUT_BYTES,
                  max2(RESID_OUT_BYTES,
                       max2(LN_OUT_BYTES,
                            max2(FFN_W1_OUT_BYTES,
                                 max2(FFN_ACT_OUT_BYTES,
                                      max2(FFN_W2_OUT_BYTES,
                                           max2(LOGITS_OUT_BYTES,
                                                ARGMAX_OUT_BYTES))))))));

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
        static constexpr int BETA_BYTES = D_MODEL * 4;
        static constexpr int EPS_BYTES = 4;
        static constexpr int TOTAL_BYTES = LN_IN_BYTES;
        static constexpr int X = 0;
        static constexpr int GAMMA = X + X_BYTES;
        static constexpr int BETA = GAMMA + GAMMA_BYTES;
        static constexpr int EPS = BETA + BETA_BYTES;
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
        static constexpr int UP_BYTES = 0;
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

    struct INLogitsLayout {
        static constexpr int X_BYTES = LOGITS_X_BYTES;
        static constexpr int W_BYTES = LOGITS_W_BYTES;
        static constexpr int TOTAL_BYTES = LOGITS_IN_BYTES;
        static constexpr int X = 0;
        static constexpr int W = X + X_BYTES;
    };

    struct INArgmaxLayout {
        static constexpr int X_BYTES = ARGMAX_IN_BYTES;
        static constexpr int TOTAL_BYTES = ARGMAX_IN_BYTES;
        static constexpr int X = 0;
    };

    // -------------------------------
    // Per-op output layouts (byte offsets)
    // -------------------------------

    struct OUTOutProjLayout {
        static constexpr int NUM_ELEMS = D_TILE_WO;
        static constexpr BufDType TYPE = BufDType::I8;
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
        static constexpr BufDType TYPE = BufDType::I8;
        static constexpr int TOTAL_BYTES = FFN_W2_OUT_BYTES;
        static constexpr int Y = 0;
    };

    struct OUTLogitsLayout {
        static constexpr int NUM_ELEMS = 2;  // (max_val, local_argmax_idx)
        static constexpr BufDType TYPE = BufDType::I32;
        static constexpr int TOTAL_BYTES = LOGITS_OUT_BYTES;
        static constexpr int Y = 0;
    };

    struct OUTArgmaxLayout {
        static constexpr int NUM_ELEMS = 1;
        static constexpr BufDType TYPE = BufDType::I32;
        static constexpr int TOTAL_BYTES = ARGMAX_OUT_BYTES;
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
            byte_val = static_cast<uint8_t>(
                (byte_val & 0x0F) | (static_cast<uint8_t>(nibble) << 4));
        } else {
            byte_val = static_cast<uint8_t>((byte_val & 0xF0) |
                                            static_cast<uint8_t>(nibble));
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

// ---------------------------------------------------------------------------
// MatMul-mode unified buffer layouts (new compute controller)
// ---------------------------------------------------------------------------
// In MatMul mode the compute buffer holds: [activation | weight_tile | out].
// Activation comes from AXIS stream-in; weight tile from DMA (MMU).
// Output is always raw int32 accumulators.
//
// Layout convention: in_buf = [ACT | W], out_buf = [int32 results]
// ---------------------------------------------------------------------------
namespace mm_buf {

    constexpr int max2(int a, int b) { return (a > b) ? a : b; }

	    // --- Q/K/V tile ---
	    constexpr int QKV_ACT_BYTES    = D_MODEL;
	    constexpr int QKV_W_BYTES      = D_HEAD_TILE_QKV * D_MODEL;
	    constexpr int QKV_B_BYTES      = STRIDE_QKV_HEAD_TILE_BIAS; // int32 bias per output element
	    constexpr int QKV_IN_BYTES     = QKV_ACT_BYTES + QKV_W_BYTES + QKV_B_BYTES;
	    constexpr int QKV_OUT_BYTES    = D_HEAD_TILE_QKV * 4;  // int32

    // --- Attention scores tile ---
    // Stream-in: int8[D_HEAD] Q; DMA: int8[ATT_CTX_BLOCK * D_HEAD] K tile
    constexpr int ATT_SCORES_ACT_BYTES = D_HEADS;
    constexpr int ATT_SCORES_W_BYTES   = ATT_CTX_BLOCK * D_HEADS;
    constexpr int ATT_SCORES_IN_BYTES  = ATT_SCORES_ACT_BYTES + ATT_SCORES_W_BYTES;
    constexpr int ATT_SCORES_OUT_BYTES = ATT_CTX_BLOCK * 4;  // int32

    // --- Attention value tile ---
    // No context chunking:
    // Stream-in: int16[CONTEXT_LENGTH] softmax weights; DMA: int8[CONTEXT_LENGTH * D_HEAD_TILE_ATT_VALUE] V tile
    constexpr int ATT_VALUE_ACT_BYTES = CONTEXT_LENGTH * 2;
    constexpr int ATT_VALUE_W_BYTES   = CONTEXT_LENGTH * D_HEAD_TILE_ATT_VALUE;
    constexpr int ATT_VALUE_IN_BYTES  = ATT_VALUE_ACT_BYTES + ATT_VALUE_W_BYTES;
    constexpr int ATT_VALUE_OUT_BYTES = D_HEAD_TILE_ATT_VALUE * 4;  // int32

	    // --- OUT_PROJ tile ---
	    constexpr int OUT_PROJ_ACT_BYTES = D_MODEL;
	    constexpr int OUT_PROJ_W_BYTES   = D_TILE_WO * D_MODEL;
	    constexpr int OUT_PROJ_B_BYTES   = STRIDE_WO_BIAS_TILE; // int32 bias per output element
	    constexpr int OUT_PROJ_IN_BYTES  = OUT_PROJ_ACT_BYTES + OUT_PROJ_W_BYTES + OUT_PROJ_B_BYTES;
	    constexpr int OUT_PROJ_OUT_BYTES = D_TILE_WO * 4;  // int32

	    // --- W1 tile ---
	    constexpr int W1_ACT_BYTES = D_MODEL;
	    constexpr int W1_W_BYTES   = D_TILE_W1 * D_MODEL;
	    constexpr int W1_B_BYTES   = STRIDE_W1_BIAS_TILE; // int32 bias per output element
	    constexpr int W1_IN_BYTES  = W1_ACT_BYTES + W1_W_BYTES + W1_B_BYTES;
	    constexpr int W1_OUT_BYTES = D_TILE_W1 * 4;  // int32

	    // --- W2 tile ---
	    constexpr int W2_ACT_BYTES = D_FFN;
	    constexpr int W2_W_BYTES   = D_TILE_W2 * D_FFN;
	    constexpr int W2_B_BYTES   = STRIDE_W2_BIAS_TILE; // int32 bias per output element
	    constexpr int W2_IN_BYTES  = W2_ACT_BYTES + W2_W_BYTES + W2_B_BYTES;
	    constexpr int W2_OUT_BYTES = D_TILE_W2 * 4;  // int32

    // --- LOGITS (W_vocab) tile ---
    constexpr int LOGITS_ACT_BYTES = D_MODEL;
    constexpr int LOGITS_W_BYTES   = D_TILE_LOGIT * D_MODEL;
    constexpr int LOGITS_IN_BYTES  = LOGITS_ACT_BYTES + LOGITS_W_BYTES;
    constexpr int LOGITS_OUT_BYTES = D_TILE_LOGIT * 4;  // int32

    // Total buffer sizes (max across all ops)
    constexpr int IN_BUF_BYTES = max2(QKV_IN_BYTES,
                                  max2(ATT_SCORES_IN_BYTES,
                                   max2(ATT_VALUE_IN_BYTES,
                                    max2(OUT_PROJ_IN_BYTES,
                                     max2(W1_IN_BYTES,
                                      max2(W2_IN_BYTES, LOGITS_IN_BYTES))))));

    constexpr int OUT_BUF_BYTES = max2(QKV_OUT_BYTES,
                                   max2(ATT_SCORES_OUT_BYTES,
                                    max2(ATT_VALUE_OUT_BYTES,
                                     max2(OUT_PROJ_OUT_BYTES,
                                      max2(W1_OUT_BYTES,
                                       max2(W2_OUT_BYTES, LOGITS_OUT_BYTES))))));

	    // Per-op in-buf layouts: [ACT | W]
	    struct INQkvLayout {
	        static constexpr int ACT = 0;
	        static constexpr int W   = ACT + QKV_ACT_BYTES;
	        static constexpr int B   = W + QKV_W_BYTES;
	        static constexpr int TOTAL_BYTES = QKV_IN_BYTES;
	    };
    struct INAttScoresLayout {
        static constexpr int ACT = 0;  // Q vector
        static constexpr int W   = ACT + ATT_SCORES_ACT_BYTES;  // K cache tile
        static constexpr int TOTAL_BYTES = ATT_SCORES_IN_BYTES;
    };
    struct INAttValueLayout {
        static constexpr int ACT = 0;  // softmax weights
        static constexpr int W   = ACT + ATT_VALUE_ACT_BYTES;  // V cache tile
        static constexpr int TOTAL_BYTES = ATT_VALUE_IN_BYTES;
    };
	    struct INOutProjLayout {
	        static constexpr int ACT = 0;
	        static constexpr int W   = ACT + OUT_PROJ_ACT_BYTES;
	        static constexpr int B   = W + OUT_PROJ_W_BYTES;
	        static constexpr int TOTAL_BYTES = OUT_PROJ_IN_BYTES;
	    };
	    struct INW1Layout {
	        static constexpr int ACT = 0;
	        static constexpr int W   = ACT + W1_ACT_BYTES;
	        static constexpr int B   = W + W1_W_BYTES;
	        static constexpr int TOTAL_BYTES = W1_IN_BYTES;
	    };
	    struct INW2Layout {
	        static constexpr int ACT = 0;
	        static constexpr int W   = ACT + W2_ACT_BYTES;
	        static constexpr int B   = W + W2_W_BYTES;
	        static constexpr int TOTAL_BYTES = W2_IN_BYTES;
	    };
    struct INLogitsLayout {
        static constexpr int ACT = 0;
        static constexpr int W   = ACT + LOGITS_ACT_BYTES;
        static constexpr int TOTAL_BYTES = LOGITS_IN_BYTES;
    };

} // namespace mm_buf

// ------------------------------------------------------------
// Attention kernel sizing (compile-time maxima + unroll factors)
// ------------------------------------------------------------
constexpr int HEAD_VECTOR_MAX =
    compute_buf::max2(D_MODEL, compute_buf::max2(D_HEADS, CONTEXT_LENGTH));
constexpr int HEAD_ACCUM_MAX = compute_buf::max2(D_HEADS, CONTEXT_LENGTH);
constexpr int HEAD_MATRIX_MAX = HEAD_VECTOR_MAX * HEAD_ACCUM_MAX;

constexpr int QKV_TO_BUF_VEC_UNROLL              = min2_constexpr(HEAD_VECTOR_MAX,       QKV_TO_BUF_VEC_UNROLL_TARGET);
constexpr int ATT_SCORES_TO_BUF_VEC_UNROLL        = min2_constexpr(HEAD_VECTOR_MAX,       ATT_SCORES_TO_BUF_VEC_UNROLL_TARGET);
constexpr int ATT_SCORES_TO_BUF_OUT_UNROLL        = min2_constexpr(ATT_CTX_BLOCK,         ATT_SCORES_TO_BUF_OUT_UNROLL_TARGET);
constexpr int ATT_VALUE_TO_BUF_CTX_UNROLL         = min2_constexpr(CONTEXT_LENGTH,        ATT_VALUE_TO_BUF_CTX_UNROLL_TARGET);
constexpr int ATT_VALUE_TO_BUF_OUT_UNROLL         = min2_constexpr(D_HEAD_TILE_ATT_VALUE, ATT_VALUE_TO_BUF_OUT_UNROLL_TARGET);
constexpr int VALUE_SCALE_CLAMP_CTX_UNROLL        = min2_constexpr(CONTEXT_LENGTH,        VALUE_SCALE_CLAMP_CTX_UNROLL_TARGET);
constexpr int SOFTMAX_CTX_UNROLL                  = min2_constexpr(CONTEXT_LENGTH,        SOFTMAX_CTX_UNROLL_TARGET);
constexpr int VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL = min2_constexpr(CONTEXT_LENGTH,        VALUE_SCALE_CLAMP_TO_BUF_CTX_UNROLL_TARGET);
// Aliases kept for QKV_TO_BUF local array sizing (accum_tile / act_local / weight_tile)
constexpr int HEAD_MAC_VEC_UNROLL = QKV_TO_BUF_VEC_UNROLL;
constexpr int HEAD_MAC_OUT_UNROLL = ATT_SCORES_TO_BUF_OUT_UNROLL;

static_assert(D_HEADS % ATT_SCORES_TO_BUF_VEC_UNROLL == 0,
    "D_HEADS must be divisible by ATT_SCORES_TO_BUF_VEC_UNROLL");
static_assert(ATT_CTX_BLOCK % ATT_SCORES_TO_BUF_OUT_UNROLL == 0,
    "ATT_CTX_BLOCK must be divisible by ATT_SCORES_TO_BUF_OUT_UNROLL");
static_assert(D_HEAD_TILE_ATT_VALUE % ATT_VALUE_TO_BUF_OUT_UNROLL == 0,
    "D_HEAD_TILE_ATT_VALUE must be divisible by ATT_VALUE_TO_BUF_OUT_UNROLL");
static_assert(CONTEXT_LENGTH % ATT_VALUE_TO_BUF_CTX_UNROLL == 0,
    "CONTEXT_LENGTH must be divisible by ATT_VALUE_TO_BUF_CTX_UNROLL");
