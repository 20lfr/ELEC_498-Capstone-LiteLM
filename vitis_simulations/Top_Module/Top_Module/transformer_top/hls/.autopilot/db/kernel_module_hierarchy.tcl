set ModuleHierarchy {[{
"Name" : "transformer_top", "RefName" : "transformer_top","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_scheduler_hls_fu_14364", "RefName" : "scheduler_hls","ID" : "1","Type" : "sequential"},
	{"Name" : "grp_compute_controller_fu_14488", "RefName" : "compute_controller","ID" : "2","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_654_36_fu_2727", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_654_36","ID" : "3","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_654_36","RefName" : "VITIS_LOOP_654_36","ID" : "4","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_638_34_fu_2765", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_638_34","ID" : "5","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_638_34","RefName" : "VITIS_LOOP_638_34","ID" : "6","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_575_25_fu_2803", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_575_25","ID" : "7","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_575_25","RefName" : "VITIS_LOOP_575_25","ID" : "8","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_530_21_fu_2841", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_530_21","ID" : "9","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_530_21","RefName" : "VITIS_LOOP_530_21","ID" : "10","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_456_12_fu_2911", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_456_12","ID" : "11","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_456_12","RefName" : "VITIS_LOOP_456_12","ID" : "12","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_663_38_VITIS_LOOP_664_39_fu_2949", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_663_38_VITIS_LOOP_664_39","ID" : "13","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_663_38_VITIS_LOOP_664_39","RefName" : "VITIS_LOOP_663_38_VITIS_LOOP_664_39","ID" : "14","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_676_40_fu_2987", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_676_40","ID" : "15","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_676_40","RefName" : "VITIS_LOOP_676_40","ID" : "16","Type" : "pipeline",
			"SubInsts" : [
			{"Name" : "grp_read_i32_fu_56", "RefName" : "read_i32","ID" : "17","Type" : "pipeline"},]},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_684_42_fu_3003", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_684_42","ID" : "18","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_684_42","RefName" : "VITIS_LOOP_684_42","ID" : "19","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_697_44_fu_3027", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_697_44","ID" : "20","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_697_44","RefName" : "VITIS_LOOP_697_44","ID" : "21","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_163_1_fu_3043", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_163_1","ID" : "22","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_163_1","RefName" : "VITIS_LOOP_163_1","ID" : "23","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_646_35_fu_3111", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_646_35","ID" : "24","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_646_35","RefName" : "VITIS_LOOP_646_35","ID" : "25","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_580_26_fu_3149", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_580_26","ID" : "26","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_580_26","RefName" : "VITIS_LOOP_580_26","ID" : "27","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_584_27_VITIS_LOOP_585_28_fu_3165", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_584_27_VITIS_LOOP_585_28","ID" : "28","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_584_27_VITIS_LOOP_585_28","RefName" : "VITIS_LOOP_584_27_VITIS_LOOP_585_28","ID" : "29","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_597_29_fu_3203", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_597_29","ID" : "30","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_597_29","RefName" : "VITIS_LOOP_597_29","ID" : "31","Type" : "pipeline",
			"SubInsts" : [
			{"Name" : "grp_read_i32_fu_54", "RefName" : "read_i32","ID" : "32","Type" : "pipeline"},]},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_605_31_fu_3217", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_605_31","ID" : "33","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_605_31","RefName" : "VITIS_LOOP_605_31","ID" : "34","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_620_33_fu_3239", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_620_33","ID" : "35","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_620_33","RefName" : "VITIS_LOOP_620_33","ID" : "36","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_551_23_fu_3253", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_551_23","ID" : "37","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_551_23","RefName" : "VITIS_LOOP_551_23","ID" : "38","Type" : "pipeline"},]},
		{"Name" : "grp_read_i32_fu_3323", "RefName" : "read_i32","ID" : "39","Type" : "pipeline"},
		{"Name" : "grp_RMS_NORM_fu_3334", "RefName" : "RMS_NORM","ID" : "40","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_RMS_NORM_Pipeline_VITIS_LOOP_123_1_fu_140", "RefName" : "RMS_NORM_Pipeline_VITIS_LOOP_123_1","ID" : "41","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_123_1","RefName" : "VITIS_LOOP_123_1","ID" : "42","Type" : "pipeline"},]},
			{"Name" : "grp_sqrt_fixed_32_19_s_fu_161", "RefName" : "sqrt_fixed_32_19_s","ID" : "43","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_567_24_fu_3435", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_567_24","ID" : "44","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_567_24","RefName" : "VITIS_LOOP_567_24","ID" : "45","Type" : "pipeline"},]},
		{"Name" : "call_ln536_RES_ADD_fu_3457", "RefName" : "RES_ADD","ID" : "46","Type" : "sequential"},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_541_22_fu_3557", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_541_22","ID" : "47","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_541_22","RefName" : "VITIS_LOOP_541_22","ID" : "48","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_506_19_fu_3579", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_506_19","ID" : "49","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_506_19","RefName" : "VITIS_LOOP_506_19","ID" : "50","Type" : "pipeline",
			"SubInsts" : [
			{"Name" : "grp_read_i32_fu_102", "RefName" : "read_i32","ID" : "51","Type" : "pipeline"},]},]},
		{"Name" : "grp_REQUANT_D_MODEL_int32_to_int8_fu_3617", "RefName" : "REQUANT_D_MODEL_int32_to_int8","ID" : "52","Type" : "sequential"},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_521_20_fu_3689", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_521_20","ID" : "53","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_521_20","RefName" : "VITIS_LOOP_521_20","ID" : "54","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_42_2_fu_3711", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_42_2","ID" : "55","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_42_2","RefName" : "VITIS_LOOP_42_2","ID" : "56","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_461_13_fu_3781", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_461_13","ID" : "57","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_461_13","RefName" : "VITIS_LOOP_461_13","ID" : "58","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_465_14_VITIS_LOOP_466_15_fu_3797", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_465_14_VITIS_LOOP_466_15","ID" : "59","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_465_14_VITIS_LOOP_466_15","RefName" : "VITIS_LOOP_465_14_VITIS_LOOP_466_15","ID" : "60","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_478_16_fu_3835", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_478_16","ID" : "61","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_478_16","RefName" : "VITIS_LOOP_478_16","ID" : "62","Type" : "pipeline",
			"SubInsts" : [
			{"Name" : "grp_read_i32_fu_54", "RefName" : "read_i32","ID" : "63","Type" : "pipeline"},]},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_493_18_fu_3849", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_493_18","ID" : "64","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_493_18","RefName" : "VITIS_LOOP_493_18","ID" : "65","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_42_21_fu_3859", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_42_21","ID" : "66","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_42_2","RefName" : "VITIS_LOOP_42_2","ID" : "67","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_42_22_fu_3929", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_42_22","ID" : "68","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_42_2","RefName" : "VITIS_LOOP_42_2","ID" : "69","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_42_23_fu_3999", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_42_23","ID" : "70","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_42_2","RefName" : "VITIS_LOOP_42_2","ID" : "71","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_42_24_fu_4069", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_42_24","ID" : "72","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_42_2","RefName" : "VITIS_LOOP_42_2","ID" : "73","Type" : "pipeline"},]},
		{"Name" : "grp_compute_controller_Pipeline_VITIS_LOOP_398_11_fu_4139", "RefName" : "compute_controller_Pipeline_VITIS_LOOP_398_11","ID" : "74","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_398_11","RefName" : "VITIS_LOOP_398_11","ID" : "75","Type" : "pipeline"},]},]},]
}]}