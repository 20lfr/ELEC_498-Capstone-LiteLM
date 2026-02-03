# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler headed_compute_controller_sparsemux_33_4_20_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
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
    id 203 \
    name out_buf \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename out_buf \
    op interface \
    ports { out_buf_address0 { O 6 vector } out_buf_ce0 { O 1 bit } out_buf_we0 { O 1 bit } out_buf_d0 { O 8 vector } out_buf_address1 { O 6 vector } out_buf_ce1 { O 1 bit } out_buf_we1 { O 1 bit } out_buf_d1 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'out_buf'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 187 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 188 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 189 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 190 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 191 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 192 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 193 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 194 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 195 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 196 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 197 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 198 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 199 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 200 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 201 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 202 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 { I 20 vector } } \
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


