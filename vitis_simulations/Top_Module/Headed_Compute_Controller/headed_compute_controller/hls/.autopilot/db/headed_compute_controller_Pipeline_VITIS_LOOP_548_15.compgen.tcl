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
    id 204 \
    name in_buf \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename in_buf \
    op interface \
    ports { in_buf_address0 { O 7 vector } in_buf_ce0 { O 1 bit } in_buf_q0 { I 8 vector } in_buf_address1 { O 7 vector } in_buf_ce1 { O 1 bit } in_buf_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'in_buf'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 205 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_3 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_3 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_3 { O 32 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_3_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 206 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_2 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_2 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_2 { O 32 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_2_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 207 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_1 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_1 { O 32 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_1_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 208 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b { O 32 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_ap_vld { O 1 bit } } \
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


