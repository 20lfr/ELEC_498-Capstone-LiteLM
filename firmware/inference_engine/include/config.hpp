// config.hpp - LiteLM inference engine configuration
#ifndef CONFIG_HPP
#define CONFIG_HPP

#include "shared_params.hpp"
#include <cstdint>
#include <string>

struct HardwareConfig {
    uint64_t stream_reg_base_addr = 0xa0000000;
    std::string uio_device = "axi_top";
    std::string dmabuf_name = "udmabuf0";
    size_t dmabuf_size = 0x7a000000; // 2GB
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
};

struct ModelConfig {
    std::string weights_file = "phi3_weights_int4.bin";
    std::string quant_params_file = "quantization.bin";
    std::string tokenizer_vocab = "tokenizer.model";

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

    // Quantization defaults
    float scale_q = 0.005f;
    int32_t zero_point_q = 0;
    float scale_k = 0.005f;
    int32_t zero_point_k = 0;
    float scale_v = 0.005f;
    int32_t zero_point_v = 0;

    bool validate() const {
        return layer_stride && wq_head_stride && wk_head_stride &&
               wv_head_stride && k_cache_stride && v_cache_stride &&
               wo_tile_stride && w1_tile_stride && w2_tile_stride;
    }
};

struct MemoryLayout {
    static constexpr uint32_t align64(uint32_t v) { return (v + 63) & ~63; }

    // relative to dmabuf
    uint32_t wq_offset = WOFF_WQ;
    uint32_t wk_offset = WOFF_WK;
    uint32_t wv_offset = WOFF_WV;
    uint32_t wo_offset = WOFF_WO;
    uint32_t w1_offset = WOFF_W1_GATE;
    uint32_t w2_offset = WOFF_W2;
    uint32_t k_cache_offset = COFF_K_CACHE;
    uint32_t v_cache_offset = COFF_V_CACHE;
    uint32_t input_offset = COFF_INPUT;
    uint32_t output_offset = COFF_OUTPUT;

    // Added 1024 padding
    uint64_t dmabuf_size = COFF_TOTAL + 1024;

    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset | w1_offset |
                  w2_offset | k_cache_offset | v_cache_offset | input_offset |
                  output_offset) &
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
        return (memory.dmabuf_size <= hardware.dmabuf_size) &&
               model.validate() && memory.isAligned();
    }
    bool loadFromFile(const std::string &) { return true; }
};

#endif
