
wire kernel_monitor_reset;
wire kernel_monitor_clock;
wire kernel_monitor_report;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
assign kernel_monitor_report = 1'b0;
wire [1:0] axis_block_sigs;
wire [8:0] inst_idle_sigs;
wire [5:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0.input_1_TDATA_blk_n;
assign axis_block_sigs[1] = ~sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0.layer8_out_TDATA_blk_n;

assign inst_idle_sigs[0] = conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0.ap_idle;
assign inst_block_sigs[0] = (conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0.ap_done & ~conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0.ap_continue) | ~conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0.layer2_out_blk_n | ~conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0.grp_compute_output_buffer_2d_array_array_ap_fixed_12_2_5_3_0_20u_config2_s_fu_146.layer2_out_blk_n;
assign inst_idle_sigs[1] = relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0.ap_idle;
assign inst_block_sigs[1] = (relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0.ap_done & ~relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0.ap_continue) | ~relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0.layer2_out_blk_n | ~relu_array_ap_fixed_20u_array_ap_fixed_16_2_5_3_0_20u_relu_config3_U0.layer3_out_blk_n;
assign inst_idle_sigs[2] = conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_U0.ap_idle;
assign inst_block_sigs[2] = (conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_U0.ap_done & ~conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_U0.ap_continue) | ~conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_U0.layer3_out_blk_n | ~conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_U0.layer4_out_blk_n;
assign inst_idle_sigs[3] = relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0.ap_idle;
assign inst_block_sigs[3] = (relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0.ap_done & ~relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0.ap_continue) | ~relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0.layer4_out_blk_n | ~relu_array_ap_fixed_10u_array_ap_fixed_16_2_5_3_0_10u_relu_config5_U0.layer5_out_blk_n;
assign inst_idle_sigs[4] = dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0.ap_idle;
assign inst_block_sigs[4] = (dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0.ap_done & ~dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0.ap_continue) | ~dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0.grp_dense_array_array_ap_fixed_10_6_5_3_0_1u_config7_Pipeline_DataPrepare_fu_10682.layer5_out_blk_n | ~dense_array_ap_fixed_10u_array_ap_fixed_10_6_5_3_0_1u_config7_U0.layer7_out_blk_n;
assign inst_idle_sigs[5] = sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0.ap_idle;
assign inst_block_sigs[5] = (sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0.ap_done & ~sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0.ap_continue) | ~sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0.layer7_out_blk_n;

assign inst_idle_sigs[6] = 1'b0;
assign inst_idle_sigs[7] = conv_2d_cl_array_ap_fixed_1u_array_ap_fixed_12_2_5_3_0_20u_config2_U0.ap_idle;
assign inst_idle_sigs[8] = sigmoid_array_array_ap_fixed_16_2_5_3_0_1u_sigmoid_config8_U0.ap_idle;

hls_cnn_2d_100s_hls_deadlock_idx0_monitor hls_cnn_2d_100s_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);


always @ (kernel_block or kernel_monitor_reset) begin
    if (kernel_block == 1'b1 && kernel_monitor_reset == 1'b0) begin
        find_kernel_block = 1'b1;
    end
    else begin
        find_kernel_block = 1'b0;
    end
end
