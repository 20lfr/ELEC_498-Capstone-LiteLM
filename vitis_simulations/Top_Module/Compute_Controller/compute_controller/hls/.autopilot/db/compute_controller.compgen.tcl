# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_RAM_Abkb BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_99_RAM_ArcU BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_149_RAM_Hfu BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_69_RAM_AXh4 BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_178_RAM_bdk BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_172_RAM_bjl BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_168_RAM_btn BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162_RAM_bzo BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40_RAM_AbZs BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20_RAM_Acfu BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_RAM_Acvx BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_189_RAM_dhF BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


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
    id 1629 \
    name in_buf \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename in_buf \
    op interface \
    ports { in_buf_address0 { O 13 vector } in_buf_ce0 { O 1 bit } in_buf_q0 { I 8 vector } in_buf_address1 { O 13 vector } in_buf_ce1 { O 1 bit } in_buf_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'in_buf'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 1630 \
    name out_buf \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename out_buf \
    op interface \
    ports { out_buf_address0 { O 10 vector } out_buf_ce0 { O 1 bit } out_buf_we0 { O 1 bit } out_buf_d0 { O 8 vector } out_buf_address1 { O 10 vector } out_buf_ce1 { O 1 bit } out_buf_we1 { O 1 bit } out_buf_d1 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'out_buf'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1620 \
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
    id 1621 \
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
    id 1622 \
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
    id 1623 \
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
    id 1624 \
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
    id 1625 \
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
    id 1626 \
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
    id 1627 \
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
    id 1628 \
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
    id 1631 \
    name dbg_state \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_state \
    op interface \
    ports { dbg_state { O 8 vector } dbg_state_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1632 \
    name dbg_req_instruction \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_instruction \
    op interface \
    ports { dbg_req_instruction { O 32 vector } dbg_req_instruction_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1633 \
    name dbg_req_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_op \
    op interface \
    ports { dbg_req_op { O 8 vector } dbg_req_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1634 \
    name dbg_req_layer \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_layer \
    op interface \
    ports { dbg_req_layer { O 8 vector } dbg_req_layer_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1635 \
    name dbg_req_head \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_head \
    op interface \
    ports { dbg_req_head { O 8 vector } dbg_req_head_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1636 \
    name dbg_req_tile \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_tile \
    op interface \
    ports { dbg_req_tile { O 8 vector } dbg_req_tile_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1637 \
    name dbg_mac_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_mac_start \
    op interface \
    ports { dbg_mac_start { O 1 vector } dbg_mac_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1638 \
    name dbg_mac_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_mac_ready \
    op interface \
    ports { dbg_mac_ready { O 1 vector } dbg_mac_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1639 \
    name dbg_mac_complete \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_mac_complete \
    op interface \
    ports { dbg_mac_complete { O 1 vector } dbg_mac_complete_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1640 \
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


