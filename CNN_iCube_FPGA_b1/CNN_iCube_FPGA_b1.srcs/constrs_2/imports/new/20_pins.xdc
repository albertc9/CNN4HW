################################################################################
# File: 20_pins.xdc
# Purpose: PACKAGE_PIN assignments (from Vivado I/O Ports table)
################################################################################

# Clock / Reset / Start
set_property PACKAGE_PIN E13 [get_ports clk]
set_property PACKAGE_PIN H11 [get_ports rst_n]
set_property PACKAGE_PIN G11 [get_ports start]

# HLS ap_ctrl signals
set_property PACKAGE_PIN J14 [get_ports done]
set_property PACKAGE_PIN H14 [get_ports idle]
set_property PACKAGE_PIN H13 [get_ports ready]

# Handshake (input side)
#   input_valid is IN (to FPGA), input_ready is OUT (from FPGA)
set_property PACKAGE_PIN J12 [get_ports input_valid]
set_property PACKAGE_PIN G14 [get_ports input_ready]

# Handshake (output side)
#   output_ready is IN (to FPGA), output_valid is OUT (from FPGA)
set_property PACKAGE_PIN H12 [get_ports output_ready]
set_property PACKAGE_PIN J13 [get_ports output_valid]

# Input data bus [15:0]
set_property PACKAGE_PIN G9  [get_ports {input_data[15]}]
set_property PACKAGE_PIN G10 [get_ports {input_data[14]}]
set_property PACKAGE_PIN F9  [get_ports {input_data[13]}]
set_property PACKAGE_PIN F10 [get_ports {input_data[12]}]
set_property PACKAGE_PIN E10 [get_ports {input_data[11]}]
set_property PACKAGE_PIN E11 [get_ports {input_data[10]}]
set_property PACKAGE_PIN D10 [get_ports {input_data[9]}]
set_property PACKAGE_PIN D11 [get_ports {input_data[8]}]
set_property PACKAGE_PIN C9  [get_ports {input_data[7]}]
set_property PACKAGE_PIN D9  [get_ports {input_data[6]}]
set_property PACKAGE_PIN A9  [get_ports {input_data[5]}]
set_property PACKAGE_PIN B9  [get_ports {input_data[4]}]
set_property PACKAGE_PIN A10 [get_ports {input_data[3]}]
set_property PACKAGE_PIN B10 [get_ports {input_data[2]}]
set_property PACKAGE_PIN B11 [get_ports {input_data[1]}]
set_property PACKAGE_PIN C11 [get_ports {input_data[0]}]

# Output data bus [15:0]
set_property PACKAGE_PIN J15 [get_ports {output_data[15]}]
set_property PACKAGE_PIN F12 [get_ports {output_data[14]}]
set_property PACKAGE_PIN G12 [get_ports {output_data[13]}]
set_property PACKAGE_PIN F13 [get_ports {output_data[12]}]
set_property PACKAGE_PIN F14 [get_ports {output_data[11]}]
set_property PACKAGE_PIN E12 [get_ports {output_data[10]}]
set_property PACKAGE_PIN D13 [get_ports {output_data[9]}]
set_property PACKAGE_PIN D14 [get_ports {output_data[8]}]
set_property PACKAGE_PIN C13 [get_ports {output_data[7]}]
set_property PACKAGE_PIN C14 [get_ports {output_data[6]}]
set_property PACKAGE_PIN B12 [get_ports {output_data[5]}]
set_property PACKAGE_PIN C12 [get_ports {output_data[4]}]
set_property PACKAGE_PIN A12 [get_ports {output_data[3]}]
set_property PACKAGE_PIN A13 [get_ports {output_data[2]}]
set_property PACKAGE_PIN A14 [get_ports {output_data[1]}]
set_property PACKAGE_PIN B14 [get_ports {output_data[0]}]
