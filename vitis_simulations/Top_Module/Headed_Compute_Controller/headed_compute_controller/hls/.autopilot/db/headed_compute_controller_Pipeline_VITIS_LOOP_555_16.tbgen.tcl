set moduleName headed_compute_controller_Pipeline_VITIS_LOOP_555_16
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
set C_modelName {headed_compute_controller_Pipeline_VITIS_LOOP_555_16}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict out_buf { MEM_WIDTH 8 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ select_ln293 int 8 regular  }
	{ select_ln293_1 int 8 regular  }
	{ select_ln293_2 int 8 regular  }
	{ select_ln293_3 int 8 regular  }
	{ out_buf int 8 regular {array 64 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "select_ln293", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "select_ln293_1", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "select_ln293_2", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "select_ln293_3", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "out_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 14
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ select_ln293 sc_in sc_lv 8 signal 0 } 
	{ select_ln293_1 sc_in sc_lv 8 signal 1 } 
	{ select_ln293_2 sc_in sc_lv 8 signal 2 } 
	{ select_ln293_3 sc_in sc_lv 8 signal 3 } 
	{ out_buf_address0 sc_out sc_lv 6 signal 4 } 
	{ out_buf_ce0 sc_out sc_logic 1 signal 4 } 
	{ out_buf_we0 sc_out sc_logic 1 signal 4 } 
	{ out_buf_d0 sc_out sc_lv 8 signal 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "select_ln293", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "select_ln293", "role": "default" }} , 
 	{ "name": "select_ln293_1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "select_ln293_1", "role": "default" }} , 
 	{ "name": "select_ln293_2", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "select_ln293_2", "role": "default" }} , 
 	{ "name": "select_ln293_3", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "select_ln293_3", "role": "default" }} , 
 	{ "name": "out_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address0" }} , 
 	{ "name": "out_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce0" }} , 
 	{ "name": "out_buf_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we0" }} , 
 	{ "name": "out_buf_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	headed_compute_controller_Pipeline_VITIS_LOOP_555_16 {
		select_ln293 {Type I LastRead 0 FirstWrite -1}
		select_ln293_1 {Type I LastRead 0 FirstWrite -1}
		select_ln293_2 {Type I LastRead 0 FirstWrite -1}
		select_ln293_3 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "6", "Max" : "6"}
	, {"Name" : "Interval", "Min" : "6", "Max" : "6"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	select_ln293 { ap_none {  { select_ln293 in_data 0 8 } } }
	select_ln293_1 { ap_none {  { select_ln293_1 in_data 0 8 } } }
	select_ln293_2 { ap_none {  { select_ln293_2 in_data 0 8 } } }
	select_ln293_3 { ap_none {  { select_ln293_3 in_data 0 8 } } }
	out_buf { ap_memory {  { out_buf_address0 mem_address 1 6 }  { out_buf_ce0 mem_ce 1 1 }  { out_buf_we0 mem_we 1 1 }  { out_buf_d0 mem_din 1 8 } } }
}
