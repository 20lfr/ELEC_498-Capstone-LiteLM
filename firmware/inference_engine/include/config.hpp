// config.hpp - Configured for Phi-3-mini-4k-instruct
#ifndef CONFIG_HPP
#define CONFIG_HPP

#include <string>
#include <cstdint>

struct HardwareConfig {
    uint64_t stream_reg_base_addr = 0xa0000000;
    std::string dmabuf0_name = "udmabuf0";
    size_t dmabuf0_max_size = 0x7a000000; // 2GB
    std::string dmabuf1_name = "udmabuf1";
    size_t dmabuf1_max_size = 0x20000000; // 512MB
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
};

struct ModelConfig {
    std::string weights_file = "phi3_weights_int4.bin";
    std::string quant_params_file = "quantization.bin";
    std::string tokenizer_vocab = "tokenizer.model";
    
    // Phi-3-mini-4k-instruct architecture
    static constexpr uint32_t d_model = 3072;
    // saw 12288 before is that old??
    static constexpr uint32_t d_ffn = 8192;
    static constexpr uint32_t num_layers = 32;
    static constexpr uint32_t num_heads = 32;
    static constexpr uint32_t head_dim = 96;
    // skrinked from 4096
    static constexpr uint32_t context_len = 2048;
    uint32_t vocab_size = 32064;
    
    // Tiling
    uint32_t num_wo_tiles = 32;
    uint32_t num_w1_tiles = 128;
    uint32_t num_w2_tiles = 32;
    
    // Strides
    uint32_t layer_stride = 0x380000;
    uint32_t wq_head_stride = 0x12000;
    uint32_t wk_head_stride = 0x12000;
    uint32_t wv_head_stride = 0x12000;
    uint32_t k_cache_stride = 0x60;
    uint32_t v_cache_stride = 0x60;
    uint32_t wo_tile_stride = 0x6000;
    uint32_t w1_tile_stride = 0x18000;
    uint32_t w2_tile_stride = 0x6000;
    
    // 1/sqrt(96) in Q1.15 ≈ 3342
    uint32_t logit_scale_qv = 3342;
    
    // Quantization defaults
    float scale_q = 0.005f;
    int32_t zero_point_q = 0;
    float scale_k = 0.005f;
    int32_t zero_point_k = 0;
    float scale_v = 0.005f;
    int32_t zero_point_v = 0;
    
    bool validate() const {
        return layer_stride && wq_head_stride && wk_head_stride && wv_head_stride &&
               k_cache_stride && v_cache_stride &&
               wo_tile_stride && w1_tile_stride && w2_tile_stride;
    }
};

struct MemoryLayout {
    constexpr uint32_t align64(uint32_t val) {
        return (val + 63) & ~63;
    }
    // relative to dmabuf0
    const uint32_t wq_offset       = 0x0;
    const uint32_t wk_offset       = align64(wq_offset + 0.5*ModelConfig::num_layers * ModelConfig::d_model * ModelConfig::d_model);
    const uint32_t wv_offset       = align64(wk_offset + 0.5*ModelConfig::num_layers * ModelConfig::d_model * ModelConfig::d_model);
    const uint32_t wo_offset       = align64(wv_offset + 0.5*ModelConfig::num_layers * ModelConfig::d_model * ModelConfig::d_model);
    const uint32_t w1_offset       = align64(wo_offset + 0.5*ModelConfig::num_layers * ModelConfig::d_model * ModelConfig::d_model);
    const uint32_t w2_offset       = align64(w1_offset + ModelConfig::num_layers * ModelConfig::d_ffn * ModelConfig::d_model);

    const uint64_t dmabuf0_real_size = align64(w2_offset + 0.5*ModelConfig::num_layers * ModelConfig::d_ffn * ModelConfig::d_model + 1024);

    // relative to dmabuf1
    const uint32_t k_cache_offset  = 0x0;
    const uint32_t v_cache_offset  = align64(k_cache_offset + ModelConfig::context_len * ModelConfig::num_layers
                                                            * ModelConfig::num_heads * ModelConfig::head_dim);
    const uint32_t input_offset    = align64(v_cache_offset + ModelConfig::context_len * ModelConfig::num_layers 
                                                            * ModelConfig::num_heads * ModelConfig::head_dim);
    const uint32_t output_offset   = align64(input_offset + ModelConfig::d_model);

    const uint64_t dmabuf1_real_size = align64(output_offset + ModelConfig::d_model + 1024);
    
    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset |
                  w1_offset | w2_offset | k_cache_offset |
                  v_cache_offset | input_offset | output_offset) & 0x3F);
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
    
    bool validate() const { return model.validate() && memory.isAligned(); }
    bool loadFromFile(const std::string&) { return true; }
};

#endif
