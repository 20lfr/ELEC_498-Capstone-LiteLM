set moduleName compute_controller_Pipeline_VITIS_LOOP_530_21
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
set cdfgNum 42
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_530_21}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 129 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ in_buf int 8 regular {array 129 { 1 1 } 1 1 }  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R int 8 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 76
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ in_buf_address0 sc_out sc_lv 8 signal 0 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 0 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 0 } 
	{ in_buf_address1 sc_out sc_lv 8 signal 0 } 
	{ in_buf_ce1 sc_out sc_logic 1 signal 0 } 
	{ in_buf_q1 sc_in sc_lv 8 signal 0 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 sc_out sc_lv 8 signal 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 sc_out sc_lv 8 signal 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 sc_out sc_lv 8 signal 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 sc_out sc_lv 8 signal 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 sc_out sc_lv 8 signal 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 sc_out sc_lv 8 signal 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 sc_out sc_lv 8 signal 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 sc_out sc_lv 8 signal 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 sc_out sc_lv 8 signal 9 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 sc_out sc_lv 8 signal 10 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 sc_out sc_lv 8 signal 11 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 sc_out sc_lv 8 signal 12 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 sc_out sc_lv 8 signal 13 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 sc_out sc_lv 8 signal 14 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 sc_out sc_lv 8 signal 15 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 sc_out sc_lv 8 signal 16 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 sc_out sc_lv 8 signal 17 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 sc_out sc_lv 8 signal 18 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 sc_out sc_lv 8 signal 19 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 sc_out sc_lv 8 signal 20 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 sc_out sc_lv 8 signal 21 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 sc_out sc_lv 8 signal 22 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 sc_out sc_lv 8 signal 23 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 sc_out sc_lv 8 signal 24 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 sc_out sc_lv 8 signal 25 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 sc_out sc_lv 8 signal 26 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 sc_out sc_lv 8 signal 27 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38_ap_vld sc_out sc_logic 1 outvld 27 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 sc_out sc_lv 8 signal 28 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 sc_out sc_lv 8 signal 29 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 sc_out sc_lv 8 signal 30 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 sc_out sc_lv 8 signal 31 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36_ap_vld sc_out sc_logic 1 outvld 31 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R sc_out sc_lv 8 signal 32 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_ap_vld sc_out sc_logic 1 outvld 32 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "in_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "address1" }} , 
 	{ "name": "in_buf_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce1" }} , 
 	{ "name": "in_buf_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q1" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_530_21 {
		in_buf {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "18", "Max" : "18"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 8 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 }  { in_buf_address1 MemPortADDR2 1 8 }  { in_buf_ce1 MemPortCE2 1 1 }  { in_buf_q1 MemPortDOUT2 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_ap_vld out_vld 1 1 } } }
}
