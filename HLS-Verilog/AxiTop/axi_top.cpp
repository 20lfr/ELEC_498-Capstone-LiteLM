#include "axi_top.hpp"
#include <cstdint>

/**
 * Simple AXI Top-Level Implementation
 * 
 * Testing:
 * - AXI4-Lite: Control/Status registers
 * - AXI4-Stream: Token input and logit output (8-bit)
 */

void axi_top(
    // AXI4-Lite Control/Status
    ControlMemSpace ctrl_mem,
    StatusMemSpace& status_mem,
    bool &irq_ps,
    
    // AXI4-Stream Token/Logit (8-bit)
    axis_stream_t& input_token,
    axis_stream_t& output_logit
) {
    #pragma HLS INTERFACE s_axilite port=ctrl_mem bundle=control
    #pragma HLS INTERFACE s_axilite port=status_mem bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control
    #pragma HLS INTERFACE ap_none port=irq_ps
    
    #pragma HLS INTERFACE axis port=input_token
    #pragma HLS INTERFACE axis port=output_logit
    
    // LOCAL BUFFERS
    int8_t token_buf[D_MODEL];
    int8_t logit_buf[D_MODEL];
    #pragma HLS ARRAY_PARTITION variable=token_buf cyclic factor=4
    #pragma HLS ARRAY_PARTITION variable=logit_buf cyclic factor=4
    
    // INTERFACE INSTANCES
    static ControlMemInterface ctrl_intf;
    static LogitStreamInterface stream_intf;

    // CONTROL INPUT PROCESSING
    ctrl_intf.update_inputs(ctrl_mem);
    StatusMemSpace &local_status = ctrl_intf.get_mutable_status();

    // Scheduler state
    bool done = false;
    bool error = false;

    // CHECK CONTROL SIGNALS 
    bool resetn = (ctrl_mem.control & CTRL_RESETN_BIT) != 0;
    bool start  = (ctrl_mem.control & CTRL_START_BIT) != 0;

    if(!resetn) {
        // In reset - do nothing
        local_status.status = STATUS_IDLE;
        irq_ps = false;
    } else if (start) {
        local_status.status = STATUS_BUSY_BIT;

        bool received_ok = stream_intf.receive_token(input_token, token_buf);
        if (!received_ok) {
            local_status.status = STATUS_ERROR;
            local_status.error_code = ERR_INPUT_STREAM;
            status_mem = local_status;
            error = true;
            return;
        }
        for (int i = 0; i < D_MODEL; i++) {
            #pragma HLS UNROLL factor=4
            logit_buf[i] = token_buf[i] + 1;  // Simple test: increment each value
        }
    
        stream_intf.send_logit(output_logit, logit_buf);
      
        done = true;
    }
    irq_ps = ctrl_intf.compute_irq(ctrl_mem.irq_mask, done, error);
    status_mem = local_status;
}
