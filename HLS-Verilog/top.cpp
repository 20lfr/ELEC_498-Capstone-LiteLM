#include "top.hpp"
#include "MMU/mmu_luka.hpp"
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
    bool        dma_ready,
    bool        dma_done,
    const uint8_t dma_rx_buf[TOP_DMA_BUF_BYTES],
    uint8_t     dma_tx_buf[TOP_DMA_BUF_BYTES],
    bool        &dma_start,
    uint32_t    &dma_addr,
    uint32_t    &dma_len,
    bool        &dma_is_write,


    /*
        TEMPORARY INPUT/OUPUTS BELOW FOR DEBUGGING PURPOSES!!!!!!!!!!!!!
    */

    // ------------------------------------------------------------
    // DEBUG MIRRORS
    // ------------------------------------------------------------
    SchedState      &dbg_state,
    HeadCtx         (&dbg_head_ctx_ref)[NUM_HEADS],
    ComputeHeadCtx  (&dbg_head_compute_ctx)[HEADS_PARALLEL],
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
    int      &dbg_head_group_idx,
    bool     &dbg_wl_ready,
    uint32_t &dbg_wl_instruction,
    bool     &dbg_wl_start,
    bool     &dbg_mem_transfer_done,
    bool     &dbg_mem_read_request,
    bool     &dbg_mem_write_request,
    uint32_t &dbg_mem_op,
    uint8_t  dbg_in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t  dbg_out_buf[compute_buf::OUT_BUF_BYTES],
    uint8_t  dbg_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES],
    uint8_t  dbg_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES],

    bool &dbg_done
) {
#pragma HLS INLINE off   
#pragma HLS INTERFACE s_axilite port=ctrl_mem bundle=control
#pragma HLS INTERFACE s_axilite port=status_mem bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS INTERFACE ap_none port=irq_ps
#pragma HLS ARRAY_PARTITION variable=dbg_head_in_buf complete dim=1
#pragma HLS ARRAY_PARTITION variable=dbg_head_out_buf complete dim=1

    bool done               = false;    // Scheduler done flag
    bool scheduler_error       = false;
    bool compute_error         = false;


    static ControlMemInterface ctrl_mem_interface;
    StatusMemSpace &active_status_mem = ctrl_mem_interface.get_mutable_status();

    static bool     compute_ready = false;
    static bool     compute_done = false;
    static bool     compute_start = false;
    static uint32_t compute_instruction = 0;
    static SchedState state_local = S_IDLE;
    static HeadCtx head_ctx_local[NUM_HEADS];
    static ComputeHeadCtx head_compute_ctx_local[HEADS_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=head_compute_ctx_local complete dim=1

    // Headed compute controller lanes (parallel heads) 
    static int      head_group_idx;
    static int8_t  head_dbg_vec[HEADS_PARALLEL][HEAD_VECTOR_MAX];
    static int32_t head_dbg_out[HEADS_PARALLEL][HEAD_ACCUM_MAX];

    // MMU-owned compute buffers (main + headed lanes)
    static uint8_t mmu_in_buf[compute_buf::IN_BUF_BYTES];
    static uint8_t mmu_out_buf[compute_buf::OUT_BUF_BYTES];
    static uint8_t mmu_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES];
    static uint8_t mmu_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES];
    static uint8_t dbg_out_buf_local[compute_buf::OUT_BUF_BYTES];
    static uint8_t dbg_head_out_buf_local[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES];

    // MMU external DMA/status interface state
    static Status      mmu_status;
    static bool        mmu_dma_req_ready = true;
    static bool        mmu_compute_req_ready = true;
    static bool        mmu_main_dma_done = false;
    static bool        mmu_main_compute_done = false;
    static bool        mmu_head_dma_done[NUM_HEADS];
    static bool        mmu_head_compute_done[NUM_HEADS];
    static uint32_t    mmu_last_dma_req_packed = 0;
    static bool        wl_ready_local = false;
    static uint32_t    wl_instruction_local = 0;
    static bool        wl_start_local = false;
    static bool        mem_transfer_done_local = false;
    static bool        mem_read_request_local = false;
    static bool        mem_write_request_local = false;
    static uint32_t    mem_op_local = 0;

    // Request tracking between producers and MMU
    static bool     main_dma_pending = false;
    static uint32_t main_dma_pending_packed = 0;
    static bool     head_dma_pending[NUM_HEADS];
    static uint32_t head_dma_pending_packed[NUM_HEADS];

    static bool           main_compute_inflight = false;
    static ComputeReqType main_compute_inflight_type = ComputeReqType::NONE;
    static bool           main_mem_transfer_pending = false;

    static bool           head_compute_inflight[NUM_HEADS];
    static ComputeReqType head_compute_inflight_type[NUM_HEADS];
    static bool           head_mem_transfer_pending[NUM_HEADS];

    // Pulses consumed by scheduler/compute from previous MMU cycle
    bool scheduler_dma_done_pulse = false;
    bool main_mem_transfer_done_pulse = false;
    bool head_dma_done_pulse[NUM_HEADS];
    bool head_lane_mem_transfer_done_pulse[HEADS_PARALLEL];

    for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
        head_dma_done_pulse[i] = false;
    }
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        head_lane_mem_transfer_done_pulse[lane] = false;
    }

    // Done-flag clear requests back into MMU (single head per cycle for each class)
    bool clear_head_dma_done_valid = false;
    int  clear_head_dma_done_idx = 0;
    bool clear_head_compute_done_valid = false;
    int  clear_head_compute_done_idx = 0;
    bool clear_main_dma_done = false;
    bool clear_main_compute_done = false;

    
    // Active-low reset derived from control register.
    const bool reset_n = (ctrl_mem.control & CTRL_RESETN_BIT) != 0u;
    const bool reset = !reset_n;

    // Clear handshake state on external resetn deassert.
    if (reset) {
        done          = false;
        scheduler_error = false;
        compute_error   = false;

        compute_ready = true;
        compute_done  = false;
        compute_start = false;
        compute_instruction = 0;
        head_group_idx = 0;

        main_dma_pending = false;
        main_dma_pending_packed = 0;
        main_compute_inflight = false;
        main_compute_inflight_type = ComputeReqType::NONE;
        main_mem_transfer_pending = false;
        mmu_last_dma_req_packed = 0;

        for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
            head_dma_pending[i] = false;
            head_dma_pending_packed[i] = 0;
            head_compute_inflight[i] = false;
            head_compute_inflight_type[i] = ComputeReqType::NONE;
            head_mem_transfer_pending[i] = false;
        }
        for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
            mmu_head_dma_done[i] = false;
            mmu_head_compute_done[i] = false;
        }
        for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
            mmu_in_buf[i] = 0;
        }
        for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
            mmu_out_buf[i] = 0;
            dbg_out_buf_local[i] = 0;
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
            for (int i = 0; i < head_buf::IN_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                mmu_head_in_buf[lane][i] = 0;
            }
            for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                mmu_head_out_buf[lane][i] = 0;
                dbg_head_out_buf_local[lane][i] = 0;
            }
        }
    }

    // Consume MMU done flags from previous cycle.
    if (mmu_main_dma_done) {
        scheduler_dma_done_pulse = true;
        mmu_main_dma_done = false;
        clear_main_dma_done = true;
    }
    if (main_mem_transfer_pending) {
        main_mem_transfer_done_pulse = true;
        main_mem_transfer_pending = false;
    }

    for (int head = 0; head < NUM_HEADS; ++head) {
#pragma HLS UNROLL
        if (mmu_head_dma_done[head] && !clear_head_dma_done_valid) {
            head_dma_done_pulse[head] = true;
            mmu_head_dma_done[head] = false;
            clear_head_dma_done_valid = true;
            clear_head_dma_done_idx = head;
        }
    }

    for (int head = 0; head < NUM_HEADS; ++head) {
#pragma HLS UNROLL
        if (mmu_head_compute_done[head] && !clear_head_compute_done_valid) {
            if (head_compute_inflight[head]) {
                const int lane = head - (head_group_idx * HEADS_PARALLEL);
                if (lane >= 0 && lane < HEADS_PARALLEL) {
                    if (head_compute_inflight_type[head] == ComputeReqType::WRITE) {
                        for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                            dbg_head_out_buf_local[lane][i] = mmu_head_out_buf[lane][i];
                        }
                    }
                }
                head_compute_inflight[head] = false;
                head_compute_inflight_type[head] = ComputeReqType::NONE;
                head_mem_transfer_pending[head] = true;
            }
            mmu_head_compute_done[head] = false;
            clear_head_compute_done_valid = true;
            clear_head_compute_done_idx = head;
        }
    }

    if (mmu_main_compute_done) {
        if (main_compute_inflight) {
            if (main_compute_inflight_type == ComputeReqType::WRITE) {
                for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                    dbg_out_buf_local[i] = mmu_out_buf[i];
                }
            }
            main_compute_inflight = false;
            main_compute_inflight_type = ComputeReqType::NONE;
            main_mem_transfer_pending = true;
        }
        mmu_main_compute_done = false;
        clear_main_compute_done = true;
    }

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int idx = head_group_idx * HEADS_PARALLEL + lane;
        if (idx >= 0 && idx < NUM_HEADS && head_mem_transfer_pending[idx]) {
            head_lane_mem_transfer_done_pulse[lane] = true;
            head_mem_transfer_pending[idx] = false;
        }
    }

    // Per-head scheduler-facing handshake inputs sourced from MMU.
    for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
        head_ctx_local[i].wl_ready = mmu_dma_req_ready;
        head_ctx_local[i].dma_done = head_dma_done_pulse[i];
    }

    bool scheduler_wl_start = false;
    uint32_t scheduler_wl_instruction = 0;

    // SCHEDULER FSM~~~~~~~~~~~~~~~~~~~~~~~
    scheduler_hls(
        ctrl_mem,
        active_status_mem,
        axis_in_valid,
        axis_in_last,
        axis_in_ready,
        scheduler_dma_done_pulse,
        mmu_dma_req_ready,
        scheduler_wl_instruction,
        scheduler_wl_start,
        compute_ready,
        compute_done,
        head_ctx_local,
        head_group_idx,
        compute_start,
        compute_instruction,
        stream_ready,
        stream_start,
        stream_done,
        done,
        scheduler_error,
        state_local
    );

    bool main_mem_read_request = false;
    bool main_mem_write_request = false;
    uint32_t main_mem_op = 0;

    compute_controller(
        ctrl_mem,               
        compute_start,       
        compute_instruction,      
        compute_ready,
        compute_done,

        main_mem_transfer_done_pulse,
        main_mem_read_request,
        main_mem_write_request,
        main_mem_op,
        mmu_in_buf,
        mmu_out_buf,

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

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int idx = head_group_idx * HEADS_PARALLEL + lane;
        if (idx >= 0 && idx < NUM_HEADS) {
            head_compute_ctx_local[lane].compute_start = head_ctx_local[idx].compute_start;
            head_compute_ctx_local[lane].compute_instruction = head_ctx_local[idx].compute_op;
            head_compute_ctx_local[lane].mem_transfer_done = head_lane_mem_transfer_done_pulse[lane];
        } else {
            head_compute_ctx_local[lane].compute_start = false;
            head_compute_ctx_local[lane].compute_instruction = 0;
            head_compute_ctx_local[lane].mem_transfer_done = false;
        }
    }
    bool head_error_any = false;
    drive_headed_compute_controller(
        head_compute_ctx_local,
        reset_n,
        mmu_head_in_buf,
        mmu_head_out_buf,
        head_dbg_vec,
        head_dbg_out,
        head_error_any
    );

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int idx = head_group_idx * HEADS_PARALLEL + lane;
        if (idx >= 0 && idx < NUM_HEADS) {
            head_ctx_local[idx].compute_ready = head_compute_ctx_local[lane].compute_ready;
            head_ctx_local[idx].compute_done  = head_compute_ctx_local[lane].compute_done;
        }
    }

    // Capture new DMA requests from scheduler + headed FSMs.
    if (scheduler_wl_start) {
        main_dma_pending = true;
        main_dma_pending_packed = scheduler_wl_instruction;
    }
    for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
        if (head_ctx_local[i].wl_start) {
            head_dma_pending[i] = true;
            head_dma_pending_packed[i] = head_ctx_local[i].wl_instruction;
        }
    }

    // Select at most one DMA request for MMU this cycle.
    bool mmu_dma_req_start = false;
    uint32_t mmu_dma_instruction = 0;
    bool selected_head_dma = false;
    int selected_head_dma_idx = -1;
    if (mmu_dma_req_ready) {
        if (main_dma_pending) {
            mmu_dma_req_start = true;
            mmu_dma_instruction = main_dma_pending_packed;
            main_dma_pending = false;
        } else {
            for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
                if (!mmu_dma_req_start && head_dma_pending[i]) {
                    selected_head_dma = true;
                    selected_head_dma_idx = i;
                    mmu_dma_instruction = head_dma_pending_packed[i];
                    head_dma_pending[i] = false;
                }
            }
        }
    }
    if (mmu_dma_req_start || selected_head_dma) {
        mmu_last_dma_req_packed = mmu_dma_instruction;
    }

    // Select at most one compute-buffer transfer request for MMU.
    bool mmu_main_mem_read = false;
    bool mmu_main_mem_write = false;
    uint32_t mmu_main_mem_op = 0;
    bool selected_head_compute = false;
    int selected_head_lane = -1;
    int selected_head_idx = -1;
    bool selected_head_read = false;
    bool selected_head_write = false;
    uint32_t selected_head_mem_op = 0;

    if (mmu_compute_req_ready) {
        if (!main_compute_inflight && (main_mem_read_request || main_mem_write_request)) {
            mmu_main_mem_read = main_mem_read_request;
            mmu_main_mem_write = main_mem_write_request;
            mmu_main_mem_op = main_mem_op;
            main_compute_inflight = true;
            main_compute_inflight_type = mmu_main_mem_read ? ComputeReqType::READ
                                                           : ComputeReqType::WRITE;
        } else {
            for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
                const int idx = head_group_idx * HEADS_PARALLEL + lane;
                if (!selected_head_compute && idx >= 0 && idx < NUM_HEADS) {
                    const bool need_read = head_compute_ctx_local[lane].mem_read_request;
                    const bool need_write = head_compute_ctx_local[lane].mem_write_request;
                    if (!head_compute_inflight[idx] && (need_read || need_write)) {
                        selected_head_compute = true;
                        selected_head_lane = lane;
                        selected_head_idx = idx;
                        selected_head_read = need_read;
                        selected_head_write = need_write;
                        selected_head_mem_op = head_compute_ctx_local[lane].mem_op;
                        head_compute_inflight[idx] = true;
                        head_compute_inflight_type[idx] = need_read ? ComputeReqType::READ
                                                                    : ComputeReqType::WRITE;
                    }
                }
            }
        }
    }

    HeadCtx mmu_head_ctx[NUM_HEADS];
    ComputeHeadCtx mmu_head_compute_ctx[HEADS_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=mmu_head_compute_ctx complete dim=1
    for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
        mmu_head_ctx[i] = head_ctx_local[i];
        mmu_head_ctx[i].wl_start = false;
        mmu_head_ctx[i].dma_done = false;
    }
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        mmu_head_compute_ctx[lane] = head_compute_ctx_local[lane];
        mmu_head_compute_ctx[lane].mem_read_request = false;
        mmu_head_compute_ctx[lane].mem_write_request = false;
        mmu_head_compute_ctx[lane].mem_transfer_done = false;
    }
    if (selected_head_dma && selected_head_dma_idx >= 0 && selected_head_dma_idx < NUM_HEADS) {
        mmu_head_ctx[selected_head_dma_idx].wl_start = true;
        mmu_head_ctx[selected_head_dma_idx].wl_instruction = mmu_dma_instruction;
    }
    if (selected_head_compute && selected_head_lane >= 0 && selected_head_lane < HEADS_PARALLEL) {
        mmu_head_compute_ctx[selected_head_lane].mem_read_request = selected_head_read;
        mmu_head_compute_ctx[selected_head_lane].mem_write_request = selected_head_write;
        mmu_head_compute_ctx[selected_head_lane].mem_op = selected_head_mem_op;
    }

    bool main_dma_done_pulse = false;
    bool main_compute_done_pulse = false;
    mmu_fsm(
        reset_n,
        ctrl_mem,
        dma_ready,
        dma_done,
        dma_rx_buf,
        dma_tx_buf,
        dma_start,
        dma_addr,
        dma_len,
        dma_is_write,
        mmu_dma_req_start,
        mmu_dma_instruction,
        mmu_dma_req_ready,
        main_dma_done_pulse,
        mmu_main_mem_read,
        mmu_main_mem_write,
        mmu_main_mem_op,
        main_compute_done_pulse,
        mmu_head_ctx,
        mmu_head_compute_ctx,
        mmu_in_buf,
        mmu_out_buf,
        mmu_head_in_buf,
        mmu_head_out_buf,
        mmu_status
    );
    if (main_dma_done_pulse) {
        mmu_main_dma_done = true;
    }
    if (main_compute_done_pulse) {
        mmu_main_compute_done = true;
    }
    for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
        head_ctx_local[i].wl_ready = mmu_head_ctx[i].wl_ready;
        if (mmu_head_ctx[i].dma_done) {
            mmu_head_dma_done[i] = true;
        }
    }
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int idx = head_group_idx * HEADS_PARALLEL + lane;
        if (idx >= 0 && idx < NUM_HEADS && mmu_head_compute_ctx[lane].mem_transfer_done) {
            mmu_head_compute_done[idx] = true;
        }
    }

    compute_error = compute_error || head_error_any || mmu_status.overflow || mmu_status.invalid;
    
    ctrl_mem_interface.check_errors(ctrl_mem, scheduler_error, compute_error);
    ctrl_mem_interface.check_control(ctrl_mem, done);
    irq_ps = ctrl_mem_interface.compute_irq(ctrl_mem.irq_mask);

    // Update status memory
    status_mem = active_status_mem;



    // Debug outputs
    wl_ready_local = mmu_dma_req_ready;
    wl_start_local = dma_start;
    wl_instruction_local = mmu_last_dma_req_packed;
    mem_transfer_done_local = main_mem_transfer_done_pulse;
    mem_read_request_local = main_mem_read_request;
    mem_write_request_local = main_mem_write_request;
    mem_op_local = main_mem_op;

    dbg_done = done;
    dbg_compute_start = compute_start;
    dbg_compute_instruction = compute_instruction;
    dbg_compute_ready = compute_ready;
    dbg_compute_done = compute_done;
    dbg_state = state_local;
    dbg_ctrl_mem = ctrl_mem;
    dbg_ctrl_reset_asserted = reset;
    dbg_head_group_idx = head_group_idx;
    dbg_wl_ready = wl_ready_local;
    dbg_wl_instruction = wl_instruction_local;
    dbg_wl_start = wl_start_local;
    dbg_mem_transfer_done = mem_transfer_done_local;
    dbg_mem_read_request = mem_read_request_local;
    dbg_mem_write_request = mem_write_request_local;
    dbg_mem_op = mem_op_local;
    for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
        dbg_in_buf[i] = mmu_in_buf[i];
    }
    for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
        dbg_out_buf[i] = dbg_out_buf_local[i];
    }
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        dbg_head_compute_ctx[lane] = head_compute_ctx_local[lane];
        for (int i = 0; i < head_buf::IN_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
            dbg_head_in_buf[lane][i] = mmu_head_in_buf[lane][i];
        }
        for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
            dbg_head_out_buf[lane][i] = dbg_head_out_buf_local[lane][i];
        }
    }
    for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
        dbg_head_ctx_ref[i] = head_ctx_local[i];
    }
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
