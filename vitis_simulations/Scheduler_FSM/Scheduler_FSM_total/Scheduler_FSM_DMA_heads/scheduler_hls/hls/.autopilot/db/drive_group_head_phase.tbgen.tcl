set moduleName drive_group_head_phase
set isTopModule 0
set isCombinational 1
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
set cdfgNum 3
set C_modelName {drive_group_head_phase}
set C_modelType { int 171 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ p_read int 32 regular  }
	{ head_ctx_ref_layer_stamp_read int 32 regular  }
	{ head_ctx_ref_head_idx_val int 32 regular  }
	{ head_ctx_ref_phase_read_5 int 4 regular  }
	{ head_ctx_ref_phase_read int 4 regular  }
	{ p_read2 int 1 regular  }
	{ p_read7 int 1 regular  }
	{ p_read8 int 1 regular  }
	{ head_ctx_ref_compute_op_read int 4 regular  }
	{ head_ctx_ref_last_compute_op_read int 4 regular  }
	{ head_ctx_ref_last_wl_addr_read int 4 regular  }
	{ p_read12 int 1 regular  }
	{ p_read13 int 1 regular  }
	{ head_ctx_ref_wl_addr_sel_read int 4 regular  }
	{ p_read15 int 32 regular  }
	{ p_read16 int 32 regular  }
	{ p_read17 int 1 regular  }
	{ p_read19 int 1 regular  }
	{ p_read20 int 1 regular  }
	{ p_read21 int 1 regular  }
	{ p_read22 int 1 regular  }
	{ p_read23 int 1 regular  }
	{ p_read24 int 1 regular  }
	{ p_read25 int 1 regular  }
	{ p_read26 int 1 regular  }
	{ p_read27 int 1 regular  }
	{ p_read28 int 1 regular  }
	{ p_read29 int 1 regular  }
	{ p_read30 int 1 regular  }
	{ p_read31 int 1 regular  }
	{ p_read32 int 1 regular  }
	{ p_read33 int 1 regular  }
	{ p_read34 int 1 regular  }
	{ p_read35 int 1 regular  }
	{ p_read36 int 1 regular  }
	{ p_read37 int 1 regular  }
	{ p_read38 int 1 regular  }
	{ p_read39 int 1 regular  }
	{ p_read40 int 1 regular  }
	{ p_read41 int 1 regular  }
	{ p_read42 int 1 regular  }
	{ p_read43 int 1 regular  }
	{ p_read44 int 1 regular  }
	{ p_read45 int 1 regular  }
	{ layer_idx int 32 regular  }
	{ start_r uint 1 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "p_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_layer_stamp_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_head_idx_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_phase_read_5", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_phase_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "p_read2", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read7", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read8", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_compute_op_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_last_compute_op_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_last_wl_addr_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "p_read12", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read13", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_wl_addr_sel_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "p_read15", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read16", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read17", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read19", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read20", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read21", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read22", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read23", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read24", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read25", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read26", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read27", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read28", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read29", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read30", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read31", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read32", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read33", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read34", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read35", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read36", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read37", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read38", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read39", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read40", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read41", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read42", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read43", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read44", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read45", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "layer_idx", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "start_r", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 171} ]}
# RTL Port declarations: 
set portNum 91
set portList { 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ p_read sc_in sc_lv 32 signal 0 } 
	{ head_ctx_ref_layer_stamp_read sc_in sc_lv 32 signal 1 } 
	{ head_ctx_ref_head_idx_val sc_in sc_lv 32 signal 2 } 
	{ head_ctx_ref_phase_read_5 sc_in sc_lv 4 signal 3 } 
	{ head_ctx_ref_phase_read sc_in sc_lv 4 signal 4 } 
	{ p_read2 sc_in sc_lv 1 signal 5 } 
	{ p_read7 sc_in sc_lv 1 signal 6 } 
	{ p_read8 sc_in sc_lv 1 signal 7 } 
	{ head_ctx_ref_compute_op_read sc_in sc_lv 4 signal 8 } 
	{ head_ctx_ref_last_compute_op_read sc_in sc_lv 4 signal 9 } 
	{ head_ctx_ref_last_wl_addr_read sc_in sc_lv 4 signal 10 } 
	{ p_read12 sc_in sc_lv 1 signal 11 } 
	{ p_read13 sc_in sc_lv 1 signal 12 } 
	{ head_ctx_ref_wl_addr_sel_read sc_in sc_lv 4 signal 13 } 
	{ p_read15 sc_in sc_lv 32 signal 14 } 
	{ p_read16 sc_in sc_lv 32 signal 15 } 
	{ p_read17 sc_in sc_lv 1 signal 16 } 
	{ p_read19 sc_in sc_lv 1 signal 17 } 
	{ p_read20 sc_in sc_lv 1 signal 18 } 
	{ p_read21 sc_in sc_lv 1 signal 19 } 
	{ p_read22 sc_in sc_lv 1 signal 20 } 
	{ p_read23 sc_in sc_lv 1 signal 21 } 
	{ p_read24 sc_in sc_lv 1 signal 22 } 
	{ p_read25 sc_in sc_lv 1 signal 23 } 
	{ p_read26 sc_in sc_lv 1 signal 24 } 
	{ p_read27 sc_in sc_lv 1 signal 25 } 
	{ p_read28 sc_in sc_lv 1 signal 26 } 
	{ p_read29 sc_in sc_lv 1 signal 27 } 
	{ p_read30 sc_in sc_lv 1 signal 28 } 
	{ p_read31 sc_in sc_lv 1 signal 29 } 
	{ p_read32 sc_in sc_lv 1 signal 30 } 
	{ p_read33 sc_in sc_lv 1 signal 31 } 
	{ p_read34 sc_in sc_lv 1 signal 32 } 
	{ p_read35 sc_in sc_lv 1 signal 33 } 
	{ p_read36 sc_in sc_lv 1 signal 34 } 
	{ p_read37 sc_in sc_lv 1 signal 35 } 
	{ p_read38 sc_in sc_lv 1 signal 36 } 
	{ p_read39 sc_in sc_lv 1 signal 37 } 
	{ p_read40 sc_in sc_lv 1 signal 38 } 
	{ p_read41 sc_in sc_lv 1 signal 39 } 
	{ p_read42 sc_in sc_lv 1 signal 40 } 
	{ p_read43 sc_in sc_lv 1 signal 41 } 
	{ p_read44 sc_in sc_lv 1 signal 42 } 
	{ p_read45 sc_in sc_lv 1 signal 43 } 
	{ layer_idx sc_in sc_lv 32 signal 44 } 
	{ start_r sc_in sc_lv 1 signal 45 } 
	{ ap_return_0 sc_out sc_lv 1 signal -1 } 
	{ ap_return_1 sc_out sc_lv 1 signal -1 } 
	{ ap_return_2 sc_out sc_lv 1 signal -1 } 
	{ ap_return_3 sc_out sc_lv 1 signal -1 } 
	{ ap_return_4 sc_out sc_lv 8 signal -1 } 
	{ ap_return_5 sc_out sc_lv 8 signal -1 } 
	{ ap_return_6 sc_out sc_lv 8 signal -1 } 
	{ ap_return_7 sc_out sc_lv 1 signal -1 } 
	{ ap_return_8 sc_out sc_lv 1 signal -1 } 
	{ ap_return_9 sc_out sc_lv 8 signal -1 } 
	{ ap_return_10 sc_out sc_lv 32 signal -1 } 
	{ ap_return_11 sc_out sc_lv 32 signal -1 } 
	{ ap_return_12 sc_out sc_lv 1 signal -1 } 
	{ ap_return_13 sc_out sc_lv 1 signal -1 } 
	{ ap_return_14 sc_out sc_lv 1 signal -1 } 
	{ ap_return_15 sc_out sc_lv 1 signal -1 } 
	{ ap_return_16 sc_out sc_lv 1 signal -1 } 
	{ ap_return_17 sc_out sc_lv 1 signal -1 } 
	{ ap_return_18 sc_out sc_lv 1 signal -1 } 
	{ ap_return_19 sc_out sc_lv 1 signal -1 } 
	{ ap_return_20 sc_out sc_lv 1 signal -1 } 
	{ ap_return_21 sc_out sc_lv 1 signal -1 } 
	{ ap_return_22 sc_out sc_lv 1 signal -1 } 
	{ ap_return_23 sc_out sc_lv 1 signal -1 } 
	{ ap_return_24 sc_out sc_lv 1 signal -1 } 
	{ ap_return_25 sc_out sc_lv 1 signal -1 } 
	{ ap_return_26 sc_out sc_lv 1 signal -1 } 
	{ ap_return_27 sc_out sc_lv 1 signal -1 } 
	{ ap_return_28 sc_out sc_lv 1 signal -1 } 
	{ ap_return_29 sc_out sc_lv 1 signal -1 } 
	{ ap_return_30 sc_out sc_lv 1 signal -1 } 
	{ ap_return_31 sc_out sc_lv 1 signal -1 } 
	{ ap_return_32 sc_out sc_lv 1 signal -1 } 
	{ ap_return_33 sc_out sc_lv 1 signal -1 } 
	{ ap_return_34 sc_out sc_lv 1 signal -1 } 
	{ ap_return_35 sc_out sc_lv 1 signal -1 } 
	{ ap_return_36 sc_out sc_lv 1 signal -1 } 
	{ ap_return_37 sc_out sc_lv 1 signal -1 } 
	{ ap_return_38 sc_out sc_lv 1 signal -1 } 
	{ ap_return_39 sc_out sc_lv 1 signal -1 } 
	{ ap_return_40 sc_out sc_lv 1 signal -1 } 
	{ ap_return_41 sc_out sc_lv 32 signal -1 } 
	{ ap_return_42 sc_out sc_lv 8 signal -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
}
set NewPortList {[ 
	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "p_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read", "role": "default" }} , 
 	{ "name": "head_ctx_ref_layer_stamp_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "head_ctx_ref_layer_stamp_read", "role": "default" }} , 
 	{ "name": "head_ctx_ref_head_idx_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "head_ctx_ref_head_idx_val", "role": "default" }} , 
 	{ "name": "head_ctx_ref_phase_read_5", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_phase_read_5", "role": "default" }} , 
 	{ "name": "head_ctx_ref_phase_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_phase_read", "role": "default" }} , 
 	{ "name": "p_read2", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read2", "role": "default" }} , 
 	{ "name": "p_read7", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read7", "role": "default" }} , 
 	{ "name": "p_read8", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read8", "role": "default" }} , 
 	{ "name": "head_ctx_ref_compute_op_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_compute_op_read", "role": "default" }} , 
 	{ "name": "head_ctx_ref_last_compute_op_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_last_compute_op_read", "role": "default" }} , 
 	{ "name": "head_ctx_ref_last_wl_addr_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_last_wl_addr_read", "role": "default" }} , 
 	{ "name": "p_read12", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read12", "role": "default" }} , 
 	{ "name": "p_read13", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read13", "role": "default" }} , 
 	{ "name": "head_ctx_ref_wl_addr_sel_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_wl_addr_sel_read", "role": "default" }} , 
 	{ "name": "p_read15", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read15", "role": "default" }} , 
 	{ "name": "p_read16", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read16", "role": "default" }} , 
 	{ "name": "p_read17", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read17", "role": "default" }} , 
 	{ "name": "p_read19", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read19", "role": "default" }} , 
 	{ "name": "p_read20", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read20", "role": "default" }} , 
 	{ "name": "p_read21", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read21", "role": "default" }} , 
 	{ "name": "p_read22", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read22", "role": "default" }} , 
 	{ "name": "p_read23", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read23", "role": "default" }} , 
 	{ "name": "p_read24", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read24", "role": "default" }} , 
 	{ "name": "p_read25", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read25", "role": "default" }} , 
 	{ "name": "p_read26", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read26", "role": "default" }} , 
 	{ "name": "p_read27", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read27", "role": "default" }} , 
 	{ "name": "p_read28", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read28", "role": "default" }} , 
 	{ "name": "p_read29", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read29", "role": "default" }} , 
 	{ "name": "p_read30", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read30", "role": "default" }} , 
 	{ "name": "p_read31", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read31", "role": "default" }} , 
 	{ "name": "p_read32", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read32", "role": "default" }} , 
 	{ "name": "p_read33", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read33", "role": "default" }} , 
 	{ "name": "p_read34", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read34", "role": "default" }} , 
 	{ "name": "p_read35", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read35", "role": "default" }} , 
 	{ "name": "p_read36", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read36", "role": "default" }} , 
 	{ "name": "p_read37", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read37", "role": "default" }} , 
 	{ "name": "p_read38", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read38", "role": "default" }} , 
 	{ "name": "p_read39", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read39", "role": "default" }} , 
 	{ "name": "p_read40", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read40", "role": "default" }} , 
 	{ "name": "p_read41", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read41", "role": "default" }} , 
 	{ "name": "p_read42", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read42", "role": "default" }} , 
 	{ "name": "p_read43", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read43", "role": "default" }} , 
 	{ "name": "p_read44", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read44", "role": "default" }} , 
 	{ "name": "p_read45", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read45", "role": "default" }} , 
 	{ "name": "layer_idx", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layer_idx", "role": "default" }} , 
 	{ "name": "start_r", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "start_r", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_return_6", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_6", "role": "default" }} , 
 	{ "name": "ap_return_7", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_7", "role": "default" }} , 
 	{ "name": "ap_return_8", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_8", "role": "default" }} , 
 	{ "name": "ap_return_9", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_9", "role": "default" }} , 
 	{ "name": "ap_return_10", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_10", "role": "default" }} , 
 	{ "name": "ap_return_11", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_11", "role": "default" }} , 
 	{ "name": "ap_return_12", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_12", "role": "default" }} , 
 	{ "name": "ap_return_13", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_13", "role": "default" }} , 
 	{ "name": "ap_return_14", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_14", "role": "default" }} , 
 	{ "name": "ap_return_15", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_15", "role": "default" }} , 
 	{ "name": "ap_return_16", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_16", "role": "default" }} , 
 	{ "name": "ap_return_17", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_17", "role": "default" }} , 
 	{ "name": "ap_return_18", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_18", "role": "default" }} , 
 	{ "name": "ap_return_19", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_19", "role": "default" }} , 
 	{ "name": "ap_return_20", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_20", "role": "default" }} , 
 	{ "name": "ap_return_21", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_21", "role": "default" }} , 
 	{ "name": "ap_return_22", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_22", "role": "default" }} , 
 	{ "name": "ap_return_23", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_23", "role": "default" }} , 
 	{ "name": "ap_return_24", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_24", "role": "default" }} , 
 	{ "name": "ap_return_25", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_25", "role": "default" }} , 
 	{ "name": "ap_return_26", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_26", "role": "default" }} , 
 	{ "name": "ap_return_27", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_27", "role": "default" }} , 
 	{ "name": "ap_return_28", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_28", "role": "default" }} , 
 	{ "name": "ap_return_29", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_29", "role": "default" }} , 
 	{ "name": "ap_return_30", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_30", "role": "default" }} , 
 	{ "name": "ap_return_31", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_31", "role": "default" }} , 
 	{ "name": "ap_return_32", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_32", "role": "default" }} , 
 	{ "name": "ap_return_33", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_33", "role": "default" }} , 
 	{ "name": "ap_return_34", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_34", "role": "default" }} , 
 	{ "name": "ap_return_35", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_35", "role": "default" }} , 
 	{ "name": "ap_return_36", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_36", "role": "default" }} , 
 	{ "name": "ap_return_37", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_37", "role": "default" }} , 
 	{ "name": "ap_return_38", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_38", "role": "default" }} , 
 	{ "name": "ap_return_39", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_39", "role": "default" }} , 
 	{ "name": "ap_return_40", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_40", "role": "default" }} , 
 	{ "name": "ap_return_41", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_41", "role": "default" }} , 
 	{ "name": "ap_return_42", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_42", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	drive_group_head_phase {
		p_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_layer_stamp_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_head_idx_val {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read_5 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read7 {Type I LastRead 0 FirstWrite -1}
		p_read8 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_compute_op_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_compute_op_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_wl_addr_read {Type I LastRead 0 FirstWrite -1}
		p_read12 {Type I LastRead 0 FirstWrite -1}
		p_read13 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_wl_addr_sel_read {Type I LastRead 0 FirstWrite -1}
		p_read15 {Type I LastRead 0 FirstWrite -1}
		p_read16 {Type I LastRead 0 FirstWrite -1}
		p_read17 {Type I LastRead 0 FirstWrite -1}
		p_read19 {Type I LastRead 0 FirstWrite -1}
		p_read20 {Type I LastRead 0 FirstWrite -1}
		p_read21 {Type I LastRead 0 FirstWrite -1}
		p_read22 {Type I LastRead 0 FirstWrite -1}
		p_read23 {Type I LastRead 0 FirstWrite -1}
		p_read24 {Type I LastRead 0 FirstWrite -1}
		p_read25 {Type I LastRead 0 FirstWrite -1}
		p_read26 {Type I LastRead 0 FirstWrite -1}
		p_read27 {Type I LastRead 0 FirstWrite -1}
		p_read28 {Type I LastRead 0 FirstWrite -1}
		p_read29 {Type I LastRead 0 FirstWrite -1}
		p_read30 {Type I LastRead 0 FirstWrite -1}
		p_read31 {Type I LastRead 0 FirstWrite -1}
		p_read32 {Type I LastRead 0 FirstWrite -1}
		p_read33 {Type I LastRead 0 FirstWrite -1}
		p_read34 {Type I LastRead 0 FirstWrite -1}
		p_read35 {Type I LastRead 0 FirstWrite -1}
		p_read36 {Type I LastRead 0 FirstWrite -1}
		p_read37 {Type I LastRead 0 FirstWrite -1}
		p_read38 {Type I LastRead 0 FirstWrite -1}
		p_read39 {Type I LastRead 0 FirstWrite -1}
		p_read40 {Type I LastRead 0 FirstWrite -1}
		p_read41 {Type I LastRead 0 FirstWrite -1}
		p_read42 {Type I LastRead 0 FirstWrite -1}
		p_read43 {Type I LastRead 0 FirstWrite -1}
		p_read44 {Type I LastRead 0 FirstWrite -1}
		p_read45 {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	p_read { ap_none {  { p_read in_data 0 32 } } }
	head_ctx_ref_layer_stamp_read { ap_none {  { head_ctx_ref_layer_stamp_read in_data 0 32 } } }
	head_ctx_ref_head_idx_val { ap_none {  { head_ctx_ref_head_idx_val in_data 0 32 } } }
	head_ctx_ref_phase_read_5 { ap_none {  { head_ctx_ref_phase_read_5 in_data 0 4 } } }
	head_ctx_ref_phase_read { ap_none {  { head_ctx_ref_phase_read in_data 0 4 } } }
	p_read2 { ap_none {  { p_read2 in_data 0 1 } } }
	p_read7 { ap_none {  { p_read7 in_data 0 1 } } }
	p_read8 { ap_none {  { p_read8 in_data 0 1 } } }
	head_ctx_ref_compute_op_read { ap_none {  { head_ctx_ref_compute_op_read in_data 0 4 } } }
	head_ctx_ref_last_compute_op_read { ap_none {  { head_ctx_ref_last_compute_op_read in_data 0 4 } } }
	head_ctx_ref_last_wl_addr_read { ap_none {  { head_ctx_ref_last_wl_addr_read in_data 0 4 } } }
	p_read12 { ap_none {  { p_read12 in_data 0 1 } } }
	p_read13 { ap_none {  { p_read13 in_data 0 1 } } }
	head_ctx_ref_wl_addr_sel_read { ap_none {  { head_ctx_ref_wl_addr_sel_read in_data 0 4 } } }
	p_read15 { ap_none {  { p_read15 in_data 0 32 } } }
	p_read16 { ap_none {  { p_read16 in_data 0 32 } } }
	p_read17 { ap_none {  { p_read17 in_data 0 1 } } }
	p_read19 { ap_none {  { p_read19 in_data 0 1 } } }
	p_read20 { ap_none {  { p_read20 in_data 0 1 } } }
	p_read21 { ap_none {  { p_read21 in_data 0 1 } } }
	p_read22 { ap_none {  { p_read22 in_data 0 1 } } }
	p_read23 { ap_none {  { p_read23 in_data 0 1 } } }
	p_read24 { ap_none {  { p_read24 in_data 0 1 } } }
	p_read25 { ap_none {  { p_read25 in_data 0 1 } } }
	p_read26 { ap_none {  { p_read26 in_data 0 1 } } }
	p_read27 { ap_none {  { p_read27 in_data 0 1 } } }
	p_read28 { ap_none {  { p_read28 in_data 0 1 } } }
	p_read29 { ap_none {  { p_read29 in_data 0 1 } } }
	p_read30 { ap_none {  { p_read30 in_data 0 1 } } }
	p_read31 { ap_none {  { p_read31 in_data 0 1 } } }
	p_read32 { ap_none {  { p_read32 in_data 0 1 } } }
	p_read33 { ap_none {  { p_read33 in_data 0 1 } } }
	p_read34 { ap_none {  { p_read34 in_data 0 1 } } }
	p_read35 { ap_none {  { p_read35 in_data 0 1 } } }
	p_read36 { ap_none {  { p_read36 in_data 0 1 } } }
	p_read37 { ap_none {  { p_read37 in_data 0 1 } } }
	p_read38 { ap_none {  { p_read38 in_data 0 1 } } }
	p_read39 { ap_none {  { p_read39 in_data 0 1 } } }
	p_read40 { ap_none {  { p_read40 in_data 0 1 } } }
	p_read41 { ap_none {  { p_read41 in_data 0 1 } } }
	p_read42 { ap_none {  { p_read42 in_data 0 1 } } }
	p_read43 { ap_none {  { p_read43 in_data 0 1 } } }
	p_read44 { ap_none {  { p_read44 in_data 0 1 } } }
	p_read45 { ap_none {  { p_read45 in_data 0 1 } } }
	layer_idx { ap_none {  { layer_idx in_data 0 32 } } }
	start_r { ap_none {  { start_r in_data 0 1 } } }
}
