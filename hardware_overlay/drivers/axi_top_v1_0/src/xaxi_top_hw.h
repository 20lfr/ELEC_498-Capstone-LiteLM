// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[31:0] (Read/Write)
// 0x14 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[63:32] (Read/Write)
// 0x18 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[95:64] (Read/Write)
// 0x1c : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[127:96] (Read/Write)
// 0x20 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[159:128] (Read/Write)
// 0x24 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[191:160] (Read/Write)
// 0x28 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[223:192] (Read/Write)
// 0x2c : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[255:224] (Read/Write)
// 0x30 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[287:256] (Read/Write)
// 0x34 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[319:288] (Read/Write)
// 0x38 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[351:320] (Read/Write)
// 0x3c : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[383:352] (Read/Write)
// 0x40 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[415:384] (Read/Write)
// 0x44 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[447:416] (Read/Write)
// 0x48 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[479:448] (Read/Write)
// 0x4c : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[511:480] (Read/Write)
// 0x50 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[543:512] (Read/Write)
// 0x54 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[575:544] (Read/Write)
// 0x58 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[607:576] (Read/Write)
// 0x5c : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[639:608] (Read/Write)
// 0x60 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[671:640] (Read/Write)
// 0x64 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[703:672] (Read/Write)
// 0x68 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[735:704] (Read/Write)
// 0x6c : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[767:736] (Read/Write)
// 0x70 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[799:768] (Read/Write)
// 0x74 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[831:800] (Read/Write)
// 0x78 : Data signal of ctrl_mem
//        bit 31~0 - ctrl_mem[863:832] (Read/Write)
// 0x7c : reserved
// 0x80 : Data signal of status_mem
//        bit 31~0 - status_mem[31:0] (Read)
// 0x84 : Data signal of status_mem
//        bit 31~0 - status_mem[63:32] (Read)
// 0x88 : Data signal of status_mem
//        bit 31~0 - status_mem[95:64] (Read)
// 0x8c : Data signal of status_mem
//        bit 31~0 - status_mem[127:96] (Read)
// 0x90 : Data signal of status_mem
//        bit 31~0 - status_mem[159:128] (Read)
// 0x94 : Data signal of status_mem
//        bit 31~0 - status_mem[191:160] (Read)
// 0x98 : Control signal of status_mem
//        bit 0  - status_mem_ap_vld (Read/COR)
//        others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XAXI_TOP_CONTROL_ADDR_AP_CTRL         0x00
#define XAXI_TOP_CONTROL_ADDR_GIE             0x04
#define XAXI_TOP_CONTROL_ADDR_IER             0x08
#define XAXI_TOP_CONTROL_ADDR_ISR             0x0c
#define XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA   0x10
#define XAXI_TOP_CONTROL_BITS_CTRL_MEM_DATA   864
#define XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA_  0x38
#define XAXI_TOP_CONTROL_BITS_CTRL_MEM_DATA   864
#define XAXI_TOP_CONTROL_ADDR_STATUS_MEM_DATA 0x80
#define XAXI_TOP_CONTROL_BITS_STATUS_MEM_DATA 192
#define XAXI_TOP_CONTROL_ADDR_STATUS_MEM_CTRL 0x98

// control_r
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of ddr_weights
//        bit 31~0 - ddr_weights[31:0] (Read/Write)
// 0x14 : Data signal of ddr_weights
//        bit 31~0 - ddr_weights[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of ddr_kvcache
//        bit 31~0 - ddr_kvcache[31:0] (Read/Write)
// 0x20 : Data signal of ddr_kvcache
//        bit 31~0 - ddr_kvcache[63:32] (Read/Write)
// 0x24 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XAXI_TOP_CONTROL_R_ADDR_DDR_WEIGHTS_DATA 0x10
#define XAXI_TOP_CONTROL_R_BITS_DDR_WEIGHTS_DATA 64
#define XAXI_TOP_CONTROL_R_ADDR_DDR_KVCACHE_DATA 0x1c
#define XAXI_TOP_CONTROL_R_BITS_DDR_KVCACHE_DATA 64

