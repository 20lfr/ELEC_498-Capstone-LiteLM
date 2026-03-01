// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps
module transformer_top_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 9,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    output wire [63:0]                   ddr_mem,
    output wire [1791:0]                 ctrl_mem,
    input  wire [223:0]                  status_mem,
    input  wire                          status_mem_ap_vld,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle
);
//------------------------Address Info-------------------
// Protocol Used: ap_ctrl_hs
//
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
// 0x010 : Data signal of ddr_mem
//         bit 31~0 - ddr_mem[31:0] (Read/Write)
// 0x014 : Data signal of ddr_mem
//         bit 31~0 - ddr_mem[63:32] (Read/Write)
// 0x018 : reserved
// 0x01c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[31:0] (Read/Write)
// 0x020 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[63:32] (Read/Write)
// 0x024 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[95:64] (Read/Write)
// 0x028 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[127:96] (Read/Write)
// 0x02c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[159:128] (Read/Write)
// 0x030 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[191:160] (Read/Write)
// 0x034 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[223:192] (Read/Write)
// 0x038 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[255:224] (Read/Write)
// 0x03c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[287:256] (Read/Write)
// 0x040 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[319:288] (Read/Write)
// 0x044 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[351:320] (Read/Write)
// 0x048 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[383:352] (Read/Write)
// 0x04c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[415:384] (Read/Write)
// 0x050 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[447:416] (Read/Write)
// 0x054 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[479:448] (Read/Write)
// 0x058 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[511:480] (Read/Write)
// 0x05c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[543:512] (Read/Write)
// 0x060 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[575:544] (Read/Write)
// 0x064 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[607:576] (Read/Write)
// 0x068 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[639:608] (Read/Write)
// 0x06c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[671:640] (Read/Write)
// 0x070 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[703:672] (Read/Write)
// 0x074 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[735:704] (Read/Write)
// 0x078 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[767:736] (Read/Write)
// 0x07c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[799:768] (Read/Write)
// 0x080 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[831:800] (Read/Write)
// 0x084 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[863:832] (Read/Write)
// 0x088 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[895:864] (Read/Write)
// 0x08c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[927:896] (Read/Write)
// 0x090 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[959:928] (Read/Write)
// 0x094 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[991:960] (Read/Write)
// 0x098 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1023:992] (Read/Write)
// 0x09c : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1055:1024] (Read/Write)
// 0x0a0 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1087:1056] (Read/Write)
// 0x0a4 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1119:1088] (Read/Write)
// 0x0a8 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1151:1120] (Read/Write)
// 0x0ac : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1183:1152] (Read/Write)
// 0x0b0 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1215:1184] (Read/Write)
// 0x0b4 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1247:1216] (Read/Write)
// 0x0b8 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1279:1248] (Read/Write)
// 0x0bc : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1311:1280] (Read/Write)
// 0x0c0 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1343:1312] (Read/Write)
// 0x0c4 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1375:1344] (Read/Write)
// 0x0c8 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1407:1376] (Read/Write)
// 0x0cc : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1439:1408] (Read/Write)
// 0x0d0 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1471:1440] (Read/Write)
// 0x0d4 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1503:1472] (Read/Write)
// 0x0d8 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1535:1504] (Read/Write)
// 0x0dc : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1567:1536] (Read/Write)
// 0x0e0 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1599:1568] (Read/Write)
// 0x0e4 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1631:1600] (Read/Write)
// 0x0e8 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1663:1632] (Read/Write)
// 0x0ec : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1695:1664] (Read/Write)
// 0x0f0 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1727:1696] (Read/Write)
// 0x0f4 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1759:1728] (Read/Write)
// 0x0f8 : Data signal of ctrl_mem
//         bit 31~0 - ctrl_mem[1791:1760] (Read/Write)
// 0x0fc : reserved
// 0x100 : Data signal of status_mem
//         bit 31~0 - status_mem[31:0] (Read)
// 0x104 : Data signal of status_mem
//         bit 31~0 - status_mem[63:32] (Read)
// 0x108 : Data signal of status_mem
//         bit 31~0 - status_mem[95:64] (Read)
// 0x10c : Data signal of status_mem
//         bit 31~0 - status_mem[127:96] (Read)
// 0x110 : Data signal of status_mem
//         bit 31~0 - status_mem[159:128] (Read)
// 0x114 : Data signal of status_mem
//         bit 31~0 - status_mem[191:160] (Read)
// 0x118 : Data signal of status_mem
//         bit 31~0 - status_mem[223:192] (Read)
// 0x11c : Control signal of status_mem
//         bit 0  - status_mem_ap_vld (Read/COR)
//         others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL           = 9'h000,
    ADDR_GIE               = 9'h004,
    ADDR_IER               = 9'h008,
    ADDR_ISR               = 9'h00c,
    ADDR_DDR_MEM_DATA_0    = 9'h010,
    ADDR_DDR_MEM_DATA_1    = 9'h014,
    ADDR_DDR_MEM_CTRL      = 9'h018,
    ADDR_CTRL_MEM_DATA_0   = 9'h01c,
    ADDR_CTRL_MEM_DATA_1   = 9'h020,
    ADDR_CTRL_MEM_DATA_2   = 9'h024,
    ADDR_CTRL_MEM_DATA_3   = 9'h028,
    ADDR_CTRL_MEM_DATA_4   = 9'h02c,
    ADDR_CTRL_MEM_DATA_5   = 9'h030,
    ADDR_CTRL_MEM_DATA_6   = 9'h034,
    ADDR_CTRL_MEM_DATA_7   = 9'h038,
    ADDR_CTRL_MEM_DATA_8   = 9'h03c,
    ADDR_CTRL_MEM_DATA_9   = 9'h040,
    ADDR_CTRL_MEM_DATA_10  = 9'h044,
    ADDR_CTRL_MEM_DATA_11  = 9'h048,
    ADDR_CTRL_MEM_DATA_12  = 9'h04c,
    ADDR_CTRL_MEM_DATA_13  = 9'h050,
    ADDR_CTRL_MEM_DATA_14  = 9'h054,
    ADDR_CTRL_MEM_DATA_15  = 9'h058,
    ADDR_CTRL_MEM_DATA_16  = 9'h05c,
    ADDR_CTRL_MEM_DATA_17  = 9'h060,
    ADDR_CTRL_MEM_DATA_18  = 9'h064,
    ADDR_CTRL_MEM_DATA_19  = 9'h068,
    ADDR_CTRL_MEM_DATA_20  = 9'h06c,
    ADDR_CTRL_MEM_DATA_21  = 9'h070,
    ADDR_CTRL_MEM_DATA_22  = 9'h074,
    ADDR_CTRL_MEM_DATA_23  = 9'h078,
    ADDR_CTRL_MEM_DATA_24  = 9'h07c,
    ADDR_CTRL_MEM_DATA_25  = 9'h080,
    ADDR_CTRL_MEM_DATA_26  = 9'h084,
    ADDR_CTRL_MEM_DATA_27  = 9'h088,
    ADDR_CTRL_MEM_DATA_28  = 9'h08c,
    ADDR_CTRL_MEM_DATA_29  = 9'h090,
    ADDR_CTRL_MEM_DATA_30  = 9'h094,
    ADDR_CTRL_MEM_DATA_31  = 9'h098,
    ADDR_CTRL_MEM_DATA_32  = 9'h09c,
    ADDR_CTRL_MEM_DATA_33  = 9'h0a0,
    ADDR_CTRL_MEM_DATA_34  = 9'h0a4,
    ADDR_CTRL_MEM_DATA_35  = 9'h0a8,
    ADDR_CTRL_MEM_DATA_36  = 9'h0ac,
    ADDR_CTRL_MEM_DATA_37  = 9'h0b0,
    ADDR_CTRL_MEM_DATA_38  = 9'h0b4,
    ADDR_CTRL_MEM_DATA_39  = 9'h0b8,
    ADDR_CTRL_MEM_DATA_40  = 9'h0bc,
    ADDR_CTRL_MEM_DATA_41  = 9'h0c0,
    ADDR_CTRL_MEM_DATA_42  = 9'h0c4,
    ADDR_CTRL_MEM_DATA_43  = 9'h0c8,
    ADDR_CTRL_MEM_DATA_44  = 9'h0cc,
    ADDR_CTRL_MEM_DATA_45  = 9'h0d0,
    ADDR_CTRL_MEM_DATA_46  = 9'h0d4,
    ADDR_CTRL_MEM_DATA_47  = 9'h0d8,
    ADDR_CTRL_MEM_DATA_48  = 9'h0dc,
    ADDR_CTRL_MEM_DATA_49  = 9'h0e0,
    ADDR_CTRL_MEM_DATA_50  = 9'h0e4,
    ADDR_CTRL_MEM_DATA_51  = 9'h0e8,
    ADDR_CTRL_MEM_DATA_52  = 9'h0ec,
    ADDR_CTRL_MEM_DATA_53  = 9'h0f0,
    ADDR_CTRL_MEM_DATA_54  = 9'h0f4,
    ADDR_CTRL_MEM_DATA_55  = 9'h0f8,
    ADDR_CTRL_MEM_CTRL     = 9'h0fc,
    ADDR_STATUS_MEM_DATA_0 = 9'h100,
    ADDR_STATUS_MEM_DATA_1 = 9'h104,
    ADDR_STATUS_MEM_DATA_2 = 9'h108,
    ADDR_STATUS_MEM_DATA_3 = 9'h10c,
    ADDR_STATUS_MEM_DATA_4 = 9'h110,
    ADDR_STATUS_MEM_DATA_5 = 9'h114,
    ADDR_STATUS_MEM_DATA_6 = 9'h118,
    ADDR_STATUS_MEM_CTRL   = 9'h11c,
    WRIDLE                 = 2'd0,
    WRDATA                 = 2'd1,
    WRRESP                 = 2'd2,
    WRRESET                = 2'd3,
    RDIDLE                 = 2'd0,
    RDDATA                 = 2'd1,
    RDRESET                = 2'd2,
    ADDR_BITS                = 9;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle = 1'b0;
    reg                           int_ap_ready = 1'b0;
    wire                          task_ap_ready;
    reg                           int_ap_done = 1'b0;
    wire                          task_ap_done;
    reg                           int_task_ap_done = 1'b0;
    reg                           int_ap_start = 1'b0;
    reg                           int_interrupt = 1'b0;
    reg                           int_auto_restart = 1'b0;
    reg                           auto_restart_status = 1'b0;
    wire                          auto_restart_done;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    reg  [1:0]                    int_isr = 2'b0;
    reg  [63:0]                   int_ddr_mem = 'b0;
    reg  [1791:0]                 int_ctrl_mem = 'b0;
    reg                           int_status_mem_ap_vld;
    reg  [223:0]                  int_status_mem = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BVALID  = (wstate == WRRESP);
assign BRESP   = 2'b00;  // OKAY
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY & BVALID)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= {AWADDR[ADDR_BITS-1:2], {2{1'b0}}};
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_task_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                    rdata[9] <= int_interrupt;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
                ADDR_DDR_MEM_DATA_0: begin
                    rdata <= int_ddr_mem[31:0];
                end
                ADDR_DDR_MEM_DATA_1: begin
                    rdata <= int_ddr_mem[63:32];
                end
                ADDR_CTRL_MEM_DATA_0: begin
                    rdata <= int_ctrl_mem[31:0];
                end
                ADDR_CTRL_MEM_DATA_1: begin
                    rdata <= int_ctrl_mem[63:32];
                end
                ADDR_CTRL_MEM_DATA_2: begin
                    rdata <= int_ctrl_mem[95:64];
                end
                ADDR_CTRL_MEM_DATA_3: begin
                    rdata <= int_ctrl_mem[127:96];
                end
                ADDR_CTRL_MEM_DATA_4: begin
                    rdata <= int_ctrl_mem[159:128];
                end
                ADDR_CTRL_MEM_DATA_5: begin
                    rdata <= int_ctrl_mem[191:160];
                end
                ADDR_CTRL_MEM_DATA_6: begin
                    rdata <= int_ctrl_mem[223:192];
                end
                ADDR_CTRL_MEM_DATA_7: begin
                    rdata <= int_ctrl_mem[255:224];
                end
                ADDR_CTRL_MEM_DATA_8: begin
                    rdata <= int_ctrl_mem[287:256];
                end
                ADDR_CTRL_MEM_DATA_9: begin
                    rdata <= int_ctrl_mem[319:288];
                end
                ADDR_CTRL_MEM_DATA_10: begin
                    rdata <= int_ctrl_mem[351:320];
                end
                ADDR_CTRL_MEM_DATA_11: begin
                    rdata <= int_ctrl_mem[383:352];
                end
                ADDR_CTRL_MEM_DATA_12: begin
                    rdata <= int_ctrl_mem[415:384];
                end
                ADDR_CTRL_MEM_DATA_13: begin
                    rdata <= int_ctrl_mem[447:416];
                end
                ADDR_CTRL_MEM_DATA_14: begin
                    rdata <= int_ctrl_mem[479:448];
                end
                ADDR_CTRL_MEM_DATA_15: begin
                    rdata <= int_ctrl_mem[511:480];
                end
                ADDR_CTRL_MEM_DATA_16: begin
                    rdata <= int_ctrl_mem[543:512];
                end
                ADDR_CTRL_MEM_DATA_17: begin
                    rdata <= int_ctrl_mem[575:544];
                end
                ADDR_CTRL_MEM_DATA_18: begin
                    rdata <= int_ctrl_mem[607:576];
                end
                ADDR_CTRL_MEM_DATA_19: begin
                    rdata <= int_ctrl_mem[639:608];
                end
                ADDR_CTRL_MEM_DATA_20: begin
                    rdata <= int_ctrl_mem[671:640];
                end
                ADDR_CTRL_MEM_DATA_21: begin
                    rdata <= int_ctrl_mem[703:672];
                end
                ADDR_CTRL_MEM_DATA_22: begin
                    rdata <= int_ctrl_mem[735:704];
                end
                ADDR_CTRL_MEM_DATA_23: begin
                    rdata <= int_ctrl_mem[767:736];
                end
                ADDR_CTRL_MEM_DATA_24: begin
                    rdata <= int_ctrl_mem[799:768];
                end
                ADDR_CTRL_MEM_DATA_25: begin
                    rdata <= int_ctrl_mem[831:800];
                end
                ADDR_CTRL_MEM_DATA_26: begin
                    rdata <= int_ctrl_mem[863:832];
                end
                ADDR_CTRL_MEM_DATA_27: begin
                    rdata <= int_ctrl_mem[895:864];
                end
                ADDR_CTRL_MEM_DATA_28: begin
                    rdata <= int_ctrl_mem[927:896];
                end
                ADDR_CTRL_MEM_DATA_29: begin
                    rdata <= int_ctrl_mem[959:928];
                end
                ADDR_CTRL_MEM_DATA_30: begin
                    rdata <= int_ctrl_mem[991:960];
                end
                ADDR_CTRL_MEM_DATA_31: begin
                    rdata <= int_ctrl_mem[1023:992];
                end
                ADDR_CTRL_MEM_DATA_32: begin
                    rdata <= int_ctrl_mem[1055:1024];
                end
                ADDR_CTRL_MEM_DATA_33: begin
                    rdata <= int_ctrl_mem[1087:1056];
                end
                ADDR_CTRL_MEM_DATA_34: begin
                    rdata <= int_ctrl_mem[1119:1088];
                end
                ADDR_CTRL_MEM_DATA_35: begin
                    rdata <= int_ctrl_mem[1151:1120];
                end
                ADDR_CTRL_MEM_DATA_36: begin
                    rdata <= int_ctrl_mem[1183:1152];
                end
                ADDR_CTRL_MEM_DATA_37: begin
                    rdata <= int_ctrl_mem[1215:1184];
                end
                ADDR_CTRL_MEM_DATA_38: begin
                    rdata <= int_ctrl_mem[1247:1216];
                end
                ADDR_CTRL_MEM_DATA_39: begin
                    rdata <= int_ctrl_mem[1279:1248];
                end
                ADDR_CTRL_MEM_DATA_40: begin
                    rdata <= int_ctrl_mem[1311:1280];
                end
                ADDR_CTRL_MEM_DATA_41: begin
                    rdata <= int_ctrl_mem[1343:1312];
                end
                ADDR_CTRL_MEM_DATA_42: begin
                    rdata <= int_ctrl_mem[1375:1344];
                end
                ADDR_CTRL_MEM_DATA_43: begin
                    rdata <= int_ctrl_mem[1407:1376];
                end
                ADDR_CTRL_MEM_DATA_44: begin
                    rdata <= int_ctrl_mem[1439:1408];
                end
                ADDR_CTRL_MEM_DATA_45: begin
                    rdata <= int_ctrl_mem[1471:1440];
                end
                ADDR_CTRL_MEM_DATA_46: begin
                    rdata <= int_ctrl_mem[1503:1472];
                end
                ADDR_CTRL_MEM_DATA_47: begin
                    rdata <= int_ctrl_mem[1535:1504];
                end
                ADDR_CTRL_MEM_DATA_48: begin
                    rdata <= int_ctrl_mem[1567:1536];
                end
                ADDR_CTRL_MEM_DATA_49: begin
                    rdata <= int_ctrl_mem[1599:1568];
                end
                ADDR_CTRL_MEM_DATA_50: begin
                    rdata <= int_ctrl_mem[1631:1600];
                end
                ADDR_CTRL_MEM_DATA_51: begin
                    rdata <= int_ctrl_mem[1663:1632];
                end
                ADDR_CTRL_MEM_DATA_52: begin
                    rdata <= int_ctrl_mem[1695:1664];
                end
                ADDR_CTRL_MEM_DATA_53: begin
                    rdata <= int_ctrl_mem[1727:1696];
                end
                ADDR_CTRL_MEM_DATA_54: begin
                    rdata <= int_ctrl_mem[1759:1728];
                end
                ADDR_CTRL_MEM_DATA_55: begin
                    rdata <= int_ctrl_mem[1791:1760];
                end
                ADDR_STATUS_MEM_DATA_0: begin
                    rdata <= int_status_mem[31:0];
                end
                ADDR_STATUS_MEM_DATA_1: begin
                    rdata <= int_status_mem[63:32];
                end
                ADDR_STATUS_MEM_DATA_2: begin
                    rdata <= int_status_mem[95:64];
                end
                ADDR_STATUS_MEM_DATA_3: begin
                    rdata <= int_status_mem[127:96];
                end
                ADDR_STATUS_MEM_DATA_4: begin
                    rdata <= int_status_mem[159:128];
                end
                ADDR_STATUS_MEM_DATA_5: begin
                    rdata <= int_status_mem[191:160];
                end
                ADDR_STATUS_MEM_DATA_6: begin
                    rdata <= int_status_mem[223:192];
                end
                ADDR_STATUS_MEM_CTRL: begin
                    rdata[0] <= int_status_mem_ap_vld;
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign interrupt         = int_interrupt;
assign ap_start          = int_ap_start;
assign task_ap_done      = (ap_done && !auto_restart_status) || auto_restart_done;
assign task_ap_ready     = ap_ready && !int_auto_restart;
assign auto_restart_done = auto_restart_status && (ap_idle && !int_ap_idle);
assign ddr_mem           = int_ddr_mem;
assign ctrl_mem          = int_ctrl_mem;
// int_interrupt
always @(posedge ACLK) begin
    if (ARESET)
        int_interrupt <= 1'b0;
    else if (ACLK_EN) begin
        if (int_gie && (|int_isr))
            int_interrupt <= 1'b1;
        else
            int_interrupt <= 1'b0;
    end
end

// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0])
            int_ap_start <= 1'b1;
        else if (ap_ready)
            int_ap_start <= int_auto_restart; // clear on handshake/auto restart
    end
end

// int_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_done <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_done <= ap_done;
    end
end

// int_task_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_task_ap_done <= 1'b0;
    else if (ACLK_EN) begin
        if (task_ap_done)
            int_task_ap_done <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_task_ap_done <= 1'b0; // clear on read
    end
end

// int_ap_idle
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_idle <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_idle <= ap_idle;
    end
end

// int_ap_ready
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_ready <= 1'b0;
    else if (ACLK_EN) begin
        if (task_ap_ready)
            int_ap_ready <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_ap_ready <= 1'b0;
    end
end

// int_auto_restart
always @(posedge ACLK) begin
    if (ARESET)
        int_auto_restart <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0])
            int_auto_restart <= WDATA[7];
    end
end

// auto_restart_status
always @(posedge ACLK) begin
    if (ARESET)
        auto_restart_status <= 1'b0;
    else if (ACLK_EN) begin
        if (int_auto_restart)
            auto_restart_status <= 1'b1;
        else if (ap_idle)
            auto_restart_status <= 1'b0;
    end
end

// int_gie
always @(posedge ACLK) begin
    if (ARESET)
        int_gie <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GIE && WSTRB[0])
            int_gie <= WDATA[0];
    end
end

// int_ier
always @(posedge ACLK) begin
    if (ARESET)
        int_ier <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IER && WSTRB[0])
            int_ier <= WDATA[1:0];
    end
end

// int_isr[0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[0] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[0] & ap_done)
            int_isr[0] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
    end
end

// int_isr[1]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[1] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[1] & ap_ready)
            int_isr[1] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
    end
end

// int_ddr_mem[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ddr_mem[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DDR_MEM_DATA_0)
            int_ddr_mem[31:0] <= (WDATA[31:0] & wmask) | (int_ddr_mem[31:0] & ~wmask);
    end
end

// int_ddr_mem[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_ddr_mem[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DDR_MEM_DATA_1)
            int_ddr_mem[63:32] <= (WDATA[31:0] & wmask) | (int_ddr_mem[63:32] & ~wmask);
    end
end

// int_ctrl_mem[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_0)
            int_ctrl_mem[31:0] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[31:0] & ~wmask);
    end
end

// int_ctrl_mem[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_1)
            int_ctrl_mem[63:32] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[63:32] & ~wmask);
    end
end

// int_ctrl_mem[95:64]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[95:64] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_2)
            int_ctrl_mem[95:64] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[95:64] & ~wmask);
    end
end

// int_ctrl_mem[127:96]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[127:96] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_3)
            int_ctrl_mem[127:96] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[127:96] & ~wmask);
    end
end

// int_ctrl_mem[159:128]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[159:128] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_4)
            int_ctrl_mem[159:128] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[159:128] & ~wmask);
    end
end

// int_ctrl_mem[191:160]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[191:160] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_5)
            int_ctrl_mem[191:160] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[191:160] & ~wmask);
    end
end

// int_ctrl_mem[223:192]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[223:192] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_6)
            int_ctrl_mem[223:192] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[223:192] & ~wmask);
    end
end

// int_ctrl_mem[255:224]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[255:224] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_7)
            int_ctrl_mem[255:224] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[255:224] & ~wmask);
    end
end

// int_ctrl_mem[287:256]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[287:256] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_8)
            int_ctrl_mem[287:256] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[287:256] & ~wmask);
    end
end

// int_ctrl_mem[319:288]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[319:288] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_9)
            int_ctrl_mem[319:288] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[319:288] & ~wmask);
    end
end

// int_ctrl_mem[351:320]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[351:320] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_10)
            int_ctrl_mem[351:320] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[351:320] & ~wmask);
    end
end

// int_ctrl_mem[383:352]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[383:352] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_11)
            int_ctrl_mem[383:352] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[383:352] & ~wmask);
    end
end

// int_ctrl_mem[415:384]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[415:384] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_12)
            int_ctrl_mem[415:384] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[415:384] & ~wmask);
    end
end

// int_ctrl_mem[447:416]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[447:416] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_13)
            int_ctrl_mem[447:416] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[447:416] & ~wmask);
    end
end

// int_ctrl_mem[479:448]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[479:448] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_14)
            int_ctrl_mem[479:448] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[479:448] & ~wmask);
    end
end

// int_ctrl_mem[511:480]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[511:480] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_15)
            int_ctrl_mem[511:480] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[511:480] & ~wmask);
    end
end

// int_ctrl_mem[543:512]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[543:512] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_16)
            int_ctrl_mem[543:512] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[543:512] & ~wmask);
    end
end

// int_ctrl_mem[575:544]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[575:544] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_17)
            int_ctrl_mem[575:544] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[575:544] & ~wmask);
    end
end

// int_ctrl_mem[607:576]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[607:576] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_18)
            int_ctrl_mem[607:576] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[607:576] & ~wmask);
    end
end

// int_ctrl_mem[639:608]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[639:608] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_19)
            int_ctrl_mem[639:608] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[639:608] & ~wmask);
    end
end

// int_ctrl_mem[671:640]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[671:640] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_20)
            int_ctrl_mem[671:640] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[671:640] & ~wmask);
    end
end

// int_ctrl_mem[703:672]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[703:672] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_21)
            int_ctrl_mem[703:672] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[703:672] & ~wmask);
    end
end

// int_ctrl_mem[735:704]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[735:704] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_22)
            int_ctrl_mem[735:704] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[735:704] & ~wmask);
    end
end

// int_ctrl_mem[767:736]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[767:736] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_23)
            int_ctrl_mem[767:736] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[767:736] & ~wmask);
    end
end

// int_ctrl_mem[799:768]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[799:768] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_24)
            int_ctrl_mem[799:768] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[799:768] & ~wmask);
    end
end

// int_ctrl_mem[831:800]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[831:800] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_25)
            int_ctrl_mem[831:800] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[831:800] & ~wmask);
    end
end

// int_ctrl_mem[863:832]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[863:832] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_26)
            int_ctrl_mem[863:832] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[863:832] & ~wmask);
    end
end

// int_ctrl_mem[895:864]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[895:864] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_27)
            int_ctrl_mem[895:864] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[895:864] & ~wmask);
    end
end

// int_ctrl_mem[927:896]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[927:896] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_28)
            int_ctrl_mem[927:896] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[927:896] & ~wmask);
    end
end

// int_ctrl_mem[959:928]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[959:928] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_29)
            int_ctrl_mem[959:928] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[959:928] & ~wmask);
    end
end

// int_ctrl_mem[991:960]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[991:960] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_30)
            int_ctrl_mem[991:960] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[991:960] & ~wmask);
    end
end

// int_ctrl_mem[1023:992]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1023:992] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_31)
            int_ctrl_mem[1023:992] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1023:992] & ~wmask);
    end
end

// int_ctrl_mem[1055:1024]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1055:1024] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_32)
            int_ctrl_mem[1055:1024] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1055:1024] & ~wmask);
    end
end

// int_ctrl_mem[1087:1056]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1087:1056] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_33)
            int_ctrl_mem[1087:1056] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1087:1056] & ~wmask);
    end
end

// int_ctrl_mem[1119:1088]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1119:1088] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_34)
            int_ctrl_mem[1119:1088] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1119:1088] & ~wmask);
    end
end

// int_ctrl_mem[1151:1120]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1151:1120] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_35)
            int_ctrl_mem[1151:1120] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1151:1120] & ~wmask);
    end
end

// int_ctrl_mem[1183:1152]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1183:1152] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_36)
            int_ctrl_mem[1183:1152] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1183:1152] & ~wmask);
    end
end

// int_ctrl_mem[1215:1184]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1215:1184] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_37)
            int_ctrl_mem[1215:1184] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1215:1184] & ~wmask);
    end
end

// int_ctrl_mem[1247:1216]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1247:1216] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_38)
            int_ctrl_mem[1247:1216] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1247:1216] & ~wmask);
    end
end

// int_ctrl_mem[1279:1248]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1279:1248] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_39)
            int_ctrl_mem[1279:1248] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1279:1248] & ~wmask);
    end
end

// int_ctrl_mem[1311:1280]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1311:1280] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_40)
            int_ctrl_mem[1311:1280] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1311:1280] & ~wmask);
    end
end

// int_ctrl_mem[1343:1312]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1343:1312] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_41)
            int_ctrl_mem[1343:1312] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1343:1312] & ~wmask);
    end
end

// int_ctrl_mem[1375:1344]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1375:1344] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_42)
            int_ctrl_mem[1375:1344] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1375:1344] & ~wmask);
    end
end

// int_ctrl_mem[1407:1376]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1407:1376] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_43)
            int_ctrl_mem[1407:1376] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1407:1376] & ~wmask);
    end
end

// int_ctrl_mem[1439:1408]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1439:1408] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_44)
            int_ctrl_mem[1439:1408] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1439:1408] & ~wmask);
    end
end

// int_ctrl_mem[1471:1440]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1471:1440] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_45)
            int_ctrl_mem[1471:1440] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1471:1440] & ~wmask);
    end
end

// int_ctrl_mem[1503:1472]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1503:1472] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_46)
            int_ctrl_mem[1503:1472] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1503:1472] & ~wmask);
    end
end

// int_ctrl_mem[1535:1504]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1535:1504] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_47)
            int_ctrl_mem[1535:1504] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1535:1504] & ~wmask);
    end
end

// int_ctrl_mem[1567:1536]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1567:1536] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_48)
            int_ctrl_mem[1567:1536] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1567:1536] & ~wmask);
    end
end

// int_ctrl_mem[1599:1568]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1599:1568] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_49)
            int_ctrl_mem[1599:1568] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1599:1568] & ~wmask);
    end
end

// int_ctrl_mem[1631:1600]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1631:1600] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_50)
            int_ctrl_mem[1631:1600] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1631:1600] & ~wmask);
    end
end

// int_ctrl_mem[1663:1632]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1663:1632] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_51)
            int_ctrl_mem[1663:1632] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1663:1632] & ~wmask);
    end
end

// int_ctrl_mem[1695:1664]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1695:1664] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_52)
            int_ctrl_mem[1695:1664] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1695:1664] & ~wmask);
    end
end

// int_ctrl_mem[1727:1696]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1727:1696] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_53)
            int_ctrl_mem[1727:1696] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1727:1696] & ~wmask);
    end
end

// int_ctrl_mem[1759:1728]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1759:1728] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_54)
            int_ctrl_mem[1759:1728] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1759:1728] & ~wmask);
    end
end

// int_ctrl_mem[1791:1760]
always @(posedge ACLK) begin
    if (ARESET)
        int_ctrl_mem[1791:1760] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CTRL_MEM_DATA_55)
            int_ctrl_mem[1791:1760] <= (WDATA[31:0] & wmask) | (int_ctrl_mem[1791:1760] & ~wmask);
    end
end

// int_status_mem
always @(posedge ACLK) begin
    if (ARESET)
        int_status_mem <= 0;
    else if (ACLK_EN) begin
        if (status_mem_ap_vld)
            int_status_mem <= status_mem;
    end
end

// int_status_mem_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_status_mem_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (status_mem_ap_vld)
            int_status_mem_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_STATUS_MEM_CTRL)
            int_status_mem_ap_vld <= 1'b0; // clear on read
    end
end

//synthesis translate_off
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (int_gie & ~int_isr[0] & int_ier[0] & ap_done)
            $display ("// Interrupt Monitor : interrupt for ap_done detected @ \"%0t\"", $time);
        if (int_gie & ~int_isr[1] & int_ier[1] & ap_ready)
            $display ("// Interrupt Monitor : interrupt for ap_ready detected @ \"%0t\"", $time);
    end
end
//synthesis translate_on

//------------------------Memory logic-------------------

endmodule
