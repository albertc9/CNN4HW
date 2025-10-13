set ModuleHierarchy {[{
"Name" : "myproject","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_20_10_5_3_0_20u_config2_U0","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputHeight_ReadInputWidth","ID" : "2","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_compute_output_buffer_2d_array_array_ap_fixed_20_10_5_3_0_20u_config2_s_fu_310","ID" : "3","Type" : "sequential",
				"SubInsts" : [
				{"Name" : "call_ln286_shift_line_buffer_array_ap_fixed_20_10_5_3_0_1u_config2_s_fu_319","ID" : "4","Type" : "pipeline"},
				{"Name" : "grp_dense_latency_ap_fixed_ap_fixed_20_10_5_3_0_config2_mult_s_fu_411","ID" : "5","Type" : "sequential"},]},]},]},
	{"Name" : "relu_array_ap_fixed_20u_array_ap_fixed_20_10_5_3_0_20u_relu_config3_U0","ID" : "6","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "7","Type" : "pipeline"},]},
	{"Name" : "conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_20_10_5_3_0_10u_config4_U0","ID" : "8","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReadInputWidth","ID" : "9","Type" : "no"},]},
	{"Name" : "relu_array_ap_fixed_10u_array_ap_fixed_20_10_5_3_0_10u_relu_config5_U0","ID" : "10","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "ReLUActLoop","ID" : "11","Type" : "pipeline"},]},
	{"Name" : "dense_array_ap_fixed_10u_array_ap_fixed_24_10_5_3_0_1u_config7_U0","ID" : "12","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_dense_array_array_ap_fixed_24_10_5_3_0_1u_config7_Pipeline_DataPrepare_fu_9555","ID" : "13","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "DataPrepare","ID" : "14","Type" : "pipeline"},]},
		{"Name" : "grp_dense_latency_wrapper_ap_fixed_ap_fixed_24_10_5_3_0_config7_s_fu_11941","ID" : "15","Type" : "sequential"},]},
	{"Name" : "sigmoid_array_array_ap_fixed_20_10_5_3_0_1u_sigmoid_config8_U0","ID" : "16","Type" : "sequential"},]
}]}