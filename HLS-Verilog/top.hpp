#pragma once
#include <cstdint>
#include "top_params.hpp"
#include "Scheduler_FSM/src-hls/Scheduler_FSM.hpp"
#include "ControlMemInterface/ControlMemInterface.hpp"
#include "IRQ_Wizard/IRQ_Wizard.hpp"


// Top-level wrapper prototype
void transformer_top(
    bool axis_in_valid,
    bool axis_in_last,
    bool &axis_in_ready,
    bool dma_done,
    bool compute_ready,
    bool compute_done,
    HeadCtx (&head_ctx_ref)[NUM_HEADS],
    bool &compute_start,
    ComputeOp &compute_op,
    bool stream_ready,
    bool &stream_start,
    bool stream_done,
    bool wl_ready,
    bool &wl_start,
    DmaSel &wl_addr_sel,
    int &wl_layer,
    int &wl_head,
    int &wl_tile,
    ControlReg ctrl_addr,
    uint32_t ctrl_data_in,
    uint32_t &ctrl_data_out,
    bool ctrl_read_en,
    bool ctrl_write_en,
    bool ctrl_chip_en,
    bool ctrl_resetn_in,
    SchedState &dbg_state, 
    ControlMemSpace &dbg_ctrl_mem,
    bool done, 
    bool &irq_ps
);
