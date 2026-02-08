// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xaxi_top.h"

extern XAxi_top_Config XAxi_top_ConfigTable[];

#ifdef SDT
XAxi_top_Config *XAxi_top_LookupConfig(UINTPTR BaseAddress) {
	XAxi_top_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XAxi_top_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XAxi_top_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XAxi_top_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XAxi_top_Initialize(XAxi_top *InstancePtr, UINTPTR BaseAddress) {
	XAxi_top_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XAxi_top_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XAxi_top_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XAxi_top_Config *XAxi_top_LookupConfig(u16 DeviceId) {
	XAxi_top_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XAXI_TOP_NUM_INSTANCES; Index++) {
		if (XAxi_top_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XAxi_top_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XAxi_top_Initialize(XAxi_top *InstancePtr, u16 DeviceId) {
	XAxi_top_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XAxi_top_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XAxi_top_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

