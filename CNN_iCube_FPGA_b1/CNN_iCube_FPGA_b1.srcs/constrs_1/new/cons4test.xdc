create_clock -period 5.000 -name sys_clk [get_ports clk]
set_input_delay -clock sys_clk -max 1.0 [get_ports {input_data[*]}]
set_output_delay -clock sys_clk -max 1.0 [get_ports {output_data[*]}]