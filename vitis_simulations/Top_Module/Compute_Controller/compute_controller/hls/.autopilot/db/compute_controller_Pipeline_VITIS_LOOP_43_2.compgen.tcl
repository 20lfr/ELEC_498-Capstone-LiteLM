# This script segment is generated automatically by AutoPilot

set name compute_controller_mul_8s_4s_12_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_mac_muladd_8s_4s_12s_32_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 31 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_address0 { O 5 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9_q0 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 32 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_address0 { O 3 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 33 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_address0 { O 5 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8_q0 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 34 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_address0 { O 3 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 35 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_address0 { O 5 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7_q0 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 36 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_address0 { O 3 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 37 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_address0 { O 5 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6_q0 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 38 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_address0 { O 3 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 28 \
    name sext_ln42 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_sext_ln42 \
    op interface \
    ports { sext_ln42 { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 29 \
    name mul_ln45 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mul_ln45 \
    op interface \
    ports { mul_ln45 { I 5 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 30 \
    name acc_2_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_acc_2_out \
    op interface \
    ports { acc_2_out { O 32 vector } acc_2_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName compute_controller_flow_control_loop_pipe_sequential_init_U
set CompName compute_controller_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix compute_controller_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


