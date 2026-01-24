set moduleName compute_controller_Pipeline_VITIS_LOOP_375_4
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
set cdfgNum 23
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_375_4}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 4920 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E { MEM_WIDTH 8 MEM_SIZE 12 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ in_buf int 8 regular {array 4920 { 1 3 } 1 1 }  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E int 8 regular {array 12 { 0 3 } 0 1 } {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 73
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ in_buf_address0 sc_out sc_lv 13 signal 0 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 0 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_address0 sc_out sc_lv 4 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_ce0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_we0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_d0 sc_out sc_lv 8 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_address0 sc_out sc_lv 4 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_ce0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_we0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_d0 sc_out sc_lv 8 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_address0 sc_out sc_lv 4 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_ce0 sc_out sc_logic 1 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_we0 sc_out sc_logic 1 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_d0 sc_out sc_lv 8 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_address0 sc_out sc_lv 4 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_ce0 sc_out sc_logic 1 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_we0 sc_out sc_logic 1 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_d0 sc_out sc_lv 8 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_address0 sc_out sc_lv 4 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_ce0 sc_out sc_logic 1 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_we0 sc_out sc_logic 1 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_d0 sc_out sc_lv 8 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_address0 sc_out sc_lv 4 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_ce0 sc_out sc_logic 1 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_we0 sc_out sc_logic 1 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_d0 sc_out sc_lv 8 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_address0 sc_out sc_lv 4 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_ce0 sc_out sc_logic 1 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_we0 sc_out sc_logic 1 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_d0 sc_out sc_lv 8 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_address0 sc_out sc_lv 4 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_ce0 sc_out sc_logic 1 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_we0 sc_out sc_logic 1 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_d0 sc_out sc_lv 8 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_address0 sc_out sc_lv 4 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_ce0 sc_out sc_logic 1 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_we0 sc_out sc_logic 1 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_d0 sc_out sc_lv 8 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_address0 sc_out sc_lv 4 signal 10 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_ce0 sc_out sc_logic 1 signal 10 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_we0 sc_out sc_logic 1 signal 10 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_d0 sc_out sc_lv 8 signal 10 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_address0 sc_out sc_lv 4 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_ce0 sc_out sc_logic 1 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_we0 sc_out sc_logic 1 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_d0 sc_out sc_lv 8 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_address0 sc_out sc_lv 4 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_ce0 sc_out sc_logic 1 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_we0 sc_out sc_logic 1 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_d0 sc_out sc_lv 8 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_address0 sc_out sc_lv 4 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_ce0 sc_out sc_logic 1 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_we0 sc_out sc_logic 1 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_d0 sc_out sc_lv 8 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_address0 sc_out sc_lv 4 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_ce0 sc_out sc_logic 1 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_we0 sc_out sc_logic 1 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_d0 sc_out sc_lv 8 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_address0 sc_out sc_lv 4 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_ce0 sc_out sc_logic 1 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_we0 sc_out sc_logic 1 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_d0 sc_out sc_lv 8 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_address0 sc_out sc_lv 4 signal 16 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_ce0 sc_out sc_logic 1 signal 16 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_we0 sc_out sc_logic 1 signal 16 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_d0 sc_out sc_lv 8 signal 16 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":13, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_375_4 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "194", "Max" : "194"}
	, {"Name" : "Interval", "Min" : "194", "Max" : "194"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 13 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_d0 mem_din 1 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_address0 mem_address 1 4 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_d0 mem_din 1 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_address0 mem_address 1 4 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5_d0 mem_din 1 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_address0 mem_address 1 4 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4_d0 mem_din 1 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_address0 mem_address 1 4 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3_d0 mem_din 1 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_address0 mem_address 1 4 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2_d0 mem_din 1 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_address0 mem_address 1 4 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1_d0 mem_din 1 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_address0 mem_address 1 4 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_d0 mem_din 1 8 } } }
}
