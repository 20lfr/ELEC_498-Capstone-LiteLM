#pragma once

#include "../../top_params.hpp"
#include <ap_int.h>
#include <cstdint>

namespace compute_buf {

constexpr int div_ceil(int a, int b) {
    return (a + b - 1) / b;
}

constexpr int max2(int a, int b) {
    return (a > b) ? a : b;
}

// -------------------------------
// Input buffer size calculations
// -------------------------------
constexpr int OUT_PROJ_ACT_BYTES = D_MODEL;
constexpr int OUT_PROJ_W_NIBBLES = D_MODEL * D_TILE_WO;
constexpr int OUT_PROJ_W_BYTES = div_ceil(OUT_PROJ_W_NIBBLES, 2);
constexpr int OUT_PROJ_B_NIBBLES = D_TILE_WO;
constexpr int OUT_PROJ_B_BYTES = div_ceil(OUT_PROJ_B_NIBBLES, 2);
constexpr int OUT_PROJ_IN_BYTES = OUT_PROJ_ACT_BYTES + OUT_PROJ_W_BYTES + OUT_PROJ_B_BYTES;

constexpr int REQUANT_IN_BYTES = (D_MODEL * 4) + 12;
constexpr int RESID_IN_BYTES = D_MODEL * 2;
constexpr int LN_IN_BYTES = D_MODEL + (D_MODEL * 4) + (D_MODEL * 4) + 4;

constexpr int FFN_W1_W_NIBBLES = D_MODEL * D_TILE_W1;
constexpr int FFN_W1_W_BYTES = div_ceil(FFN_W1_W_NIBBLES, 2);
constexpr int FFN_W1_B_NIBBLES = D_TILE_W1;
constexpr int FFN_W1_B_BYTES = div_ceil(FFN_W1_B_NIBBLES, 2);
constexpr int FFN_W1_IN_BYTES = D_MODEL + FFN_W1_W_BYTES + FFN_W1_B_BYTES + (D_TILE_W1 * 2);

constexpr int FFN_ACT_IN_BYTES = D_FFN * 2;

constexpr int FFN_W2_W_NIBBLES = D_FFN * D_TILE_W2;
constexpr int FFN_W2_W_BYTES = div_ceil(FFN_W2_W_NIBBLES, 2);
constexpr int FFN_W2_B_NIBBLES = D_TILE_W2;
constexpr int FFN_W2_B_BYTES = div_ceil(FFN_W2_B_NIBBLES, 2);
constexpr int FFN_W2_IN_BYTES = (D_FFN * 2) + FFN_W2_W_BYTES + FFN_W2_B_BYTES + (D_TILE_W2 * 2);

constexpr int IN_BUF_BYTES = max2(
    OUT_PROJ_IN_BYTES,
    max2(
        REQUANT_IN_BYTES,
        max2(
            RESID_IN_BYTES,
            max2(
                LN_IN_BYTES,
                max2(FFN_W1_IN_BYTES, 
                    max2(FFN_ACT_IN_BYTES, FFN_W2_IN_BYTES))))));

// -------------------------------
// Output buffer size calculations
// -------------------------------
constexpr int OUT_PROJ_OUT_BYTES = D_TILE_WO * 4;
constexpr int REQUANT_OUT_BYTES = D_MODEL;
constexpr int RESID_OUT_BYTES = D_MODEL;
constexpr int LN_OUT_BYTES = D_MODEL * 4;
constexpr int FFN_W1_OUT_BYTES = D_TILE_W1 * 2;
constexpr int FFN_ACT_OUT_BYTES = D_FFN * 2;
constexpr int FFN_W2_OUT_BYTES = D_TILE_W2 * 4;

constexpr int OUT_BUF_BYTES = max2(
    OUT_PROJ_OUT_BYTES,
    max2(
        REQUANT_OUT_BYTES,
        max2(
            RESID_OUT_BYTES,
            max2(
                LN_OUT_BYTES,
                max2(FFN_W1_OUT_BYTES, max2(FFN_ACT_OUT_BYTES, FFN_W2_OUT_BYTES))))));

// -------------------------------
// Per-op layouts (byte offsets)
// -------------------------------
struct OutProjLayout {
    static constexpr int ACT = 0;
    static constexpr int W = ACT + OUT_PROJ_ACT_BYTES;
    static constexpr int B = W + OUT_PROJ_W_BYTES;
};

struct RequantLayout {
    static constexpr int X = 0;
    static constexpr int M = X + (D_MODEL * 4);
    static constexpr int N = M + 4;
    static constexpr int Z = N + 4;
};

struct ResidLayout {
    static constexpr int X = 0;
    static constexpr int R = X + D_MODEL;
};

struct LayerNormLayout {
    static constexpr int X = 0;
    static constexpr int GAMMA = X + D_MODEL;
    static constexpr int BETA = GAMMA + (D_MODEL * 4);
    static constexpr int EPS = BETA + (D_MODEL * 4);
};

struct FfnW1Layout {
    static constexpr int X = 0;
    static constexpr int W = X + D_MODEL;
    static constexpr int B = W + FFN_W1_W_BYTES;
    static constexpr int S = B + FFN_W1_B_BYTES;
};

struct FfnActLayout {
    static constexpr int X = 0;
};

struct FfnW2Layout {
    static constexpr int X = 0;
    static constexpr int W = X + (D_FFN * 2);
    static constexpr int B = W + FFN_W2_W_BYTES;
    static constexpr int S = B + FFN_W2_B_BYTES;
};

// -------------------------------
// Byte helpers (little-endian)
// -------------------------------
inline int8_t read_i8(const uint8_t *buf, int byte_addr) {
    return static_cast<int8_t>(buf[byte_addr]);
}

inline ap_int<4> read_i4(const uint8_t *buf, int nibble_idx) {
    const int byte_addr = nibble_idx / 2;
    const uint8_t byte_val = buf[byte_addr];
    const ap_uint<4> nibble = (nibble_idx & 1) ? ap_uint<4>(byte_val >> 4)
                                               : ap_uint<4>(byte_val & 0xF);
    return ap_int<4>(nibble);
}

inline int16_t read_i16(const uint8_t *buf, int byte_addr) {
    const uint16_t lo = buf[byte_addr];
    const uint16_t hi = buf[byte_addr + 1];
    const uint16_t v = static_cast<uint16_t>((hi << 8) | lo);
    return static_cast<int16_t>(v);
}

inline int32_t read_i32(const uint8_t *buf, int byte_addr) {
    const uint32_t b0 = buf[byte_addr + 0];
    const uint32_t b1 = buf[byte_addr + 1];
    const uint32_t b2 = buf[byte_addr + 2];
    const uint32_t b3 = buf[byte_addr + 3];
    const uint32_t v = (b3 << 24) | (b2 << 16) | (b1 << 8) | b0;
    return static_cast<int32_t>(v);
}

inline void write_i8(uint8_t *buf, int byte_addr, int8_t value) {
    buf[byte_addr] = static_cast<uint8_t>(value);
}

inline void write_i4(uint8_t *buf, int nibble_idx, ap_int<4> value) {
    const int byte_addr = nibble_idx / 2;
    const ap_uint<4> nibble = ap_uint<4>(value);
    uint8_t byte_val = buf[byte_addr];
    if (nibble_idx & 1) {
        byte_val = static_cast<uint8_t>((byte_val & 0x0F)
                                         | (static_cast<uint8_t>(nibble) << 4));
    } else {
        byte_val = static_cast<uint8_t>((byte_val & 0xF0) | static_cast<uint8_t>(nibble));
    }
    buf[byte_addr] = byte_val;
}

inline void write_i16(uint8_t *buf, int byte_addr, int16_t value) {
    const uint16_t v = static_cast<uint16_t>(value);
    buf[byte_addr + 0] = static_cast<uint8_t>(v & 0xFFu);
    buf[byte_addr + 1] = static_cast<uint8_t>((v >> 8) & 0xFFu);
}

inline void write_i32(uint8_t *buf, int byte_addr, int32_t value) {
    const uint32_t v = static_cast<uint32_t>(value);
    buf[byte_addr + 0] = static_cast<uint8_t>(v & 0xFFu);
    buf[byte_addr + 1] = static_cast<uint8_t>((v >> 8) & 0xFFu);
    buf[byte_addr + 2] = static_cast<uint8_t>((v >> 16) & 0xFFu);
    buf[byte_addr + 3] = static_cast<uint8_t>((v >> 24) & 0xFFu);
}

} // namespace compute_buf
