# gpt2-endTOend-HARDWARE (Legacy — Did Not Work)

> **This architecture was abandoned and did not result in a functioning accelerator.**
> It represents an earlier, full end-to-end attempt at running GPT-2 on FPGA that includes firmware, hardware overlays, and a full Linux boot stack alongside the HLS design. The design was superseded by the MatMul-mode architecture in `gpt2-MatMulMode/`.

---

## Directory Overview

```
gpt2-endTOend-HARDWARE/
├── HLS-Verilog/        — HLS C++ design source and generated RTL
├── firmware/           — ARM Linux firmware for PS-side inference control
├── hardware_overlay/   — FPGA bitstream, device trees, and IP drivers
├── logs/               — C-simulation and integration testbench logs
└── model/              — Quantized GPT-2 weights, embeddings, and tokenizer
```

---

## `./HLS-Verilog/`

Core hardware design in HLS C++. Each subdirectory is a hardware module with its own implementation and C-simulation testbenches.

### Root-level files

| File | Purpose |
|------|---------|
| `top_params.hpp` | Architecture constants: tile sizes, context length, head count, data widths |
| `shared_params.hpp` | Parameters shared across modules to avoid circular includes |
| `top_no_debug.hpp` / `.cpp` | Top-level HLS entry point (debug ports stripped), wires all submodules |
| `requant_scales_v0/v1/v2.hpp` | Per-layer INT8 requantization scale factors (three calibration iterations) |
| `tb_paths.hpp` | Filesystem paths to binary test fixtures used by testbenches |
| `tb_model_bin_loader.hpp` | Utility for loading quantized weights/activations into testbench arrays |
| `top_no_debug_tb.cpp` | Single-token C-sim testbench for the top-level |
| `top_no_debug_multiple_token_tb.cpp` | Multi-token C-sim testbench |

### `./HLS-Verilog/Scheduler_FSM/src-hls/`
Central control FSM — sequences every compute stage and data transfer across a full transformer forward pass.

| File | Purpose |
|------|---------|
| `Scheduler_FSM.hpp` | State enums, constants, and function prototypes |
| `Scheduler_FSM.cpp` | Main FSM logic: drives LN → MATMUL → FFN → LOGITS → ARGMAX and attention path; calls head helpers |
| `Scheduler_tb.cpp` | C-sim testbench for the scheduler |
| `Head_Helpers/head_helpers.hpp` | Types and prototypes for parallel attention head helpers |
| `Head_Helpers/head_helpers.cpp` | Shared-resource manager modeling concurrent multi-head access to the compute block |
| `Head_Helpers/drive_head_phase_tb.cpp` | Isolated testbench for head-phase scheduling logic |

### `./HLS-Verilog/Compute_Controller_Logic/src-hls/`
Shared compute block: executes matrix-multiply, layer norm, requant, and activations.

| File | Purpose |
|------|---------|
| `compute_controller.hpp` / `.cpp` | Standard (non-headed) compute controller |
| `headed_compute_controller.hpp` / `.cpp` | Extended variant supporting per-head Q/K/V compute |
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
| `test_gpt2_int8.py` | Software reference: runs INT8 GPT-2 and dumps intermediate activations |
| `ddr_image.bin` / `ddr_image.hex` | Pre-generated DDR memory image (binary and hex for Vivado) |
| `stream_in.bin` | Pre-generated AXI-stream input payload |
| `ctrl_mem.bin` | Pre-generated control memory image |
| `generated_params.svh` | Auto-generated SystemVerilog `define` constants from `top_params.hpp` |
| `generated_mem_map.svh` | Auto-generated SystemVerilog memory-map base addresses |
| `From_Andy/` | Legacy test vectors from a prior design handoff |

### `./HLS-Verilog/Verilog-top-module/Top_Module_Integration-NO-DEBUG-PORTS/`
RTL integration testbench and HLS-generated Verilog output.

| File/Dir | Purpose |
|----------|---------|
| `Top_module_hls_tb.sv` | SystemVerilog integration testbench |
| `errors.txt` | Captured compilation/simulation error log |
| `verilog/` | ~307 HLS-generated Verilog files (primary synthesis run) |
| `verilog1/` | ~313 HLS-generated Verilog files (alternative/updated synthesis run) |

### `./HLS-Verilog/OLD-Top_Modules/`
Superseded top-level implementations kept for reference.

| File | Purpose |
|------|---------|
| `top.hpp` / `top.cpp` | Earlier top-level with debug ports still enabled |
| `top_DEBUG_tb.cpp` | Debug testbench for the old top module (single token) |
| `top_DEBUG_multiple_token_tb.cpp` | Debug testbench for multi-token inference |

---

## `./firmware/`
ARM Cortex-A PS-side software stack for controlling the accelerator from Linux.

| Path | Purpose |
|------|---------|
| `inference_engine/include/` | Headers: DMA buffer management, PL interface, tokenizer, performance monitor, error handler |
| `inference_engine/src/inference_engine.cpp` | Main inference loop: loads model, drives PL via AXI, processes output tokens |
| `inference_engine/src/pl_interface.cpp` | Low-level register/DMA interface to the PL fabric |
| `linux_boot_files/boot.cmd` | U-Boot boot script |
| `linux_boot_files/system.dts` | System device tree source |
| `udmabuf/` | Third-party Linux kernel module for user-space DMA buffer allocation |
| `dependencies/` | Pre-built AArch64 cross-compilation toolchain and Linux sysroot (large) |
| `Makefile` | Builds the inference engine binary for ARM64 |

---

## `./hardware_overlay/`
FPGA bitstream, device tree outputs, and Xilinx IP drivers.

| Path | Purpose |
|------|---------|
| `design_1_wrapper.bit` | Compiled FPGA bitstream (full design) |
| `design_1_wrapper.xsa` | Vivado exported hardware specification |
| `bitstream.bif` | Bitstream information file for bootgen |
| `psu_init.*` | Zynq UltraScale+ PS initialization scripts and headers |
| `generate_dts.tcl` | TCL script to generate device tree from XSA |
| `dts_output/` | Generated device tree files: system-top.dts, pl.dtsi, pcw.dtsi, zynqmp.dtsi |
| `device-tree-xlnx/` | Xilinx device tree binding library (full repo, 80+ IP blocks) |
| `drivers/transformer_top_v1_0/` | Custom Xilinx IP driver for the transformer top module (C + Linux variant) |
| `drivers/axi_top_v1_0/` | AXI top-level hardware register header |
| `output/load_hw.sh` | Script to load the bitstream and device tree overlay at runtime |

---

## `./logs/`
Captured stdout/stderr from C-simulation and SystemVerilog integration runs.

| Path | Contents |
|------|---------|
| `Top_module_hls_tb/` | SV integration testbench logs |
| `top_no_debug_multiple_token/` | Multi-token top-level C-sim logs (multiple requant scale variants) |

---

## `./model/`
Quantized GPT-2 small weights and tokenizer data.

| File | Purpose |
|------|---------|
| `gpt2_weights_int8.bin` | All layer weights quantized to INT8 |
| `embed_tokens.bin` / `embed_tokens_float.bin` | Token embedding table (quantized and float reference) |
| `pos_embed.bin` / `pos_embed_float.bin` | Positional embedding table (quantized and float reference) |
| `quant_scales.json` | Per-tensor quantization scale factors |
| `requant_scales_v0.hpp` / `requant_scales_v0_calibrated.hpp` | Layer-wise requantization scales as C++ headers |
| `vocab.json` / `vocab.txt` / `merges.txt` | GPT-2 BPE tokenizer vocabulary and merge rules |
| `tokenizer.json` / `tokenizer_config.json` | Full tokenizer configuration |
| `special_tokens_map.json` | Special token definitions (BOS, EOS, PAD) |
| `vocab_verify.py` | Script to sanity-check vocabulary consistency |
