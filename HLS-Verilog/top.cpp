#include "top.hpp"

// Temporary top-level wrapper that calls only the mem interface and scheduler (so no inputs rn)
void transformer_top(
    // ------------------------------------------------------------
    // AXI4-STREAM INPUT (INGRESS: PS → PL)
    // ------------------------------------------------------------
    bool axis_in_valid,                 // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,                  // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready,                // [OUTPUT] s_axis_in_tready

    // ------------------------------------------------------------
    // WEIGHT LOADER (AXI4-FULL MASTER via DMA)
    // ------------------------------------------------------------
    bool dma_done,                      // [INPUT]  DMA transfer completed (single-cycle pulse)

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
    bool compute_ready,                 // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,                  // [INPUT]  Compute operation finished (one-shot)
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]  Per-head context (in/out)
    bool &compute_start,                // [OUTPUT] Trigger compute engine
    ComputeOp &compute_op,              // [OUTPUT] What operation to run (QKV, AttnScore,
                                        // Softmax...)
    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence




    // TEMPORARY INTERFACING FOR DEBUG
    // ------------------------------------------------------------
    // WEIGHT LOADER (AXI4-FULL MASTER via DMA)
    // ------------------------------------------------------------
    bool wl_ready,    // [INPUT]  Weight loader ready for a new request
    bool &wl_start,   // [OUTPUT] Start weight load DMA
    DmaSel &wl_addr_sel, // [OUTPUT] Select which matrix/tile (Q, K, V, K cache, V
                      // cache, WO, W1...)
    int &wl_layer,    // [OUTPUT] Layer index for DMA
    int &wl_head,     // [OUTPUT] Head index for DMA (or -1 for non-head ops)
    int &wl_tile,     // [OUTPUT] Tile index for large matrices


    ControlReg ctrl_addr,
    uint32_t   ctrl_data_in,
    uint32_t   &ctrl_data_out,
    bool       ctrl_read_en,
    bool       ctrl_write_en,
    bool       ctrl_chip_en,
    bool       ctrl_resetn_in, 

    SchedState  &dbg_state,
    ControlMemSpace &dbg_ctrl_mem,
    bool        done, 

    bool        &irq_ps
) {
#pragma HLS INLINE off

    // Control Memory Address Space~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    static ControlMemSpace ctrl_mem; 
    ControlMemInterface(
        ctrl_mem,       // AXI-Lite mapped control memory
        ctrl_addr,      // byte address for control/IRQ registers
        ctrl_data_in,   // data from PS-side writes
        ctrl_data_out,  // data returned on PS-side reads
        ctrl_read_en,   // read strobe
        ctrl_write_en,  // write strobe
        ctrl_chip_en,   // chip enable gate
        ctrl_resetn_in  // active-low reset
    );
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    

    // Placeholder wires for scheduler inputs/outputs.
    bool error          = false;    // Scheduler error flag
    

    
    // SCHEDULER FSM~~~~~~~~~~~~~~~~~~~~~~~
    scheduler_hls(
        ctrl_mem,
        axis_in_valid,
        axis_in_last,
        axis_in_ready,
        wl_ready,
        wl_start,
        wl_addr_sel,
        wl_layer,
        wl_head,
        wl_tile,
        dma_done, // <-- needs to come from the AXI-full interface
        compute_ready,
        compute_done,
        head_ctx_ref,
        compute_start,
        compute_op,
        stream_ready,
        stream_start,
        stream_done,
        done,
        dbg_state // FOR DEBUGGGG FOR NOW REMOVE WHEN DONE!!!
    );

    // IRQ WIZARD~~~~~~~~~~~~~~~~~~~~~~~~~~
    irq_ps = irq_wizard(ctrl_mem, done, error);
    dbg_ctrl_mem = ctrl_mem;

}
