// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "hls_cnn_2d_100s,Vivado 2023.2" *)
module hls_cnn_2d_100s_0(input_1_TVALID, input_1_TREADY, 
  input_1_TDATA, layer8_out_TVALID, layer8_out_TREADY, layer8_out_TDATA, ap_clk, ap_rst_n, 
  ap_start, ap_done, ap_ready, ap_idle);
  input input_1_TVALID;
  output input_1_TREADY;
  input [15:0]input_1_TDATA;
  output layer8_out_TVALID;
  input layer8_out_TREADY;
  output [15:0]layer8_out_TDATA;
  input ap_clk /* synthesis syn_isclock = 1 */;
  input ap_rst_n;
  input ap_start;
  output ap_done;
  output ap_ready;
  output ap_idle;
endmodule
