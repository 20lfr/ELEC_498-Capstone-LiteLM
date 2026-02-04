set moduleName scheduler_hls
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
set cdfgNum 42
set C_modelName {scheduler_hls}
set C_modelType { int 892 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ ctrl_mem_control int 2 regular  }
	{ axis_in_valid uint 1 regular  }
	{ axis_in_last uint 1 regular  }
	{ dma_done uint 1 regular  }
	{ wl_ready uint 1 regular  }
	{ wl_instruction int 32 regular {pointer 1}  }
	{ wl_start_read int 1 regular  }
	{ compute_ready uint 1 regular  }
	{ compute_done uint 1 regular  }
	{ p_read1 int 214 regular  }
	{ p_read2 int 214 regular  }
	{ p_read3 int 214 regular  }
	{ p_read4 int 214 regular  }
	{ stream_ready uint 1 regular  }
	{ stream_done uint 1 regular  }
	{ compute_start int 1 regular {pointer 2} {global 2}  }
	{ compute_instruction int 32 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "ctrl_mem_control", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_valid", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_last", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "dma_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_start_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read1", "interface" : "wire", "bitwidth" : 214, "direction" : "READONLY"} , 
 	{ "Name" : "p_read2", "interface" : "wire", "bitwidth" : 214, "direction" : "READONLY"} , 
 	{ "Name" : "p_read3", "interface" : "wire", "bitwidth" : 214, "direction" : "READONLY"} , 
 	{ "Name" : "p_read4", "interface" : "wire", "bitwidth" : 214, "direction" : "READONLY"} , 
 	{ "Name" : "stream_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "stream_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "compute_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 892} ]}
# RTL Port declarations: 
set portNum 36
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ctrl_mem_control sc_in sc_lv 2 signal 0 } 
	{ axis_in_valid sc_in sc_lv 1 signal 1 } 
	{ axis_in_last sc_in sc_lv 1 signal 2 } 
	{ dma_done sc_in sc_lv 1 signal 3 } 
	{ wl_ready sc_in sc_lv 1 signal 4 } 
	{ wl_instruction sc_out sc_lv 32 signal 5 } 
	{ wl_instruction_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ wl_start_read sc_in sc_lv 1 signal 6 } 
	{ compute_ready sc_in sc_lv 1 signal 7 } 
	{ compute_done sc_in sc_lv 1 signal 8 } 
	{ p_read1 sc_in sc_lv 214 signal 9 } 
	{ p_read2 sc_in sc_lv 214 signal 10 } 
	{ p_read3 sc_in sc_lv 214 signal 11 } 
	{ p_read4 sc_in sc_lv 214 signal 12 } 
	{ stream_ready sc_in sc_lv 1 signal 13 } 
	{ stream_done sc_in sc_lv 1 signal 14 } 
	{ compute_start_i sc_in sc_lv 1 signal 15 } 
	{ compute_start_o sc_out sc_lv 1 signal 15 } 
	{ compute_start_o_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ compute_instruction sc_out sc_lv 32 signal 16 } 
	{ compute_instruction_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ ap_return_0 sc_out sc_lv 1 signal -1 } 
	{ ap_return_1 sc_out sc_lv 1 signal -1 } 
	{ ap_return_2 sc_out sc_lv 1 signal -1 } 
	{ ap_return_3 sc_out sc_lv 1 signal -1 } 
	{ ap_return_4 sc_out sc_lv 32 signal -1 } 
	{ ap_return_5 sc_out sc_lv 214 signal -1 } 
	{ ap_return_6 sc_out sc_lv 214 signal -1 } 
	{ ap_return_7 sc_out sc_lv 214 signal -1 } 
	{ ap_return_8 sc_out sc_lv 214 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ctrl_mem_control", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ctrl_mem_control", "role": "default" }} , 
 	{ "name": "axis_in_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_valid", "role": "default" }} , 
 	{ "name": "axis_in_last", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_last", "role": "default" }} , 
 	{ "name": "dma_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dma_done", "role": "default" }} , 
 	{ "name": "wl_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_ready", "role": "default" }} , 
 	{ "name": "wl_instruction", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_instruction", "role": "default" }} , 
 	{ "name": "wl_instruction_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_instruction", "role": "ap_vld" }} , 
 	{ "name": "wl_start_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_start_read", "role": "default" }} , 
 	{ "name": "compute_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_ready", "role": "default" }} , 
 	{ "name": "compute_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_done", "role": "default" }} , 
 	{ "name": "p_read1", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "p_read1", "role": "default" }} , 
 	{ "name": "p_read2", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "p_read2", "role": "default" }} , 
 	{ "name": "p_read3", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "p_read3", "role": "default" }} , 
 	{ "name": "p_read4", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "p_read4", "role": "default" }} , 
 	{ "name": "stream_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_ready", "role": "default" }} , 
 	{ "name": "stream_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_done", "role": "default" }} , 
 	{ "name": "compute_start_i", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "i" }} , 
 	{ "name": "compute_start_o", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "o" }} , 
 	{ "name": "compute_start_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_start", "role": "o_ap_vld" }} , 
 	{ "name": "compute_instruction", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_instruction", "role": "default" }} , 
 	{ "name": "compute_instruction_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_instruction", "role": "ap_vld" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_return_6", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "ap_return_6", "role": "default" }} , 
 	{ "name": "ap_return_7", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "ap_return_7", "role": "default" }} , 
 	{ "name": "ap_return_8", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "ap_return_8", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	scheduler_hls {
		ctrl_mem_control {Type I LastRead 0 FirstWrite -1}
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		dma_done {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_instruction {Type O LastRead -1 FirstWrite 1}
		wl_start_read {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read3 {Type I LastRead 0 FirstWrite -1}
		p_read4 {Type I LastRead 0 FirstWrite -1}
		stream_ready {Type I LastRead 0 FirstWrite -1}
		stream_done {Type I LastRead 0 FirstWrite -1}
		st {Type IO LastRead -1 FirstWrite -1}
		layer_idx {Type IO LastRead -1 FirstWrite -1}
		attn_started {Type IO LastRead -1 FirstWrite -1}
		group_idx {Type IO LastRead -1 FirstWrite -1}
		start_head_group {Type IO LastRead -1 FirstWrite -1}
		requant1_started {Type IO LastRead -1 FirstWrite -1}
		requant2_started {Type IO LastRead -1 FirstWrite -1}
		requant3_started {Type IO LastRead -1 FirstWrite -1}
		requant4_started {Type IO LastRead -1 FirstWrite -1}
		requant1_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant2_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant3_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant4_compute_done {Type IO LastRead -1 FirstWrite -1}
		concat_dma_done {Type IO LastRead -1 FirstWrite -1}
		concat_started {Type IO LastRead -1 FirstWrite -1}
		outproj_started {Type IO LastRead -1 FirstWrite -1}
		outproj_compute_done {Type IO LastRead -1 FirstWrite -1}
		wo_dma_done {Type IO LastRead -1 FirstWrite -1}
		w1_dma_done {Type IO LastRead -1 FirstWrite -1}
		w2_dma_done {Type IO LastRead -1 FirstWrite -1}
		resid0_started {Type IO LastRead -1 FirstWrite -1}
		resid0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln0_started {Type IO LastRead -1 FirstWrite -1}
		ln0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_act_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w2_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_stage {Type IO LastRead -1 FirstWrite -1}
		ffn_started {Type IO LastRead -1 FirstWrite -1}
		resid1_started {Type IO LastRead -1 FirstWrite -1}
		resid1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_started {Type IO LastRead -1 FirstWrite -1}
		ln1_compute_done {Type IO LastRead -1 FirstWrite -1}
		final_norm_started {Type IO LastRead -1 FirstWrite -1}
		final_norm_compute_done {Type IO LastRead -1 FirstWrite -1}
		axis_last_seen {Type IO LastRead -1 FirstWrite -1}
		stream_done_seen {Type IO LastRead -1 FirstWrite -1}
		stream_started {Type IO LastRead -1 FirstWrite -1}
		wo_tile {Type IO LastRead -1 FirstWrite -1}
		wo_dma_busy {Type IO LastRead -1 FirstWrite -1}
		wo_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w1_tile {Type IO LastRead -1 FirstWrite -1}
		w1_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w1_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w2_tile {Type IO LastRead -1 FirstWrite -1}
		w2_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w2_comp_busy {Type IO LastRead -1 FirstWrite -1}
		compute_start {Type IO LastRead 0 FirstWrite 1}
		compute_instruction {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	ctrl_mem_control { ap_none {  { ctrl_mem_control in_data 0 2 } } }
	axis_in_valid { ap_none {  { axis_in_valid in_data 0 1 } } }
	axis_in_last { ap_none {  { axis_in_last in_data 0 1 } } }
	dma_done { ap_none {  { dma_done in_data 0 1 } } }
	wl_ready { ap_none {  { wl_ready in_data 0 1 } } }
	wl_instruction { ap_vld {  { wl_instruction out_data 1 32 }  { wl_instruction_ap_vld out_vld 1 1 } } }
	wl_start_read { ap_none {  { wl_start_read in_data 0 1 } } }
	compute_ready { ap_none {  { compute_ready in_data 0 1 } } }
	compute_done { ap_none {  { compute_done in_data 0 1 } } }
	p_read1 { ap_none {  { p_read1 in_data 0 214 } } }
	p_read2 { ap_none {  { p_read2 in_data 0 214 } } }
	p_read3 { ap_none {  { p_read3 in_data 0 214 } } }
	p_read4 { ap_none {  { p_read4 in_data 0 214 } } }
	stream_ready { ap_none {  { stream_ready in_data 0 1 } } }
	stream_done { ap_none {  { stream_done in_data 0 1 } } }
	compute_start { ap_ovld {  { compute_start_i in_data 0 1 }  { compute_start_o out_data 1 1 }  { compute_start_o_ap_vld out_vld 1 1 } } }
	compute_instruction { ap_vld {  { compute_instruction out_data 1 32 }  { compute_instruction_ap_vld out_vld 1 1 } } }
}
