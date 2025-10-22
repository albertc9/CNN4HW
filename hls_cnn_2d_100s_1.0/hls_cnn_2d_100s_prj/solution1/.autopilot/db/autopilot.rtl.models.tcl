set SynModuleInfo {
  {SRCNAME {shift_line_buffer<array<ap_fixed<16, 2, 5, 3, 0>, 1u>, config2>} MODELNAME shift_line_buffer_array_ap_fixed_16_2_5_3_0_1u_config2_s RTLNAME hls_cnn_2d_100s_shift_line_buffer_array_ap_fixed_16_2_5_3_0_1u_config2_s
    SUBMODULES {
      {MODELNAME hls_cnn_2d_100s_shift_line_buffer_array_ap_fixed_16_2_5_3_0_1u_config2_s_void_conv_2d_buffer_bkb RTLNAME hls_cnn_2d_100s_shift_line_buffer_array_ap_fixed_16_2_5_3_0_1u_config2_s_void_conv_2d_buffer_bkb BINDTYPE storage TYPE shiftreg IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME {dense_latency<ap_fixed<16, 2, 5, 3, 0>, ap_fixed<12, 2, 5, 3, 0>, config2_mult>} MODELNAME dense_latency_ap_fixed_16_2_5_3_0_ap_fixed_12_2_5_3_0_config2_mult_s RTLNAME hls_cnn_2d_100s_dense_latency_ap_fixed_16_2_5_3_0_ap_fixed_12_2_5_3_0_config2_mult_s
    SUBMODULES {
      {MODELNAME hls_cnn_2d_100s_mul_16s_13ns_29_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_13ns_29_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_13s_29_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_13s_29_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_15s_30_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_15s_30_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_14s_29_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_14s_29_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_11s_27_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_11s_27_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_12s_28_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_12s_28_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_14s_30_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_14s_30_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_16s_30_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_16s_30_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_12ns_28_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_12ns_28_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_13s_28_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_13s_28_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_14ns_30_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_14ns_30_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_mul_16s_12s_27_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_12s_27_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME compute_output_buffer_2d<array,array<ap_fixed<12,2,5,3,0>,20u>,config2> MODELNAME compute_output_buffer_2d_array_array_ap_fixed_12_2_5_3_0_20u_config2_s RTLNAME hls_cnn_2d_100s_compute_output_buffer_2d_array_array_ap_fixed_12_2_5_3_0_20u_config2_s}
  {SRCNAME conv_2d_cl<array<ap_fixed,1u>,array<ap_fixed<12,2,5,3,0>,20u>,config2> MODELNAME conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_s RTLNAME hls_cnn_2d_100s_conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_s
    SUBMODULES {
      {MODELNAME hls_cnn_2d_100s_regslice_both RTLNAME hls_cnn_2d_100s_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME hls_cnn_2d_100s_regslice_both_U}
      {MODELNAME hls_cnn_2d_100s_flow_control_loop_pipe RTLNAME hls_cnn_2d_100s_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME hls_cnn_2d_100s_flow_control_loop_pipe_U}
    }
  }
  {SRCNAME relu<array<ap_fixed,20u>,array<ap_fixed<16,2,5,3,0>,20u>,relu_config3> MODELNAME relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_s RTLNAME hls_cnn_2d_100s_relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_s}
  {SRCNAME {dense_latency<ap_fixed<16, 2, 5, 3, 0>, ap_fixed<12, 2, 5, 3, 0>, config4_mult>} MODELNAME dense_latency_ap_fixed_16_2_5_3_0_ap_fixed_12_2_5_3_0_config4_mult_s RTLNAME hls_cnn_2d_100s_dense_latency_ap_fixed_16_2_5_3_0_ap_fixed_12_2_5_3_0_config4_mult_s}
  {SRCNAME conv_2d_cl<array<ap_fixed,20u>,array<ap_fixed<12,2,5,3,0>,10u>,config4> MODELNAME conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_s RTLNAME hls_cnn_2d_100s_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_s}
  {SRCNAME relu<array<ap_fixed,10u>,array<ap_fixed<16,2,5,3,0>,10u>,relu_config5> MODELNAME relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_s RTLNAME hls_cnn_2d_100s_relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_s}
  {SRCNAME dense<array,array<ap_fixed<10,6,5,3,0>,1u>,config7>_Pipeline_DataPrepare MODELNAME dense_array_array_ap_fixed_10_6_5_3_0_1u_config7_Pipeline_DataPrepare RTLNAME hls_cnn_2d_100s_dense_array_array_ap_fixed_10_6_5_3_0_1u_config7_Pipeline_DataPrepare
    SUBMODULES {
      {MODELNAME hls_cnn_2d_100s_flow_control_loop_pipe_sequential_init RTLNAME hls_cnn_2d_100s_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME hls_cnn_2d_100s_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME dense<array<ap_fixed,10u>,array<ap_fixed<10,6,5,3,0>,1u>,config7> MODELNAME dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_s RTLNAME hls_cnn_2d_100s_dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_s
    SUBMODULES {
      {MODELNAME hls_cnn_2d_100s_sparsemux_69_6_16_1_1 RTLNAME hls_cnn_2d_100s_sparsemux_69_6_16_1_1 BINDTYPE op TYPE sparsemux IMPL auto}
      {MODELNAME hls_cnn_2d_100s_mul_16s_15s_31_1_1 RTLNAME hls_cnn_2d_100s_mul_16s_15s_31_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hls_cnn_2d_100s_dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_s_w7_ROM_AUTO_1R RTLNAME hls_cnn_2d_100s_dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_s_w7_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME sigmoid<array,array<ap_fixed<16,2,5,3,0>,1u>,sigmoid_config8> MODELNAME sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_s RTLNAME hls_cnn_2d_100s_sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_s
    SUBMODULES {
      {MODELNAME hls_cnn_2d_100s_sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_s_sigmoid_table_ROeOg RTLNAME hls_cnn_2d_100s_sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_s_sigmoid_table_ROeOg BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME hls_cnn_2d_100s MODELNAME hls_cnn_2d_100s RTLNAME hls_cnn_2d_100s IS_TOP 1
    SUBMODULES {
      {MODELNAME hls_cnn_2d_100s_fifo_w240_d247_A RTLNAME hls_cnn_2d_100s_fifo_w240_d247_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer2_out_U}
      {MODELNAME hls_cnn_2d_100s_fifo_w320_d247_A RTLNAME hls_cnn_2d_100s_fifo_w320_d247_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer3_out_U}
      {MODELNAME hls_cnn_2d_100s_fifo_w120_d238_A RTLNAME hls_cnn_2d_100s_fifo_w120_d238_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer4_out_U}
      {MODELNAME hls_cnn_2d_100s_fifo_w160_d238_A RTLNAME hls_cnn_2d_100s_fifo_w160_d238_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME layer5_out_U}
      {MODELNAME hls_cnn_2d_100s_fifo_w10_d1_S RTLNAME hls_cnn_2d_100s_fifo_w10_d1_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME layer7_out_U}
      {MODELNAME hls_cnn_2d_100s_start_for_relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0 RTLNAME hls_cnn_2d_100s_start_for_relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0_U}
      {MODELNAME hls_cnn_2d_100s_start_for_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4fYi RTLNAME hls_cnn_2d_100s_start_for_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4fYi BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4fYi_U}
      {MODELNAME hls_cnn_2d_100s_start_for_relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0 RTLNAME hls_cnn_2d_100s_start_for_relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0_U}
      {MODELNAME hls_cnn_2d_100s_start_for_dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0 RTLNAME hls_cnn_2d_100s_start_for_dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0_U}
      {MODELNAME hls_cnn_2d_100s_start_for_sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0 RTLNAME hls_cnn_2d_100s_start_for_sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0_U}
    }
  }
}
