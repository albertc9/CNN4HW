set ModuleHierarchy {[{
"Name" : "hls_cnn_2d_100s","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeight_ReadInputWidth","ID" : "2","Type" : "pipeline",
		"SubInsts" : [
		{"Name" : "grp_compute_output_buffer_2d_array_array_ap_fixed_12_2_5_3_0_20u_config2_s_fu_146","ID" : "3","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "call_ln286_shift_line_buffer_array_ap_fixed_16_2_5_3_0_1u_config2_s_fu_156","ID" : "4","Type" : "pipeline"},
				{"Name" : "grp_dense_latency_ap_fixed_16_2_5_3_0_ap_fixed_12_2_5_3_0_config2_mult_s_fu_248","ID" : "5","Type" : "pipeline"},]},]},]},
	{"Name" : "relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0","ID" : "6","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "7","Type" : "pipeline"},]},
	{"Name" : "conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_U0","ID" : "8","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputWidth","ID" : "9","Type" : "pipeline",
		"SubInsts" : [
		{"Name" : "grp_dense_latency_ap_fixed_16_2_5_3_0_ap_fixed_12_2_5_3_0_config4_mult_s_fu_556","ID" : "10","Type" : "pipeline"},]},]},
	{"Name" : "relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0","ID" : "11","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "12","Type" : "pipeline"},]},
	{"Name" : "dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0","ID" : "13","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_dense_array_array_ap_fixed_10_6_5_3_0_1u_config7_Pipeline_DataPrepare_fu_10682","ID" : "14","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "DataPrepare","ID" : "15","Type" : "pipeline"},]},],
		"SubLoops" : [
		{"Name" : "ReuseLoop","ID" : "16","Type" : "pipeline"},]},
	{"Name" : "sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0","ID" : "17","Type" : "sequential"},]
}]}