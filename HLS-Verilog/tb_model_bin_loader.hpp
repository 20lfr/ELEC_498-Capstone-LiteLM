#pragma once

#include <cstdio>
#include <cstdint>
#include <fstream>
#include <string>
#include <vector>

#include "top_params.hpp"

namespace tb_model_bin_loader {

constexpr const char *DEFAULT_MODEL_BIN_PATH =
    "/home/luka/Scripting/model/phi3_weights_int4.bin";

inline std::string default_model_bin_path(const std::string &tb_source_dir) {
    (void)tb_source_dir;
    return DEFAULT_MODEL_BIN_PATH;
}

constexpr size_t packed_i4_bytes(int elems) {
    return static_cast<size_t>((elems + 1) / 2);
}

inline void zero_axi_words(axi_gmem_word_t *mem, uint64_t word_count) {
    for (uint64_t i = 0; i < word_count; ++i) {
        mem[i] = 0;
    }
}

inline bool write_axi_bytes(axi_gmem_word_t *mem,
                            uint64_t word_count,
                            uint64_t dst_byte_off,
                            const uint8_t *src,
                            size_t len,
                            const char *label) {
    const uint64_t total_bytes =
        word_count * static_cast<uint64_t>(AXI_GMEM_WORD_BYTES);
    if ((dst_byte_off + static_cast<uint64_t>(len)) > total_bytes) {
        std::fprintf(stderr,
                     "ERROR: %s write overruns compact DDR image "
                     "(dst=0x%llX len=%zu total=0x%llX)\n",
                     label,
                     static_cast<unsigned long long>(dst_byte_off),
                     len,
                     static_cast<unsigned long long>(total_bytes));
        return false;
    }

    for (size_t i = 0; i < len; ++i) {
        const uint64_t byte_addr = dst_byte_off + static_cast<uint64_t>(i);
        const uint64_t word_idx = byte_addr / AXI_GMEM_WORD_BYTES;
        const uint64_t byte_idx = byte_addr % AXI_GMEM_WORD_BYTES;
        axi_gmem_word_t word = mem[word_idx];
        word.range(((byte_idx + 1) * 8) - 1, byte_idx * 8) =
            static_cast<ap_uint<8> >(src[i]);
        mem[word_idx] = word;
    }

    return true;
}

inline bool read_exact_at(std::ifstream &in,
                          uint64_t src_off,
                          uint8_t *dst,
                          size_t len,
                          const char *label) {
    in.clear();
    in.seekg(static_cast<std::streamoff>(src_off), std::ios::beg);
    if (!in) {
        std::fprintf(stderr,
                     "ERROR: Failed to seek %s at 0x%llX\n",
                     label,
                     static_cast<unsigned long long>(src_off));
        return false;
    }

    in.read(reinterpret_cast<char *>(dst), static_cast<std::streamsize>(len));
    if (static_cast<size_t>(in.gcount()) != len) {
        std::fprintf(stderr,
                     "ERROR: Failed to read %s at 0x%llX (wanted=%zu got=%lld)\n",
                     label,
                     static_cast<unsigned long long>(src_off),
                     len,
                     static_cast<long long>(in.gcount()));
        return false;
    }

    return true;
}

inline bool copy_i4_rows(std::ifstream &in,
                         axi_gmem_word_t *ddr_mem,
                         uint64_t word_count,
                         const char *label,
                         uint64_t src_off,
                         uint64_t src_row_stride,
                         int rows,
                         size_t row_copy_bytes,
                         uint64_t dst_off) {
    std::vector<uint8_t> row_buf(row_copy_bytes, 0);
    for (int r = 0; r < rows; ++r) {
        const uint64_t row_src_off =
            src_off + static_cast<uint64_t>(r) * src_row_stride;
        if (!read_exact_at(in, row_src_off, row_buf.data(), row_copy_bytes,
                           label)) {
            return false;
        }
        const uint64_t row_dst_off =
            dst_off + static_cast<uint64_t>(r) * row_copy_bytes;
        if (!write_axi_bytes(ddr_mem, word_count, row_dst_off, row_buf.data(),
                             row_copy_bytes, label)) {
            return false;
        }
    }
    return true;
}

inline bool copy_bytes_block(std::ifstream &in,
                             axi_gmem_word_t *ddr_mem,
                             uint64_t word_count,
                             const char *label,
                             uint64_t src_off,
                             uint64_t dst_off,
                             size_t len) {
    std::vector<uint8_t> buf(len, 0);
    if (!read_exact_at(in, src_off, buf.data(), len, label)) {
        return false;
    }
    return write_axi_bytes(ddr_mem, word_count, dst_off, buf.data(), len,
                           label);
}

inline bool load_compact_weights_image(const std::string &image_path,
                                       axi_gmem_word_t *ddr_mem,
                                       uint64_t word_count) {
    static_assert(NUM_LAYERS <= MODEL_LAYERS,
                  "Compact layer count cannot exceed source model");
    static_assert(NUM_HEADS <= MODEL_HEADS,
                  "Compact head count cannot exceed source model");
    static_assert(D_MODEL <= MODEL_HIDDEN_SIZE,
                  "Compact hidden size cannot exceed source model");
    static_assert(D_HEADS <= MODEL_HEAD_DIMENSTION,
                  "Compact head dimension cannot exceed source model");
    static_assert(D_FFN <= MODEL_INTERMEDIATE_SIZE,
                  "Compact FFN size cannot exceed source model");
    static_assert(D_VOCAB <= MODEL_VOCAB_SIZE,
                  "Compact vocab size cannot exceed source model");

    zero_axi_words(ddr_mem, word_count);

    const uint64_t compact_bytes =
        word_count * static_cast<uint64_t>(AXI_GMEM_WORD_BYTES);
    if (compact_bytes < static_cast<uint64_t>(WEIGHTS_SIZE)) {
        std::fprintf(stderr,
                     "ERROR: Compact DDR image is too small "
                     "(have=%llu need=%u)\n",
                     static_cast<unsigned long long>(compact_bytes),
                     static_cast<unsigned>(WEIGHTS_SIZE));
        return false;
    }

    std::ifstream in(image_path.c_str(), std::ios::binary);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to open shared weights image '%s'\n",
                     image_path.c_str());
        return false;
    }

    const size_t compact_hidden_bytes = packed_i4_bytes(D_MODEL);
    const size_t compact_ffn_bytes = packed_i4_bytes(D_FFN);

    // Q / K / V: first NUM_LAYERS layers, first NUM_HEADS heads,
    // first D_HEADS rows per head, first D_MODEL input columns.
    for (int layer = 0; layer < NUM_LAYERS; ++layer) {
        for (int head = 0; head < NUM_HEADS; ++head) {
            const uint64_t src_row0 =
                static_cast<uint64_t>(layer) * STRIDE_WQ_LAYER +
                static_cast<uint64_t>(head * MODEL_HEAD_DIMENSTION) *
                    (static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull);

            if (!copy_i4_rows(
                    in, ddr_mem, word_count, "WQ", WQ_OFF + src_row0,
                    static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull,
                    D_HEADS, compact_hidden_bytes,
                    static_cast<uint64_t>(WQ_OFF) +
                        static_cast<uint64_t>(layer) * STRIDE_WQ_LAYER +
                        static_cast<uint64_t>(head) * STRIDE_QKV_HEAD)) {
                return false;
            }
            if (!copy_i4_rows(
                    in, ddr_mem, word_count, "WK", WK_OFF + src_row0,
                    static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull,
                    D_HEADS, compact_hidden_bytes,
                    static_cast<uint64_t>(WK_OFF) +
                        static_cast<uint64_t>(layer) * STRIDE_WK_LAYER +
                        static_cast<uint64_t>(head) * STRIDE_QKV_HEAD)) {
                return false;
            }
            if (!copy_i4_rows(
                    in, ddr_mem, word_count, "WV", WV_OFF + src_row0,
                    static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull,
                    D_HEADS, compact_hidden_bytes,
                    static_cast<uint64_t>(WV_OFF) +
                        static_cast<uint64_t>(layer) * STRIDE_WV_LAYER +
                        static_cast<uint64_t>(head) * STRIDE_QKV_HEAD)) {
                return false;
            }
        }
    }

    for (int layer = 0; layer < NUM_LAYERS; ++layer) {
        for (int tile = 0; tile < NUM_WO_TILES; ++tile) {
            const uint64_t src_off =
                WO_OFF +
                static_cast<uint64_t>(layer) * STRIDE_WO_LAYER +
                static_cast<uint64_t>(tile * D_TILE_WO) *
                    (static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull);
            const uint64_t dst_off =
                static_cast<uint64_t>(WO_OFF) +
                static_cast<uint64_t>(layer) * STRIDE_WO_LAYER +
                static_cast<uint64_t>(tile) * STRIDE_WO_TILE;
            if (!copy_i4_rows(in, ddr_mem, word_count, "WO", src_off,
                              static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull,
                              D_TILE_WO,
                              compact_hidden_bytes, dst_off)) {
                return false;
            }
        }
    }

    for (int layer = 0; layer < NUM_LAYERS; ++layer) {
        for (int tile = 0; tile < (NUM_W1_TILES / 2); ++tile) {
            const uint64_t gate_src_off =
                W1_OFF +
                static_cast<uint64_t>(layer) * STRIDE_W1_GATE_LAYER +
                static_cast<uint64_t>(tile * D_TILE_W1) *
                    (static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull);
            const uint64_t gate_dst_off =
                static_cast<uint64_t>(W1_OFF) +
                static_cast<uint64_t>(layer) * STRIDE_W1_GATE_LAYER +
                static_cast<uint64_t>(tile) * STRIDE_W1_TILE;
            if (!copy_i4_rows(in, ddr_mem, word_count, "W1_GATE", gate_src_off,
                              static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull,
                              D_TILE_W1,
                              compact_hidden_bytes, gate_dst_off)) {
                return false;
            }

            const uint64_t up_src_off =
                W1_UP_OFF +
                static_cast<uint64_t>(layer) * STRIDE_W1_UP_LAYER +
                static_cast<uint64_t>(tile * D_TILE_W1) *
                    (static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull);
            const uint64_t up_dst_off =
                static_cast<uint64_t>(W1_UP_OFF) +
                static_cast<uint64_t>(layer) * STRIDE_W1_UP_LAYER +
                static_cast<uint64_t>(tile) * STRIDE_W1_TILE;
            if (!copy_i4_rows(in, ddr_mem, word_count, "W1_UP", up_src_off,
                              static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull,
                              D_TILE_W1,
                              compact_hidden_bytes, up_dst_off)) {
                return false;
            }
        }
    }

    for (int layer = 0; layer < NUM_LAYERS; ++layer) {
        for (int tile = 0; tile < NUM_W2_TILES; ++tile) {
            const uint64_t src_off =
                W2_OFF +
                static_cast<uint64_t>(layer) * STRIDE_W2_LAYER +
                static_cast<uint64_t>(tile * D_TILE_W2) *
                    (static_cast<uint64_t>(MODEL_INTERMEDIATE_SIZE) / 2ull);
            const uint64_t dst_off =
                static_cast<uint64_t>(W2_OFF) +
                static_cast<uint64_t>(layer) * STRIDE_W2_LAYER +
                static_cast<uint64_t>(tile) * STRIDE_W2_TILE;
            if (!copy_i4_rows(in, ddr_mem, word_count, "W2", src_off,
                              static_cast<uint64_t>(MODEL_INTERMEDIATE_SIZE) / 2ull,
                              D_TILE_W2,
                              compact_ffn_bytes, dst_off)) {
                return false;
            }
        }
    }

    for (int layer = 0; layer < NUM_LAYERS; ++layer) {
        if (!copy_bytes_block(
                in, ddr_mem, word_count, "WO_BIAS",
                WO_BIAS_OFF +
                    static_cast<uint64_t>(layer) * STRIDE_WO_BIAS_LAYER,
                static_cast<uint64_t>(WO_BIAS_OFF) +
                    static_cast<uint64_t>(layer) * STRIDE_WO_BIAS_LAYER,
                static_cast<size_t>(STRIDE_WO_BIAS_LAYER))) {
            return false;
        }
        if (!copy_bytes_block(
                in, ddr_mem, word_count, "W1_BIAS",
                W1_BIAS_OFF +
                    static_cast<uint64_t>(layer) * STRIDE_W1_BIAS_LAYER,
                static_cast<uint64_t>(W1_BIAS_OFF) +
                    static_cast<uint64_t>(layer) * STRIDE_W1_BIAS_LAYER,
                static_cast<size_t>(STRIDE_W1_BIAS_LAYER))) {
            return false;
        }
        if (!copy_bytes_block(
                in, ddr_mem, word_count, "W2_BIAS",
                W2_BIAS_OFF +
                    static_cast<uint64_t>(layer) * STRIDE_W2_BIAS_LAYER,
                static_cast<uint64_t>(W2_BIAS_OFF) +
                    static_cast<uint64_t>(layer) * STRIDE_W2_BIAS_LAYER,
                static_cast<size_t>(STRIDE_W2_BIAS_LAYER))) {
            return false;
        }
        if (!copy_bytes_block(
                in, ddr_mem, word_count, "LN0_GAMMA",
                LN0_GAMMA_OFF +
                    static_cast<uint64_t>(layer) * STRIDE_LN0_GAMMA,
                static_cast<uint64_t>(LN0_GAMMA_OFF) +
                    static_cast<uint64_t>(layer) * STRIDE_LN0_GAMMA,
                static_cast<size_t>(STRIDE_LN0_GAMMA))) {
            return false;
        }
        if (!copy_bytes_block(
                in, ddr_mem, word_count, "LN1_GAMMA",
                LN1_GAMMA_OFF +
                    static_cast<uint64_t>(layer) * STRIDE_LN1_GAMMA,
                static_cast<uint64_t>(LN1_GAMMA_OFF) +
                    static_cast<uint64_t>(layer) * STRIDE_LN1_GAMMA,
                static_cast<size_t>(STRIDE_LN1_GAMMA))) {
            return false;
        }
        if (!copy_bytes_block(
                in, ddr_mem, word_count, "LN0_EPS",
                LN0_EPS_OFF +
                    static_cast<uint64_t>(layer) * STRIDE_LN0_EPS,
                static_cast<uint64_t>(LN0_EPS_OFF) +
                    static_cast<uint64_t>(layer) * STRIDE_LN0_EPS,
                static_cast<size_t>(STRIDE_LN0_EPS))) {
            return false;
        }
        if (!copy_bytes_block(
                in, ddr_mem, word_count, "LN1_EPS",
                LN1_EPS_OFF +
                    static_cast<uint64_t>(layer) * STRIDE_LN1_EPS,
                static_cast<uint64_t>(LN1_EPS_OFF) +
                    static_cast<uint64_t>(layer) * STRIDE_LN1_EPS,
                static_cast<size_t>(STRIDE_LN1_EPS))) {
            return false;
        }
    }

    if (!copy_bytes_block(in, ddr_mem, word_count, "FINAL_NORM_GAMMA",
                          FINAL_NORM_GAMMA_OFF,
                          static_cast<uint64_t>(FINAL_NORM_GAMMA_OFF),
                          static_cast<size_t>(STRIDE_FINAL_NORM_GAMMA))) {
        return false;
    }
    if (!copy_bytes_block(in, ddr_mem, word_count, "FINAL_NORM_EPS",
                          FINAL_NORM_EPS_OFF,
                          static_cast<uint64_t>(FINAL_NORM_EPS_OFF),
                          static_cast<size_t>(STRIDE_FINAL_NORM_EPS))) {
        return false;
    }

    for (int row = 0; row < D_VOCAB; ++row) {
        const uint64_t src_off =
            WLOGIT_OFF +
            static_cast<uint64_t>(row) *
                (static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull);
        const uint64_t dst_off =
            static_cast<uint64_t>(WLOGIT_OFF) +
            static_cast<uint64_t>(row) * compact_hidden_bytes;
        if (!copy_i4_rows(in, ddr_mem, word_count, "WLOGIT", src_off,
                          static_cast<uint64_t>(MODEL_HIDDEN_SIZE) / 2ull, 1,
                          compact_hidden_bytes,
                          dst_off)) {
            return false;
        }
    }

    return true;
}

} // namespace tb_model_bin_loader
