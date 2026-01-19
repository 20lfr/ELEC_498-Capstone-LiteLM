set moduleName LAYER_NORM
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 13
set C_modelName {LAYER_NORM}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict int8_activation { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict layerNorm_gamma { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict layerNorm_beta { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict layerNorm_out { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ int8_activation int 8 regular {array 8 { 1 1 } 1 1 }  }
	{ layerNorm_gamma int 32 regular {array 8 { 1 1 } 1 1 }  }
	{ layerNorm_beta int 32 regular {array 8 { 1 1 } 1 1 }  }
	{ epsilon int 16 regular  }
	{ layerNorm_out int 32 regular {array 8 { 0 0 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "int8_activation", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "layerNorm_gamma", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "layerNorm_beta", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "epsilon", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "layerNorm_out", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 33
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ int8_activation_address0 sc_out sc_lv 3 signal 0 } 
	{ int8_activation_ce0 sc_out sc_logic 1 signal 0 } 
	{ int8_activation_q0 sc_in sc_lv 8 signal 0 } 
	{ int8_activation_address1 sc_out sc_lv 3 signal 0 } 
	{ int8_activation_ce1 sc_out sc_logic 1 signal 0 } 
	{ int8_activation_q1 sc_in sc_lv 8 signal 0 } 
	{ layerNorm_gamma_address0 sc_out sc_lv 3 signal 1 } 
	{ layerNorm_gamma_ce0 sc_out sc_logic 1 signal 1 } 
	{ layerNorm_gamma_q0 sc_in sc_lv 32 signal 1 } 
	{ layerNorm_gamma_address1 sc_out sc_lv 3 signal 1 } 
	{ layerNorm_gamma_ce1 sc_out sc_logic 1 signal 1 } 
	{ layerNorm_gamma_q1 sc_in sc_lv 32 signal 1 } 
	{ layerNorm_beta_address0 sc_out sc_lv 3 signal 2 } 
	{ layerNorm_beta_ce0 sc_out sc_logic 1 signal 2 } 
	{ layerNorm_beta_q0 sc_in sc_lv 32 signal 2 } 
	{ layerNorm_beta_address1 sc_out sc_lv 3 signal 2 } 
	{ layerNorm_beta_ce1 sc_out sc_logic 1 signal 2 } 
	{ layerNorm_beta_q1 sc_in sc_lv 32 signal 2 } 
	{ epsilon sc_in sc_lv 16 signal 3 } 
	{ layerNorm_out_address0 sc_out sc_lv 3 signal 4 } 
	{ layerNorm_out_ce0 sc_out sc_logic 1 signal 4 } 
	{ layerNorm_out_we0 sc_out sc_logic 1 signal 4 } 
	{ layerNorm_out_d0 sc_out sc_lv 32 signal 4 } 
	{ layerNorm_out_address1 sc_out sc_lv 3 signal 4 } 
	{ layerNorm_out_ce1 sc_out sc_logic 1 signal 4 } 
	{ layerNorm_out_we1 sc_out sc_logic 1 signal 4 } 
	{ layerNorm_out_d1 sc_out sc_lv 32 signal 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "int8_activation_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "int8_activation", "role": "address0" }} , 
 	{ "name": "int8_activation_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "int8_activation", "role": "ce0" }} , 
 	{ "name": "int8_activation_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation", "role": "q0" }} , 
 	{ "name": "int8_activation_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "int8_activation", "role": "address1" }} , 
 	{ "name": "int8_activation_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "int8_activation", "role": "ce1" }} , 
 	{ "name": "int8_activation_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation", "role": "q1" }} , 
 	{ "name": "layerNorm_gamma_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "address0" }} , 
 	{ "name": "layerNorm_gamma_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "ce0" }} , 
 	{ "name": "layerNorm_gamma_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "q0" }} , 
 	{ "name": "layerNorm_gamma_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "address1" }} , 
 	{ "name": "layerNorm_gamma_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "ce1" }} , 
 	{ "name": "layerNorm_gamma_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "q1" }} , 
 	{ "name": "layerNorm_beta_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "address0" }} , 
 	{ "name": "layerNorm_beta_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "ce0" }} , 
 	{ "name": "layerNorm_beta_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "q0" }} , 
 	{ "name": "layerNorm_beta_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "address1" }} , 
 	{ "name": "layerNorm_beta_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "ce1" }} , 
 	{ "name": "layerNorm_beta_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "q1" }} , 
 	{ "name": "epsilon", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "epsilon", "role": "default" }} , 
 	{ "name": "layerNorm_out_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "address0" }} , 
 	{ "name": "layerNorm_out_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "ce0" }} , 
 	{ "name": "layerNorm_out_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "we0" }} , 
 	{ "name": "layerNorm_out_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "d0" }} , 
 	{ "name": "layerNorm_out_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "address1" }} , 
 	{ "name": "layerNorm_out_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "ce1" }} , 
 	{ "name": "layerNorm_out_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "we1" }} , 
 	{ "name": "layerNorm_out_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "d1" }}  ]}

set ArgLastReadFirstWriteLatency {
	LAYER_NORM {
		int8_activation {Type I LastRead 51 FirstWrite -1}
		layerNorm_gamma {Type I LastRead 52 FirstWrite -1}
		layerNorm_beta {Type I LastRead 52 FirstWrite -1}
		epsilon {Type I LastRead 3 FirstWrite -1}
		layerNorm_out {Type O LastRead -1 FirstWrite 49}}
	LAYER_NORM_Pipeline_VITIS_LOOP_79_1 {
		int8_activation {Type I LastRead 0 FirstWrite -1}
		square_out {Type O LastRead -1 FirstWrite 3}
		sum_out {Type O LastRead -1 FirstWrite 3}}
	sqrt_fixed_32_16_s {
		x {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "65", "Max" : "65"}
	, {"Name" : "Interval", "Min" : "65", "Max" : "65"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	int8_activation { ap_memory {  { int8_activation_address0 mem_address 1 3 }  { int8_activation_ce0 mem_ce 1 1 }  { int8_activation_q0 mem_dout 0 8 }  { int8_activation_address1 MemPortADDR2 1 3 }  { int8_activation_ce1 MemPortCE2 1 1 }  { int8_activation_q1 MemPortDOUT2 0 8 } } }
	layerNorm_gamma { ap_memory {  { layerNorm_gamma_address0 mem_address 1 3 }  { layerNorm_gamma_ce0 mem_ce 1 1 }  { layerNorm_gamma_q0 mem_dout 0 32 }  { layerNorm_gamma_address1 MemPortADDR2 1 3 }  { layerNorm_gamma_ce1 MemPortCE2 1 1 }  { layerNorm_gamma_q1 MemPortDOUT2 0 32 } } }
	layerNorm_beta { ap_memory {  { layerNorm_beta_address0 mem_address 1 3 }  { layerNorm_beta_ce0 mem_ce 1 1 }  { layerNorm_beta_q0 mem_dout 0 32 }  { layerNorm_beta_address1 MemPortADDR2 1 3 }  { layerNorm_beta_ce1 MemPortCE2 1 1 }  { layerNorm_beta_q1 MemPortDOUT2 0 32 } } }
	epsilon { ap_none {  { epsilon in_data 0 16 } } }
	layerNorm_out { ap_memory {  { layerNorm_out_address0 mem_address 1 3 }  { layerNorm_out_ce0 mem_ce 1 1 }  { layerNorm_out_we0 mem_we 1 1 }  { layerNorm_out_d0 mem_din 1 32 }  { layerNorm_out_address1 MemPortADDR2 1 3 }  { layerNorm_out_ce1 MemPortCE2 1 1 }  { layerNorm_out_we1 MemPortWE2 1 1 }  { layerNorm_out_d1 MemPortDIN2 1 32 } } }
}
