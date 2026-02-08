// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xaxi_top.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XAxi_top_CfgInitialize(XAxi_top *InstancePtr, XAxi_top_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XAxi_top_Start(XAxi_top *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_AP_CTRL) & 0x80;
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XAxi_top_IsDone(XAxi_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XAxi_top_IsIdle(XAxi_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XAxi_top_IsReady(XAxi_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XAxi_top_EnableAutoRestart(XAxi_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XAxi_top_DisableAutoRestart(XAxi_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_AP_CTRL, 0);
}

void XAxi_top_Set_ctrl_mem(XAxi_top *InstancePtr, XAxi_top_Ctrl_mem Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 0, Data.word_0);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 4, Data.word_1);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 8, Data.word_2);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 12, Data.word_3);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 16, Data.word_4);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 20, Data.word_5);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 24, Data.word_6);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 28, Data.word_7);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 32, Data.word_8);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 36, Data.word_9);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 40, Data.word_10);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 44, Data.word_11);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 48, Data.word_12);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 52, Data.word_13);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 56, Data.word_14);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 60, Data.word_15);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 64, Data.word_16);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 68, Data.word_17);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 72, Data.word_18);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 76, Data.word_19);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 80, Data.word_20);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 84, Data.word_21);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 88, Data.word_22);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 92, Data.word_23);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 96, Data.word_24);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 100, Data.word_25);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 104, Data.word_26);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 108, Data.word_27);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 112, Data.word_28);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 116, Data.word_29);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 120, Data.word_30);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 124, Data.word_31);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 128, Data.word_32);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 132, Data.word_33);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 136, Data.word_34);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 140, Data.word_35);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 144, Data.word_36);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 148, Data.word_37);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 152, Data.word_38);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 156, Data.word_39);
}

XAxi_top_Ctrl_mem XAxi_top_Get_ctrl_mem(XAxi_top *InstancePtr) {
    XAxi_top_Ctrl_mem Data;

    Data.word_0 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 0);
    Data.word_1 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 4);
    Data.word_2 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 8);
    Data.word_3 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 12);
    Data.word_4 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 16);
    Data.word_5 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 20);
    Data.word_6 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 24);
    Data.word_7 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 28);
    Data.word_8 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 32);
    Data.word_9 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 36);
    Data.word_10 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 40);
    Data.word_11 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 44);
    Data.word_12 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 48);
    Data.word_13 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 52);
    Data.word_14 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 56);
    Data.word_15 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 60);
    Data.word_16 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 64);
    Data.word_17 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 68);
    Data.word_18 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 72);
    Data.word_19 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 76);
    Data.word_20 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 80);
    Data.word_21 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 84);
    Data.word_22 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 88);
    Data.word_23 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 92);
    Data.word_24 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 96);
    Data.word_25 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 100);
    Data.word_26 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 104);
    Data.word_27 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 108);
    Data.word_28 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 112);
    Data.word_29 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 116);
    Data.word_30 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 120);
    Data.word_31 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 124);
    Data.word_32 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 128);
    Data.word_33 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 132);
    Data.word_34 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 136);
    Data.word_35 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 140);
    Data.word_36 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 144);
    Data.word_37 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 148);
    Data.word_38 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 152);
    Data.word_39 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA + 156);
    return Data;
}

XAxi_top_Status_mem XAxi_top_Get_status_mem(XAxi_top *InstancePtr) {
    XAxi_top_Status_mem Data;

    Data.word_0 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_STATUS_MEM_DATA + 0);
    Data.word_1 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_STATUS_MEM_DATA + 4);
    Data.word_2 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_STATUS_MEM_DATA + 8);
    Data.word_3 = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_STATUS_MEM_DATA + 12);
    return Data;
}

u32 XAxi_top_Get_status_mem_vld(XAxi_top *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_STATUS_MEM_CTRL);
    return Data & 0x1;
}

void XAxi_top_InterruptGlobalEnable(XAxi_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_GIE, 1);
}

void XAxi_top_InterruptGlobalDisable(XAxi_top *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_GIE, 0);
}

void XAxi_top_InterruptEnable(XAxi_top *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_IER);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_IER, Register | Mask);
}

void XAxi_top_InterruptDisable(XAxi_top *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_IER);
    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_IER, Register & (~Mask));
}

void XAxi_top_InterruptClear(XAxi_top *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxi_top_WriteReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_ISR, Mask);
}

u32 XAxi_top_InterruptGetEnabled(XAxi_top *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_IER);
}

u32 XAxi_top_InterruptGetStatus(XAxi_top *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAxi_top_ReadReg(InstancePtr->Control_BaseAddress, XAXI_TOP_CONTROL_ADDR_ISR);
}

