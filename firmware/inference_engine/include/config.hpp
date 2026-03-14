#ifndef CONFIG_HPP
#define CONFIG_HPP

#include "shared_params.hpp"
#include <cstdint>
#include <string>

struct HardwareConfig {
    uint64_t stream_reg_base_addr = 0xa0000000;
    std::string uio_device = "transformer_top";
    std::string dmabuf0_name = "udmabuf0";
    size_t dmabuf0_size = 0x72000000;
    std::string dmabuf1_name = "udmabuf1";
    size_t dmabuf1_size = 0x20000000;
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
    bool debug_mode = false;
};

struct ModelConfig {
    std::string weights_file = "model/gpt2_weights_int8.bin";
    std::string tokenizer_vocab = "model/vocab.txt";
    std::string embeddings_file = "model/embed_tokens.bin";
    std::string pos_embeddings_file = "model/pos_embed.bin";

    uint32_t vocab_size = MODEL_VOCAB_SIZE;
    uint32_t context_length = MODEL_CONTEXT_LENGTH;

    bool validate() const {
        return STRIDE_WQ_LAYER && STRIDE_QKV_HEAD && STRIDE_KV_HEAD &&
               STRIDE_WO_TILE && STRIDE_W1_TILE && STRIDE_W2_TILE &&
               STRIDE_WO_BIAS_TILE && STRIDE_W1_BIAS_TILE &&
               STRIDE_W2_BIAS_TILE && STRIDE_WLOGIT_TILE && STRIDE_LN0_GAMMA &&
               STRIDE_LN1_GAMMA && STRIDE_FINAL_NORM_GAMMA && STRIDE_LN0_EPS &&
               STRIDE_LN1_EPS && STRIDE_FINAL_NORM_EPS;
    }
};

struct MemoryLayout {
    // ═══════════════════════════════════════════════════════════════════
    // All offsets come from shared_params.hpp (WQ_OFF, WK_OFF, etc.)
    // which are computed from the HLS dimensions.
    // ═══════════════════════════════════════════════════════════════════

    // Weights (int8)
    uint32_t wq_offset = WQ_OFF;
    uint32_t wk_offset = WK_OFF;
    uint32_t wv_offset = WV_OFF;
    uint32_t wo_offset = WO_OFF;
    uint32_t w1_offset = W1_OFF;
    uint32_t w2_offset = W2_OFF;
    uint32_t wlogit_offset = WLOGIT_OFF;

    // Biases (Q16.16 int32)
    uint32_t wq_bias_offset = WQ_BIAS_OFF;
    uint32_t wk_bias_offset = WK_BIAS_OFF;
    uint32_t wv_bias_offset = WV_BIAS_OFF;
    uint32_t wo_bias_offset = WO_BIAS_OFF;
    uint32_t w1_bias_offset = W1_BIAS_OFF;
    uint32_t w2_bias_offset = W2_BIAS_OFF;

    // LayerNorm gamma + beta (Q16.16 int32)
    uint32_t ln0_gamma_offset = LN0_GAMMA_OFF;
    uint32_t ln0_beta_offset = LN0_BETA_OFF;
    uint32_t ln1_gamma_offset = LN1_GAMMA_OFF;
    uint32_t ln1_beta_offset = LN1_BETA_OFF;
    uint32_t final_norm_gamma_offset = FINAL_NORM_GAMMA_OFF;
    uint32_t final_norm_beta_offset = FINAL_NORM_BETA_OFF;

    // Epsilon
    uint32_t ln0_eps_offset = LN0_EPS_OFF;
    uint32_t ln1_eps_offset = LN1_EPS_OFF;
    uint32_t final_norm_eps_offset = FINAL_NORM_EPS_OFF;

    // Position embeddings (int8)
    uint32_t pos_embed_offset = POS_EMBED_OFF;

    uint32_t weights_size = WEIGHTS_SIZE;

    // KV cache (udmabuf1, starts at 0)
    uint32_t k_cache_offset = K_CACHE_OFF;
    uint32_t v_cache_offset = V_CACHE_OFF;

    // Stream I/O (in KV buffer, after V cache)
    uint32_t input_offset = align64_u32(KV_SIZE);
    uint32_t output_offset = align64_u32(input_offset + STREAM_IN_BUF_BYTES);
    static constexpr uint32_t total_kv_size =
        align64_u32(align64_u32(V_CACHE_OFF + MEM_V_CACHE) +
                    STREAM_IN_BUF_BYTES + STREAM_OUT_BUF_BYTES);

    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset | w1_offset |
                  w2_offset | wlogit_offset | wq_bias_offset | wk_bias_offset |
                  wv_bias_offset | wo_bias_offset | w1_bias_offset |
                  w2_bias_offset | ln0_gamma_offset | ln0_beta_offset |
                  ln1_gamma_offset | ln1_beta_offset | final_norm_gamma_offset |
                  final_norm_beta_offset | ln0_eps_offset | ln1_eps_offset |
                  final_norm_eps_offset | pos_embed_offset | k_cache_offset |
                  v_cache_offset | input_offset | output_offset) &
                 0x3F);
    }
};

struct GenerationConfig {
    uint32_t max_tokens = 512;
};

struct SystemConfig {
    HardwareConfig hardware;
    ModelConfig model;
    MemoryLayout memory;
    GenerationConfig generation;

    bool validate() const {
        return model.validate() && memory.isAligned() &&
               hardware.dmabuf0_size >= memory.weights_size &&
               hardware.dmabuf1_size >= memory.total_kv_size;
    }
    bool loadFromFile(const std::string &) { return true; }
};
#endif
