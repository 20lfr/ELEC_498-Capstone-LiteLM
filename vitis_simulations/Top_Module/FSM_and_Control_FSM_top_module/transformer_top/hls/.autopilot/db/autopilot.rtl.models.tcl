set SynModuleInfo {
  {SRCNAME drive_group_head_phase MODELNAME drive_group_head_phase RTLNAME transformer_top_drive_group_head_phase
    SUBMODULES {
      {MODELNAME transformer_top_mul_32s_32s_32_1_1 RTLNAME transformer_top_mul_32s_32s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME scheduler_hls MODELNAME scheduler_hls RTLNAME transformer_top_scheduler_hls
    SUBMODULES {
      {MODELNAME transformer_top_sparsemux_7_2_1_1_1 RTLNAME transformer_top_sparsemux_7_2_1_1_1 BINDTYPE op TYPE sparsemux IMPL onehotencoding_realdef}
      {MODELNAME transformer_top_sparsemux_7_2_235_1_1 RTLNAME transformer_top_sparsemux_7_2_235_1_1 BINDTYPE op TYPE sparsemux IMPL onehotencoding_realdef}
    }
  }
  {SRCNAME transformer_top MODELNAME transformer_top RTLNAME transformer_top IS_TOP 1}
}
