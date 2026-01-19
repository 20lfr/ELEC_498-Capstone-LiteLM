set moduleName compute_controller_Pipeline_VITIS_LOOP_113_1
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
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
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_113_1}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict FFN1_biases { MEM_WIDTH 4 MEM_SIZE 2 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN1_weights1 { MEM_WIDTH 4 MEM_SIZE 16 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN1_scale { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN1_output { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ FFN1_biases int 4 regular {array 2 { 1 3 } 1 1 }  }
	{ FFN1_weights1 int 4 regular {array 16 { 1 1 } 1 1 }  }
	{ FFN1_scale int 16 regular {array 2 { 1 3 } 1 1 }  }
	{ int8_activation_load_cast int 8 regular  }
	{ sext_ln113 int 8 regular  }
	{ int8_activation_load_6_cast int 8 regular  }
	{ int8_activation_load_5_cast int 8 regular  }
	{ int8_activation_load_4_cast int 8 regular  }
	{ int8_activation_load_3_cast int 8 regular  }
	{ int8_activation_load_2_cast int 8 regular  }
	{ int8_activation_load_1_cast int 8 regular  }
	{ FFN1_output int 16 regular {array 2 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "FFN1_biases", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN1_weights1", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN1_scale", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "int8_activation_load_cast", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "sext_ln113", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "int8_activation_load_6_cast", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "int8_activation_load_5_cast", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "int8_activation_load_4_cast", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "int8_activation_load_3_cast", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "int8_activation_load_2_cast", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "int8_activation_load_1_cast", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "FFN1_output", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 30
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ FFN1_biases_address0 sc_out sc_lv 1 signal 0 } 
	{ FFN1_biases_ce0 sc_out sc_logic 1 signal 0 } 
	{ FFN1_biases_q0 sc_in sc_lv 4 signal 0 } 
	{ FFN1_weights1_address0 sc_out sc_lv 4 signal 1 } 
	{ FFN1_weights1_ce0 sc_out sc_logic 1 signal 1 } 
	{ FFN1_weights1_q0 sc_in sc_lv 4 signal 1 } 
	{ FFN1_weights1_address1 sc_out sc_lv 4 signal 1 } 
	{ FFN1_weights1_ce1 sc_out sc_logic 1 signal 1 } 
	{ FFN1_weights1_q1 sc_in sc_lv 4 signal 1 } 
	{ FFN1_scale_address0 sc_out sc_lv 1 signal 2 } 
	{ FFN1_scale_ce0 sc_out sc_logic 1 signal 2 } 
	{ FFN1_scale_q0 sc_in sc_lv 16 signal 2 } 
	{ int8_activation_load_cast sc_in sc_lv 8 signal 3 } 
	{ sext_ln113 sc_in sc_lv 8 signal 4 } 
	{ int8_activation_load_6_cast sc_in sc_lv 8 signal 5 } 
	{ int8_activation_load_5_cast sc_in sc_lv 8 signal 6 } 
	{ int8_activation_load_4_cast sc_in sc_lv 8 signal 7 } 
	{ int8_activation_load_3_cast sc_in sc_lv 8 signal 8 } 
	{ int8_activation_load_2_cast sc_in sc_lv 8 signal 9 } 
	{ int8_activation_load_1_cast sc_in sc_lv 8 signal 10 } 
	{ FFN1_output_address0 sc_out sc_lv 1 signal 11 } 
	{ FFN1_output_ce0 sc_out sc_logic 1 signal 11 } 
	{ FFN1_output_we0 sc_out sc_logic 1 signal 11 } 
	{ FFN1_output_d0 sc_out sc_lv 16 signal 11 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "FFN1_biases_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_biases", "role": "address0" }} , 
 	{ "name": "FFN1_biases_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_biases", "role": "ce0" }} , 
 	{ "name": "FFN1_biases_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_biases", "role": "q0" }} , 
 	{ "name": "FFN1_weights1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "address0" }} , 
 	{ "name": "FFN1_weights1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "ce0" }} , 
 	{ "name": "FFN1_weights1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "q0" }} , 
 	{ "name": "FFN1_weights1_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "address1" }} , 
 	{ "name": "FFN1_weights1_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "ce1" }} , 
 	{ "name": "FFN1_weights1_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "q1" }} , 
 	{ "name": "FFN1_scale_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_scale", "role": "address0" }} , 
 	{ "name": "FFN1_scale_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_scale", "role": "ce0" }} , 
 	{ "name": "FFN1_scale_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN1_scale", "role": "q0" }} , 
 	{ "name": "int8_activation_load_cast", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation_load_cast", "role": "default" }} , 
 	{ "name": "sext_ln113", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "sext_ln113", "role": "default" }} , 
 	{ "name": "int8_activation_load_6_cast", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation_load_6_cast", "role": "default" }} , 
 	{ "name": "int8_activation_load_5_cast", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation_load_5_cast", "role": "default" }} , 
 	{ "name": "int8_activation_load_4_cast", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation_load_4_cast", "role": "default" }} , 
 	{ "name": "int8_activation_load_3_cast", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation_load_3_cast", "role": "default" }} , 
 	{ "name": "int8_activation_load_2_cast", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation_load_2_cast", "role": "default" }} , 
 	{ "name": "int8_activation_load_1_cast", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation_load_1_cast", "role": "default" }} , 
 	{ "name": "FFN1_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_output", "role": "address0" }} , 
 	{ "name": "FFN1_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_output", "role": "ce0" }} , 
 	{ "name": "FFN1_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_output", "role": "we0" }} , 
 	{ "name": "FFN1_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN1_output", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_113_1 {
		FFN1_biases {Type I LastRead 0 FirstWrite -1}
		FFN1_weights1 {Type I LastRead 4 FirstWrite -1}
		FFN1_scale {Type I LastRead 4 FirstWrite -1}
		int8_activation_load_cast {Type I LastRead 0 FirstWrite -1}
		sext_ln113 {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_6_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_5_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_4_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_3_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_2_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_1_cast {Type I LastRead 0 FirstWrite -1}
		FFN1_output {Type O LastRead -1 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "15", "Max" : "15"}
	, {"Name" : "Interval", "Min" : "15", "Max" : "15"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	FFN1_biases { ap_memory {  { FFN1_biases_address0 mem_address 1 1 }  { FFN1_biases_ce0 mem_ce 1 1 }  { FFN1_biases_q0 mem_dout 0 4 } } }
	FFN1_weights1 { ap_memory {  { FFN1_weights1_address0 mem_address 1 4 }  { FFN1_weights1_ce0 mem_ce 1 1 }  { FFN1_weights1_q0 mem_dout 0 4 }  { FFN1_weights1_address1 MemPortADDR2 1 4 }  { FFN1_weights1_ce1 MemPortCE2 1 1 }  { FFN1_weights1_q1 MemPortDOUT2 0 4 } } }
	FFN1_scale { ap_memory {  { FFN1_scale_address0 mem_address 1 1 }  { FFN1_scale_ce0 mem_ce 1 1 }  { FFN1_scale_q0 mem_dout 0 16 } } }
	int8_activation_load_cast { ap_none {  { int8_activation_load_cast in_data 0 8 } } }
	sext_ln113 { ap_none {  { sext_ln113 in_data 0 8 } } }
	int8_activation_load_6_cast { ap_none {  { int8_activation_load_6_cast in_data 0 8 } } }
	int8_activation_load_5_cast { ap_none {  { int8_activation_load_5_cast in_data 0 8 } } }
	int8_activation_load_4_cast { ap_none {  { int8_activation_load_4_cast in_data 0 8 } } }
	int8_activation_load_3_cast { ap_none {  { int8_activation_load_3_cast in_data 0 8 } } }
	int8_activation_load_2_cast { ap_none {  { int8_activation_load_2_cast in_data 0 8 } } }
	int8_activation_load_1_cast { ap_none {  { int8_activation_load_1_cast in_data 0 8 } } }
	FFN1_output { ap_memory {  { FFN1_output_address0 mem_address 1 1 }  { FFN1_output_ce0 mem_ce 1 1 }  { FFN1_output_we0 mem_we 1 1 }  { FFN1_output_d0 mem_din 1 16 } } }
}
