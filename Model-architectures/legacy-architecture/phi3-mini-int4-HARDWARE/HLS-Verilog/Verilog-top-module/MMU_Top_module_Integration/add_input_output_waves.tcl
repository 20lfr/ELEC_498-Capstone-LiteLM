# Full ordered dataflow wave setup for top_module_hls_tb
# Inputs = magenta, outputs = aqua.

proc add_colored_wave {path radix color} {
    add_wave $path
    set ws [get_waves $path]
    if {[llength $ws] == 0} {
        return
    }
    set w [lindex $ws end]
    set_property radix $radix $w
    set_property color $color $w
}

# LN0
add_colored_wave /top_module_hls_tb/ln0_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ln0_gamma_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ln0_eps_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ln0_out signed_decimal aqua

# Q
add_colored_wave /top_module_hls_tb/q_act_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/q_w_in hexadecimal magenta
add_colored_wave /top_module_hls_tb/q_b_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/q_out signed_decimal aqua

# K
add_colored_wave /top_module_hls_tb/k_act_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/k_w_in hexadecimal magenta
add_colored_wave /top_module_hls_tb/k_b_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/k_out signed_decimal aqua

# V
add_colored_wave /top_module_hls_tb/v_act_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/v_w_in hexadecimal magenta
add_colored_wave /top_module_hls_tb/v_b_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/v_out signed_decimal aqua

# ATT_SCORES
add_colored_wave /top_module_hls_tb/att_scores_q_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/att_scores_k_cache_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/att_scores_out signed_decimal aqua

# VALUE_SCALE
add_colored_wave /top_module_hls_tb/val_scale_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/val_scale_out signed_decimal aqua

# SOFTMAX
add_colored_wave /top_module_hls_tb/softmax_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/softmax_out signed_decimal aqua

# ATT_VALUE
add_colored_wave /top_module_hls_tb/att_value_weights_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/att_value_v_cache_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/att_value_out signed_decimal aqua

# HEAD_REQUANT
add_colored_wave /top_module_hls_tb/head_rq_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/head_rq_out signed_decimal aqua

# OUT_PROJ
add_colored_wave /top_module_hls_tb/out_proj_act_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/out_proj_w_in hexadecimal magenta
add_colored_wave /top_module_hls_tb/out_proj_b_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/out_proj_out signed_decimal aqua
add_colored_wave /top_module_hls_tb/out_proj_out_by_tile signed_decimal aqua

# RESID1
add_colored_wave /top_module_hls_tb/resid1_x_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/resid1_r_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/resid1_out signed_decimal aqua

# LN1
add_colored_wave /top_module_hls_tb/ln1_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ln1_gamma_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ln1_eps_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ln1_out signed_decimal aqua

# FFN_W1
add_colored_wave /top_module_hls_tb/ffn_w1_x_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ffn_w1_w_in hexadecimal magenta
add_colored_wave /top_module_hls_tb/ffn_w1_b_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ffn_w1_out signed_decimal aqua
add_colored_wave /top_module_hls_tb/ffn_w1_out_by_tile signed_decimal aqua

# FFN_ACT
add_colored_wave /top_module_hls_tb/ffn_act_gate_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ffn_act_up_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ffn_act_out signed_decimal aqua

# FFN_W2
add_colored_wave /top_module_hls_tb/ffn_w2_x_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ffn_w2_w_in hexadecimal magenta
add_colored_wave /top_module_hls_tb/ffn_w2_b_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/ffn_w2_out signed_decimal aqua
add_colored_wave /top_module_hls_tb/ffn_w2_out_by_tile signed_decimal aqua

# RESID2
add_colored_wave /top_module_hls_tb/resid2_x_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/resid2_r_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/resid2_out signed_decimal aqua

# FINAL_NORM
add_colored_wave /top_module_hls_tb/final_norm_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/final_norm_gamma_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/final_norm_eps_in signed_decimal magenta
add_colored_wave /top_module_hls_tb/final_norm_out signed_decimal aqua
