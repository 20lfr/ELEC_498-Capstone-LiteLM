set SynModuleInfo {
  {SRCNAME OUT_PROJ MODELNAME OUT_PROJ RTLNAME compute_controller_OUT_PROJ
    SUBMODULES {
      {MODELNAME compute_controller_mul_8s_4s_12_1_1 RTLNAME compute_controller_mul_8s_4s_12_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME compute_controller_mac_muladd_8s_4s_12s_13_4_1 RTLNAME compute_controller_mac_muladd_8s_4s_12s_13_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
    }
  }
  {SRCNAME compute_controller MODELNAME compute_controller RTLNAME compute_controller IS_TOP 1}
}
