#pragma once

#include <cstdint>
#include "Head_Helpers/head_helpers.hpp"
#include "../../top_params.hpp"

constexpr int NUM_HEAD_GROUPS = (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;

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
    uint32_t  &wl_instruction,
    bool      &wl_start,
    bool        compute_ready,
    bool        compute_done,
    HeadCtx (&head_ctx_ref)[NUM_HEADS],
    bool        &compute_start,
    uint32_t   &compute_instruction,
    bool        stream_ready,
    bool        &stream_start,
    bool        stream_done,
    bool        &done,
    bool &error,
    SchedState &STATE
);
