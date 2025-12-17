set SynModuleInfo {
  {SRCNAME drive_group_head_phase MODELNAME drive_group_head_phase RTLNAME scheduler_hls_drive_group_head_phase}
  {SRCNAME scheduler_hls MODELNAME scheduler_hls RTLNAME scheduler_hls IS_TOP 1
    SUBMODULES {
      {MODELNAME scheduler_hls_mul_32s_32s_32_1_1 RTLNAME scheduler_hls_mul_32s_32s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME scheduler_hls_sparsemux_7_2_1_1_1 RTLNAME scheduler_hls_sparsemux_7_2_1_1_1 BINDTYPE op TYPE sparsemux IMPL onehotencoding_realdef}
    }
  }
}
