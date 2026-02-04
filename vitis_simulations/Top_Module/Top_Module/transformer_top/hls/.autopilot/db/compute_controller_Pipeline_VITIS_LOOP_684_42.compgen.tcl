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
    id 78 \
    name in_buf \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename in_buf \
    op interface \
    ports { in_buf_address0 { O 8 vector } in_buf_ce0 { O 1 bit } in_buf_q0 { I 8 vector } in_buf_address1 { O 8 vector } in_buf_ce1 { O 1 bit } in_buf_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'in_buf'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 74 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 75 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 76 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 77 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 79 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_271_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_271_out \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_271_out { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_271_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 80 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_272_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_272_out \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_272_out { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_272_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 81 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_273_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_273_out \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_273_out { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_273_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 82 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_274_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_274_out \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_274_out { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_274_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 83 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64 { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 84 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63 { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 85 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62 { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 86 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61 { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 87 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_60 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_60 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_60 { O 16 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_60_ap_vld { O 1 bit } } \
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
set InstName transformer_top_flow_control_loop_pipe_sequential_init_U
set CompName transformer_top_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix transformer_top_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


