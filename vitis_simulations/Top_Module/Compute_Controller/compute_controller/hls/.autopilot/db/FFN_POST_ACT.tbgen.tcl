set moduleName FFN_POST_ACT
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
set C_modelName {FFN_POST_ACT}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict FFN2_input { MEM_WIDTH 16 MEM_SIZE 44 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_weights2 { MEM_WIDTH 4 MEM_SIZE 110 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_biases { MEM_WIDTH 4 MEM_SIZE 5 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_scale { MEM_WIDTH 16 MEM_SIZE 10 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_output { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ FFN2_input int 16 regular {array 22 { 1 1 } 1 1 }  }
	{ FFN2_weights2 int 4 regular {array 110 { 1 1 } 1 1 }  }
	{ FFN2_biases int 4 regular {array 5 { 1 3 } 1 1 }  }
	{ FFN2_scale int 16 regular {array 5 { 1 3 } 1 1 }  }
	{ FFN2_output int 32 regular {array 8 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "FFN2_input", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_weights2", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_biases", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_scale", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_output", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 28
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ FFN2_input_address0 sc_out sc_lv 5 signal 0 } 
	{ FFN2_input_ce0 sc_out sc_logic 1 signal 0 } 
	{ FFN2_input_q0 sc_in sc_lv 16 signal 0 } 
	{ FFN2_input_address1 sc_out sc_lv 5 signal 0 } 
	{ FFN2_input_ce1 sc_out sc_logic 1 signal 0 } 
	{ FFN2_input_q1 sc_in sc_lv 16 signal 0 } 
	{ FFN2_weights2_address0 sc_out sc_lv 7 signal 1 } 
	{ FFN2_weights2_ce0 sc_out sc_logic 1 signal 1 } 
	{ FFN2_weights2_q0 sc_in sc_lv 4 signal 1 } 
	{ FFN2_weights2_address1 sc_out sc_lv 7 signal 1 } 
	{ FFN2_weights2_ce1 sc_out sc_logic 1 signal 1 } 
	{ FFN2_weights2_q1 sc_in sc_lv 4 signal 1 } 
	{ FFN2_biases_address0 sc_out sc_lv 3 signal 2 } 
	{ FFN2_biases_ce0 sc_out sc_logic 1 signal 2 } 
	{ FFN2_biases_q0 sc_in sc_lv 4 signal 2 } 
	{ FFN2_scale_address0 sc_out sc_lv 3 signal 3 } 
	{ FFN2_scale_ce0 sc_out sc_logic 1 signal 3 } 
	{ FFN2_scale_q0 sc_in sc_lv 16 signal 3 } 
	{ FFN2_output_address0 sc_out sc_lv 3 signal 4 } 
	{ FFN2_output_ce0 sc_out sc_logic 1 signal 4 } 
	{ FFN2_output_we0 sc_out sc_logic 1 signal 4 } 
	{ FFN2_output_d0 sc_out sc_lv 32 signal 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "FFN2_input_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "FFN2_input", "role": "address0" }} , 
 	{ "name": "FFN2_input_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_input", "role": "ce0" }} , 
 	{ "name": "FFN2_input_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN2_input", "role": "q0" }} , 
 	{ "name": "FFN2_input_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "FFN2_input", "role": "address1" }} , 
 	{ "name": "FFN2_input_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_input", "role": "ce1" }} , 
 	{ "name": "FFN2_input_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN2_input", "role": "q1" }} , 
 	{ "name": "FFN2_weights2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "address0" }} , 
 	{ "name": "FFN2_weights2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "ce0" }} , 
 	{ "name": "FFN2_weights2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "q0" }} , 
 	{ "name": "FFN2_weights2_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "address1" }} , 
 	{ "name": "FFN2_weights2_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "ce1" }} , 
 	{ "name": "FFN2_weights2_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "q1" }} , 
 	{ "name": "FFN2_biases_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "FFN2_biases", "role": "address0" }} , 
 	{ "name": "FFN2_biases_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_biases", "role": "ce0" }} , 
 	{ "name": "FFN2_biases_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN2_biases", "role": "q0" }} , 
 	{ "name": "FFN2_scale_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "FFN2_scale", "role": "address0" }} , 
 	{ "name": "FFN2_scale_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_scale", "role": "ce0" }} , 
 	{ "name": "FFN2_scale_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN2_scale", "role": "q0" }} , 
 	{ "name": "FFN2_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "FFN2_output", "role": "address0" }} , 
 	{ "name": "FFN2_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_output", "role": "ce0" }} , 
 	{ "name": "FFN2_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_output", "role": "we0" }} , 
 	{ "name": "FFN2_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "FFN2_output", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	FFN_POST_ACT {
		FFN2_input {Type I LastRead 11 FirstWrite -1}
		FFN2_weights2 {Type I LastRead 11 FirstWrite -1}
		FFN2_biases {Type I LastRead 0 FirstWrite -1}
		FFN2_scale {Type I LastRead 11 FirstWrite -1}
		FFN2_output {Type O LastRead -1 FirstWrite 19}}
	FFN_POST_ACT_Pipeline_VITIS_LOOP_151_1 {
		FFN2_biases {Type I LastRead 0 FirstWrite -1}
		FFN2_weights2 {Type I LastRead 11 FirstWrite -1}
		FFN2_scale {Type I LastRead 11 FirstWrite -1}
		FFN2_input_load_12_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_11_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_10_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_9_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_8_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_7_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_6_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_5_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_4_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_3_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_2_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_1_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_cast {Type I LastRead 0 FirstWrite -1}
		sext_ln151 {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_20_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_19_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_18_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_17_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_16_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_15_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_14_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_13_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_output {Type O LastRead -1 FirstWrite 19}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "77", "Max" : "77"}
	, {"Name" : "Interval", "Min" : "77", "Max" : "77"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	FFN2_input { ap_memory {  { FFN2_input_address0 mem_address 1 5 }  { FFN2_input_ce0 mem_ce 1 1 }  { FFN2_input_q0 mem_dout 0 16 }  { FFN2_input_address1 MemPortADDR2 1 5 }  { FFN2_input_ce1 MemPortCE2 1 1 }  { FFN2_input_q1 MemPortDOUT2 0 16 } } }
	FFN2_weights2 { ap_memory {  { FFN2_weights2_address0 mem_address 1 7 }  { FFN2_weights2_ce0 mem_ce 1 1 }  { FFN2_weights2_q0 mem_dout 0 4 }  { FFN2_weights2_address1 MemPortADDR2 1 7 }  { FFN2_weights2_ce1 MemPortCE2 1 1 }  { FFN2_weights2_q1 MemPortDOUT2 0 4 } } }
	FFN2_biases { ap_memory {  { FFN2_biases_address0 mem_address 1 3 }  { FFN2_biases_ce0 mem_ce 1 1 }  { FFN2_biases_q0 mem_dout 0 4 } } }
	FFN2_scale { ap_memory {  { FFN2_scale_address0 mem_address 1 3 }  { FFN2_scale_ce0 mem_ce 1 1 }  { FFN2_scale_q0 mem_dout 0 16 } } }
	FFN2_output { ap_memory {  { FFN2_output_address0 mem_address 1 3 }  { FFN2_output_ce0 mem_ce 1 1 }  { FFN2_output_we0 mem_we 1 1 }  { FFN2_output_d0 mem_din 1 32 } } }
}
