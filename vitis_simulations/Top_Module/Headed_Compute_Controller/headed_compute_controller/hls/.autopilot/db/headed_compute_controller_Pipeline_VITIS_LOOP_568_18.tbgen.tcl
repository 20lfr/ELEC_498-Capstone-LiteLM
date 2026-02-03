set moduleName headed_compute_controller_Pipeline_VITIS_LOOP_568_18
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
set cdfgNum 34
set C_modelName {headed_compute_controller_Pipeline_VITIS_LOOP_568_18}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 80 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ in_buf int 8 regular {array 80 { 1 3 } 1 1 }  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 int 8 regular {pointer 1} {global 1}  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 int 8 regular {pointer 1} {global 1}  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 int 8 regular {pointer 1} {global 1}  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 int 8 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 17
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ in_buf_address0 sc_out sc_lv 7 signal 0 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 0 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 0 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 sc_out sc_lv 8 signal 1 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 sc_out sc_lv 8 signal 2 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 sc_out sc_lv 8 signal 3 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 sc_out sc_lv 8 signal 4 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10_ap_vld sc_out sc_logic 1 outvld 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13", "role": "ap_vld" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12", "role": "ap_vld" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11", "role": "ap_vld" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	headed_compute_controller_Pipeline_VITIS_LOOP_568_18 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "6", "Max" : "6"}
	, {"Name" : "Interval", "Min" : "6", "Max" : "6"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 7 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 out_data 1 8 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13_ap_vld out_vld 1 1 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 out_data 1 8 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12_ap_vld out_vld 1 1 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 out_data 1 8 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11_ap_vld out_vld 1 1 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 out_data 1 8 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10_ap_vld out_vld 1 1 } } }
}
