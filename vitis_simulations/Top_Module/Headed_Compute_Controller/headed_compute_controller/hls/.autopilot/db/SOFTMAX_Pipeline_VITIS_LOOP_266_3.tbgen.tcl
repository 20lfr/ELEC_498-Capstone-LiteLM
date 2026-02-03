set moduleName SOFTMAX_Pipeline_VITIS_LOOP_266_3
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
set C_modelName {SOFTMAX_Pipeline_VITIS_LOOP_266_3}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict soft_out { MEM_WIDTH 15 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ exp_buf_reload int 16 regular  }
	{ exp_buf_1_reload int 16 regular  }
	{ exp_buf_2_reload int 16 regular  }
	{ exp_buf_3_reload int 16 regular  }
	{ exp_buf_4_reload int 16 regular  }
	{ exp_buf_5_reload int 16 regular  }
	{ exp_buf_6_reload int 16 regular  }
	{ exp_buf_7_reload int 16 regular  }
	{ exp_buf_8_reload int 16 regular  }
	{ exp_buf_9_reload int 16 regular  }
	{ exp_buf_10_reload int 16 regular  }
	{ exp_buf_11_reload int 16 regular  }
	{ exp_buf_12_reload int 16 regular  }
	{ exp_buf_13_reload int 16 regular  }
	{ exp_buf_14_reload int 16 regular  }
	{ exp_buf_15_reload int 16 regular  }
	{ inv_sum_q15_1 int 31 regular  }
	{ soft_out int 15 regular {array 16 { 0 3 } 0 1 } {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "exp_buf_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_1_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_2_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_3_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_4_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_5_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_6_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_7_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_8_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_9_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_10_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_11_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_12_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_13_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_14_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_15_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "inv_sum_q15_1", "interface" : "wire", "bitwidth" : 31, "direction" : "READONLY"} , 
 	{ "Name" : "soft_out", "interface" : "memory", "bitwidth" : 15, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 27
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ exp_buf_reload sc_in sc_lv 16 signal 0 } 
	{ exp_buf_1_reload sc_in sc_lv 16 signal 1 } 
	{ exp_buf_2_reload sc_in sc_lv 16 signal 2 } 
	{ exp_buf_3_reload sc_in sc_lv 16 signal 3 } 
	{ exp_buf_4_reload sc_in sc_lv 16 signal 4 } 
	{ exp_buf_5_reload sc_in sc_lv 16 signal 5 } 
	{ exp_buf_6_reload sc_in sc_lv 16 signal 6 } 
	{ exp_buf_7_reload sc_in sc_lv 16 signal 7 } 
	{ exp_buf_8_reload sc_in sc_lv 16 signal 8 } 
	{ exp_buf_9_reload sc_in sc_lv 16 signal 9 } 
	{ exp_buf_10_reload sc_in sc_lv 16 signal 10 } 
	{ exp_buf_11_reload sc_in sc_lv 16 signal 11 } 
	{ exp_buf_12_reload sc_in sc_lv 16 signal 12 } 
	{ exp_buf_13_reload sc_in sc_lv 16 signal 13 } 
	{ exp_buf_14_reload sc_in sc_lv 16 signal 14 } 
	{ exp_buf_15_reload sc_in sc_lv 16 signal 15 } 
	{ inv_sum_q15_1 sc_in sc_lv 31 signal 16 } 
	{ soft_out_address0 sc_out sc_lv 4 signal 17 } 
	{ soft_out_ce0 sc_out sc_logic 1 signal 17 } 
	{ soft_out_we0 sc_out sc_logic 1 signal 17 } 
	{ soft_out_d0 sc_out sc_lv 15 signal 17 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "exp_buf_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_reload", "role": "default" }} , 
 	{ "name": "exp_buf_1_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_1_reload", "role": "default" }} , 
 	{ "name": "exp_buf_2_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_2_reload", "role": "default" }} , 
 	{ "name": "exp_buf_3_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_3_reload", "role": "default" }} , 
 	{ "name": "exp_buf_4_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_4_reload", "role": "default" }} , 
 	{ "name": "exp_buf_5_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_5_reload", "role": "default" }} , 
 	{ "name": "exp_buf_6_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_6_reload", "role": "default" }} , 
 	{ "name": "exp_buf_7_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_7_reload", "role": "default" }} , 
 	{ "name": "exp_buf_8_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_8_reload", "role": "default" }} , 
 	{ "name": "exp_buf_9_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_9_reload", "role": "default" }} , 
 	{ "name": "exp_buf_10_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_10_reload", "role": "default" }} , 
 	{ "name": "exp_buf_11_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_11_reload", "role": "default" }} , 
 	{ "name": "exp_buf_12_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_12_reload", "role": "default" }} , 
 	{ "name": "exp_buf_13_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_13_reload", "role": "default" }} , 
 	{ "name": "exp_buf_14_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_14_reload", "role": "default" }} , 
 	{ "name": "exp_buf_15_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_15_reload", "role": "default" }} , 
 	{ "name": "inv_sum_q15_1", "direction": "in", "datatype": "sc_lv", "bitwidth":31, "type": "signal", "bundle":{"name": "inv_sum_q15_1", "role": "default" }} , 
 	{ "name": "soft_out_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "soft_out", "role": "address0" }} , 
 	{ "name": "soft_out_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "soft_out", "role": "ce0" }} , 
 	{ "name": "soft_out_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "soft_out", "role": "we0" }} , 
 	{ "name": "soft_out_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "soft_out", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	SOFTMAX_Pipeline_VITIS_LOOP_266_3 {
		exp_buf_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_1_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_2_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_3_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_4_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_5_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_6_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_7_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_8_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_9_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_10_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_11_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_12_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_13_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_14_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_15_reload {Type I LastRead 0 FirstWrite -1}
		inv_sum_q15_1 {Type I LastRead 0 FirstWrite -1}
		soft_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "18", "Max" : "18"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	exp_buf_reload { ap_none {  { exp_buf_reload in_data 0 16 } } }
	exp_buf_1_reload { ap_none {  { exp_buf_1_reload in_data 0 16 } } }
	exp_buf_2_reload { ap_none {  { exp_buf_2_reload in_data 0 16 } } }
	exp_buf_3_reload { ap_none {  { exp_buf_3_reload in_data 0 16 } } }
	exp_buf_4_reload { ap_none {  { exp_buf_4_reload in_data 0 16 } } }
	exp_buf_5_reload { ap_none {  { exp_buf_5_reload in_data 0 16 } } }
	exp_buf_6_reload { ap_none {  { exp_buf_6_reload in_data 0 16 } } }
	exp_buf_7_reload { ap_none {  { exp_buf_7_reload in_data 0 16 } } }
	exp_buf_8_reload { ap_none {  { exp_buf_8_reload in_data 0 16 } } }
	exp_buf_9_reload { ap_none {  { exp_buf_9_reload in_data 0 16 } } }
	exp_buf_10_reload { ap_none {  { exp_buf_10_reload in_data 0 16 } } }
	exp_buf_11_reload { ap_none {  { exp_buf_11_reload in_data 0 16 } } }
	exp_buf_12_reload { ap_none {  { exp_buf_12_reload in_data 0 16 } } }
	exp_buf_13_reload { ap_none {  { exp_buf_13_reload in_data 0 16 } } }
	exp_buf_14_reload { ap_none {  { exp_buf_14_reload in_data 0 16 } } }
	exp_buf_15_reload { ap_none {  { exp_buf_15_reload in_data 0 16 } } }
	inv_sum_q15_1 { ap_none {  { inv_sum_q15_1 in_data 0 31 } } }
	soft_out { ap_memory {  { soft_out_address0 mem_address 1 4 }  { soft_out_ce0 mem_ce 1 1 }  { soft_out_we0 mem_we 1 1 }  { soft_out_d0 mem_din 1 15 } } }
}
