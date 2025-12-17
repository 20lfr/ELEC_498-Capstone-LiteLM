#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_start", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_done", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_idle", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_ready", 1, hls_out, -1, "", "", 1),
	Port_Property("wl_start", 1, hls_in, 0, "ap_none", "in_data", 1),
	Port_Property("wl_addr_sel", 8, hls_in, 1, "ap_none", "in_data", 1),
	Port_Property("wl_layer", 32, hls_in, 2, "ap_none", "in_data", 1),
	Port_Property("wl_head", 32, hls_in, 3, "ap_none", "in_data", 1),
	Port_Property("wl_tile", 32, hls_in, 4, "ap_none", "in_data", 1),
	Port_Property("ctrl_mem", 1056, hls_in, 5, "ap_none", "in_data", 1),
	Port_Property("wl_ready", 1, hls_out, 6, "ap_vld", "out_data", 1),
	Port_Property("wl_ready_ap_vld", 1, hls_out, 6, "ap_vld", "out_vld", 1),
	Port_Property("memory_request", 1, hls_out, 7, "ap_vld", "out_data", 1),
	Port_Property("memory_request_ap_vld", 1, hls_out, 7, "ap_vld", "out_vld", 1),
	Port_Property("error", 1, hls_out, 8, "ap_vld", "out_data", 1),
	Port_Property("error_ap_vld", 1, hls_out, 8, "ap_vld", "out_vld", 1),
	Port_Property("ap_return", 32, hls_out, -1, "", "", 1),
};
const char* HLS_Design_Meta::dut_name = "weight_stager";
