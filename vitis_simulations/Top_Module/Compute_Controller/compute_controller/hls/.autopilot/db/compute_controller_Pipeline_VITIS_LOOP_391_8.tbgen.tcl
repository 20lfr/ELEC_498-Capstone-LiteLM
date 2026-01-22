set moduleName compute_controller_Pipeline_VITIS_LOOP_391_8
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
set cdfgNum 11
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_391_8}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 { MEM_WIDTH 4 MEM_SIZE 2 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 { MEM_WIDTH 4 MEM_SIZE 2 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ byte_val_1 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 int 4 regular {array 2 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 int 4 regular {array 2 { 0 3 } 0 1 } {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "byte_val_1", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 15
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ byte_val_1 sc_in sc_lv 8 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_address0 sc_out sc_lv 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_ce0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_we0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_d0 sc_out sc_lv 4 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_address0 sc_out sc_lv 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_ce0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_we0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_d0 sc_out sc_lv 4 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "byte_val_1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "byte_val_1", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_391_8 {
		byte_val_1 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 {Type O LastRead -1 FirstWrite 0}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4", "Max" : "4"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "4"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	byte_val_1 { ap_none {  { byte_val_1 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_d0 mem_din 1 4 } } }
}
