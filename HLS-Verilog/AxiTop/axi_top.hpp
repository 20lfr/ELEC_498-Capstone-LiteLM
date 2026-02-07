#pragma once
#include "../top_params.hpp"
#include "../LogitStreamInterface/LogitStreamInterface.hpp"
//#include "../WeightTransferInterface/WeightTransferInterface.hpp"
#include "../ControlMemInterface/ControlMemInterface.hpp"
#include <hls_stream.h>

/**
 * External Interface Top - Hardware Test Wrapper
 * 
 * Demonstrates all 3 AXI interface types:
 * - AXI4-Lite:   ControlMemSpace (input) / StatusMemSpace (output)
 * - AXI4-Stream: Token input (PS→PL) / Logit output (PL→PS)
 */

void axi_top(
    // ===== AXI4-Lite Control/Status (s_axilite) =====
    ControlMemSpace ctrl_mem,       // [IN]  PS → PL control registers
    StatusMemSpace& status_mem,     // [OUT] PL → PS status registers
    bool &irq_ps,                   // [OUTPUT] Interrupt signal 
    
    // ===== AXI4-Stream Token/Logit (axis) =====
    axis_stream_t& token_in_stream,   // [IN]  PS → PL embedding tokens
    axis_stream_t& logit_out_stream   // [OUT] PL → PS logit output
);
