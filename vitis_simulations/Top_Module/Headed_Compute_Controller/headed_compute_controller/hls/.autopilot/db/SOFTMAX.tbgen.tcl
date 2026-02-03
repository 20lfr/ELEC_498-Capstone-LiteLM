set moduleName SOFTMAX
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
set cdfgNum 34
set C_modelName {SOFTMAX}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict soft_in { MEM_WIDTH 16 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict soft_out { MEM_WIDTH 15 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ soft_in int 16 regular {array 16 { 1 3 } 1 1 } {global 0}  }
	{ soft_out int 15 regular {array 16 { 0 3 } 0 1 } {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "soft_in", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "soft_out", "interface" : "memory", "bitwidth" : 15, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 13
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ soft_in_address0 sc_out sc_lv 4 signal 0 } 
	{ soft_in_ce0 sc_out sc_logic 1 signal 0 } 
	{ soft_in_q0 sc_in sc_lv 16 signal 0 } 
	{ soft_out_address0 sc_out sc_lv 4 signal 1 } 
	{ soft_out_ce0 sc_out sc_logic 1 signal 1 } 
	{ soft_out_we0 sc_out sc_logic 1 signal 1 } 
	{ soft_out_d0 sc_out sc_lv 15 signal 1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "soft_in_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "soft_in", "role": "address0" }} , 
 	{ "name": "soft_in_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "soft_in", "role": "ce0" }} , 
 	{ "name": "soft_in_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "soft_in", "role": "q0" }} , 
 	{ "name": "soft_out_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "soft_out", "role": "address0" }} , 
 	{ "name": "soft_out_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "soft_out", "role": "ce0" }} , 
 	{ "name": "soft_out_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "soft_out", "role": "we0" }} , 
 	{ "name": "soft_out_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "soft_out", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	SOFTMAX {
		soft_in {Type I LastRead 0 FirstWrite -1}
		exp_lut_q15 {Type I LastRead -1 FirstWrite -1}
		soft_out {Type O LastRead -1 FirstWrite 0}}
	SOFTMAX_Pipeline_VITIS_LOOP_232_1 {
		max_val {Type I LastRead 0 FirstWrite -1}
		max_val_1_out {Type O LastRead -1 FirstWrite 0}
		soft_in {Type I LastRead 0 FirstWrite -1}}
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
		exp_lut_q15 {Type I LastRead -1 FirstWrite -1}}
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
	{"Name" : "Latency", "Min" : "62", "Max" : "95"}
	, {"Name" : "Interval", "Min" : "62", "Max" : "95"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	soft_in { ap_memory {  { soft_in_address0 mem_address 1 4 }  { soft_in_ce0 mem_ce 1 1 }  { soft_in_q0 mem_dout 0 16 } } }
	soft_out { ap_memory {  { soft_out_address0 mem_address 1 4 }  { soft_out_ce0 mem_ce 1 1 }  { soft_out_we0 mem_we 1 1 }  { soft_out_d0 mem_din 1 15 } } }
}
