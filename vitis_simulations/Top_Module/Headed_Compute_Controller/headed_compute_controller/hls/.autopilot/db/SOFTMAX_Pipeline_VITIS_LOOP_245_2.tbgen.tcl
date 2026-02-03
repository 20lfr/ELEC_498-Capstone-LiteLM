set moduleName SOFTMAX_Pipeline_VITIS_LOOP_245_2
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
set C_modelName {SOFTMAX_Pipeline_VITIS_LOOP_245_2}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict soft_in { MEM_WIDTH 16 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ max_val_1_reload int 16 regular  }
	{ exp_buf_15_out int 16 regular {pointer 1}  }
	{ exp_buf_14_out int 16 regular {pointer 1}  }
	{ exp_buf_13_out int 16 regular {pointer 1}  }
	{ exp_buf_12_out int 16 regular {pointer 1}  }
	{ exp_buf_11_out int 16 regular {pointer 1}  }
	{ exp_buf_10_out int 16 regular {pointer 1}  }
	{ exp_buf_9_out int 16 regular {pointer 1}  }
	{ exp_buf_8_out int 16 regular {pointer 1}  }
	{ exp_buf_7_out int 16 regular {pointer 1}  }
	{ exp_buf_6_out int 16 regular {pointer 1}  }
	{ exp_buf_5_out int 16 regular {pointer 1}  }
	{ exp_buf_4_out int 16 regular {pointer 1}  }
	{ exp_buf_3_out int 16 regular {pointer 1}  }
	{ exp_buf_2_out int 16 regular {pointer 1}  }
	{ exp_buf_1_out int 16 regular {pointer 1}  }
	{ exp_buf_out int 16 regular {pointer 1}  }
	{ sum_exp_out int 19 regular {pointer 1}  }
	{ soft_in int 16 regular {array 16 { 1 3 } 1 1 } {global 0}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "max_val_1_reload", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "exp_buf_15_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_14_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_13_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_12_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_11_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_10_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_9_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_8_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_7_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_6_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_5_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_4_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_3_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_2_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_1_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "exp_buf_out", "interface" : "wire", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "sum_exp_out", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY"} , 
 	{ "Name" : "soft_in", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 44
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ max_val_1_reload sc_in sc_lv 16 signal 0 } 
	{ exp_buf_15_out sc_out sc_lv 16 signal 1 } 
	{ exp_buf_15_out_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ exp_buf_14_out sc_out sc_lv 16 signal 2 } 
	{ exp_buf_14_out_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ exp_buf_13_out sc_out sc_lv 16 signal 3 } 
	{ exp_buf_13_out_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ exp_buf_12_out sc_out sc_lv 16 signal 4 } 
	{ exp_buf_12_out_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ exp_buf_11_out sc_out sc_lv 16 signal 5 } 
	{ exp_buf_11_out_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ exp_buf_10_out sc_out sc_lv 16 signal 6 } 
	{ exp_buf_10_out_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ exp_buf_9_out sc_out sc_lv 16 signal 7 } 
	{ exp_buf_9_out_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ exp_buf_8_out sc_out sc_lv 16 signal 8 } 
	{ exp_buf_8_out_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ exp_buf_7_out sc_out sc_lv 16 signal 9 } 
	{ exp_buf_7_out_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ exp_buf_6_out sc_out sc_lv 16 signal 10 } 
	{ exp_buf_6_out_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ exp_buf_5_out sc_out sc_lv 16 signal 11 } 
	{ exp_buf_5_out_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ exp_buf_4_out sc_out sc_lv 16 signal 12 } 
	{ exp_buf_4_out_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ exp_buf_3_out sc_out sc_lv 16 signal 13 } 
	{ exp_buf_3_out_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ exp_buf_2_out sc_out sc_lv 16 signal 14 } 
	{ exp_buf_2_out_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ exp_buf_1_out sc_out sc_lv 16 signal 15 } 
	{ exp_buf_1_out_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ exp_buf_out sc_out sc_lv 16 signal 16 } 
	{ exp_buf_out_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ sum_exp_out sc_out sc_lv 19 signal 17 } 
	{ sum_exp_out_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ soft_in_address0 sc_out sc_lv 4 signal 18 } 
	{ soft_in_ce0 sc_out sc_logic 1 signal 18 } 
	{ soft_in_q0 sc_in sc_lv 16 signal 18 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "max_val_1_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "max_val_1_reload", "role": "default" }} , 
 	{ "name": "exp_buf_15_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_15_out", "role": "default" }} , 
 	{ "name": "exp_buf_15_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_15_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_14_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_14_out", "role": "default" }} , 
 	{ "name": "exp_buf_14_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_14_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_13_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_13_out", "role": "default" }} , 
 	{ "name": "exp_buf_13_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_13_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_12_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_12_out", "role": "default" }} , 
 	{ "name": "exp_buf_12_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_12_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_11_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_11_out", "role": "default" }} , 
 	{ "name": "exp_buf_11_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_11_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_10_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_10_out", "role": "default" }} , 
 	{ "name": "exp_buf_10_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_10_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_9_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_9_out", "role": "default" }} , 
 	{ "name": "exp_buf_9_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_9_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_8_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_8_out", "role": "default" }} , 
 	{ "name": "exp_buf_8_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_8_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_7_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_7_out", "role": "default" }} , 
 	{ "name": "exp_buf_7_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_7_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_6_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_6_out", "role": "default" }} , 
 	{ "name": "exp_buf_6_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_6_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_5_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_5_out", "role": "default" }} , 
 	{ "name": "exp_buf_5_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_5_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_4_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_4_out", "role": "default" }} , 
 	{ "name": "exp_buf_4_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_4_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_3_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_3_out", "role": "default" }} , 
 	{ "name": "exp_buf_3_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_3_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_2_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_2_out", "role": "default" }} , 
 	{ "name": "exp_buf_2_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_2_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_1_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_1_out", "role": "default" }} , 
 	{ "name": "exp_buf_1_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_1_out", "role": "ap_vld" }} , 
 	{ "name": "exp_buf_out", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "exp_buf_out", "role": "default" }} , 
 	{ "name": "exp_buf_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "exp_buf_out", "role": "ap_vld" }} , 
 	{ "name": "sum_exp_out", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "sum_exp_out", "role": "default" }} , 
 	{ "name": "sum_exp_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "sum_exp_out", "role": "ap_vld" }} , 
 	{ "name": "soft_in_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "soft_in", "role": "address0" }} , 
 	{ "name": "soft_in_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "soft_in", "role": "ce0" }} , 
 	{ "name": "soft_in_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "soft_in", "role": "q0" }}  ]}

set ArgLastReadFirstWriteLatency {
	SOFTMAX_Pipeline_VITIS_LOOP_245_2 {
		max_val_1_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_15_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_14_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_13_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_12_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_11_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_10_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_9_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_8_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_7_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_6_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_5_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_4_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_3_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_2_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_1_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_out {Type O LastRead -1 FirstWrite 1}
		sum_exp_out {Type O LastRead -1 FirstWrite 1}
		soft_in {Type I LastRead 0 FirstWrite -1}
		exp_lut_q15 {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "19", "Max" : "19"}
	, {"Name" : "Interval", "Min" : "19", "Max" : "19"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	max_val_1_reload { ap_none {  { max_val_1_reload in_data 0 16 } } }
	exp_buf_15_out { ap_vld {  { exp_buf_15_out out_data 1 16 }  { exp_buf_15_out_ap_vld out_vld 1 1 } } }
	exp_buf_14_out { ap_vld {  { exp_buf_14_out out_data 1 16 }  { exp_buf_14_out_ap_vld out_vld 1 1 } } }
	exp_buf_13_out { ap_vld {  { exp_buf_13_out out_data 1 16 }  { exp_buf_13_out_ap_vld out_vld 1 1 } } }
	exp_buf_12_out { ap_vld {  { exp_buf_12_out out_data 1 16 }  { exp_buf_12_out_ap_vld out_vld 1 1 } } }
	exp_buf_11_out { ap_vld {  { exp_buf_11_out out_data 1 16 }  { exp_buf_11_out_ap_vld out_vld 1 1 } } }
	exp_buf_10_out { ap_vld {  { exp_buf_10_out out_data 1 16 }  { exp_buf_10_out_ap_vld out_vld 1 1 } } }
	exp_buf_9_out { ap_vld {  { exp_buf_9_out out_data 1 16 }  { exp_buf_9_out_ap_vld out_vld 1 1 } } }
	exp_buf_8_out { ap_vld {  { exp_buf_8_out out_data 1 16 }  { exp_buf_8_out_ap_vld out_vld 1 1 } } }
	exp_buf_7_out { ap_vld {  { exp_buf_7_out out_data 1 16 }  { exp_buf_7_out_ap_vld out_vld 1 1 } } }
	exp_buf_6_out { ap_vld {  { exp_buf_6_out out_data 1 16 }  { exp_buf_6_out_ap_vld out_vld 1 1 } } }
	exp_buf_5_out { ap_vld {  { exp_buf_5_out out_data 1 16 }  { exp_buf_5_out_ap_vld out_vld 1 1 } } }
	exp_buf_4_out { ap_vld {  { exp_buf_4_out out_data 1 16 }  { exp_buf_4_out_ap_vld out_vld 1 1 } } }
	exp_buf_3_out { ap_vld {  { exp_buf_3_out out_data 1 16 }  { exp_buf_3_out_ap_vld out_vld 1 1 } } }
	exp_buf_2_out { ap_vld {  { exp_buf_2_out out_data 1 16 }  { exp_buf_2_out_ap_vld out_vld 1 1 } } }
	exp_buf_1_out { ap_vld {  { exp_buf_1_out out_data 1 16 }  { exp_buf_1_out_ap_vld out_vld 1 1 } } }
	exp_buf_out { ap_vld {  { exp_buf_out out_data 1 16 }  { exp_buf_out_ap_vld out_vld 1 1 } } }
	sum_exp_out { ap_vld {  { sum_exp_out out_data 1 19 }  { sum_exp_out_ap_vld out_vld 1 1 } } }
	soft_in { ap_memory {  { soft_in_address0 mem_address 1 4 }  { soft_in_ce0 mem_ce 1 1 }  { soft_in_q0 mem_dout 0 16 } } }
}
