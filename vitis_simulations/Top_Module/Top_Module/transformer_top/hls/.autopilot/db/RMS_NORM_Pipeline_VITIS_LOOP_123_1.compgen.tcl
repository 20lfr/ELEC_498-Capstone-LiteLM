# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler transformer_top_sparsemux_33_4_8_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler transformer_top_mac_muladd_8s_8s_20s_20_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 284 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_431 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_431 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_431 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 285 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_432 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_432 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_432 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 286 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_433 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_433 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_433 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 287 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_434 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_434 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_434 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 288 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_435 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_435 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_435 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 289 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_436 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_436 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_436 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 290 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_437 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_437 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_437 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 291 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_438 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_438 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_438 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 292 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_439 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_439 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_439 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 293 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_440 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_440 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_440 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 294 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_234 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_234 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_234 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 295 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_235 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_235 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_235 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 296 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_236 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_236 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_236 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 297 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_237 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_237 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_237 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 298 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_238 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_238 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_238 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 299 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_239 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_239 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_239 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 300 \
    name square_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_square_out \
    op interface \
    ports { square_out { O 19 vector } square_out_ap_vld { O 1 bit } } \
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


