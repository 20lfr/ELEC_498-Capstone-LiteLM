// config.hpp - Configured for Phi-3-mini-4k-instruct
#ifndef CONFIG_HPP
#define CONFIG_HPP

#include <string>
#include <cstdint>

struct HardwareConfig {
    uint64_t dma_reg_base_addr = 0x80000000;
    std::string dmabuf_device = "udmabuf0";
    size_t dma_buffer_size = 0x100000; // 1MB
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
    uint64_t ddr_reg_base_addr = 0x40000000;
    size_t ddr_size = 0x80000000;  // 2GB for Phi-3
};

struct MemoryLayout {
    uint64_t wq_offset       = 0x00000000;
    uint64_t wk_offset       = 0x10000000;
    uint64_t wv_offset       = 0x20000000;
    uint64_t wo_offset       = 0x30000000;
    uint64_t w1_offset       = 0x40000000;
    uint64_t w2_offset       = 0x50000000;
    uint64_t k_cache_offset  = 0x60000000;
    uint64_t v_cache_offset  = 0x68000000;
    uint64_t input_offset    = 0x70000000;
    uint64_t output_offset   = 0x70100000;
    uint64_t quant_params    = 0x70200000;
    
    bool isAligned() const {
        return !((wq_offset | wk_offset | wv_offset | wo_offset |
                  w1_offset | w2_offset | k_cache_offset | v_cache_offset) & 0x3F);
    }
};

struct ModelConfig {
    std::string weights_file = "phi3_weights_int4.bin";
    std::string quant_params_file = "quantization.bin";
    std::string tokenizer_vocab = "tokenizer.model";
    
    // Phi-3-mini-4k-instruct architecture
    uint32_t d_model = 3072;
    uint32_t d_ffn = 12288;
    uint32_t num_layers = 32;
    uint32_t num_heads = 32;
    uint32_t head_dim = 96;
    uint32_t context_len = 4096;
    uint32_t vocab_size = 32064;
    
    // Tiling
    uint32_t num_wo_tiles = 32;
    uint32_t num_w1_tiles = 128;
    uint32_t num_w2_tiles = 32;
    
    // DMA lengths
    uint32_t dma_layer_len = 0x380000;
    uint32_t dma_head_len = 0x12000;
    uint32_t dma_tile_len = 0x6000;
    
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
        return dma_layer_len && dma_head_len && dma_tile_len &&
               layer_stride && wq_head_stride && wk_head_stride && wv_head_stride &&
               k_cache_stride && v_cache_stride &&
               wo_tile_stride && w1_tile_stride && w2_tile_stride;
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
