# Chat Handoff

## Current State

This project is an HLS-based transformer pipeline with:

- `top.cpp` as the top-level orchestrator
- `MMU/mmu_luka.cpp` as the memory manager / region store
- `Scheduler_FSM.cpp` as the top scheduler
- `Compute_Controller_Logic/src-hls/compute_controller.cpp` for main ops
- `Compute_Controller_Logic/src-hls/headed_compute_controller.cpp` for headed-attention ops
- `Verilog-top-module/MMU_Top_module_Integration/Top_module_hls_tb.sv` as the main RTL/SystemVerilog integration TB
- `top_DEBUG_tb.cpp` as the C-sim / debug TB

The current work has already made several major architectural changes.

## Major Changes Already Made

### 1. ControlMem moved to offset-only addressing

`HLS-Verilog/top_params.hpp` now uses offset-only addressing in `ControlMemSpace`:

- `wq_offset ... v_cache_offset`
- `wq_bias_offset ... w2_bias_offset`
- `ln0_gamma_offset ... final_norm_eps_offset`
- `wlogit_offset`
- `wlogit_tile_stride`

`*_base_addr` style fields are no longer the active interface.

### 2. Shared generated test data

`HLS-Verilog/test_data/gen_ddr_image.py` generates:

- `ctrl_mem.bin`
- `ddr_image.bin`
- `stream_in.bin`
- `generated_mem_map.svh`

These are used by:

- `HLS-Verilog/top_DEBUG_tb.cpp`
- `HLS-Verilog/Verilog-top-module/MMU_Top_module_Integration/Top_module_hls_tb.sv`

### 3. Control struct layout alignment fixed

The order of `ControlMemSpace` is now correctly reflected in:

- `HLS-Verilog/top_DEBUG_tb.cpp` (`load_shared_ctrl_mem`)
- `HLS-Verilog/Verilog-top-module/MMU_Top_module_Integration/Top_module_hls_tb.sv`

Important corrected positions in the 56-word control image:

- `wlogit_tile_stride` = word `21`
- `wlogit_offset` = word `48`

### 4. New logits / argmax path added

After final norm, the pipeline now supports:

- `CMP_LOGITS`
- `CMP_ARGMAX`

And scheduler states:

- `S_LOGITS`
- `S_ARGMAX`

Files changed for this:

- `HLS-Verilog/top_params.hpp`
- `HLS-Verilog/Compute_Controller_Logic/src-hls/compute_controller.cpp`
- `HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_FSM.cpp`
- `HLS-Verilog/MMU/mmu_luka.cpp`

The flow is now:

`FINAL_NORM -> LOGITS -> ARGMAX -> STREAM_OUT`

### 5. MMU storage was refactored to word-addressed URAM

`MMU/mmu_luka.cpp` was refactored from byte-addressed URAM storage to word-addressed storage:

- `uram_banks` is now `axi_gmem_word_t` based
- region read/write logic bridges byte-level logical accesses onto word-based URAM entries

This solved the earlier issue where the large MMU store was not inferring URAM properly.

### 6. Chunked DMA transfer model added

The design no longer requires every logical DMA transfer to fit entirely in the top-level DMA buffer.

Instead:

- `TOP_DMA_BUF_BYTES` is treated as chunk size
- large logical MMU transfers are split into multiple DMA chunks
- chunks are written incrementally into URAM

Files changed:

- `HLS-Verilog/top.hpp`
- `HLS-Verilog/top.cpp`
- `HLS-Verilog/MMU/mmu_luka.cpp`

### 7. Compute controllers were refactored to bounded micro-tile storage

The compute engines no longer materialize many full-dimension temporary arrays.

#### Main controller

`HLS-Verilog/Compute_Controller_Logic/src-hls/compute_controller.cpp`

Refactored:

- LayerNorm paths to direct-to-buffer tile processing
- Residual add to direct-to-buffer
- FFN activation to direct-to-buffer
- Main matmul paths (`OUT_PROJ`, `FFN_W1`, `FFN_W2`, `LOGITS`) now use bounded `MAC_OP_TO_BUF(...)`

This removed large arrays like:

- `vectorA`
- `matrixB`
- `bias`
- `out`
- `x_act`
- `ln_gamma`
- `ffn_gate`
- `ffn_up`
- etc.

#### Headed controller

`HLS-Verilog/Compute_Controller_Logic/src-hls/headed_compute_controller.cpp`

Refactored:

- `Q/K/V`
- `ATT_SCORES`
- `VALUE_SCALE`
- `SOFTMAX`
- `ATT_VALUE`
- `HEAD_REQUANT`

to bounded tile/direct-to-buffer logic.

The large persistent headed matrix/state arrays were removed from the active data path.

## Current Integration TB State

Primary SV TB:

- `HLS-Verilog/Verilog-top-module/MMU_Top_module_Integration/Top_module_hls_tb.sv`

This TB has:

- control image support for 56-word `ctrl_mem.bin`
- generated mem map include
- decoded `*_out` arrays for main and headed ops
- decoded `*_in` arrays for main and headed ops
- new decoded arrays for logits path:
  - `wlogit_act_in`
  - `wlogit_w_in`
  - `wlogit_b_in`
  - `argmax_in`
  - `wlogit_out`
  - `wlogit_out_by_tile`
  - `argmax_out`

It also now has:

- `dbg_main_in_decode_pulse`

which pulses when the TB decodes/writes the main `*_in` arrays.

## Current Blocker

### Problem

The main decoded input arrays (`ln0_in`, `ln0_gamma_in`, etc.) were previously being captured too late.

Observed behavior:

- `dbg_in_buf_mem` holds correct input data earlier
- by the time the old capture event occurred, much of the debug mirror had already been overwritten or zeroed
- outputs (`ln0_out`, etc.) still looked correct because the DUT had consumed valid input earlier

### New Fix Attempt Already Applied

The TB was changed to stop using `WAIT_MEM -> EXECUTE` as the main input capture trigger.

Instead, it now uses:

- arm on main op issue (`main_in_capture_pending`)
- keep updating `dbg_in_buf_mem`
- when `dbg_in_buf_we0 && dbg_in_buf_address0 == main_input_last_addr(main_in_pending_op)`:
  - decode immediately
  - pulse `dbg_main_in_decode_pulse`
  - clear pending

Two helpers were added:

- `main_input_last_addr(op)`  
  returns the last required input byte index for each main op

- `main_dbg_in_byte(idx, write_en, write_addr, write_data)`  
  returns the just-written byte on the current cycle if the requested index matches the current write address, otherwise returns `dbg_in_buf_mem[idx]`

This is the correct architectural direction.

### Remaining Issue

The file now compiles, but `xvlog` still gives warnings:

- `select on function call violates IEEE 1800 syntax`

These come from patterns like:

- `main_dbg_in_byte(...)[7:4]`
- `main_dbg_in_byte(...)[3:0]`

This is only a warning, not a compile failure.

The clean fix is:

- replace nibble selection on function calls with a temporary byte variable inside each decode block, e.g.
  - `logic [7:0] packed_byte;`
  - `packed_byte = main_dbg_in_byte(...);`
  - then use `packed_byte[7:4]` / `packed_byte[3:0]`

This has **not** been done yet.

## Important Files to Inspect Next

- `HLS-Verilog/Verilog-top-module/MMU_Top_module_Integration/Top_module_hls_tb.sv`
  - current focus
  - verify the new main-input capture is actually working at runtime
  - clean up the `select on function call` warnings

- `HLS-Verilog/top_params.hpp`
  - source of truth for all enums/layouts/ControlMemSpace

- `HLS-Verilog/test_data/gen_ddr_image.py`
  - source of test vectors + control image + generated mem map

- `HLS-Verilog/top_DEBUG_tb.cpp`
  - useful reference for expected functional behavior and control image parsing

## Next Recommended Steps

1. In `Top_module_hls_tb.sv`, clean up the `main_dbg_in_byte(...)[7:4]/[3:0]` warnings by introducing temporary packed-byte variables in the int4 decode loops.

2. Re-run SV sim and confirm:
   - `dbg_main_in_decode_pulse` fires on the final debug write for each main op
   - `ln0_in`, `ln0_gamma_in`, `ln0_eps_in` match the earlier valid raw `dbg_in_buf_mem`

3. If needed, add a temporary `$display` at the main decode point printing:
   - `main_in_pending_op`
   - `dbg_in_buf_address0`
   - first 16 bytes of `dbg_in_buf_mem`
   - `dbg_main_in_decode_pulse`

4. After the main `*_in` capture is verified, update the wave TCL if desired to include:
   - `wlogit_*`
   - `argmax_*`

## Prompt For The New Chat

Use this prompt in the new chat:

> We are continuing from a long prior session on `ELEC_498-Capstone-LiteLM`. Read `CHAT_HANDOFF.md` first. The immediate task is to continue debugging `HLS-Verilog/Verilog-top-module/MMU_Top_module_Integration/Top_module_hls_tb.sv`. We already changed main input capture to trigger on the last debug write (`dbg_in_buf_we0 && dbg_in_buf_address0 == main_input_last_addr(main_in_pending_op)`) instead of `WAIT_MEM -> EXECUTE`. The current file compiles, but `xvlog` emits IEEE warnings because there are nibble selects on `main_dbg_in_byte(...)` function calls. Clean that up using temporary byte variables, then validate that the main decoded input arrays (`ln0_in`, `ln0_gamma_in`, etc.) now capture the correct values at `dbg_main_in_decode_pulse`. Do not undo the new control-memory layout, logits/argmax support, or offset-only addressing.

