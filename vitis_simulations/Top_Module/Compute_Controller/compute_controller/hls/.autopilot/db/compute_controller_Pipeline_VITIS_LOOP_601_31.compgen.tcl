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
    id 193 \
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
    id 189 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_125 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_125 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_125 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 190 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_126 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_126 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_126 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 191 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_127 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_127 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_127 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 192 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_128 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_128 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_128 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 194 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_183_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_183_out \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_183_out { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_183_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 195 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_184_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_184_out \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_184_out { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_184_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 196 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_185_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_185_out \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_185_out { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_185_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 197 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_186_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_186_out \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_186_out { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_186_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 198 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_64 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_64 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_64 { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_64_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 199 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_63 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_63 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_63 { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_63_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 200 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_62 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_62 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_62 { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_62_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 201 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_61 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_61 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_61 { O 16 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_61_ap_vld { O 1 bit } } \
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


