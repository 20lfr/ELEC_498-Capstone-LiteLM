# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler transformer_top_sparsemux_33_4_16_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
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
    id 124 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 125 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 126 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 127 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 128 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 129 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 130 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 131 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 132 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 133 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 134 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 135 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 136 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 137 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 138 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 139 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 140 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 141 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 142 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 143 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 144 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 145 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 146 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 147 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 148 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 149 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 150 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 151 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 152 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 153 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 154 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 155 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60'"
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


