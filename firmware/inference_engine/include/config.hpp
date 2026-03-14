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
    uint32_t hidden_size = MODEL_HIDDEN_SIZE;
    uint32_t num_layers = MODEL_LAYERS;
    uint32_t stream_in_size = MODEL_HIDDEN_SIZE;
    uint32_t stream_out_size = 4; // int32 token index

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
    // Firmware computes full GPT-2 layout for DDR loading using MODEL_*
    // constants to ensure alignment with the actual weight files.
    // ═══════════════════════════════════════════════════════════════════

    // Weights (int8)
    uint32_t wq_offset = 0;
    uint32_t wk_offset = align64_u32(
        wq_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * MODEL_HIDDEN_SIZE));
    uint32_t wv_offset = align64_u32(
        wk_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * MODEL_HIDDEN_SIZE));
    uint32_t wo_offset = align64_u32(
        wv_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * MODEL_HIDDEN_SIZE));
    uint32_t w1_offset = align64_u32(
        wo_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * MODEL_HIDDEN_SIZE));
    uint32_t w2_offset =
        align64_u32(w1_offset + (MODEL_LAYERS * MODEL_INTERMEDIATE_SIZE *
                                 MODEL_HIDDEN_SIZE));
    uint32_t wlogit_offset =
        align64_u32(w2_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE *
                                 MODEL_INTERMEDIATE_SIZE));

    // Biases (Q16.16 int32)
    uint32_t wo_bias_offset =
        align64_u32(wlogit_offset + (MODEL_VOCAB_SIZE * MODEL_HIDDEN_SIZE));
    uint32_t w1_bias_offset =
        align64_u32(wo_bias_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * 4));
    uint32_t w2_bias_offset = align64_u32(
        w1_bias_offset + (MODEL_LAYERS * MODEL_INTERMEDIATE_SIZE * 4));

    // LayerNorm (Q16.16 int32)
    uint32_t ln0_gamma_offset =
        align64_u32(w2_bias_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * 4));
    uint32_t ln0_beta_offset =
        align64_u32(ln0_gamma_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * 4));
    uint32_t ln1_gamma_offset =
        align64_u32(ln0_beta_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * 4));
    uint32_t ln1_beta_offset =
        align64_u32(ln1_gamma_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * 4));
    uint32_t final_norm_gamma_offset =
        align64_u32(ln1_beta_offset + (MODEL_LAYERS * MODEL_HIDDEN_SIZE * 4));
    uint32_t final_norm_beta_offset =
        align64_u32(final_norm_gamma_offset + (MODEL_HIDDEN_SIZE * 4));

    // Epsilon & Position Embeddings
    uint32_t ln0_eps_offset =
        align64_u32(final_norm_beta_offset + (MODEL_HIDDEN_SIZE * 4));
    uint32_t ln1_eps_offset = align64_u32(ln0_eps_offset + (MODEL_LAYERS * 4));
    uint32_t final_norm_eps_offset =
        align64_u32(ln1_eps_offset + (MODEL_LAYERS * 4));
    uint32_t pos_embed_offset = align64_u32(final_norm_eps_offset + 4);

    uint32_t weights_size = align64_u32(
        pos_embed_offset + (MODEL_CONTEXT_LENGTH * MODEL_HIDDEN_SIZE));

    // KV Cache (DDR BUF1)
    uint32_t k_cache_offset = 0;
    uint32_t v_cache_offset =
        align64_u32(k_cache_offset +
                    (MODEL_LAYERS * MODEL_HIDDEN_SIZE * MODEL_CONTEXT_LENGTH));
    uint32_t input_offset =
        align64_u32(v_cache_offset +
                    (MODEL_LAYERS * MODEL_HIDDEN_SIZE * MODEL_CONTEXT_LENGTH));
    uint32_t output_offset = align64_u32(input_offset + MODEL_HIDDEN_SIZE);
    uint32_t total_kv_size = align64_u32(output_offset + 4);

    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset | w1_offset |
                  w2_offset | wlogit_offset | wo_bias_offset | w1_bias_offset |
                  w2_bias_offset | ln0_gamma_offset | ln1_gamma_offset |
                  final_norm_gamma_offset | ln0_eps_offset | ln1_eps_offset |
                  final_norm_eps_offset | k_cache_offset | v_cache_offset |
                  input_offset | output_offset) &
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
