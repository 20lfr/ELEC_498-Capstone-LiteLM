#pragma once

#include "../top_params.hpp"
#include <cstdint>

using int4_t = ap_int<4>;

// Simple MAC for Q/K/V projection: vector (int8) × weights (int4) → int32 accum per head.
void MAC_QKV(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_HEADS],
    int32_t accum_out[D_HEADS]
);
