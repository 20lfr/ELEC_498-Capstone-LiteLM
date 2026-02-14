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
    static void burst_read(const int32_t* src,
                           int32_t local_buf[WT_MAX_BURST_LEN],
                           int offset, int len)
    {
        #pragma HLS INLINE
        const int n = (len > WT_MAX_BURST_LEN) ? WT_MAX_BURST_LEN : len;
        for (int i = 0; i < n; i++) {
            #pragma HLS PIPELINE II=1
            local_buf[i] = src[offset + i];
        }
    }

    // Burst-write len int32 words from local_buf into dst[offset]
    static void burst_write(int32_t* dst,
                            const int32_t local_buf[WT_MAX_BURST_LEN],
                            int offset, int len)
    {
        #pragma HLS INLINE
        const int n = (len > WT_MAX_BURST_LEN) ? WT_MAX_BURST_LEN : len;
        for (int i = 0; i < n; i++) {
            #pragma HLS PIPELINE II=1
            dst[offset + i] = local_buf[i];
        }
    }
};
