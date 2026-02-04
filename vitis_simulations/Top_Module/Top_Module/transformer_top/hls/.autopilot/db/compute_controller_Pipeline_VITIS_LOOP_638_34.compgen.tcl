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
    id 105 \
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


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 106 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 107 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 108 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 109 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 110 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 111 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 112 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 113 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 114 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 115 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 116 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 117 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 118 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 119 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 120 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 121 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54'"
}
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


