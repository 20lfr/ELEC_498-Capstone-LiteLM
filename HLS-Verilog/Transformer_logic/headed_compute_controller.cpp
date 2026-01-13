#include "headed_compute_controller.hpp"

void MAC_QKV(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_HEADS],
    int32_t accum_out[D_HEADS]
) {
#pragma HLS INLINE off
    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS UNROLL
        int32_t acc = 0;
        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
            const int4_t w = valueB[h * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        accum_out[h] = acc;
    }
}
