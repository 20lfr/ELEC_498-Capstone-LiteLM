// config.hpp - LiteLM inference engine configuration
#ifndef CONFIG_HPP
#define CONFIG_HPP

#include "shared_params.hpp"
#include <cstdint>
#include <string>

struct HardwareConfig {
    uint64_t stream_reg_base_addr = 0xa0000000;
    std::string uio_device = "transformer_top";
    std::string dmabuf0_name = "udmabuf0";
    size_t dmabuf0_size = static_cast<size_t>(WEIGHTS_SIZE) + 1024u;
    std::string dmabuf1_name = "udmabuf1";
    size_t dmabuf1_size = 0x20000000;
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
    bool debug_mode = false;
};

struct ModelConfig {
    std::string weights_file = "/home/luka/Scripting/model/phi3_weights_int4.bin";
    std::string tokenizer_vocab = "/home/luka/Scripting/model/vocab.txt";
    std::string embeddings_file = "/home/luka/Scripting/model/embed_tokens.bin";

    uint32_t vocab_size = MODEL_VOCAB_SIZE;

    bool validate() const { return true; }
};

struct MemoryLayout {

    // Runtime-overridable fields (default to computed values)
    uint32_t wq_offset = WQ_OFF;
    uint32_t wk_offset = WK_OFF;
    uint32_t wv_offset = WV_OFF;
    uint32_t wo_offset = WO_OFF;
    uint32_t w1_gate_offset = W1_OFF;
    uint32_t w1_up_offset = W1_UP_OFF;
    uint32_t w2_offset = W2_OFF;
    uint32_t wo_bias_offset = WO_BIAS_OFF;
    uint32_t w1_bias_offset = W1_BIAS_OFF;
    uint32_t w2_bias_offset = W2_BIAS_OFF;
    uint32_t ln0_gamma_offset = LN0_GAMMA_OFF;
    uint32_t ln1_gamma_offset = LN1_GAMMA_OFF;
    uint32_t final_norm_gamma_offset = FINAL_NORM_GAMMA_OFF;
    uint32_t ln0_eps_offset = LN0_EPS_OFF;
    uint32_t ln1_eps_offset = LN1_EPS_OFF;
    uint32_t final_norm_eps_offset = FINAL_NORM_EPS_OFF;
    uint32_t wlogit_offset = WLOGIT_OFF;

    uint64_t dmabuf0_size = static_cast<uint64_t>(WEIGHTS_SIZE) + 1024u;

    uint32_t k_cache_offset = K_CACHE_OFF;
    uint32_t v_cache_offset = V_CACHE_OFF;
    uint32_t input_offset = align64_u32(V_CACHE_OFF + MEM_V_CACHE);
    uint32_t output_offset = align64_u32(input_offset + STREAM_IN_BUF_BYTES);

    uint64_t dmabuf1_size = static_cast<uint64_t>(output_offset) + 1024u;

    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset |
                  w1_gate_offset | w1_up_offset |
                  w2_offset | k_cache_offset | v_cache_offset | input_offset |
                  output_offset | wo_bias_offset | w1_bias_offset |
                  w2_bias_offset | ln0_gamma_offset | ln1_gamma_offset |
                  final_norm_gamma_offset | ln0_eps_offset | ln1_eps_offset |
                  final_norm_eps_offset | wlogit_offset) &
                 0x3F);
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
        return (memory.dmabuf0_size <= hardware.dmabuf0_size) &&
               (memory.dmabuf1_size <= hardware.dmabuf1_size) &&
               model.validate() && memory.isAligned();
    }
    bool loadFromFile(const std::string &) { return true; }
};

#endif
