set moduleName RES_ADD
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
set C_modelName {RES_ADD}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict int8_activation { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict residualAdd_residual { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict residualAdd_output { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ int8_activation int 8 regular {array 8 { 1 1 } 1 1 }  }
	{ residualAdd_residual int 8 regular {array 8 { 1 1 } 1 1 }  }
	{ residualAdd_output int 8 regular {array 8 { 0 0 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "int8_activation", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "residualAdd_residual", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "residualAdd_output", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 26
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
	{ residualAdd_residual_address0 sc_out sc_lv 3 signal 1 } 
	{ residualAdd_residual_ce0 sc_out sc_logic 1 signal 1 } 
	{ residualAdd_residual_q0 sc_in sc_lv 8 signal 1 } 
	{ residualAdd_residual_address1 sc_out sc_lv 3 signal 1 } 
	{ residualAdd_residual_ce1 sc_out sc_logic 1 signal 1 } 
	{ residualAdd_residual_q1 sc_in sc_lv 8 signal 1 } 
	{ residualAdd_output_address0 sc_out sc_lv 3 signal 2 } 
	{ residualAdd_output_ce0 sc_out sc_logic 1 signal 2 } 
	{ residualAdd_output_we0 sc_out sc_logic 1 signal 2 } 
	{ residualAdd_output_d0 sc_out sc_lv 8 signal 2 } 
	{ residualAdd_output_address1 sc_out sc_lv 3 signal 2 } 
	{ residualAdd_output_ce1 sc_out sc_logic 1 signal 2 } 
	{ residualAdd_output_we1 sc_out sc_logic 1 signal 2 } 
	{ residualAdd_output_d1 sc_out sc_lv 8 signal 2 } 
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
 	{ "name": "residualAdd_residual_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "address0" }} , 
 	{ "name": "residualAdd_residual_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "ce0" }} , 
 	{ "name": "residualAdd_residual_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "q0" }} , 
 	{ "name": "residualAdd_residual_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "address1" }} , 
 	{ "name": "residualAdd_residual_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "ce1" }} , 
 	{ "name": "residualAdd_residual_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "q1" }} , 
 	{ "name": "residualAdd_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "address0" }} , 
 	{ "name": "residualAdd_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "ce0" }} , 
 	{ "name": "residualAdd_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "we0" }} , 
 	{ "name": "residualAdd_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "d0" }} , 
 	{ "name": "residualAdd_output_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "address1" }} , 
 	{ "name": "residualAdd_output_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "ce1" }} , 
 	{ "name": "residualAdd_output_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "we1" }} , 
 	{ "name": "residualAdd_output_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "d1" }}  ]}

set ArgLastReadFirstWriteLatency {
	RES_ADD {
		int8_activation {Type I LastRead 4 FirstWrite -1}
		residualAdd_residual {Type I LastRead 4 FirstWrite -1}
		residualAdd_output {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4", "Max" : "4"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "4"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	int8_activation { ap_memory {  { int8_activation_address0 mem_address 1 3 }  { int8_activation_ce0 mem_ce 1 1 }  { int8_activation_q0 mem_dout 0 8 }  { int8_activation_address1 MemPortADDR2 1 3 }  { int8_activation_ce1 MemPortCE2 1 1 }  { int8_activation_q1 MemPortDOUT2 0 8 } } }
	residualAdd_residual { ap_memory {  { residualAdd_residual_address0 mem_address 1 3 }  { residualAdd_residual_ce0 mem_ce 1 1 }  { residualAdd_residual_q0 mem_dout 0 8 }  { residualAdd_residual_address1 MemPortADDR2 1 3 }  { residualAdd_residual_ce1 MemPortCE2 1 1 }  { residualAdd_residual_q1 MemPortDOUT2 0 8 } } }
	residualAdd_output { ap_memory {  { residualAdd_output_address0 mem_address 1 3 }  { residualAdd_output_ce0 mem_ce 1 1 }  { residualAdd_output_we0 mem_we 1 1 }  { residualAdd_output_d0 mem_din 1 8 }  { residualAdd_output_address1 MemPortADDR2 1 3 }  { residualAdd_output_ce1 MemPortCE2 1 1 }  { residualAdd_output_we1 MemPortWE2 1 1 }  { residualAdd_output_d1 MemPortDIN2 1 8 } } }
}
