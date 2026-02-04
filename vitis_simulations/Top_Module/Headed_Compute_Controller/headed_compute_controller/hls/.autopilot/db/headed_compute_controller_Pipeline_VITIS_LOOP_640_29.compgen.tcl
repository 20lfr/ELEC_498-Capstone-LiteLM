# This script segment is generated automatically by AutoPilot

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
    id 17 \
    name in_buf \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename in_buf \
    op interface \
    ports { in_buf_address0 { O 7 vector } in_buf_ce0 { O 1 bit } in_buf_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'in_buf'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 18 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 19 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 20 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 21 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 22 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 23 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 24 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 25 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 26 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 27 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 { O 8 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 28 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 { O 8 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 29 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 { O 8 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 30 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 { O 8 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 31 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 { O 8 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 32 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 { O 8 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 33 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s { O 8 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s_ap_vld { O 1 bit } } \
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
set InstName headed_compute_controller_flow_control_loop_pipe_sequential_init_U
set CompName headed_compute_controller_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix headed_compute_controller_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


