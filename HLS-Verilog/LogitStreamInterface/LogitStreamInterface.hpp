#pragma once
#include "../top_params.hpp"
#include <ap_axi_sdata.h>
#include <ap_int.h>
#include <hls_stream.h>

/**
 * LogitStreamInterface - Bidirectional AXI4-Stream for Token/Logit Transfer
 *
 */

constexpr uint32_t NUM_BITS_PER_STREAM = 512;
constexpr uint32_t NUM_BYTES_PER_STREAM = NUM_BITS_PER_STREAM / 8;

// AXI-Stream packet with TLAST only (simple interface)
typedef hls::axis_data<ap_int<NUM_BITS_PER_STREAM>, AXIS_ENABLE_LAST>
    axis_pkt_t;
typedef hls::stream<axis_pkt_t> axis_stream_t;

class LogitStreamInterface {
private:
    // confirm D_MODEL is a multiple of 2
    static constexpr uint32_t NUM_WORDS_PER_STREAM =
        Phi3Mini4K::d_model / NUM_BYTES_PER_STREAM;

public:
    LogitStreamInterface() = default;

    /**
     * Receive a full token (D_MODEL int8 values) from PS via AXI-Stream
     * Returns true if TLAST was seen on final word
     */
    bool receive_token(axis_stream_t &input_stream,
                       int8_t token_buf[Phi3Mini4K::d_model]) {
#pragma HLS INLINE

        bool saw_last = false;
        for (int w = 0; w < NUM_WORDS_PER_STREAM; w++) {
// #pragma HLS PIPELINE II = 1
            axis_pkt_t pkt = input_stream.read();
            ap_int<NUM_BITS_PER_STREAM> data = pkt.data;

            uint32_t base = w * NUM_BYTES_PER_STREAM;
            for (int b = 0; b < NUM_BYTES_PER_STREAM; b++) {
// #pragma HLS UNROLL
                token_buf[base + b] = data.range(b * 8 + 7, b * 8);
            }

            if (w == NUM_WORDS_PER_STREAM - 1) {
                saw_last = (pkt.last == 1);
            }
        }
        return saw_last;
    }

    /**
     * Send a full token/logit (D_MODEL int8 values) to PS via AXI-Stream
     */
    void send_logit(axis_stream_t &output_stream,
                    const int8_t logit_buf[Phi3Mini4K::d_model]) {
#pragma HLS INLINE

        for (int w = 0; w < NUM_WORDS_PER_STREAM; w++) {
// #pragma HLS PIPELINE II = 1

            uint32_t base = w * NUM_BYTES_PER_STREAM;
            ap_int<NUM_BITS_PER_STREAM> data;
            for (int b = 0; b < NUM_BYTES_PER_STREAM; b++) {
// #pragma HLS UNROLL
                data.range(b * 8 + 7, b * 8) = logit_buf[base + b];
            }

            axis_pkt_t pkt;
            pkt.data = data;
            pkt.last =
                (w == NUM_WORDS_PER_STREAM - 1) ? 1 : 0; // TLAST on final word
            output_stream.write(pkt);
        }
    }
};
