set SynModuleInfo {
  {SRCNAME REQUANT_D_MODEL_int32_to_int8 MODELNAME REQUANT_D_MODEL_int32_to_int8 RTLNAME compute_controller_REQUANT_D_MODEL_int32_to_int8
    SUBMODULES {
      {MODELNAME compute_controller_mul_32s_32s_64_1_1 RTLNAME compute_controller_mul_32s_32s_64_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME LAYER_NORM_Pipeline_VITIS_LOOP_79_1 MODELNAME LAYER_NORM_Pipeline_VITIS_LOOP_79_1 RTLNAME compute_controller_LAYER_NORM_Pipeline_VITIS_LOOP_79_1
    SUBMODULES {
      {MODELNAME compute_controller_mac_muladd_8s_8s_19s_19_4_1 RTLNAME compute_controller_mac_muladd_8s_8s_19s_19_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME compute_controller_flow_control_loop_pipe_sequential_init RTLNAME compute_controller_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME compute_controller_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME {sqrt_fixed<32, 16>} MODELNAME sqrt_fixed_32_16_s RTLNAME compute_controller_sqrt_fixed_32_16_s}
  {SRCNAME LAYER_NORM MODELNAME LAYER_NORM RTLNAME compute_controller_LAYER_NORM
    SUBMODULES {
      {MODELNAME compute_controller_mul_24s_24s_48_1_1 RTLNAME compute_controller_mul_24s_24s_48_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME compute_controller_mul_25s_32s_48_1_1 RTLNAME compute_controller_mul_25s_32s_48_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME compute_controller_mul_32s_32s_48_1_1 RTLNAME compute_controller_mul_32s_32s_48_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME compute_controller_udiv_33s_24ns_32_37_seq_1 RTLNAME compute_controller_udiv_33s_24ns_32_37_seq_1 BINDTYPE op TYPE udiv IMPL auto_seq LATENCY 36 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME RES_ADD MODELNAME RES_ADD RTLNAME compute_controller_RES_ADD}
  {SRCNAME FFN_POST_ACT_Pipeline_VITIS_LOOP_151_1 MODELNAME FFN_POST_ACT_Pipeline_VITIS_LOOP_151_1 RTLNAME compute_controller_FFN_POST_ACT_Pipeline_VITIS_LOOP_151_1
    SUBMODULES {
      {MODELNAME compute_controller_mul_16s_4s_20_1_1 RTLNAME compute_controller_mul_16s_4s_20_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME compute_controller_mac_muladd_16s_4s_4s_20_4_1 RTLNAME compute_controller_mac_muladd_16s_4s_4s_20_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME compute_controller_mac_muladd_16s_4s_20s_21_4_1 RTLNAME compute_controller_mac_muladd_16s_4s_20s_21_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME compute_controller_mac_muladd_16s_4s_21s_21_4_1 RTLNAME compute_controller_mac_muladd_16s_4s_21s_21_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME compute_controller_am_addmul_23s_23s_16s_32_4_1 RTLNAME compute_controller_am_addmul_23s_23s_16s_32_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
    }
  }
  {SRCNAME FFN_POST_ACT MODELNAME FFN_POST_ACT RTLNAME compute_controller_FFN_POST_ACT}
  {SRCNAME compute_controller_Pipeline_VITIS_LOOP_132_1 MODELNAME compute_controller_Pipeline_VITIS_LOOP_132_1 RTLNAME compute_controller_compute_controller_Pipeline_VITIS_LOOP_132_1}
  {SRCNAME compute_controller_Pipeline_VITIS_LOOP_113_1 MODELNAME compute_controller_Pipeline_VITIS_LOOP_113_1 RTLNAME compute_controller_compute_controller_Pipeline_VITIS_LOOP_113_1
    SUBMODULES {
      {MODELNAME compute_controller_mul_8s_4s_12_1_1 RTLNAME compute_controller_mul_8s_4s_12_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME compute_controller_mac_muladd_8s_4s_4s_12_4_1 RTLNAME compute_controller_mac_muladd_8s_4s_4s_12_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME compute_controller_mac_muladd_8s_4s_12s_13_4_1 RTLNAME compute_controller_mac_muladd_8s_4s_12s_13_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME compute_controller_am_addmul_14s_14s_16s_31_4_1 RTLNAME compute_controller_am_addmul_14s_14s_16s_31_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
    }
  }
  {SRCNAME OUT_PROJ MODELNAME OUT_PROJ RTLNAME compute_controller_OUT_PROJ
    SUBMODULES {
      {MODELNAME compute_controller_mac_muladd_8s_4s_32s_32_4_1 RTLNAME compute_controller_mac_muladd_8s_4s_32s_32_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME compute_controller_mac_muladd_8s_4s_13s_13_4_1 RTLNAME compute_controller_mac_muladd_8s_4s_13s_13_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
    }
  }
  {SRCNAME compute_controller MODELNAME compute_controller RTLNAME compute_controller IS_TOP 1}
}
