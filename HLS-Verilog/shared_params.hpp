#pragma once
#include <cstdint>

namespace Phi3Mini4K {

    // ================================================================
    // 1. CORE MODEL PARAMETERS
    // ================================================================
    static constexpr uint32_t d_model = 3072;
    static constexpr uint32_t d_ffn = 8192;
    static constexpr uint32_t num_layers = 32;
    static constexpr uint32_t num_heads = 32;
    static constexpr uint32_t head_dim = 96; // d_model / num_heads
    static constexpr uint32_t vocab_size = 32064;
    // max tokens (can increase to 4096 if memory allows)
    static constexpr uint32_t context_len = 2048;
    static constexpr uint32_t logit_scale_qv = 3344;

    // ================================================================
    // PRECISION & BIT WIDTHS
    // ================================================================
    static constexpr uint32_t int4_bits = 4;
    static constexpr uint32_t int8_bits = 8;
    static constexpr uint32_t int16_bits = 16;
    static constexpr uint32_t int32_bits = 32;
    static constexpr uint32_t fp16_bits = 16;

    // ================================================================
    // PER-ELEMENT SIZES (bits)
    // For FPGA resource estimation
    // ================================================================

    // Residual (int8): 3072 values
    static constexpr uint32_t residual_bits =
        d_model * int8_bits;                                      // 24,576 bits
    static constexpr uint32_t residual_kb = residual_bits / 1024; // 24 Kb

    // Per-head QKV weights (int4): 3072 x 96
    static constexpr uint32_t head_weights_count =
        d_model * head_dim; // 294,912
    static constexpr uint32_t head_weights_bits =
        head_weights_count * int4_bits;
    static constexpr uint32_t head_weights_kb =
        head_weights_bits / 1024; // 1,152 Kb

    // Head concat activations (int8): 32 heads x 96
    static constexpr uint32_t head_concat_bits =
        num_heads * head_dim * int8_bits;
    static constexpr uint32_t head_concat_kb = head_concat_bits / 1024; // 24 Kb

    // Full QKV/WO matrix per layer (int4): 3072 x 3072
    static constexpr uint32_t w_qkvo_count = d_model * d_model; // 9,437,184
    static constexpr uint32_t w_qkvo_bits = w_qkvo_count * int4_bits;
    static constexpr uint32_t w_qkvo_kb =
        w_qkvo_bits / 1024; // 36,864 Kb (~36 MB)

    // FFN matrix per layer (int4): 3072 x 8192
    // NOTE: W1 has gate_proj AND up_proj, each [d_ffn, d_model]
    static constexpr uint32_t w_ffn_count = d_model * d_ffn; // 25,165,824
    static constexpr uint32_t w_ffn_bits = w_ffn_count * int4_bits;
    static constexpr uint32_t w_ffn_kb =
        w_ffn_bits / 1024; // 98,304 Kb (~96 MB)
    // 196,608 Kb (~192 MB, gate+up combined)
    static constexpr uint32_t w1_gate_up_kb = w_ffn_kb * 2;

    // ================================================================
    // TILING PARAMETERS
    // ================================================================

    // WO: output projection (after head concat), NOT per-head
    static constexpr uint32_t wo_tile_rows = 128;
    static constexpr uint32_t wo_num_tiles = d_model / wo_tile_rows;

    // W1 (gate / up): tiled along FFN dimension
    static constexpr uint32_t w1_tile_rows = 128;
    static constexpr uint32_t w1_num_tiles = d_ffn / w1_tile_rows;

    // W2 (down): tiled along d_model dimension
    static constexpr uint32_t w2_tile_rows = 128;
    static constexpr uint32_t w2_num_tiles = d_model / w2_tile_rows;

    // ================================================================
    // FPGA ON-CHIP MEMORY (URAM / BRAM)
    // ================================================================

    // URAM
    static constexpr uint32_t uram_block_kb = 288;
    static constexpr uint32_t uram_total_blocks = 64;
    static constexpr uint32_t uram_total_kb =
        uram_total_blocks * uram_block_kb; // 18,432 Kb

    // URAM blocks per tile (ceiling division)
    static constexpr uint32_t blocks_per_head_qkv =
        (head_weights_kb + uram_block_kb - 1) / uram_block_kb; // 4

    static constexpr uint32_t wo_tile_kb =
        (wo_tile_rows * d_model * int4_bits) / 1024; // 768 Kb
    static constexpr uint32_t blocks_per_tile_wo =
        (wo_tile_kb + uram_block_kb - 1) / uram_block_kb; // 3

    static constexpr uint32_t w1_tile_kb =
        (w1_tile_rows * d_model * int4_bits) / 1024; // 768 Kb
    static constexpr uint32_t blocks_per_tile_w1 =
        (w1_tile_kb + uram_block_kb - 1) / uram_block_kb; // 3

    static constexpr uint32_t w2_tile_kb =
        (w2_tile_rows * d_ffn * int4_bits) / 1024; // 2,048 Kb
    static constexpr uint32_t blocks_per_tile_w2 =
        (w2_tile_kb + uram_block_kb - 1) / uram_block_kb; // 8

    // BRAM
    static constexpr uint32_t bram_block_kb = 36;
    static constexpr uint32_t bram_total_blocks = 144;
    static constexpr uint32_t bram_total_kb =
        bram_total_blocks * bram_block_kb; // 5,184 Kb

    // ================================================================
    // KV CACHE (all layers, all heads)
    // ================================================================

    // Per head, per layer
    static constexpr uint32_t kv_cache_head_items = context_len * head_dim;
    static constexpr uint32_t kv_cache_head_bytes = kv_cache_head_items; // int8
    static constexpr uint32_t kv_cache_head_kb =
        kv_cache_head_bytes / 1024; // per K or V

    // Per layer (all heads)
    static constexpr uint32_t kv_cache_layer_items =
        num_heads * context_len * head_dim;
    static constexpr uint32_t kv_cache_layer_bytes =
        kv_cache_layer_items; // int8

    // Total K cache or V cache (all layers)
    static constexpr uint32_t kv_cache_total_items =
        num_layers * num_heads * context_len * head_dim;
    static constexpr uint32_t kv_cache_total_bytes =
        kv_cache_total_items; // int8
    // @ctx=2048: 32 * 32 * 2048 * 96 = 201,326,592 bytes = 192 MB per K or V
    // @ctx=4096: 32 * 32 * 4096 * 96 = 402,653,184 bytes = 384 MB per K or V

    // Per token (all layers, all heads) — growth rate
    static constexpr uint32_t kv_per_token =
        2 * num_layers * num_heads * head_dim; // 196,608 bytes = 192 KB

    // ================================================================
    // DDR SECTION SIZES (bytes)
    // ================================================================
    namespace mem_sizes {
        // Weights (int4 packed = elements / 2)
        static constexpr uint32_t wq =
            num_layers * d_model * d_model / 2; // 144 MB
        static constexpr uint32_t wk = wq;      // 144 MB
        static constexpr uint32_t wv = wq;      // 144 MB
        static constexpr uint32_t wo = wq;      // 144 MB
        static constexpr uint32_t w1_gate =
            num_layers * d_ffn * d_model / 2;      // 384 MB
        static constexpr uint32_t w1_up = w1_gate; // 384 MB
        static constexpr uint32_t w2 =
            num_layers * d_model * d_ffn / 2; // 384 MB
        static constexpr uint32_t embed =
            vocab_size * d_model * 2; // 187.88 MB (fp16)
        static constexpr uint32_t gamma =
            (2 * num_layers + 1) * d_model * 2; // 0.38 MB (fp16)
        static constexpr uint32_t bias = num_layers *
                                         (d_model * 4 + d_ffn * 2 + d_model) *
                                         4; // 3.88 MB (int32)

        // KV cache (int8)
        static constexpr uint32_t k_cache = kv_cache_total_bytes;
        static constexpr uint32_t v_cache = kv_cache_total_bytes;
    } // namespace mem_sizes

    // ================================================================
    // DDR WEIGHT BUFFER OFFSETS (64-byte aligned)
    // Total: ~1920 MB
    // ================================================================
    namespace weight_offsets {
        static constexpr uint32_t align64(uint32_t v) { return (v + 63) & ~63; }

        static constexpr uint32_t wq = 0;
        static constexpr uint32_t wk = align64(wq + mem_sizes::wq);
        static constexpr uint32_t wv = align64(wk + mem_sizes::wk);
        static constexpr uint32_t wo = align64(wv + mem_sizes::wv);
        static constexpr uint32_t w1_gate = align64(wo + mem_sizes::wo);
        static constexpr uint32_t w1_up = align64(w1_gate + mem_sizes::w1_gate);
        static constexpr uint32_t w2 = align64(w1_up + mem_sizes::w1_up);
        static constexpr uint32_t embed = align64(w2 + mem_sizes::w2);
        static constexpr uint32_t gamma = align64(embed + mem_sizes::embed);
        static constexpr uint32_t bias = align64(gamma + mem_sizes::gamma);
        static constexpr uint32_t total = align64(bias + mem_sizes::bias);
    } // namespace weight_offsets

    // ================================================================
    // DDR KV CACHE BUFFER OFFSETS (64-byte aligned)
    // Total: ~768 MB @ ctx=4096, ~384 MB @ ctx=2048
    // ================================================================
    namespace cache_offsets {
        static constexpr uint32_t align64(uint32_t v) { return (v + 63) & ~63; }

        static constexpr uint32_t k_cache = 0;
        static constexpr uint32_t v_cache =
            align64(k_cache + mem_sizes::k_cache);
        static constexpr uint32_t input = align64(v_cache + mem_sizes::v_cache);
        static constexpr uint32_t output = align64(input + d_model);
        static constexpr uint32_t total = align64(output + d_model);
    } // namespace cache_offsets

    // ================================================================
    // STRIDES (bytes) for DDR address computation
    // addr = base_offset + layer * layer_stride + head/tile * sub_stride
    // ================================================================
    namespace strides {
        // Weight layer strides (within each weight section)
        static constexpr uint32_t wq_layer = d_model * d_model / 2; // 4.5 MB
        static constexpr uint32_t wk_layer = wq_layer;
        static constexpr uint32_t wv_layer = wq_layer;
        static constexpr uint32_t wo_layer = wq_layer;
        static constexpr uint32_t w1_gate_layer = d_ffn * d_model / 2; // 12 MB
        static constexpr uint32_t w1_up_layer = w1_gate_layer;
        static constexpr uint32_t w2_layer = d_model * d_ffn / 2; // 12 MB

        // QKV: per-head stride within one layer
        static constexpr uint32_t qkv_head = head_dim * d_model / 2; // 144 KB

        // WO/W1/W2: per-tile stride within one layer
        static constexpr uint32_t wo_tile =
            wo_tile_rows * d_model / 2; // 64 * 3072 / 2 = 96 KB
        static constexpr uint32_t w1_tile =
            w1_tile_rows * d_model / 2; // 64 * 3072 / 2 = 96 KB
        static constexpr uint32_t w2_tile =
            w2_tile_rows * d_ffn / 2; // 64 * 8192 / 2 = 256 KB

        // KV cache strides
        static constexpr uint32_t kv_layer =
            num_heads * context_len * head_dim; // 6 MB @ctx=2048
        static constexpr uint32_t kv_head =
            context_len * head_dim;                    // 192 KB @ctx=2048
        static constexpr uint32_t kv_token = head_dim; // 96 bytes
    } // namespace strides

    // ================================================================
    // DMA TRANSFER SIZES (bytes per operation)
    // ================================================================
    namespace dma_sizes {
        // int4 weights + int32 biases per tile/head
        static constexpr uint32_t qkv_head =
            head_dim * d_model / 2 + head_dim * 4; // 144.4 KB
        static constexpr uint32_t wo_tile =
            wo_tile_rows * d_model / 2 + wo_tile_rows * 4; // 96.25 KB
        static constexpr uint32_t w1_tile =
            w1_tile_rows * d_model / 2 +
            w1_tile_rows * 4; // 96.25 KB (gate OR up)
        static constexpr uint32_t w2_tile =
            w2_tile_rows * d_ffn / 2 + w2_tile_rows * 4; // 256.25 KB
        static constexpr uint32_t gamma_ln =
            d_model * 2; // 6 KB (one RMSNorm, fp16)
        static constexpr uint32_t kv_token =
            head_dim; // 96 bytes (one head, one token)
    } // namespace dma_sizes

    // ================================================================
    // PIPELINE BUFFER SIZES (element counts, not bytes)
    // Used for on-chip BRAM/register allocation
    // ================================================================
    namespace pipeline_bufs {
        // Phase 0: Input / Residual
        static constexpr uint32_t x_in = d_model; // int8

        // Phase 1: Q/K/V Projections (per head)
        static constexpr uint32_t q_head = head_dim; // int8
        static constexpr uint32_t k_head = head_dim; // int8
        static constexpr uint32_t v_head = head_dim; // int8
        static constexpr uint32_t q_all = d_model;   // int8

        // Phase 2 & 3: Attention Scores & Softmax
        static constexpr uint32_t scores_head = context_len; // int16
        static constexpr uint32_t probs_head = context_len;  // int16

        // Phase 4 & 5: Value Aggregation & Output Projection
        static constexpr uint32_t out_head = head_dim; // int8
        static constexpr uint32_t attn_out = d_model;  // int8
        static constexpr uint32_t attn_proj = d_model; // int8
        static constexpr uint32_t x_out = d_model;     // int8

        // Phase 7-10: FFN
        static constexpr uint32_t ffn_gate = d_ffn; // int16 (Q1.15)
        static constexpr uint32_t ffn_up = d_ffn;   // int16 (Q1.15)
        static constexpr uint32_t ffn_act = d_ffn;  // int16 (Q1.15 after SiLU)
        static constexpr uint32_t ffn_down = d_model;  // int8
        static constexpr uint32_t final_out = d_model; // int8
    } // namespace pipeline_bufs

} // namespace Phi3Mini4K

namespace PLRegBits {
    // AXI-Lite Control Register Bits (From Vitis HLS UG1399)
    constexpr uint32_t AP_START_BIT = (1u << 0);
    constexpr uint32_t AP_DONE_BIT = (1u << 1);
    constexpr uint32_t AP_IDLE_BIT = (1u << 2);
    constexpr uint32_t AP_READY_BIT = (1u << 3);
    constexpr uint32_t AP_AUTO_RESTART_BIT = (1u << 7);

    // Bit positions: bit0 = reset_n, bit1 = start
    constexpr uint32_t CTRL_RESETN_BIT = 1u << 0;
    constexpr uint32_t CTRL_START_BIT = 1u << 1;
    // Testing Bits
    constexpr uint32_t CTRL_WEIGHTS_GET_BIT = 1u << 2;
    constexpr uint32_t CTRL_KCACHE_SEND_BIT = 1u << 3;
    constexpr uint32_t CTRL_KCACHE_GET_BIT = 1u << 4;
    constexpr uint32_t CTRL_VCACHE_SEND_BIT = 1u << 5;
    constexpr uint32_t CTRL_VCACHE_GET_BIT = 1u << 6;
    constexpr uint32_t CTRL_STREAM_IN_BIT = 1u << 7;
    constexpr uint32_t CTRL_STREAM_OUT_BIT = 1u << 8;
    constexpr uint32_t CTRL_INCR_HEAD_BIT = 1u << 9;
    constexpr uint32_t CTRL_INCR_LAYER_BIT = 1u << 10;
    constexpr uint32_t CTRL_INCR_MATRIX_BIT = 1u << 11;
    constexpr uint32_t CTRL_INCR_TOKEN_BIT = 1u << 12;
    constexpr uint32_t CTRL_COMPUTE_BIT = 1u << 13;

    // IRQ Bits
    constexpr uint32_t IRQ_ERROR_BIT = 1u << 1;
    constexpr uint32_t IRQ_INFER_DONE_BIT = 1u << 2;
    // Testing Bits
    constexpr uint32_t IRQ_AXI_DONE_BIT = 1u << 3;

    // Status bits
    constexpr uint32_t STAT_IDLE_BIT = 1u << 0;
    // I don't think we need this redundant, IRQ already tells us
    // and we kinda want to know what its status was when error happened
    // constexpr uint32_t STAT_ERROR             = 1u << 1;
    constexpr uint32_t STAT_BUSY_BIT = 1u << 2;
    // Testing Bits
    constexpr uint32_t STAT_WEIGHTS_GET_BIT = 1u << 3;
    constexpr uint32_t STAT_KCACHE_GET_BIT = 1u << 4;
    constexpr uint32_t STAT_KCACHE_SEND_BIT = 1u << 5;
    constexpr uint32_t STAT_VCACHE_GET_BIT = 1u << 6;
    constexpr uint32_t STAT_VCACHE_SEND_BIT = 1u << 7;
    constexpr uint32_t STAT_STREAM_IN_BIT = 1u << 8;
    constexpr uint32_t STAT_STREAM_OUT_BIT = 1u << 9;
    constexpr uint32_t STAT_INCR_HEAD_BIT = 1u << 10;
    constexpr uint32_t STAT_INCR_LAYER_BIT = 1u << 11;
    constexpr uint32_t STAT_INCR_MATRIX_BIT = 1u << 12;
    constexpr uint32_t STAT_INCR_TOKEN_BIT = 1u << 13;
    constexpr uint32_t STAT_COMPUTE_BIT = 1u << 14;

    // Error Bits
    constexpr uint32_t ERR_NONE_BIT = 0;
    constexpr uint32_t ERR_DMA_ALIGNMENT_BIT = 1u << 0;
    constexpr uint32_t ERR_DMA_ZERO_STRIDE_BIT = 1u << 1;
    constexpr uint32_t ERR_SCHEDULER_ERROR_BIT = 1u << 2;
    constexpr uint32_t ERR_COMPUTE_ERROR_BIT = 1u << 3;
    constexpr uint32_t ERR_INPUT_STREAM_BIT = 1u << 4;
    constexpr uint32_t ERR_WEIGHTS_GET_BIT = 1u << 5;
    constexpr uint32_t ERR_KCACHE_GET_BIT = 1u << 6;
    constexpr uint32_t ERR_KCACHE_SEND_BIT = 1u << 7;
    constexpr uint32_t ERR_VCACHE_GET_BIT = 1u << 8;
    constexpr uint32_t ERR_VCACHE_SEND_BIT = 1u << 9;

    constexpr uint32_t ERR_ALL_BITS =
        ERR_DMA_ALIGNMENT_BIT | ERR_DMA_ZERO_STRIDE_BIT |
        ERR_SCHEDULER_ERROR_BIT | ERR_COMPUTE_ERROR_BIT | ERR_INPUT_STREAM_BIT |
        ERR_WEIGHTS_GET_BIT | ERR_KCACHE_GET_BIT | ERR_KCACHE_SEND_BIT |
        ERR_VCACHE_GET_BIT | ERR_VCACHE_SEND_BIT;
} // namespace PLRegBits
