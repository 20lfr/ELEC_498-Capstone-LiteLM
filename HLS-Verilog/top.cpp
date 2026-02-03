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
    // Memory Management System (WEIGHT LOADER via DMA)
    // ------------------------------------------------------------
    bool        dma_done,                   // [INPUT]  DMA transfer completed (single-cycle pulse)

    bool        wl_ready,                 // [INPUT]  Weight loader ready for a new request
    bool        &wl_start,                // [OUTPUT] Start weight load request
    DmaSel      &wl_addr_sel,             // [OUTPUT] Select weight matrix/tile
    int         &wl_layer,                // [OUTPUT] Layer index for DMA
    int         &wl_head,                 // [OUTPUT] Head index (or -1 for non-head ops)
    int         &wl_tile,                 // [OUTPUT] Tile index for large matrices

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
    bool compute_ready,                 // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,                  // [INPUT]  Compute operation finished (one-shot)
    bool &compute_start,                // [OUTPUT] Trigger compute engine
    uint32_t &compute_op,               // [OUTPUT] Packed op|layer|head|tile for compute
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]   Per-head context (in/out) - includes DMA signals, head records and compute signals
    
    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence     

    // ------------------------------------------------------------
    // AXI4-LITE INTERFACING (PL <-> PS)
    // ------------------------------------------------------------
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interfaceo
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface

    // ------------------------------------------------------------
    // INTERUPT INTERFACING (PL → PS)
    // ------------------------------------------------------------
    bool        &irq_ps,

    // ------------------------------------------------------------
    // DEBUG OUTPUTS
    // ------------------------------------------------------------
    SchedState  &dbg_state,
    ControlMemSpace &dbg_ctrl_mem,
    StatusMemSpace &dbg_status_mem,
    uint32_t &control_reg,
    uint32_t &irq_status_reg,
    uint32_t &irq_mask_reg,
    uint32_t &wq_base_addr,
    uint32_t &wk_base_addr,
    uint32_t &wv_base_addr,
    uint32_t &wo_base_addr,
    uint32_t &w1_base_addr,
    uint32_t &w2_base_addr,
    uint32_t &wq_head_stride,
    uint32_t &wk_head_stride,
    uint32_t &wv_head_stride,
    uint32_t &wo_tile_stride,
    uint32_t &w1_tile_stride,
    uint32_t &w2_tile_stride,

    bool &dbg_done,
    bool &dbg_error
) {
#pragma HLS INLINE off   
#pragma HLS INTERFACE s_axilite port=ctrl_mem bundle=control
#pragma HLS INTERFACE s_axilite port=status_mem bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS INTERFACE ap_none port=irq_ps

    bool done               = false;    // Scheduler done flag
    bool error              = false;    // Scheduler error flag
    ControlMemInterface ctrl_mem_interface;
    ctrl_mem_interface.update_inputs(ctrl_mem);
    static StatusMemSpace active_status_mem = ctrl_mem_interface.get_mutable_status();

    // Debugging mirrors
    control_reg   = ctrl_mem.control;
    irq_status_reg   = active_status_mem.irq_status;
    irq_mask_reg   = ctrl_mem.irq_mask;
    wq_base_addr   = ctrl_mem.wq_base_addr;
    wk_base_addr   = ctrl_mem.wk_base_addr;
    wv_base_addr   = ctrl_mem.wv_base_addr;
    wo_base_addr   = ctrl_mem.wo_base_addr;
    w1_base_addr   = ctrl_mem.w1_base_addr;
    w2_base_addr   = ctrl_mem.w2_base_addr;
    wq_head_stride   = ctrl_mem.wq_head_stride;
    wk_head_stride   = ctrl_mem.wk_head_stride;
    wv_head_stride   = ctrl_mem.wv_head_stride;
    wo_tile_stride   = ctrl_mem.wo_tile_stride;
    w1_tile_stride   = ctrl_mem.w1_tile_stride;
    w2_tile_stride   = ctrl_mem.w2_tile_stride;

    // Clear handshake state on external resetn deassert.
    if (ctrl_mem.control & !CTRL_RESETN_BIT) {
        done          = false;
        error         = false;
    }

    // SCHEDULER FSM~~~~~~~~~~~~~~~~~~~~~~~
    scheduler_hls(
        ctrl_mem,
        active_status_mem,
        axis_in_valid,
        axis_in_last,
        axis_in_ready,
        dma_done,
        wl_ready,
        wl_start,
        wl_addr_sel,
        wl_layer,
        wl_head,
        wl_tile,
        compute_ready,
        compute_done,
        head_ctx_ref,
        compute_start,
        compute_op,
        stream_ready,
        stream_start,
        stream_done,
        done,
        error,
        dbg_state
    );

    // IRQ WIZARD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    irq_ps = irq_wizard(active_status_mem.irq_status, ctrl_mem.irq_mask, done, error);
    dbg_done = done;
    dbg_error = error;

    // Update status memory
    status_mem = active_status_mem;
}
