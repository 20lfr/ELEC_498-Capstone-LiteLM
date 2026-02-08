// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XAXI_TOP_H
#define XAXI_TOP_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xaxi_top_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XAxi_top_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XAxi_top;

typedef u32 word_type;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
    u32 word_8;
    u32 word_9;
    u32 word_10;
    u32 word_11;
    u32 word_12;
    u32 word_13;
    u32 word_14;
    u32 word_15;
    u32 word_16;
    u32 word_17;
    u32 word_18;
    u32 word_19;
    u32 word_20;
    u32 word_21;
    u32 word_22;
    u32 word_23;
    u32 word_24;
    u32 word_25;
    u32 word_26;
    u32 word_27;
    u32 word_28;
    u32 word_29;
    u32 word_30;
    u32 word_31;
    u32 word_32;
    u32 word_33;
    u32 word_34;
    u32 word_35;
    u32 word_36;
    u32 word_37;
    u32 word_38;
    u32 word_39;
} XAxi_top_Ctrl_mem;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
} XAxi_top_Status_mem;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XAxi_top_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XAxi_top_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XAxi_top_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XAxi_top_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XAxi_top_Initialize(XAxi_top *InstancePtr, UINTPTR BaseAddress);
XAxi_top_Config* XAxi_top_LookupConfig(UINTPTR BaseAddress);
#else
int XAxi_top_Initialize(XAxi_top *InstancePtr, u16 DeviceId);
XAxi_top_Config* XAxi_top_LookupConfig(u16 DeviceId);
#endif
int XAxi_top_CfgInitialize(XAxi_top *InstancePtr, XAxi_top_Config *ConfigPtr);
#else
int XAxi_top_Initialize(XAxi_top *InstancePtr, const char* InstanceName);
int XAxi_top_Release(XAxi_top *InstancePtr);
#endif

void XAxi_top_Start(XAxi_top *InstancePtr);
u32 XAxi_top_IsDone(XAxi_top *InstancePtr);
u32 XAxi_top_IsIdle(XAxi_top *InstancePtr);
u32 XAxi_top_IsReady(XAxi_top *InstancePtr);
void XAxi_top_EnableAutoRestart(XAxi_top *InstancePtr);
void XAxi_top_DisableAutoRestart(XAxi_top *InstancePtr);

void XAxi_top_Set_ctrl_mem(XAxi_top *InstancePtr, XAxi_top_Ctrl_mem Data);
XAxi_top_Ctrl_mem XAxi_top_Get_ctrl_mem(XAxi_top *InstancePtr);
XAxi_top_Status_mem XAxi_top_Get_status_mem(XAxi_top *InstancePtr);
u32 XAxi_top_Get_status_mem_vld(XAxi_top *InstancePtr);

void XAxi_top_InterruptGlobalEnable(XAxi_top *InstancePtr);
void XAxi_top_InterruptGlobalDisable(XAxi_top *InstancePtr);
void XAxi_top_InterruptEnable(XAxi_top *InstancePtr, u32 Mask);
void XAxi_top_InterruptDisable(XAxi_top *InstancePtr, u32 Mask);
void XAxi_top_InterruptClear(XAxi_top *InstancePtr, u32 Mask);
u32 XAxi_top_InterruptGetEnabled(XAxi_top *InstancePtr);
u32 XAxi_top_InterruptGetStatus(XAxi_top *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
