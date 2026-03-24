# phi3-mini-int4-HARDWARE (Legacy — Did Not Work)

> **This architecture was abandoned and did not result in a functioning accelerator.**
> It represents an attempt to target the Phi-3 Mini model using INT4 quantization on FPGA. The design added rotary positional embeddings (RoPE) and deeper requantization calibration on top of the GPT-2 end-to-end architecture, but was ultimately not viable. It was superseded by the MatMul-mode GPT-2 architecture in `gpt2-MatMulMode/`.

---

## Directory Overview

```
phi3-mini-int4-HARDWARE/
├── top*.cpp / top*.hpp  — Top-level HLS entry points and testbenches (at root)
├── shared_params.hpp    — Shared architecture constants
├── requant_scales_*.hpp — Per-layer INT4 requantization scales (4 calibration versions)
├── rope_lut_full_q15.hpp— Rotary positional embedding (RoPE) look-up table
├── HLS-Verilog/         — HLS submodule implementations and generated RTL
├── logs/                — C-simulation and integration testbench logs
└── quantize/            — INT4 quantization parameter files for Phi-3 Mini
```

---

## Root-Level Files

### Top-Level Implementation

| File | Purpose |
|------|---------|
| `top.hpp` / `top.cpp` | Debug-enabled top-level HLS entry point |
| `top_no_debug.hpp` / `top_no_debug.cpp` | Production top-level (debug ports stripped) |
| `top_DEBUG_tb.cpp` | Single-token debug testbench |
| `top_DEBUG_multiple_token_tb.cpp` | Multi-token debug testbench |
| `top_no_debug_tb.cpp` | Single-token production testbench |
| `top_no_debug_multiple_token_tb.cpp` | Multi-token production testbench |

### Configuration & Parameters

| File | Purpose |
|------|---------|
| `top_params.hpp` | Architecture constants: tile sizes, context length, head count, data widths |
| `shared_params.hpp` | Parameters shared across modules to avoid circular includes |
| `requant_scales_v0/v1/v2/v3.hpp` | Per-layer INT4 requantization scales across four calibration iterations |
| `rope_lut_full_q15.hpp` | Pre-computed RoPE (Rotary Positional Embedding) cosine/sine LUT in Q15 fixed-point, used by Phi-3's attention |
| `tb_paths.hpp` | Filesystem paths to binary test fixtures |
| `tb_model_bin_loader.hpp` | Utility for loading quantized weights into testbench arrays |

---

## `./HLS-Verilog/`

HLS C++ submodules, each with its own implementation and C-simulation testbenches.

### `./HLS-Verilog/Scheduler_FSM/src-hls/`
Central control FSM — sequences every compute stage and data transfer across a full transformer forward pass.

| File | Purpose |
|------|---------|
| `Scheduler_FSM.hpp` | State enums, constants, and function prototypes |
| `Scheduler_FSM.cpp` | Main FSM: drives LN → MATMUL → FFN → LOGITS → ARGMAX and headed attention path |
| `Scheduler_tb.cpp` | C-sim testbench for the scheduler |
| `Head_Helpers/head_helpers.hpp` | Types and prototypes for parallel attention head helpers |
| `Head_Helpers/head_helpers.cpp` | Shared-resource manager modeling concurrent multi-head access to the compute block |
| `Head_Helpers/drive_head_phase_tb.cpp` | Isolated testbench for head-phase scheduling logic |

### `./HLS-Verilog/Compute_Controller_Logic/src-hls/`
Shared compute block: matrix-multiply, layer norm, requant, and activations.

| File | Purpose |
|------|---------|
| `compute_controller.hpp` / `.cpp` | Standard (non-headed) compute controller |
| `headed_compute_controller.hpp` / `.cpp` | Extended variant for per-head Q/K/V operations with RoPE integration |
| `computer_controller_tb.cpp` | General compute controller testbench |
| `computer_controller_layer_norm_tb.cpp` | Focused layer-norm correctness testbench |
| `headed_computer_controller_tb.cpp` | Headed compute testbench |
| `headed_compute_controller_parallel_tb.cpp` | Testbench for parallel headed execution |

### `./HLS-Verilog/MMU/`
Memory Management Unit — DMA staging between DDR (AXI-full) and on-chip scratchpads.

| File | Purpose |
|------|---------|
| `mmu_luka.hpp` | Buffer declarations and function prototypes |
| `mmu_luka.cpp` | FSM-driven burst read/write logic |
| `mmu_luka_tb.cpp` | C-sim testbench for address generation and data movement |

### `./HLS-Verilog/ControlMemInterface/`
Interface to on-chip control memory storing layer configurations, weight addresses, and tile descriptors.

| File | Purpose |
|------|---------|
| `ControlMemInterface.hpp` | Address map definitions and prototypes |
| `ControlMemInterface_tb.cpp` | Read/write access testbench |
| `ControlTest_Top.cpp` | Top-level integration test for the control interface |
| `Verilog/ControlTest_Top.v` | HLS-generated Verilog for the control interface |
| `Verilog/ControlTest_Top_control_s_axi.v` | Generated AXI-Lite slave register block |

### `./HLS-Verilog/test_data/`
Scripts and pre-generated binary fixtures used by all testbenches.

| File | Purpose |
|------|---------|
| `gen_ddr_image.py` | Packs quantized weights/biases into a flat DDR memory image |
| `gen_stream_in_from_embeddings.py` | Serializes a token embedding into AXI-stream format |
| `test_gpt2_int8.py` | Software INT8 reference model for generating golden outputs |
| `ddr_image.bin` / `ddr_image.hex` | Pre-generated DDR image (binary and hex for Vivado) |
| `stream_in.bin` | Pre-generated AXI-stream input payload |
| `ctrl_mem.bin` | Pre-generated control memory image |
| `generated_params.svh` | Auto-generated SystemVerilog `define` constants |
| `generated_mem_map.svh` | Auto-generated SystemVerilog memory-map base addresses |
| `From_Andy/test_vectors_4_layers/` | Per-layer test vectors from an earlier design handoff (L0_b1_t0.bin, etc.) |

### `./HLS-Verilog/Verilog-top-module/`
HLS-generated RTL outputs and SystemVerilog integration testbenches. Multiple snapshot directories reflect iterative debugging.

| Path | Purpose |
|------|---------|
| `MMU_Top_module_Integration/Top_module_hls_tb.sv` | SV integration testbench with MMU in the loop |
| `MMU_Top_module_Integration/verilog/` | ~250 HLS-generated Verilog files for this integration |
| `Top_Module_Integration-NO-DEBUG-PORTS/Top_module_hls_tb.sv` | SV integration testbench without debug ports |
| `Top_Module_Integration-NO-DEBUG-PORTS/verilog/` | Primary synthesis output (~316 files) |
| `Top_Module_Integration-NO-DEBUG-PORTS/verilog-working/` | Snapshot of a state where simulation partially passed |
| `Top_Module_Integration-NO-DEBUG-PORTS/verilog-working1/` | Second working snapshot |
| `Top_Module_Integration-NO-DEBUG-PORTS/verilog-working2/` | Third working snapshot |
| `Top_Module_Integration-NO-DEBUG-PORTS/verilog-BROKEN-output-1/` | Explicitly-labeled broken synthesis output, kept for debugging reference |
| `Top_module_Integration_Testing/` | Separate SV testbench variant used for targeted integration tests |

---

## `./logs/`
Captured stdout/stderr from C-simulation runs across all modules.

| Path | Contents |
|------|---------|
| `compute_controller_tb/` | Compute controller C-sim logs |
| `mmu_luka_tb/` | MMU C-sim logs |
| `scheduler_tb/` | Scheduler FSM C-sim logs |
| `top_DEBUG/` | Debug top-level C-sim logs (single token, multi-session) |
| `top_no_debug_multiple_token/` | Multi-token production testbench logs |
| `headed_compute_controller_tb/` | Headed compute controller logs (empty — runs not captured) |

---

## `./quantize/`
INT4 quantization parameters specific to Phi-3 Mini.

| File | Purpose |
|------|---------|
| `phi3_quantization_params.json` | Per-layer INT4 scale and zero-point factors for Phi-3 Mini |
| `fpga_requant_scales_v2.json` | Requantization scales calibrated for FPGA fixed-point pipeline (v2) |
| `fpga_requant_scales_fixed.json` | Final fixed requantization scale values after calibration |
| `fpga_requant_scales1.json` | Earlier requantization scale iteration |
| `phi3-mini-int4/config.json` | Phi-3 Mini model configuration (architecture hyperparameters) |
