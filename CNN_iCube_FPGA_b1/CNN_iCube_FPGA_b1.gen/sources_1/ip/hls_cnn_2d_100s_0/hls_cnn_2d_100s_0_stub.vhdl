-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
-- Date        : Tue Oct 14 15:34:33 2025
-- Host        : dhcp-172-31-232-100.mobile.uci.edu running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/work1/Work/CNN_iCube_FPGA_b/CNN_iCube_FPGA_b1/CNN_iCube_FPGA_b1.gen/sources_1/ip/hls_cnn_2d_100s_0/hls_cnn_2d_100s_0_stub.vhdl
-- Design      : hls_cnn_2d_100s_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku5p-ffvb676-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hls_cnn_2d_100s_0 is
  Port ( 
    input_1_TVALID : in STD_LOGIC;
    input_1_TREADY : out STD_LOGIC;
    input_1_TDATA : in STD_LOGIC_VECTOR ( 15 downto 0 );
    layer8_out_TVALID : out STD_LOGIC;
    layer8_out_TREADY : in STD_LOGIC;
    layer8_out_TDATA : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    ap_idle : out STD_LOGIC
  );

end hls_cnn_2d_100s_0;

architecture stub of hls_cnn_2d_100s_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "input_1_TVALID,input_1_TREADY,input_1_TDATA[15:0],layer8_out_TVALID,layer8_out_TREADY,layer8_out_TDATA[15:0],ap_clk,ap_rst_n,ap_start,ap_done,ap_ready,ap_idle";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "hls_cnn_2d_100s,Vivado 2023.2";
begin
end;
