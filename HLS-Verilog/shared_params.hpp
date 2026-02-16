#pragma once
#include <cstdint>

namespace Phi3Mini2K {

    // ==========================================
    // Core Model Parameters
    // ==========================================
    static constexpr uint32_t d_model = 3072;
    static constexpr uint32_t d_ffn = 8192; // 8/3 expansion for SwiGLU
    static constexpr uint32_t num_layers = 32;
    static constexpr uint32_t num_heads = 32;
    static constexpr uint32_t head_dim = 96; // d_model / num_heads
    static constexpr uint32_t context_len = 2048;

    // ==========================================
    // Precision & Bit Sizes
    // ==========================================
    static constexpr uint32_t int8_bits = 8;
    static constexpr uint32_t int4_bits = 4;
    static constexpr uint32_t int16_bits = 16;
    static constexpr uint32_t int32_bits = 32;

    // ==========================================
    // Memory Sizes (in Bits and Kb)
    // ==========================================
    // Residual size (int8): 3072 values -> 24 Kb
    static constexpr uint32_t residual_bits = d_model * int8_bits;
    static constexpr uint32_t residual_kb = residual_bits / 1024;

    // Head size (int4): Q/K/V weights per head
    static constexpr uint32_t head_weights_count = d_model * head_dim;
    static constexpr uint32_t head_weights_bits = head_weights_count * int4_bits;
    static constexpr uint32_t head_weights_kb = head_weights_bits / 1024; // 1152 Kb

    // Head concat (int8 activations): 32 heads * 96
    static constexpr uint32_t head_concat_bits = num_heads * head_dim * int8_bits;
    static constexpr uint32_t head_concat_kb = head_concat_bits / 1024; // 24 Kb

    // WQ, WK, WV, WO dimensions (int4): 3072 x 3072
    static constexpr uint32_t w_qkv_weights_count = d_model * d_model;
    static constexpr uint32_t w_qkv_bits = w_qkv_weights_count * int4_bits;
    static constexpr uint32_t w_qkv_kb = w_qkv_bits / 1024; // 36,864 Kb (~36 Mb)

    // W1 (Up/Gate) & W2 (Down) dimensions (int4): 3072 x 8192
    static constexpr uint32_t w_ffn_weights_count = d_model * d_ffn;
    static constexpr uint32_t w_ffn_bits = w_ffn_weights_count * int4_bits;
    static constexpr uint32_t w_ffn_kb = w_ffn_bits / 1024; // 98,304 Kb (~96 Mb)

    // ==========================================
    // Tiling Methods
    // ==========================================
    // WO tiled by head_dim (32 tiles of 3072 x 96)
    static constexpr uint32_t w_out_tile_cols = head_dim;
    static constexpr uint32_t w_out_num_tiles = num_heads; // 32

    // W1 / W2 tiled by 256 (32 tiles to cleanly divide 8192)
    static constexpr uint32_t ffn_tile_cols = 256; 
    static constexpr uint32_t ffn_num_tiles = d_ffn / ffn_tile_cols; // 32 tiles

    // ==========================================
    // KV Cache
    // ==========================================
    static constexpr uint32_t kv_cache_head_items = context_len * head_dim;
    static constexpr uint32_t kv_cache_head_bits = kv_cache_head_items * int8_bits;
    static constexpr uint32_t kv_cache_head_kb = kv_cache_head_bits / 1024; // 1536 Kb per head

    static constexpr uint32_t kv_cache_all_items = num_heads * context_len * head_dim;
    static constexpr uint32_t kv_cache_all_kb = (kv_cache_all_items * int8_bits) / 1024; // 49,152 Kb (~48 Mb)

}

namespace PLRegBits {
    // AXI-Lite Control Register Bits (From Vitis HLS UG1399)
    constexpr uint32_t AP_START_BIT         = (1u << 0);
    constexpr uint32_t AP_DONE_BIT          = (1u << 1);
    constexpr uint32_t AP_IDLE_BIT          = (1u << 2);
    constexpr uint32_t AP_READY_BIT         = (1u << 3);
    constexpr uint32_t AP_AUTO_RESTART_BIT  = (1u << 7);
    
    // Bit positions: bit0 = reset_n, bit1 = start
    constexpr uint32_t CTRL_RESETN_BIT      = 1u << 0;
    constexpr uint32_t CTRL_START_BIT       = 1u << 1;
    // Testing Bits
    constexpr uint32_t CTRL_WEIGHTS_GET_BIT = 1u << 2;
    constexpr uint32_t CTRL_KCACHE_SEND_BIT = 1u << 3;
    constexpr uint32_t CTRL_KCACHE_GET_BIT  = 1u << 4;
    constexpr uint32_t CTRL_VCACHE_SEND_BIT = 1u << 5;
    constexpr uint32_t CTRL_VCACHE_GET_BIT  = 1u << 6;
    constexpr uint32_t CTRL_STREAM_IN_BIT   = 1u << 7;
    constexpr uint32_t CTRL_STREAM_OUT_BIT  = 1u << 8;
    constexpr uint32_t CTRL_INCR_HEAD_BIT   = 1u << 9;
    constexpr uint32_t CTRL_INCR_LAYER_BIT  = 1u << 10;
    constexpr uint32_t CTRL_INCR_MATRIX_BIT = 1u << 11;
    constexpr uint32_t CTRL_INCR_TOKEN_BIT  = 1u << 12;
    constexpr uint32_t CTRL_COMPUTE_BIT     = 1u << 13;

    // IRQ Bits
    constexpr uint32_t IRQ_ERROR_BIT        = 1u << 1;
    constexpr uint32_t IRQ_INFER_DONE_BIT   = 1u << 2;
    // Testing Bits
    constexpr uint32_t IRQ_AXI_DONE_BIT     = 1u << 3;

    // Status bits
    constexpr uint32_t STAT_IDLE_BIT        = 1u << 0;
    // I don't think we need this redundant, IRQ already tells us
    // and we kinda want to know what its status was when error happened
    //constexpr uint32_t STAT_ERROR             = 1u << 1;
    constexpr uint32_t STAT_BUSY_BIT        = 1u << 2;
    // Testing Bits
    constexpr uint32_t STAT_WEIGHTS_GET_BIT = 1u << 3;
    constexpr uint32_t STAT_KCACHE_GET_BIT  = 1u << 4;
    constexpr uint32_t STAT_KCACHE_SEND_BIT = 1u << 5;
    constexpr uint32_t STAT_VCACHE_GET_BIT  = 1u << 6;
    constexpr uint32_t STAT_VCACHE_SEND_BIT = 1u << 7;
    constexpr uint32_t STAT_STREAM_IN_BIT   = 1u << 8;
    constexpr uint32_t STAT_STREAM_OUT_BIT  = 1u << 9;
    constexpr uint32_t STAT_INCR_HEAD_BIT   = 1u << 10;
    constexpr uint32_t STAT_INCR_LAYER_BIT  = 1u << 11;
    constexpr uint32_t STAT_INCR_MATRIX_BIT = 1u << 12;
    constexpr uint32_t STAT_INCR_TOKEN_BIT  = 1u << 13;
    constexpr uint32_t STAT_COMPUTE_BIT     = 1u << 14;

    // Error Bits
    constexpr uint32_t ERR_NONE_BIT            = 0;
    constexpr uint32_t ERR_DMA_ALIGNMENT_BIT   = 1u << 0;
    constexpr uint32_t ERR_DMA_ZERO_STRIDE_BIT = 1u << 1;
    constexpr uint32_t ERR_SCHEDULER_ERROR_BIT = 1u << 2;
    constexpr uint32_t ERR_COMPUTE_ERROR_BIT   = 1u << 3;
    constexpr uint32_t ERR_INPUT_STREAM_BIT    = 1u << 4;
    constexpr uint32_t ERR_WEIGHTS_GET_BIT     = 1u << 5;
    constexpr uint32_t ERR_KCACHE_GET_BIT      = 1u << 6;
    constexpr uint32_t ERR_KCACHE_SEND_BIT     = 1u << 7;
    constexpr uint32_t ERR_VCACHE_GET_BIT      = 1u << 8;
    constexpr uint32_t ERR_VCACHE_SEND_BIT     = 1u << 9;
    
    constexpr uint32_t ERR_ALL_BITS = ERR_DMA_ALIGNMENT_BIT | ERR_DMA_ZERO_STRIDE_BIT
                                    | ERR_SCHEDULER_ERROR_BIT | ERR_COMPUTE_ERROR_BIT
                                    | ERR_INPUT_STREAM_BIT | ERR_WEIGHTS_GET_BIT
                                    | ERR_KCACHE_GET_BIT | ERR_KCACHE_SEND_BIT
                                    | ERR_VCACHE_GET_BIT | ERR_VCACHE_SEND_BIT;
}

