# gpt2-MatMulMode

This is the active FPGA accelerator design for GPT-2 inference using INT8 per-tensor quantization. The architecture operates in MatMul mode — all transformer operations (attention, FFN, layer norm, logits) are executed through a shared matrix-multiply compute block, tiled over context and head dimensions, controlled by a central Scheduler FSM.

**Firmware** (ARM PS-side inference engine) is located at:
[`/firmware/`](../../../../firmware)

---

## Directory Overview

```
gpt2-MatMulMode/
├── HLS-Verilog/   — HLS C++ hardware design: modules, testbenches, and generated RTL
├── logs/          — C-simulation and integration testbench run logs
└── model/         — Quantized GPT-2 weights, embeddings, and tokenizer data
```

---

## `./HLS-Verilog/`

HLS C++ source for all hardware modules. Each subdirectory is a standalone module with its own implementation and C-simulation testbenches.

### Root-level files

| File | Purpose |
|------|---------|
| `top_params.hpp` | Primary architecture constants: tile sizes, context length, head count, data widths, stream depths |
| `shared_params.hpp` | Parameters shared across modules to avoid circular includes |
| `top_no_debug.hpp` / `.cpp` | Top-level HLS entry point (debug ports stripped), wires all submodules to AXI-stream I/O, DDR, and control memory |
| `requant_scales_v0.hpp` | Per-layer INT8 requantization scale factors |
| `tb_paths.hpp` | Filesystem paths to binary test fixtures used by testbenches |
| `tb_model_bin_loader.hpp` | Utility for loading quantized weights and activations into testbench arrays |
| `matmul_mode_tb.cpp` | C-simulation testbench for the full top-level design |
| `verify_matmul.py` | Python script to compare testbench output against a reference software model |

### `./HLS-Verilog/Scheduler_FSM/src-hls/`
Central control FSM — sequences every compute stage and data transfer across a full transformer forward pass.

| File | Purpose |
|------|---------|
| `Scheduler_FSM.hpp` | State enums, constants, and function prototypes |
| `Scheduler_FSM.cpp` | Main FSM: drives LN → OUT_PROJ → FFN → LOGITS → ARGMAX on the main path and Q/K/V → ATT_SCORES → SOFTMAX → ATT_VALUE on the attention path; coordinates headed helper FSMs |

### `./HLS-Verilog/Compute_Controller_Logic/src-hls/`
Shared compute block executing MATMUL, layer norm, requantization, and activation functions. Operated as a slave by the Scheduler FSM.

| File | Purpose |
|------|---------|
| `compute_controller.hpp` / `.cpp` | Main HLS implementation: matrix multiply, layer norm, requant, non-linear activations |
| `computer_controller_tb.cpp` | General compute controller C-sim testbench |
| `computer_controller_layer_norm_tb.cpp` | Focused layer-norm correctness testbench |

### `./HLS-Verilog/MMU/`
Memory Management Unit — DMA staging between DDR (AXI-full) and on-chip scratchpad buffers.

| File | Purpose |
|------|---------|
| `mmu_luka.hpp` | Buffer declarations and function prototypes |
| `mmu_luka.cpp` | FSM-driven burst read/write logic between DDR and on-chip buffers |
| `mmu_luka_tb.cpp` | C-sim testbench verifying address generation and data movement |

### `./HLS-Verilog/ControlMemInterface/`
Interface to on-chip control memory storing layer configurations, weight addresses, and tile descriptors.

| File | Purpose |
|------|---------|
| `ControlMemInterface.hpp` | Address map definitions and read/write function prototypes |
| `ControlMemInterface_tb.cpp` | Read/write access testbench |
| `ControlTest_Top.cpp` | Top-level integration test for the control interface |
| `Verilog/ControlTest_Top.v` | HLS-generated Verilog for the control interface |
| `Verilog/ControlTest_Top_control_s_axi.v` | Generated AXI-Lite slave register block |

### `./HLS-Verilog/test_data/`
Scripts and pre-generated binary fixtures used by all testbenches.

| File | Purpose |
|------|---------|
| `gen_ddr_image.py` | Packs quantized GPT-2 weights/biases into a flat DDR memory image following the accelerator's memory map |
| `gen_stream_in_from_embeddings.py` | Serializes a token embedding into the AXI-stream format expected by the top-level |
| `test_gpt2_int8.py` | End-to-end software reference: runs INT8 GPT-2 and dumps intermediate activations for comparison |
| `ddr_image.bin` / `ddr_image.hex` | Pre-generated DDR memory image (binary and hex for Vivado memory initialization) |
| `stream_in.bin` | Pre-generated AXI-stream input payload (token embedding) |
| `ctrl_mem.bin` | Pre-generated control memory image (tile descriptors, layer configs) |
| `generated_params.svh` | Auto-generated SystemVerilog `define` constants from `top_params.hpp` |
| `generated_mem_map.svh` | Auto-generated SystemVerilog memory-map base addresses and offsets |

---

## `./logs/`

Captured stdout/stderr from C-simulation and synthesis runs.

| Path | Contents |
|------|---------|
| `Top_Module_MATMUL_ARCH/matmul_mode_tb_stdout/stderr_*.log` | Timestamped top-level C-sim run logs |
| `Top_Module_MATMUL_ARCH/csim.log` | Vitis HLS C-simulation summary log |
| `Top_Module_MATMUL_ARCH/synth.logs` | HLS synthesis report log |

---

## `./model/`

Quantized GPT-2 small (124M) weights and tokenizer data. All weights are INT8 per-tensor quantized.

| File | Purpose |
|------|---------|
| `gpt2_weights_int8.bin` | All 12-layer transformer weights quantized to INT8, packed in DDR layout order |
| `embed_tokens.bin` / `embed_tokens_float.bin` | Token embedding table (INT8 and float32 reference) |
| `pos_embed.bin` / `pos_embed_float.bin` | Positional embedding table (INT8 and float32 reference) |
| `stream_in.bin` | Pre-packed AXI-stream input (copy of `test_data/stream_in.bin`, kept here for firmware use) |
| `layout.txt` | DDR memory map: base address and byte size for every weight tensor; also lists calibrated per-layer effective scales |
| `quant_scales.json` | Per-tensor quantization scale factors (used during model export) |
| `requant_scales_v0.hpp` / `requant_scales_v0_calibrated.hpp` | Layer-wise requantization scales as C++ headers for testbench inclusion |
| `vocab.json` / `vocab.txt` / `merges.txt` | GPT-2 BPE tokenizer vocabulary and merge rules |
| `tokenizer.json` / `tokenizer_config.json` | Full tokenizer configuration |
| `special_tokens_map.json` | Special token definitions (BOS, EOS, PAD) |
| `vocab_verify.py` | Script to sanity-check vocabulary file consistency |

---

## Firmware

The PS-side (ARM Cortex-A) inference engine that loads the bitstream, drives the accelerator via AXI, and handles tokenization is maintained separately at:

**[`/firmware/`](../../../../firmware)**

| Path | Purpose |
|------|---------|
| `firmware/inference_engine/include/` | Headers: DMA buffer management, PL interface, tokenizer, performance monitor, error handler, type definitions |
| `firmware/inference_engine/src/inference_engine.cpp` | Main inference loop: loads model into DDR, streams token embeddings to PL, reads output token ID |
| `firmware/inference_engine/src/pl_interface.cpp` | Low-level AXI register and DMA interface to the PL fabric |
| `firmware/linux_boot_files/boot.cmd` | U-Boot boot script |
| `firmware/linux_boot_files/system.dts` | System device tree source |
| `firmware/udmabuf/` | Third-party Linux kernel module for user-space DMA buffer allocation |
| `firmware/dependencies/` | Pre-built AArch64 cross-compilation toolchain and Linux sysroot |
| `firmware/Makefile` | Builds the inference engine binary for ARM64 |
