#include "ControlMemInterface.hpp"

// THIS FUNCTION IS TEMPORARY. 
// It exists only to generate the AXI-Lite adapter for testing.
void ControlTest_Top(
    // 1. AXI-Lite Mapped Ports
    ControlMemSpace config_in,    // Input Bundle
    StatusMemSpace  &status_out,  // Output Bundle
    uint32_t        irq_clear_in // Control Bundle
    
    // 2. Dummy Hardware Signals (to simulate internal logic)
    // bool            sim_trigger_done,
    // bool            sim_trigger_error
) {
    // =========================================================
    // COPY THESE FOR USE IN TOP LATER
    // =========================================================
    #pragma HLS INTERFACE s_axilite port=config_in      bundle=control
    #pragma HLS INTERFACE s_axilite port=status_out     bundle=control
    #pragma HLS INTERFACE s_axilite port=irq_clear_in   bundle=control
    #pragma HLS INTERFACE s_axilite port=return         bundle=control

    // Instantiate logic
    static ControlMemInterface ctrl;

    // Read Inputs
    ctrl.update_inputs(config_in, irq_clear_in);

    // Logic Loop
    if (ctrl.is_safe_to_start()) {
      ctrl.set_busy(true);
      // if (sim_trigger_done) {
      //   ctrl.set_done();
      // }
    }

    // if (sim_trigger_error) {
    //   ctrl.set_error(ERR_DMA_ALIGNMENT);
    // }

    // Write to PS
    status_out = ctrl.get_status_output();
}
