#pragma once

#include <cstdint>
#include "Head_Helpers/head_helpers.hpp"
#include "../../top_params.hpp"

constexpr int NUM_HEAD_GROUPS = (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;


// Drive a three-phase LayerNorm using the shared compute interface.
// Returns true once PASS2 completes and phase is set to DONE.
bool LayerNorm(
    LnPhase   &phase,
    bool      &ln_started,
    bool      &ln_compute_done,
    bool       compute_ready,
    int        layer_idx,
    bool      &compute_start,
    uint32_t  &compute_op,
    const ComputeOp ops[10]
);


// ------------------------------------------------------------
// Scheduler FSM top-level
// ------------------------------------------------------------
void scheduler_hls(
    ControlMemSpace ctrl_mem,
    StatusMemSpace &status_mem,
    bool axis_in_valid,
    bool axis_in_last,
    bool &axis_in_ready,
    bool      dma_done,
    bool      wl_ready,
    bool      &wl_start,
    DmaSel      &wl_addr_sel,
    int         &wl_layer,
    int         &wl_head,
    int         &wl_tile,
    bool        compute_ready,
    bool        compute_done,
    HeadCtx (&head_ctx_ref)[NUM_HEADS],
    bool        &compute_start,
    uint32_t  &compute_op,
    bool        stream_ready,
    bool        &stream_start,
    bool        stream_done,
    bool        &done,
    bool &error,
    SchedState &STATE
);
