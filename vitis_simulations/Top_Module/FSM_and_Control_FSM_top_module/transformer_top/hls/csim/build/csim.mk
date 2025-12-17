# ==============================================================
# Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
# Tool Version Limit: 2025.05
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
# 
# ==============================================================
CSIM_DESIGN = 1

__SIM_FPO__ = 1

__SIM_MATHHLS__ = 1

__SIM_FFT__ = 1

__SIM_FIR__ = 1

__SIM_DDS__ = 1

__USE_CLANG__ = 1

__USE_VCXX_CLANG__ = 1

ObjDir = obj

HLS_SOURCES = ../../../../../../../HLS-Verilog/top_DEBUG_tb.cpp ../../../../../../../HLS-Verilog/Weight_Loader-Stager/Weight_stager.cpp ../../../../../../../HLS-Verilog/IRQ_Wizard/IRQ_Wizard.cpp ../../../../../../../HLS-Verilog/top.cpp ../../../../../../../HLS-Verilog/ControlMemInterface/ControlMemInterface.cpp ../../../../../../../HLS-Verilog/Scheduler_FSM/src-hls/Head_Helpers/head_helpers.cpp ../../../../../../../HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_FSM.cpp

override TARGET := csim.exe

AUTOPILOT_ROOT := /tools/Xilinx/2025.1/Vitis
AUTOPILOT_MACH := lnx64
ifdef AP_GCC_M32
  AUTOPILOT_MACH := Linux_x86
  IFLAG += -m32
endif
IFLAG += -fPIC
ifndef AP_GCC_PATH
  AP_GCC_PATH := /tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/bin
endif
AUTOPILOT_TOOL := ${AUTOPILOT_ROOT}/${AUTOPILOT_MACH}/tools
AP_CLANG_PATH := ${XILINX_VCXX}/libexec
AUTOPILOT_TECH := ${AUTOPILOT_ROOT}/common/technology


IFLAG += -I "${AUTOPILOT_ROOT}/include"
IFLAG += -I "${AUTOPILOT_ROOT}/include/ap_sysc"
IFLAG += -I "${AUTOPILOT_TECH}/generic/SystemC"
IFLAG += -I "${AUTOPILOT_TECH}/generic/SystemC/AESL_FP_comp"
IFLAG += -I "${AUTOPILOT_TECH}/generic/SystemC/AESL_comp"
IFLAG += -I "${AUTOPILOT_TOOL}/auto_cc/include"
IFLAG += -I "/usr/include/x86_64-linux-gnu"
IFLAG += -D__HLS_COSIM__

IFLAG += -D__HLS_CSIM__

IFLAG += -D__VITIS_HLS__

IFLAG += -D__SIM_FPO__

IFLAG += -D__SIM_FFT__

IFLAG += -D__SIM_FIR__

IFLAG += -D__SIM_DDS__

IFLAG += -D__DSP48E2__
IFLAG += -g
DFLAG += -D__xilinx_ip_top= -DAESL_TB
CCFLAG += -Werror=return-type
CCFLAG += -Wno-abi
CCFLAG += -fdebug-default-version=4
CCFLAG += --gcc-toolchain=/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0
CCFLAG += -Werror=uninitialized
CCFLAG += -Wno-c++11-narrowing
CCFLAG += -Wno-error=sometimes-uninitialized
LFLAG += --gcc-toolchain=/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0



include ./Makefile.rules

all: $(TARGET)



$(ObjDir)/top_DEBUG_tb.o: ../../../../../../../HLS-Verilog/top_DEBUG_tb.cpp $(ObjDir)/.dir csim.mk
	$(Echo) "   Compiling ../../../../../../../HLS-Verilog/top_DEBUG_tb.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CXX) -std=gnu++14 ${CCFLAG} -c -MMD -Wno-unknown-pragmas -Wno-unknown-pragmas  $(IFLAG) $(DFLAG) $< -o $@ ; \

-include $(ObjDir)/top_DEBUG_tb.d

$(ObjDir)/Weight_stager.o: ../../../../../../../HLS-Verilog/Weight_Loader-Stager/Weight_stager.cpp $(ObjDir)/.dir csim.mk
	$(Echo) "   Compiling ../../../../../../../HLS-Verilog/Weight_Loader-Stager/Weight_stager.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CXX) -std=gnu++14 ${CCFLAG} -c -MMD  $(IFLAG) $(DFLAG) $< -o $@ ; \

-include $(ObjDir)/Weight_stager.d

$(ObjDir)/IRQ_Wizard.o: ../../../../../../../HLS-Verilog/IRQ_Wizard/IRQ_Wizard.cpp $(ObjDir)/.dir csim.mk
	$(Echo) "   Compiling ../../../../../../../HLS-Verilog/IRQ_Wizard/IRQ_Wizard.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CXX) -std=gnu++14 ${CCFLAG} -c -MMD  $(IFLAG) $(DFLAG) $< -o $@ ; \

-include $(ObjDir)/IRQ_Wizard.d

$(ObjDir)/top.o: ../../../../../../../HLS-Verilog/top.cpp $(ObjDir)/.dir csim.mk
	$(Echo) "   Compiling ../../../../../../../HLS-Verilog/top.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CXX) -std=gnu++14 ${CCFLAG} -c -MMD  $(IFLAG) $(DFLAG) $< -o $@ ; \

-include $(ObjDir)/top.d

$(ObjDir)/ControlMemInterface.o: ../../../../../../../HLS-Verilog/ControlMemInterface/ControlMemInterface.cpp $(ObjDir)/.dir csim.mk
	$(Echo) "   Compiling ../../../../../../../HLS-Verilog/ControlMemInterface/ControlMemInterface.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CXX) -std=gnu++14 ${CCFLAG} -c -MMD  $(IFLAG) $(DFLAG) $< -o $@ ; \

-include $(ObjDir)/ControlMemInterface.d

$(ObjDir)/head_helpers.o: ../../../../../../../HLS-Verilog/Scheduler_FSM/src-hls/Head_Helpers/head_helpers.cpp $(ObjDir)/.dir csim.mk
	$(Echo) "   Compiling ../../../../../../../HLS-Verilog/Scheduler_FSM/src-hls/Head_Helpers/head_helpers.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CXX) -std=gnu++14 ${CCFLAG} -c -MMD  $(IFLAG) $(DFLAG) $< -o $@ ; \

-include $(ObjDir)/head_helpers.d

$(ObjDir)/Scheduler_FSM.o: ../../../../../../../HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_FSM.cpp $(ObjDir)/.dir csim.mk
	$(Echo) "   Compiling ../../../../../../../HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_FSM.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CXX) -std=gnu++14 ${CCFLAG} -c -MMD  $(IFLAG) $(DFLAG) $< -o $@ ; \

-include $(ObjDir)/Scheduler_FSM.d
