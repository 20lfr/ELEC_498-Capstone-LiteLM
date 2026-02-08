#pragma once
#include "../top_params.hpp"
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <ap_int.h>

/**
 * LogitStreamInterface - Bidirectional AXI4-Stream for Token/Logit Transfer
 * 
 * Input Stream (PS → PL):  Token embedding data, D_MODEL uint8 values per token
 * Output Stream (PL → PS): Logit data, D_MODEL uint8 values per token
 * 
 * Uses 8-bit TDATA with TLAST for simple byte-by-byte transfers.
 */

// 8-bit AXI-Stream packet with TLAST only (simple interface)
typedef hls::axis_data<ap_int<8>, AXIS_ENABLE_LAST> axis_pkt_t;
typedef hls::stream<axis_pkt_t> axis_stream_t;

class LogitStreamInterface {
public:
    LogitStreamInterface() = default;

    /**
     * Receive a full token (D_MODEL uint8 values) from PS via AXI-Stream
     * Returns true if TLAST was seen on final byte
     */
    bool receive_token(axis_stream_t& input_stream, int8_t token_buf[D_MODEL]) {
        #pragma HLS INLINE
        
        bool saw_last = false;
        for (int i = 0; i < D_MODEL; i++) {
            #pragma HLS PIPELINE II=1
            axis_pkt_t pkt = input_stream.read();
            token_buf[i] = pkt.data;
            
            if (i == D_MODEL - 1) {
                saw_last = (pkt.last == 1);
            }
        }
        return saw_last;
    }

    /**
     * Send a full token/logit (D_MODEL uint8 values) to PS via AXI-Stream
     */
    void send_logit(axis_stream_t& output_stream, const int8_t logit_buf[D_MODEL]) {
        #pragma HLS INLINE
        
        for (int i = 0; i < D_MODEL; i++) {
            #pragma HLS PIPELINE II=1
            
            axis_pkt_t pkt;
            pkt.data = logit_buf[i];
            pkt.last = (i == D_MODEL - 1) ? 1 : 0;  // TLAST on final byte
            
            output_stream.write(pkt);
        }
    }
};
