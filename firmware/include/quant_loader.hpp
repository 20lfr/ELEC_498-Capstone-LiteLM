// quant_loader.hpp - Load quantization.bin for Phi-3
#ifndef QUANT_LOADER_HPP
#define QUANT_LOADER_HPP

#include <cstdint>
#include <string>
#include <vector>
#include <fstream>
#include <cstring>

// Binary file header (from step5_directml.py)
struct QuantHeader {
    uint32_t magic;       // "QUAT" = 0x51554154
    uint32_t version;
    uint32_t num_layers;
    uint32_t num_heads;
};

// Scale + zero_point pair
struct QuantParam {
    float scale;
    int32_t zero_point;
};

// Per-head attention params
struct HeadQuantParams {
    QuantParam wq, wk, wv;           // Weight projections
    QuantParam q, k, v;              // Activations
    QuantParam scores, probs, ctx;   // Attention computation
    QuantParam wo, wo_out;           // Output projection
    float inv_sqrt_dk;
};

// Per-layer params
struct LayerQuantParams {
    QuantParam input;
    QuantParam ln1_gamma, ln1_beta, ln1_out;
    float ln1_eps;
    std::vector<HeadQuantParams> heads;
    QuantParam post_attn;
    QuantParam ln2_gamma, ln2_beta, ln2_out;
    float ln2_eps;
    QuantParam ffn_w1, ffn_b1, ffn_act1;
    QuantParam ffn_gelu;
    QuantParam ffn_w2, ffn_b2, ffn_act2;
    QuantParam residual, output;
};

class QuantLoader {
    QuantHeader header;
    QuantParam embedding[3];
    std::vector<LayerQuantParams> layers;
    QuantParam final_ln[4];
    float final_ln_eps;
    QuantParam logit_weight, logit_out;
    QuantParam kv_cache[2];
    bool loaded = false;

public:
    bool load(const std::string& path) {
        std::ifstream f(path, std::ios::binary);
        if (!f) return false;

        f.read(reinterpret_cast<char*>(&header), sizeof(header));
        if (header.magic != 0x51554154) return false;  // "QUAT"

        // Embedding params
        for (int i = 0; i < 3; i++)
            f.read(reinterpret_cast<char*>(&embedding[i]), sizeof(QuantParam));

        // Per-layer params
        layers.resize(header.num_layers);
        for (uint32_t l = 0; l < header.num_layers; l++) {
            auto& layer = layers[l];
            
            f.read(reinterpret_cast<char*>(&layer.input), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln1_gamma), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln1_beta), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln1_out), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln1_eps), sizeof(float));

            layer.heads.resize(header.num_heads);
            for (uint32_t h = 0; h < header.num_heads; h++) {
                auto& head = layer.heads[h];
                f.read(reinterpret_cast<char*>(&head.wq), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.wk), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.wv), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.q), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.k), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.v), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.scores), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.probs), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.ctx), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.wo), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.wo_out), sizeof(QuantParam));
                f.read(reinterpret_cast<char*>(&head.inv_sqrt_dk), sizeof(float));
            }

            f.read(reinterpret_cast<char*>(&layer.post_attn), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln2_gamma), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln2_beta), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln2_out), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ln2_eps), sizeof(float));
            f.read(reinterpret_cast<char*>(&layer.ffn_w1), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ffn_b1), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ffn_act1), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ffn_gelu), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ffn_w2), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ffn_b2), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.ffn_act2), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.residual), sizeof(QuantParam));
            f.read(reinterpret_cast<char*>(&layer.output), sizeof(QuantParam));
        }

        // Output head
        for (int i = 0; i < 4; i++)
            f.read(reinterpret_cast<char*>(&final_ln[i]), sizeof(QuantParam));
        f.read(reinterpret_cast<char*>(&final_ln_eps), sizeof(float));
        f.read(reinterpret_cast<char*>(&logit_weight), sizeof(QuantParam));
        f.read(reinterpret_cast<char*>(&logit_out), sizeof(QuantParam));

        // KV cache
        f.read(reinterpret_cast<char*>(&kv_cache[0]), sizeof(QuantParam));
        f.read(reinterpret_cast<char*>(&kv_cache[1]), sizeof(QuantParam));

        loaded = true;
        return true;
    }

    uint32_t getNumLayers() const { return header.num_layers; }
    uint32_t getNumHeads() const { return header.num_heads; }
    
    float getLayerQScale(uint32_t layer) const {
        if (layer < layers.size() && !layers[layer].heads.empty())
            return layers[layer].heads[0].wq.scale;
        return 0.005f;
    }
    
    float getLayerKScale(uint32_t layer) const {
        if (layer < layers.size() && !layers[layer].heads.empty())
            return layers[layer].heads[0].wk.scale;
        return 0.005f;
    }
    
    float getLayerVScale(uint32_t layer) const {
        if (layer < layers.size() && !layers[layer].heads.empty())
            return layers[layer].heads[0].wv.scale;
        return 0.005f;
    }
    
    float getInvSqrtDk() const {
        if (!layers.empty() && !layers[0].heads.empty())
            return layers[0].heads[0].inv_sqrt_dk;
        return 0.102f;  // 1/sqrt(96)
    }
    
    bool isLoaded() const { return loaded; }
};

#endif
