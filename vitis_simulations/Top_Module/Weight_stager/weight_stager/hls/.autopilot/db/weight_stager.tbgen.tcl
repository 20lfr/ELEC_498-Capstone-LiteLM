set moduleName weight_stager
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 1
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 2
set C_modelName {weight_stager}
set C_modelType { int 32 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ wl_start uint 1 regular  }
	{ wl_addr_sel uint 8 regular  }
	{ wl_layer int 32 regular  }
	{ wl_head int 32 regular  }
	{ wl_tile int 32 regular  }
	{ ctrl_mem int 1056 regular  }
	{ wl_ready int 1 regular {pointer 1}  }
	{ memory_request int 1 regular {pointer 1}  }
	{ error int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "wl_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_addr_sel", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "wl_layer", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "wl_head", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "wl_tile", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_mem", "interface" : "wire", "bitwidth" : 1056, "direction" : "READONLY"} , 
 	{ "Name" : "wl_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "memory_request", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "error", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 32} ]}
# RTL Port declarations: 
set portNum 19
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ wl_start sc_in sc_lv 1 signal 0 } 
	{ wl_addr_sel sc_in sc_lv 8 signal 1 } 
	{ wl_layer sc_in sc_lv 32 signal 2 } 
	{ wl_head sc_in sc_lv 32 signal 3 } 
	{ wl_tile sc_in sc_lv 32 signal 4 } 
	{ ctrl_mem sc_in sc_lv 1056 signal 5 } 
	{ wl_ready sc_out sc_lv 1 signal 6 } 
	{ wl_ready_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ memory_request sc_out sc_lv 1 signal 7 } 
	{ memory_request_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ error sc_out sc_lv 1 signal 8 } 
	{ error_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ ap_return sc_out sc_lv 32 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "wl_start", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_start", "role": "default" }} , 
 	{ "name": "wl_addr_sel", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "wl_addr_sel", "role": "default" }} , 
 	{ "name": "wl_layer", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_layer", "role": "default" }} , 
 	{ "name": "wl_head", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_head", "role": "default" }} , 
 	{ "name": "wl_tile", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_tile", "role": "default" }} , 
 	{ "name": "ctrl_mem", "direction": "in", "datatype": "sc_lv", "bitwidth":1056, "type": "signal", "bundle":{"name": "ctrl_mem", "role": "default" }} , 
 	{ "name": "wl_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_ready", "role": "default" }} , 
 	{ "name": "wl_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_ready", "role": "ap_vld" }} , 
 	{ "name": "memory_request", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "memory_request", "role": "default" }} , 
 	{ "name": "memory_request_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "memory_request", "role": "ap_vld" }} , 
 	{ "name": "error", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "error", "role": "default" }} , 
 	{ "name": "error_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "error", "role": "ap_vld" }} , 
 	{ "name": "ap_return", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	weight_stager {
		wl_start {Type I LastRead 0 FirstWrite -1}
		wl_addr_sel {Type I LastRead 0 FirstWrite -1}
		wl_layer {Type I LastRead 0 FirstWrite -1}
		wl_head {Type I LastRead 0 FirstWrite -1}
		wl_tile {Type I LastRead 0 FirstWrite -1}
		ctrl_mem {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type O LastRead -1 FirstWrite 0}
		memory_request {Type O LastRead -1 FirstWrite 0}
		error {Type O LastRead -1 FirstWrite 0}
		addr_latched {Type IO LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	wl_start { ap_none {  { wl_start in_data 0 1 } } }
	wl_addr_sel { ap_none {  { wl_addr_sel in_data 0 8 } } }
	wl_layer { ap_none {  { wl_layer in_data 0 32 } } }
	wl_head { ap_none {  { wl_head in_data 0 32 } } }
	wl_tile { ap_none {  { wl_tile in_data 0 32 } } }
	ctrl_mem { ap_none {  { ctrl_mem in_data 0 1056 } } }
	wl_ready { ap_vld {  { wl_ready out_data 1 1 }  { wl_ready_ap_vld out_vld 1 1 } } }
	memory_request { ap_vld {  { memory_request out_data 1 1 }  { memory_request_ap_vld out_vld 1 1 } } }
	error { ap_vld {  { error out_data 1 1 }  { error_ap_vld out_vld 1 1 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
