set moduleName REQUANT_D_MODEL_int32_to_int8
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
set cdfgNum 40
set C_modelName {REQUANT_D_MODEL_int32_to_int8}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ M int 32 regular  }
	{ n int 32 regular  }
	{ z_out int 32 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 int 32 regular {pointer 0} {global 0}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 int 32 regular {pointer 0} {global 0}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 int 32 regular {pointer 0} {global 0}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 int 32 regular {pointer 0} {global 0}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 int 32 regular {pointer 0} {global 0}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 int 32 regular {pointer 0} {global 0}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 int 32 regular {pointer 0} {global 0}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 int 8 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "M", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "n", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "z_out", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 57
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ M sc_in sc_lv 32 signal 0 } 
	{ n sc_in sc_lv 32 signal 1 } 
	{ z_out sc_in sc_lv 32 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 sc_in sc_lv 32 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 sc_in sc_lv 32 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 sc_in sc_lv 32 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 sc_in sc_lv 32 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 sc_in sc_lv 32 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 sc_in sc_lv 32 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 sc_in sc_lv 32 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 sc_in sc_lv 32 signal 10 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 sc_in sc_lv 32 signal 11 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 sc_in sc_lv 32 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 sc_in sc_lv 32 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 sc_in sc_lv 32 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 sc_in sc_lv 32 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 sc_in sc_lv 32 signal 16 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 sc_in sc_lv 32 signal 17 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 sc_in sc_lv 32 signal 18 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 sc_out sc_lv 8 signal 19 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 sc_out sc_lv 8 signal 20 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 sc_out sc_lv 8 signal 21 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 sc_out sc_lv 8 signal 22 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 sc_out sc_lv 8 signal 23 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 sc_out sc_lv 8 signal 24 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 sc_out sc_lv 8 signal 25 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 sc_out sc_lv 8 signal 26 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 sc_out sc_lv 8 signal 27 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21_ap_vld sc_out sc_logic 1 outvld 27 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 sc_out sc_lv 8 signal 28 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 sc_out sc_lv 8 signal 29 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 sc_out sc_lv 8 signal 30 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 sc_out sc_lv 8 signal 31 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51_ap_vld sc_out sc_logic 1 outvld 31 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 sc_out sc_lv 8 signal 32 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50_ap_vld sc_out sc_logic 1 outvld 32 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 sc_out sc_lv 8 signal 33 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49_ap_vld sc_out sc_logic 1 outvld 33 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 sc_out sc_lv 8 signal 34 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48_ap_vld sc_out sc_logic 1 outvld 34 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "M", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "M", "role": "default" }} , 
 	{ "name": "n", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "n", "role": "default" }} , 
 	{ "name": "z_out", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "z_out", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	REQUANT_D_MODEL_int32_to_int8 {
		M {Type I LastRead 0 FirstWrite -1}
		n {Type I LastRead 0 FirstWrite -1}
		z_out {Type I LastRead 1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	M { ap_none {  { M in_data 0 32 } } }
	n { ap_none {  { n in_data 0 32 } } }
	z_out { ap_none {  { z_out in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 in_data 0 32 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 in_data 0 32 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 in_data 0 32 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 in_data 0 32 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 in_data 0 32 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 in_data 0 32 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 in_data 0 32 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21_ap_vld out_vld 1 1 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 { ap_vld {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 out_data 1 8 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 { ap_vld {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 out_data 1 8 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 { ap_vld {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 out_data 1 8 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 { ap_vld {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 out_data 1 8 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 { ap_vld {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 out_data 1 8 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 { ap_vld {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 out_data 1 8 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 { ap_vld {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 out_data 1 8 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48_ap_vld out_vld 1 1 } } }
}
