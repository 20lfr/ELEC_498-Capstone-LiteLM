set ModuleHierarchy {[{
"Name" : "compute_controller", "RefName" : "compute_controller","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_REQUANT_D_MODEL_int32_to_int8_fu_585", "RefName" : "REQUANT_D_MODEL_int32_to_int8","ID" : "1","Type" : "sequential"},
	{"Name" : "grp_LAYER_NORM_fu_599", "RefName" : "LAYER_NORM","ID" : "2","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_LAYER_NORM_Pipeline_VITIS_LOOP_79_1_fu_412", "RefName" : "LAYER_NORM_Pipeline_VITIS_LOOP_79_1","ID" : "3","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_79_1","RefName" : "VITIS_LOOP_79_1","ID" : "4","Type" : "pipeline"},]},
		{"Name" : "grp_sqrt_fixed_32_16_s_fu_420", "RefName" : "sqrt_fixed_32_16_s","ID" : "5","Type" : "pipeline"},]},
	{"Name" : "grp_RES_ADD_fu_612", "RefName" : "RES_ADD","ID" : "6","Type" : "sequential"},
	{"Name" : "grp_FFN_POST_ACT_fu_622", "RefName" : "FFN_POST_ACT","ID" : "7","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_FFN_POST_ACT_Pipeline_VITIS_LOOP_151_1_fu_273", "RefName" : "FFN_POST_ACT_Pipeline_VITIS_LOOP_151_1","ID" : "8","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_151_1","RefName" : "VITIS_LOOP_151_1","ID" : "9","Type" : "pipeline"},]},]},
	{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_132_1_fu_636", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_132_1","ID" : "10","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_132_1","RefName" : "VITIS_LOOP_132_1","ID" : "11","Type" : "pipeline"},]},
	{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_113_1_fu_644", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_113_1","ID" : "12","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_113_1","RefName" : "VITIS_LOOP_113_1","ID" : "13","Type" : "pipeline"},]},
	{"Name" : "grp_OUT_PROJ_fu_666", "RefName" : "OUT_PROJ","ID" : "14","Type" : "sequential"},]
}]}