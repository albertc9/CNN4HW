// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
// Date        : Tue Oct 14 15:34:33 2025
// Host        : dhcp-172-31-232-100.mobile.uci.edu running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/work1/Work/CNN_iCube_FPGA_b/CNN_iCube_FPGA_b1/CNN_iCube_FPGA_b1.gen/sources_1/ip/hls_cnn_2d_100s_0/hls_cnn_2d_100s_0_stub.v
// Design      : hls_cnn_2d_100s_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku5p-ffvb676-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "hls_cnn_2d_100s,Vivado 2023.2" *)
module hls_cnn_2d_100s_0(input_1_TVALID, input_1_TREADY, 
  input_1_TDATA, layer8_out_TVALID, layer8_out_TREADY, layer8_out_TDATA, ap_clk, ap_rst_n, 
  ap_start, ap_done, ap_ready, ap_idle)
/* synthesis syn_black_box black_box_pad_pin="input_1_TVALID,input_1_TREADY,input_1_TDATA[15:0],layer8_out_TVALID,layer8_out_TREADY,layer8_out_TDATA[15:0],ap_rst_n,ap_start,ap_done,ap_ready,ap_idle" */
/* synthesis syn_force_seq_prim="ap_clk" */;
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
