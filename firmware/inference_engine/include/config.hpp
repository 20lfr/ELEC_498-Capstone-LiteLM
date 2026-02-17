// config.hpp - Configured for Phi-3-mini-4k-instruct
#ifndef CONFIG_HPP
#define CONFIG_HPP

#include "shared_params.hpp"
#include <cstdint>
#include <string>

struct HardwareConfig {
    uint64_t stream_reg_base_addr = 0xa0000000;
    std::string dmabuf0_name = "udmabuf0";
    size_t dmabuf0_size = 0x7a000000; // 2GB
    std::string dmabuf1_name = "udmabuf1";
    size_t dmabuf1_size = 0x20000000; // 512MB
    uint32_t timeout_ms = 30000;
    bool mock_mode = false;
};

struct ModelConfig {
    std::string weights_file = "phi3_weights_int4.bin";
    std::string quant_params_file = "quantization.bin";
    std::string tokenizer_vocab = "tokenizer.model";

    uint32_t vocab_size = Phi3Mini4K::vocab_size;
    uint32_t logit_scale_qv = Phi3Mini4K::logit_scale_qv;

    struct Strides {
        uint32_t layer = Phi3Mini4K::strides::wq_layer;
        uint32_t wq_head = Phi3Mini4K::strides::qkv_head;
        uint32_t wk_head = Phi3Mini4K::strides::qkv_head;
        uint32_t wv_head = Phi3Mini4K::strides::qkv_head;
        uint32_t k_cache = Phi3Mini4K::strides::kv_head;
        uint32_t v_cache = Phi3Mini4K::strides::kv_head;
        uint32_t wo_tile = Phi3Mini4K::strides::wo_tile;
        uint32_t w1_tile = Phi3Mini4K::strides::w1_tile;
        uint32_t w2_tile = Phi3Mini4K::strides::w2_tile;
    } strides;

    // Quantization defaults
    float scale_q = 0.005f;
    int32_t zero_point_q = 0;
    float scale_k = 0.005f;
    int32_t zero_point_k = 0;
    float scale_v = 0.005f;
    int32_t zero_point_v = 0;

    bool validate() const {
        return strides.layer && strides.wq_head && strides.wk_head &&
               strides.wv_head && strides.k_cache && strides.v_cache &&
               strides.wo_tile && strides.w1_tile && strides.w2_tile;
    }
};

struct MemoryLayout {

    // relative to dmabuf0
    uint32_t wq_offset = Phi3Mini4K::weight_offsets::wq;
    uint32_t wk_offset = Phi3Mini4K::weight_offsets::wk;
    uint32_t wv_offset = Phi3Mini4K::weight_offsets::wv;
    uint32_t wo_offset = Phi3Mini4K::weight_offsets::wo;
    uint32_t w1_offset = Phi3Mini4K::weight_offsets::w1_gate;
    uint32_t w2_offset = Phi3Mini4K::weight_offsets::w2;

    // Added your 1024 padding here
    uint64_t dmabuf0_size = Phi3Mini4K::weight_offsets::total + 1024;

    // relative to dmabuf1
    uint32_t k_cache_offset = Phi3Mini4K::cache_offsets::k_cache;
    uint32_t v_cache_offset = Phi3Mini4K::cache_offsets::v_cache;
    uint32_t input_offset = Phi3Mini4K::cache_offsets::input;
    uint32_t output_offset = Phi3Mini4K::cache_offsets::output;

    // Added your 1024 padding here
    uint64_t dmabuf1_size = Phi3Mini4K::cache_offsets::total + 1024;

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
        return (memory.dmabuf1_size < hardware.dmabuf1_size) &&
               (memory.dmabuf0_size < hardware.dmabuf0_size) &&
               model.validate() && memory.isAligned();
    }
    bool loadFromFile(const std::string &) { return true; }
};

#endif
