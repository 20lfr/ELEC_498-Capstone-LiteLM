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
    size_t dmabuf0_size = 0x70000000;
    std::string dmabuf1_name = "udmabuf1";
    size_t dmabuf1_size = 0x10000000;
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
    bool debug_mode = false;
};

struct ModelConfig {
    std::string weights_file = "model/phi3_weights_int4.bin";
    std::string quant_params_file = "model/quantization.bin";
    std::string tokenizer_vocab = "model/vocab.txt";
    std::string embeddings_file = "model/embeddings.bin";

    uint32_t vocab_size = MODEL_VOCAB_SIZE;
    uint32_t logit_scale_qv = ATTN_SCALE_Q15;

    uint32_t layer_stride = STRIDE_WQ_LAYER;
    uint32_t wq_head_stride = STRIDE_QKV_HEAD;
    uint32_t wk_head_stride = STRIDE_QKV_HEAD;
    uint32_t wv_head_stride = STRIDE_QKV_HEAD;

    uint32_t k_cache_stride = STRIDE_KV_HEAD;
    uint32_t v_cache_stride = STRIDE_KV_HEAD;

    uint32_t wo_tile_stride = STRIDE_WO_TILE;
    uint32_t w1_tile_stride = STRIDE_W1_TILE;
    uint32_t w2_tile_stride = STRIDE_W2_TILE;
    uint32_t wo_bias_tile_stride = D_TILE_WO * sizeof(int32_t);
    uint32_t w1_bias_tile_stride = D_TILE_W1 * sizeof(int32_t);
    uint32_t w2_bias_tile_stride = D_TILE_W2 * sizeof(int32_t);
    uint32_t wlogit_tile_stride = D_TILE_LOGIT * sizeof(int32_t);
    uint32_t ln0_gamma_stride = D_MODEL * sizeof(int32_t);
    uint32_t ln1_gamma_stride = D_MODEL * sizeof(int32_t);
    uint32_t final_norm_gamma_stride = D_MODEL * sizeof(int32_t);
    uint32_t ln0_eps_stride = sizeof(uint32_t);
    uint32_t ln1_eps_stride = sizeof(uint32_t);
    uint32_t final_norm_eps_stride = sizeof(uint32_t);

    bool validate() const {
        return layer_stride && wq_head_stride && wk_head_stride &&
               wv_head_stride && k_cache_stride && v_cache_stride &&
               wo_tile_stride && w1_tile_stride && w2_tile_stride &&
               wo_bias_tile_stride && w1_bias_tile_stride &&
               w2_bias_tile_stride && wlogit_tile_stride && ln0_gamma_stride &&
               ln1_gamma_stride && final_norm_gamma_stride && ln0_eps_stride &&
               ln1_eps_stride && final_norm_eps_stride;
    }
};

constexpr uint32_t align64(uint32_t v) { return (v + 63) & ~63; }

struct MemoryLayout {
    // Weight offsets (relative to dmabuf base)
    static constexpr uint32_t wq_off = 0;
    static constexpr uint32_t wk_off = align64(wq_off + MEM_WQ);
    static constexpr uint32_t wv_off = align64(wk_off + MEM_WK);
    static constexpr uint32_t wo_off = align64(wv_off + MEM_WV);
    static constexpr uint32_t w1_off = align64(wo_off + MEM_WO);
    static constexpr uint32_t w1_up_off = align64(w1_off + MEM_W1_GATE);
    static constexpr uint32_t w2_off = align64(w1_up_off + MEM_W1_UP);
    static constexpr uint32_t embed_off = align64(w2_off + MEM_W2);
    static constexpr uint32_t wo_bias_off = align64(embed_off + MEM_EMBED);
    static constexpr uint32_t w1_bias_off = align64(wo_bias_off + MEM_WO_BIAS);
    static constexpr uint32_t w2_bias_off = align64(w1_bias_off + MEM_W1_BIAS);
    static constexpr uint32_t ln0_gamma_off =
        align64(w2_bias_off + MEM_W2_BIAS);
    static constexpr uint32_t ln1_gamma_off =
        align64(ln0_gamma_off + MEM_LN0_GAMMA);
    static constexpr uint32_t final_norm_gamma_off =
        align64(ln1_gamma_off + MEM_LN1_GAMMA);
    static constexpr uint32_t ln0_eps_off =
        align64(final_norm_gamma_off + MEM_FINAL_NORM_GAMMA);
    static constexpr uint32_t ln1_eps_off = align64(ln0_eps_off + MEM_LN0_EPS);
    static constexpr uint32_t final_norm_eps_off =
        align64(ln1_eps_off + MEM_LN1_EPS);
    static constexpr uint32_t wlogit_off =
        align64(final_norm_eps_off + MEM_FINAL_NORM_EPS);
    static constexpr uint32_t w_size = align64(wlogit_off + MEM_WLOGIT);

    // KV cache / stream offsets (after weights)
    static constexpr uint32_t k_cache_off = 0;
    static constexpr uint32_t v_cache_off = align64(k_cache_off + MEM_K_CACHE);
    static constexpr uint32_t input_off = align64(v_cache_off + MEM_V_CACHE);
    static constexpr uint32_t output_off = align64(input_off + D_MODEL);
    static constexpr uint32_t kv_size = align64(output_off + D_MODEL);

    // Runtime-overridable fields (default to computed values)
    uint32_t wq_offset = wq_off;
    uint32_t wk_offset = wk_off;
    uint32_t wv_offset = wv_off;
    uint32_t wo_offset = wo_off;
    uint32_t w1_offset = w1_off;
    uint32_t w2_offset = w2_off;
    uint32_t embed_offset = embed_off;
    uint32_t wo_bias_offset = wo_bias_off;
    uint32_t w1_bias_offset = w1_bias_off;
    uint32_t w2_bias_offset = w2_bias_off;
    uint32_t ln0_gamma_offset = ln0_gamma_off;
    uint32_t ln1_gamma_offset = ln1_gamma_off;
    uint32_t final_norm_gamma_offset = final_norm_gamma_off;
    uint32_t ln0_eps_offset = ln0_eps_off;
    uint32_t ln1_eps_offset = ln1_eps_off;
    uint32_t final_norm_eps_offset = final_norm_eps_off;
    uint32_t wlogit_offset = wlogit_off;

    uint64_t dmabuf0_size = w_size + 1024;

    uint32_t k_cache_offset = k_cache_off;
    uint32_t v_cache_offset = v_cache_off;
    uint32_t input_offset = input_off;
    uint32_t output_offset = output_off;

    uint64_t dmabuf1_size = kv_size + 1024;

    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset | w1_offset |
                  w2_offset | k_cache_offset | v_cache_offset | input_offset |
                  output_offset | embed_offset | wo_bias_offset |
                  w1_bias_offset | w2_bias_offset | ln0_gamma_offset |
                  ln1_gamma_offset | final_norm_gamma_offset | ln0_eps_offset |
                  ln1_eps_offset | final_norm_eps_offset | wlogit_offset) &
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
