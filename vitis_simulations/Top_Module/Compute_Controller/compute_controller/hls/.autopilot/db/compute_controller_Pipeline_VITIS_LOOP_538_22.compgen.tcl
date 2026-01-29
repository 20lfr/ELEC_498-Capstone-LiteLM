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
    id 473 \
    name out_buf \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename out_buf \
    op interface \
    ports { out_buf_address0 { O 6 vector } out_buf_ce0 { O 1 bit } out_buf_we0 { O 1 bit } out_buf_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'out_buf'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 457 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_153 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_153 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_153 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 458 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_154 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_154 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_154 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 459 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_155 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_155 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_155 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 460 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_156 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_156 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_156 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 461 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_157 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_157 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_157 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 462 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_158 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_158 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_158 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 463 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 464 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 465 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 466 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 467 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_78 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_78 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_78 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 468 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_79 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_79 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_79 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 469 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_80 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_80 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_80 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 470 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_81 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_81 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_81 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 471 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_82 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_82 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_82 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 472 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_83 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_83 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_83 { I 8 vector } } \
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


