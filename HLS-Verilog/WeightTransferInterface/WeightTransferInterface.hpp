#pragma once
#include "../top_params.hpp"
#include <cstdint>

// AXI4 Full (m_axi) burst read/write helpers.
// m_axi INTERFACE pragmas live in the top function, not here.

constexpr int WT_MAX_BURST_LEN = 256;

class WeightTransferInterface {
public:
    WeightTransferInterface() = default;

    // Burst-read len int32 words from src[offset] into local_buf
    static void burst_read(const int32_t *src, int32_t *local_buf, int offset,
                           int len) {
#pragma HLS INLINE

        int remaining = len;
        int current_offset = 0;

        while (remaining > 0) {
#pragma HLS LOOP_TRIPCOUNT min = 1 max = 800
            int burst_len =
                (remaining > WT_MAX_BURST_LEN) ? WT_MAX_BURST_LEN : remaining;

        read_loop:
            for (int i = 0; i < burst_len; i++) {
// #pragma HLS PIPELINE II = 1
                local_buf[current_offset + i] =
                    src[offset + current_offset + i];
            }

            remaining -= burst_len;
            current_offset += burst_len;
        }
    }

    // Burst-write len int32 words from local_buf into dst[offset]
    static void burst_write(int32_t *dst, const int32_t *local_buf, int offset,
                            int len) {
#pragma HLS INLINE

        int remaining = len;
        int current_offset = 0;

        while (remaining > 0) {
#pragma HLS LOOP_TRIPCOUNT min = 1 max = 800
            int burst_len =
                (remaining > WT_MAX_BURST_LEN) ? WT_MAX_BURST_LEN : remaining;

        write_loop:
            for (int i = 0; i < burst_len; i++) {
// #pragma HLS PIPELINE II = 1
                dst[offset + current_offset + i] =
                    local_buf[current_offset + i];
            }

            remaining -= burst_len;
            current_offset += burst_len;
        }
    }
};
