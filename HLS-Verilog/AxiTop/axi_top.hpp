#pragma once
#include "../ControlMemInterface/ControlMemInterface.hpp"
#include "../LogitStreamInterface/LogitStreamInterface.hpp"
#include "../WeightTransferInterface/WeightTransferInterface.hpp"
#include "../Weight_Loader-Stager/Weight_stager.hpp"
#include "../top_params.hpp"
#include <hls_stream.h>

/**
 * AXI Top - Hardware Interface Test Wrapper
 *
 * Demonstrates all 3 AXI interface types:
 * - AXI4-Lite:   ControlMemSpace (input) / StatusMemSpace (output)
 * - AXI4-Stream: Token input (PS→PL) / Logit output (PL→PS)
 * - AXI4-Full:   Weights read (gmem_weights) / KV cache r/w (gmem_kvcache)
 */

enum class TestState {
    NONE = 0,
    INCR_MATRIX,
    INCR_LAYER,
    INCR_HEAD,
    INCR_TOKEN,
    WEIGHTS_GET,
    KCACHE_GET,
    VCACHE_GET,
    STREAM_IN,
    COMPUTE,
    STREAM_OUT,
    KCACHE_SEND,
    VCACHE_SEND
};

void axi_top(
    // AXI4-Lite Control/Status (s_axilite)
    ControlMemSpace ctrl_mem,   // [IN]  PS → PL control registers
    StatusMemSpace &status_mem, // [OUT] PL → PS status registers
    bool &irq_ps,               // [OUT] Interrupt signal

    // AXI4-Stream Token/Logit (axis)
    axis_stream_t &token_in_stream,  // [IN]  PS → PL embedding tokens
    axis_stream_t &logit_out_stream, // [OUT] PL → PS logit output

    // AXI4 Full DDR Memory (m_axi)
    const int32_t *ddr_weights, // [IN]    Read-only weight loading
    int32_t *ddr_kvcache        // [INOUT] KV cache read/write
);
