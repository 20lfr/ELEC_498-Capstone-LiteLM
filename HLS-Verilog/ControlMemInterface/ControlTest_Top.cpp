#include "ControlMemInterface.hpp"

// THIS FUNCTION IS TEMPORARY. 
// It exists only to generate the AXI-Lite adapter for testing.
void ControlTest_Top(
    // 1. AXI-Lite Mapped Ports
    ControlMemSpace config_in,    // Input Bundle
    StatusMemSpace  &status_out,  // Output Bundle

    // 2. Dummy Hardware Signals (to simulate internal logic)
    bool            sim_trigger_done,
    bool            sim_trigger_error
) {
    // =========================================================
    // COPY THESE FOR USE IN TOP LATER
    // =========================================================
    #pragma HLS INTERFACE s_axilite port=config_in      bundle=control
    #pragma HLS INTERFACE s_axilite port=status_out     bundle=control
    #pragma HLS INTERFACE s_axilite port=return         bundle=control

    // Instantiate logic
    static ControlMemInterface ctrl;
    // Read Inputs
    ctrl.update_inputs(config_in);
    StatusMemSpace active_status = ctrl.get_mutable_status();

    if (sim_trigger_error) {
      active_status.irq_status |= IRQ_ERROR_BIT;
      active_status.status = STATUS_ERROR;
      active_status.error_code = ERR_DMA_ALIGNMENT;
    }
    if (sim_trigger_done) {
      active_status.irq_status |= IRQ_INFER_DONE_BIT;
      active_status.status &= ~STATUS_BUSY_BIT;
    }

    // Write to PS
    status_out = active_status;
}
