# This script segment is generated automatically by AutoPilot

set name scheduler_hls_mul_32s_32s_32_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler scheduler_hls_sparsemux_7_2_1_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {onehotencoding_realdef}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler scheduler_hls_sparsemux_7_2_1_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {onehotencoding_realdef}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 98 \
    name ctrl_mem \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_mem \
    op interface \
    ports { ctrl_mem { I 1056 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 99 \
    name axis_in_valid \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_valid \
    op interface \
    ports { axis_in_valid { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 100 \
    name axis_in_last \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_last \
    op interface \
    ports { axis_in_last { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 101 \
    name axis_in_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_ready \
    op interface \
    ports { axis_in_ready { O 1 vector } axis_in_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 102 \
    name memory_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_memory_request \
    op interface \
    ports { memory_request { O 1 vector } memory_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 103 \
    name dma_address \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dma_address \
    op interface \
    ports { dma_address { O 32 vector } dma_address_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 104 \
    name dma_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_dma_done \
    op interface \
    ports { dma_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 105 \
    name compute_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_ready \
    op interface \
    ports { compute_ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 106 \
    name compute_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_done \
    op interface \
    ports { compute_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 107 \
    name head_ctx_ref_0 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_0 \
    op interface \
    ports { head_ctx_ref_0_i { I 202 vector } head_ctx_ref_0_o { O 202 vector } head_ctx_ref_0_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 108 \
    name head_ctx_ref_1 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_1 \
    op interface \
    ports { head_ctx_ref_1_i { I 202 vector } head_ctx_ref_1_o { O 202 vector } head_ctx_ref_1_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 109 \
    name head_ctx_ref_2 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_2 \
    op interface \
    ports { head_ctx_ref_2_i { I 202 vector } head_ctx_ref_2_o { O 202 vector } head_ctx_ref_2_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 110 \
    name head_ctx_ref_3 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_3 \
    op interface \
    ports { head_ctx_ref_3_i { I 202 vector } head_ctx_ref_3_o { O 202 vector } head_ctx_ref_3_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 111 \
    name compute_start \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_start \
    op interface \
    ports { compute_start_i { I 1 vector } compute_start_o { O 1 vector } compute_start_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 112 \
    name compute_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_op \
    op interface \
    ports { compute_op { O 8 vector } compute_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 113 \
    name stream_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_ready \
    op interface \
    ports { stream_ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 114 \
    name stream_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_start \
    op interface \
    ports { stream_start { O 1 vector } stream_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 115 \
    name stream_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_done \
    op interface \
    ports { stream_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 116 \
    name done \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_done \
    op interface \
    ports { done { O 1 vector } done_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 117 \
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
    id 118 \
    name STATE \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_STATE \
    op interface \
    ports { STATE { O 32 vector } STATE_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 119 \
    name dbg_wl_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_ready \
    op interface \
    ports { dbg_wl_ready { O 1 vector } dbg_wl_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 120 \
    name dbg_wl_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_start \
    op interface \
    ports { dbg_wl_start { O 1 vector } dbg_wl_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 121 \
    name dbg_wl_addr_sel \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_addr_sel \
    op interface \
    ports { dbg_wl_addr_sel { O 8 vector } dbg_wl_addr_sel_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 122 \
    name dbg_wl_layer \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_layer \
    op interface \
    ports { dbg_wl_layer { O 32 vector } dbg_wl_layer_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 123 \
    name dbg_wl_head \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_head \
    op interface \
    ports { dbg_wl_head { O 32 vector } dbg_wl_head_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 124 \
    name dbg_wl_tile \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_tile \
    op interface \
    ports { dbg_wl_tile { O 32 vector } dbg_wl_tile_ap_vld { O 1 bit } } \
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


