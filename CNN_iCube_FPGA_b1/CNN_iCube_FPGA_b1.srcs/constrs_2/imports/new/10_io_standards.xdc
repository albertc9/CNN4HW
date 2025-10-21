################################################################################
# File: 10_io_standards.xdc
# Purpose: I/O standards (voltage levels) for ports
# Note: Banks 86/87 are at 1.8 V per board
################################################################################

# I/O Standard (banks 86/87 are at 1.8 V per board)
set_property IOSTANDARD LVCMOS18 [get_ports {clk rst_n start}]
set_property IOSTANDARD LVCMOS18 [get_ports {input_valid input_ready}]
set_property IOSTANDARD LVCMOS18 [get_ports {output_valid output_ready}]
set_property IOSTANDARD LVCMOS18 [get_ports {done idle ready}]
set_property IOSTANDARD LVCMOS18 [get_ports {input_data[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports {output_data[*]}]
