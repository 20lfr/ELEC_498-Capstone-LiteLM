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
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence

    // ------------------------------------------------------------
    // AXI4-LITE INTERFACING (PL <-> PS)
    // ------------------------------------------------------------
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interface
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface

    // ------------------------------------------------------------
    // INTERUPT INTERFACING (PL → PS)
    // ------------------------------------------------------------
    bool        &irq_ps,


    /*
        TEMPORARY INPUT/OUPUTS BELOW FOR DEBUGGING PURPOSES!!!!!!!!!!!!!
    */

    // ------------------------------------------------------------
    // Memory Management System (WEIGHT LOADER via DMA)
    // ------------------------------------------------------------
    // FSM communication signals
    bool        dma_done,                   // [INPUT]  DMA transfer completed (single-cycle pulse)
    bool        wl_ready,                 // [INPUT]  Weight loader ready for a new request
    uint32_t    &wl_instruction,          // [OUTPUT] Packed dma op|layer|head|tile
    bool        &wl_start,                // [OUTPUT] Start weight load request

    // Compute Controller communication signals
    bool        mem_transfer_done,   // [INPUT] Memory manager transfer complete
    bool        &mem_read_request,   // [OUTPUT] Request memory manager read
    bool        &mem_write_request,  // [OUTPUT] Request memory manager write
    uint32_t    &mem_op,             // [OUTPUT] Opcode for memory manager
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t       out_buf[compute_buf::OUT_BUF_BYTES],

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]   Per-head context (in/out) - includes DMA signals, head records and compute signals
    SchedState  &STATE,
    // ------------------------------------------------------------
    // DEBUG OUTPUTS
    // ------------------------------------------------------------
    ControlMemSpace &dbg_ctrl_mem,
    uint32_t &control_reg,
    uint32_t &irq_status_reg,
    uint32_t &irq_mask_reg,
    uint32_t &irq_clear_reg,
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

    // Debug (compute controller)
    bool     &dbg_compute_start,
    uint32_t &dbg_compute_instruction,
    bool     &dbg_compute_ready,
    bool     &dbg_compute_done,
    ComputeState &dbg_compute_state,
    uint32_t &dbg_req_instruction,
    uint8_t  &dbg_req_op,
    uint8_t  &dbg_req_layer,
    uint8_t  &dbg_req_head,
    uint8_t  &dbg_req_tile,
    bool     &dbg_mac_start,
    bool     &dbg_mac_ready,
    bool     &dbg_mac_complete,
    bool     &dbg_ctrl_reset_asserted,

    bool &dbg_done
) {
#pragma HLS INLINE off   
#pragma HLS INTERFACE s_axilite port=ctrl_mem bundle=control
#pragma HLS INTERFACE s_axilite port=status_mem bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS INTERFACE ap_none port=irq_ps

    bool done               = false;    // Scheduler done flag
    bool scheduler_error       = false;
    bool compute_error         = false;


    static ControlMemInterface ctrl_mem_interface;
    StatusMemSpace &active_status_mem = ctrl_mem_interface.get_mutable_status();

    static bool     compute_ready = false;
    static bool     compute_done = false;
    static bool     compute_start = false;
    static uint32_t compute_instruction = 0;
    static ComputeHeadCtx head_compute_ctx[NUM_HEADS];
#pragma HLS ARRAY_PARTITION variable=head_compute_ctx complete dim=1
    static uint8_t head_in_buf[NUM_HEADS][head_buf::IN_BUF_BYTES];
    static uint8_t head_out_buf[NUM_HEADS][head_buf::OUT_BUF_BYTES];
#pragma HLS ARRAY_PARTITION variable=head_in_buf complete dim=1
#pragma HLS ARRAY_PARTITION variable=head_out_buf complete dim=1
    static bool head_mem_read_request[NUM_HEADS];
    static bool head_mem_write_request[NUM_HEADS];
    static uint32_t head_mem_op[NUM_HEADS];
    static ComputeState head_dbg_state[NUM_HEADS];
    static uint32_t head_dbg_req_instruction[NUM_HEADS];
    static uint8_t head_dbg_req_op[NUM_HEADS];
    static uint8_t head_dbg_req_layer[NUM_HEADS];
    static uint8_t head_dbg_req_head[NUM_HEADS];
    static uint8_t head_dbg_req_tile[NUM_HEADS];
    static bool head_error[NUM_HEADS];

    
    // Clear handshake state on external resetn deassert.
    if ((ctrl_mem.control & CTRL_RESETN_BIT) == 0u) {
        done          = false;
        scheduler_error = false;
        compute_error   = false;

        compute_ready = true;
        compute_done  = false;
        compute_start = false;
        compute_instruction = 0;
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
        wl_instruction,
        wl_start,
        compute_ready,
        compute_done,
        head_ctx_ref,
        compute_start,
        compute_instruction,
        stream_ready,
        stream_start,
        stream_done,
        done,
        scheduler_error,
        STATE
    );

    compute_controller(
        ctrl_mem,               
        compute_start,       
        compute_instruction,      
        compute_ready,
        compute_done,

        mem_transfer_done,   
        mem_read_request,   
        mem_write_request,  
        mem_op,    
        in_buf,
        out_buf,

        //DEBUG VISIBILITY
        dbg_compute_state,
        dbg_req_instruction,
        dbg_req_op,
        dbg_req_layer,
        dbg_req_head,
        dbg_req_tile,
        dbg_mac_start,
        dbg_mac_ready,
        dbg_mac_complete,
        compute_error               
    );

    for (int h = 0; h < NUM_HEADS; ++h) {
#pragma HLS UNROLL
        // TODO: wire real head memory manager. For now, assume head buffers are ready.
        const bool head_mem_transfer_done = true;
        head_compute_ctx[h].compute_start = head_ctx_ref[h].compute_start;
        head_compute_ctx[h].compute_instruction = head_ctx_ref[h].compute_op;
        head_compute_ctx[h].mem_transfer_done = head_mem_transfer_done;
        headed_compute_controller(
            head_compute_ctx[h],
            (ctrl_mem.control & CTRL_RESETN_BIT) == 0u,
            head_in_buf[h],
            head_out_buf[h],
            head_dbg_state[h],
            head_dbg_req_instruction[h],
            head_dbg_req_op[h],
            head_dbg_req_layer[h],
            head_dbg_req_head[h],
            head_dbg_req_tile[h],
            head_error[h]
        );
        head_ctx_ref[h].compute_ready = head_compute_ctx[h].compute_ready;
        head_ctx_ref[h].compute_done = head_compute_ctx[h].compute_done;
        head_mem_read_request[h] = head_compute_ctx[h].mem_read_request;
        head_mem_write_request[h] = head_compute_ctx[h].mem_write_request;
        head_mem_op[h] = head_compute_ctx[h].mem_op;
    }
    ctrl_mem_interface.check_errors(ctrl_mem, scheduler_error, compute_error);
    ctrl_mem_interface.check_control(ctrl_mem, done);
    irq_ps = ctrl_mem_interface.compute_irq(ctrl_mem.irq_mask);
    dbg_done = done;

    // Update status memory
    status_mem = active_status_mem;

    // Temporary Debug outputs
    dbg_ctrl_mem = ctrl_mem;
    dbg_compute_start = compute_start;
    dbg_compute_instruction = compute_instruction;
    dbg_compute_ready = compute_ready;
    dbg_compute_done = compute_done;



    // Debugging mirrors
    dbg_ctrl_mem = ctrl_mem;
    dbg_ctrl_reset_asserted = ((ctrl_mem.control & CTRL_RESETN_BIT) == 0u);
    control_reg   = ctrl_mem.control;
    irq_mask_reg   = ctrl_mem.irq_mask;
    irq_clear_reg  = ctrl_mem.irq_clear;
    irq_status_reg = active_status_mem.irq_status;
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


}
