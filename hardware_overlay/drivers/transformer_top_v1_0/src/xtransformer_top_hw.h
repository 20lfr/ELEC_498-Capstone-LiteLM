// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
// control
// 0x000 : Control signals
//         bit 0  - ap_start (Read/Write/COH)
//         bit 1  - ap_done (Read/COR)
//         bit 2  - ap_idle (Read)
//         bit 3  - ap_ready (Read/COR)
//         bit 7  - auto_restart (Read/Write)
//         bit 9  - interrupt (Read)
//         others - reserved
// 0x004 : Global Interrupt Enable Register
//         bit 0  - Global Interrupt Enable (Read/Write)
//         others - reserved
// 0x008 : IP Interrupt Enable Register (Read/Write)
//         bit 0 - enable ap_done interrupt (Read/Write)
//         bit 1 - enable ap_ready interrupt (Read/Write)
//         others - reserved
// 0x00c : IP Interrupt Status Register (Read/TOW)
//         bit 0 - ap_done (Read/TOW)
//         bit 1 - ap_ready (Read/TOW)
//         others - reserved
// 0x010 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[31:0] (Read/Write)
// 0x014 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[63:32] (Read/Write)
// 0x018 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[95:64] (Read/Write)
// 0x01c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[127:96] (Read/Write)
// 0x020 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[159:128] (Read/Write)
// 0x024 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[191:160] (Read/Write)
// 0x028 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[223:192] (Read/Write)
// 0x02c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[255:224] (Read/Write)
// 0x030 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[287:256] (Read/Write)
// 0x034 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[319:288] (Read/Write)
// 0x038 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[351:320] (Read/Write)
// 0x03c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[383:352] (Read/Write)
// 0x040 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[415:384] (Read/Write)
// 0x044 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[447:416] (Read/Write)
// 0x048 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[479:448] (Read/Write)
// 0x04c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[511:480] (Read/Write)
// 0x050 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[543:512] (Read/Write)
// 0x054 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[575:544] (Read/Write)
// 0x058 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[607:576] (Read/Write)
// 0x05c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[639:608] (Read/Write)
// 0x060 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[671:640] (Read/Write)
// 0x064 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[703:672] (Read/Write)
// 0x068 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[735:704] (Read/Write)
// 0x06c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[767:736] (Read/Write)
// 0x070 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[799:768] (Read/Write)
// 0x074 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[831:800] (Read/Write)
// 0x078 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[863:832] (Read/Write)
// 0x07c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[895:864] (Read/Write)
// 0x080 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[927:896] (Read/Write)
// 0x084 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[959:928] (Read/Write)
// 0x088 : reserved
// 0x100 ~
// 0x17f : Memory 'status_mem' (21 * 32b)
//         Word n : bit [31:0] - status_mem[n]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XTRANSFORMER_TOP_CONTROL_ADDR_AP_CTRL         0x000
#define XTRANSFORMER_TOP_CONTROL_ADDR_GIE             0x004
#define XTRANSFORMER_TOP_CONTROL_ADDR_IER             0x008
#define XTRANSFORMER_TOP_CONTROL_ADDR_ISR             0x00c
#define XTRANSFORMER_TOP_CONTROL_ADDR_CTRL_MEM_DATA   0x010
#define XTRANSFORMER_TOP_CONTROL_BITS_CTRL_MEM_DATA   960
#define XTRANSFORMER_TOP_CONTROL_ADDR_CTRL_MEM_DATA_  0x038
#define XTRANSFORMER_TOP_CONTROL_BITS_CTRL_MEM_DATA   960
#define XTRANSFORMER_TOP_CONTROL_ADDR_STATUS_MEM_BASE 0x100
#define XTRANSFORMER_TOP_CONTROL_ADDR_STATUS_MEM_HIGH 0x17f
#define XTRANSFORMER_TOP_CONTROL_WIDTH_STATUS_MEM     32
#define XTRANSFORMER_TOP_CONTROL_DEPTH_STATUS_MEM     21

// control_r
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of ddr_mem
//        bit 31~0 - ddr_mem[31:0] (Read/Write)
// 0x14 : Data signal of ddr_mem
//        bit 31~0 - ddr_mem[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of kv_cache
//        bit 31~0 - kv_cache[31:0] (Read/Write)
// 0x20 : Data signal of kv_cache
//        bit 31~0 - kv_cache[63:32] (Read/Write)
// 0x24 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XTRANSFORMER_TOP_CONTROL_R_ADDR_DDR_MEM_DATA  0x10
#define XTRANSFORMER_TOP_CONTROL_R_BITS_DDR_MEM_DATA  64
#define XTRANSFORMER_TOP_CONTROL_R_ADDR_KV_CACHE_DATA 0x1c
#define XTRANSFORMER_TOP_CONTROL_R_BITS_KV_CACHE_DATA 64

