#ifndef CONFIG_HPP
#define CONFIG_HPP

#include "shared_params.hpp"
#include <cstdint>
#include <string>

struct HardwareConfig {
    uint64_t stream_reg_base_addr = 0xa0000000;
    std::string uio_device = "transformer_top";
    std::string dmabuf0_name = "udmabuf0";
    size_t dmabuf0_size = 0x08000000;    // 128 MB (weights ~119 MB for full GPT-2)
    std::string dmabuf1_name = "udmabuf1";
    size_t dmabuf1_size = 0x02000000;    // 32 MB (KV cache)
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
    bool debug_mode = false;
};

struct ModelConfig {
    std::string weights_file        = "model/gpt2_weights_int8.bin";
    std::string tokenizer_vocab     = "model/vocab.txt";
    std::string embeddings_file     = "model/embed_tokens.bin";
    std::string pos_embeddings_file = "model/pos_embed.bin";

    uint32_t vocab_size = MODEL_VOCAB_SIZE;

    // Strides — from shared_params.hpp (int8: full byte, no /2)
    uint32_t layer_stride            = STRIDE_WQ_LAYER;
    uint32_t wq_head_stride          = STRIDE_QKV_HEAD;
    uint32_t wk_head_stride          = STRIDE_QKV_HEAD;
    uint32_t wv_head_stride          = STRIDE_QKV_HEAD;
    uint32_t k_cache_stride          = STRIDE_KV_HEAD;
    uint32_t v_cache_stride          = STRIDE_KV_HEAD;
    uint32_t wo_tile_stride          = STRIDE_WO_TILE;
    uint32_t w1_tile_stride          = STRIDE_W1_TILE;
    uint32_t w2_tile_stride          = STRIDE_W2_TILE;
    uint32_t wo_bias_tile_stride     = STRIDE_WO_BIAS_TILE;
    uint32_t w1_bias_tile_stride     = STRIDE_W1_BIAS_TILE;
    uint32_t w2_bias_tile_stride     = STRIDE_W2_BIAS_TILE;
    uint32_t wlogit_tile_stride      = STRIDE_WLOGIT_TILE;
    uint32_t ln0_gamma_stride        = STRIDE_LN0_GAMMA;
    uint32_t ln1_gamma_stride        = STRIDE_LN1_GAMMA;
    uint32_t final_norm_gamma_stride = STRIDE_FINAL_NORM_GAMMA;
    uint32_t ln0_eps_stride          = STRIDE_LN0_EPS;
    uint32_t ln1_eps_stride          = STRIDE_LN1_EPS;
    uint32_t final_norm_eps_stride   = STRIDE_FINAL_NORM_EPS;

    bool validate() const {
        return layer_stride && wq_head_stride && wk_head_stride &&
               wv_head_stride && k_cache_stride && v_cache_stride &&
               wo_tile_stride && w1_tile_stride && w2_tile_stride &&
               wo_bias_tile_stride && w1_bias_tile_stride &&
               w2_bias_tile_stride && wlogit_tile_stride &&
               ln0_gamma_stride && ln1_gamma_stride &&
               final_norm_gamma_stride && ln0_eps_stride &&
               ln1_eps_stride && final_norm_eps_stride;
    }
};

struct MemoryLayout {
    // ═══════════════════════════════════════════════════════════════════
    // All offsets come from shared_params.hpp (WQ_OFF, WK_OFF, etc.)
    // which are computed from the HLS dimensions.
    // ═══════════════════════════════════════════════════════════════════

    // Weights (int8)
    uint32_t wq_offset     = WQ_OFF;
    uint32_t wk_offset     = WK_OFF;
    uint32_t wv_offset     = WV_OFF;
    uint32_t wo_offset     = WO_OFF;
    uint32_t w1_offset     = W1_OFF;
    uint32_t w2_offset     = W2_OFF;
    uint32_t wlogit_offset = WLOGIT_OFF;

    // Biases (Q16.16 int32) — GPT-2 has biases on all projections
    uint32_t wq_bias_offset = WQ_BIAS_OFF;
    uint32_t wk_bias_offset = WK_BIAS_OFF;
    uint32_t wv_bias_offset = WV_BIAS_OFF;
    uint32_t wo_bias_offset = WO_BIAS_OFF;
    uint32_t w1_bias_offset = W1_BIAS_OFF;
    uint32_t w2_bias_offset = W2_BIAS_OFF;

    // LayerNorm gamma + beta (Q16.16 int32)
    uint32_t ln0_gamma_offset       = LN0_GAMMA_OFF;
    uint32_t ln0_beta_offset        = LN0_BETA_OFF;
    uint32_t ln1_gamma_offset       = LN1_GAMMA_OFF;
    uint32_t ln1_beta_offset        = LN1_BETA_OFF;
    uint32_t final_norm_gamma_offset = FINAL_NORM_GAMMA_OFF;
    uint32_t final_norm_beta_offset  = FINAL_NORM_BETA_OFF;

    // Epsilon
    uint32_t ln0_eps_offset        = LN0_EPS_OFF;
    uint32_t ln1_eps_offset        = LN1_EPS_OFF;
    uint32_t final_norm_eps_offset = FINAL_NORM_EPS_OFF;

    // Position embeddings (int8)
    uint32_t pos_embed_offset = POS_EMBED_OFF;

    // KV cache (udmabuf1, starts at 0)
    uint32_t k_cache_offset = K_CACHE_OFF;
    uint32_t v_cache_offset = V_CACHE_OFF;

    // Stream I/O (in KV buffer, after V cache)
    uint32_t input_offset  = align64_u32(V_CACHE_OFF + MEM_V_CACHE);
    uint32_t output_offset = align64_u32(align64_u32(V_CACHE_OFF + MEM_V_CACHE) + STREAM_IN_BUF_BYTES);

    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset |
                  w1_offset | w2_offset | wlogit_offset |
                  wq_bias_offset | wk_bias_offset | wv_bias_offset |
                  wo_bias_offset | w1_bias_offset | w2_bias_offset |
                  ln0_gamma_offset | ln0_beta_offset |
                  ln1_gamma_offset | ln1_beta_offset |
                  final_norm_gamma_offset | final_norm_beta_offset |
                  ln0_eps_offset | ln1_eps_offset | final_norm_eps_offset |
                  pos_embed_offset |
                  k_cache_offset | v_cache_offset |
                  input_offset | output_offset) & 0x3F);
    }
};

struct GenerationConfig {
    uint32_t max_tokens = 512;
    float temperature = 0.7f;
    float top_p = 0.9f;
    uint32_t top_k = 50;
};

struct SystemConfig {
    HardwareConfig hardware;
    ModelConfig model;
    MemoryLayout memory;
    GenerationConfig generation;

    bool validate() const {
        return model.validate() && memory.isAligned();
    }
    bool loadFromFile(const std::string &) { return true; }
};

#endif
