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
    id 175 \
    name in_buf \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename in_buf \
    op interface \
    ports { in_buf_address0 { O 8 vector } in_buf_ce0 { O 1 bit } in_buf_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'in_buf'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 176 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 177 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 178 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 179 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 180 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 181 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 182 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 183 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 184 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 185 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58_address0 { O 1 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58_ce0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58_we0 { O 1 bit } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 186 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 187 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 188 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 189 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 190 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 191 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18_address0 { O 1 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18_ce0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18_we0 { O 1 bit } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18'"
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


