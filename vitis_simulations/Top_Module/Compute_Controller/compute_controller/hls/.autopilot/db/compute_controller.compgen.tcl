# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 31 \
    name OUT_PROJ_valueA \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename OUT_PROJ_valueA \
    op interface \
    ports { OUT_PROJ_valueA_address0 { O 3 vector } OUT_PROJ_valueA_ce0 { O 1 bit } OUT_PROJ_valueA_q0 { I 8 vector } OUT_PROJ_valueA_address1 { O 3 vector } OUT_PROJ_valueA_ce1 { O 1 bit } OUT_PROJ_valueA_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'OUT_PROJ_valueA'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 32 \
    name OUT_PROJ_valueB \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename OUT_PROJ_valueB \
    op interface \
    ports { OUT_PROJ_valueB_address0 { O 4 vector } OUT_PROJ_valueB_ce0 { O 1 bit } OUT_PROJ_valueB_q0 { I 4 vector } OUT_PROJ_valueB_address1 { O 4 vector } OUT_PROJ_valueB_ce1 { O 1 bit } OUT_PROJ_valueB_q1 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'OUT_PROJ_valueB'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 33 \
    name OUT_PROJ_accum \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename OUT_PROJ_accum \
    op interface \
    ports { OUT_PROJ_accum_address0 { O 1 vector } OUT_PROJ_accum_ce0 { O 1 bit } OUT_PROJ_accum_we0 { O 1 bit } OUT_PROJ_accum_d0 { O 32 vector } OUT_PROJ_accum_address1 { O 1 vector } OUT_PROJ_accum_ce1 { O 1 bit } OUT_PROJ_accum_we1 { O 1 bit } OUT_PROJ_accum_d1 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'OUT_PROJ_accum'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 22 \
    name reset \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_reset \
    op interface \
    ports { reset { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 23 \
    name compute_start \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_start \
    op interface \
    ports { compute_start { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 24 \
    name compute_instruction \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_instruction \
    op interface \
    ports { compute_instruction { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 25 \
    name compute_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_ready \
    op interface \
    ports { compute_ready { O 1 vector } compute_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 26 \
    name compute_done \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_done \
    op interface \
    ports { compute_done { O 1 vector } compute_done_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 27 \
    name mem_transfer_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_transfer_done \
    op interface \
    ports { mem_transfer_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 28 \
    name mem_read_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_read_request \
    op interface \
    ports { mem_read_request { O 1 vector } mem_read_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 29 \
    name mem_write_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_write_request \
    op interface \
    ports { mem_write_request { O 1 vector } mem_write_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 30 \
    name mem_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_op \
    op interface \
    ports { mem_op { O 32 vector } mem_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 34 \
    name error \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_error \
    op interface \
    ports { error { O 1 vector } error_ap_vld { O 1 bit } } \
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


