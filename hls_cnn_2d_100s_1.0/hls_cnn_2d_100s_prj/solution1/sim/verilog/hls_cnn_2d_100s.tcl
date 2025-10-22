
source "../../../../project.tcl"
                if {[string equal "$backend" "vivadoaccelerator"]} {
                    current_scope [get_scopes -regex "/apatb_${project_name}_axi_top/AESL_inst_${project_name}_axi/${project_name}_U0.*"]
                    set scopes [get_scopes -regexp {layer(\d*)_.*data_0_V_U.*}]
                    append scopes { }
                    current_scope "/apatb_${project_name}_axi_top/AESL_inst_${project_name}_axi"
                    append scopes [get_scopes -regexp {(in_local_V_data.*_0_.*)}]
                    append scopes { }
                    append scopes [get_scopes -regexp {(out_local_V_data.*_0_.*)}]
                } else {
                    current_scope [get_scopes -regex "/apatb_${project_name}_top/AESL_inst_${project_name}"]
                    set scopes [get_scopes -regexp {layer(\d*)_.*data_0_V_U.*}]
                }
                open_vcd fifo_opt.vcd
                foreach scope $scopes {
                    current_scope $scope
                    if {[catch [get_objects usedw]] == 0} {
                        puts "$scope skipped"
                        continue
                    }
                    set usedw [get_objects usedw]
                    set depth [get_objects DEPTH]
                    add_wave $usedw
                    log_vcd $usedw
                    log_wave $usedw
                    add_wave $depth
                    log_vcd $depth
                    log_wave $depth
                }
            
set designtopgroup [add_wave_group "Design Top Signals"]
set coutputgroup [add_wave_group "C Outputs" -into $designtopgroup]
set return_group [add_wave_group return(axis) -into $coutputgroup]
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/layer8_out_TREADY -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/layer8_out_TVALID -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/layer8_out_TDATA -into $return_group -radix hex
set cinputgroup [add_wave_group "C Inputs" -into $designtopgroup]
set return_group [add_wave_group return(axis) -into $cinputgroup]
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/input_1_TREADY -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/input_1_TVALID -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/input_1_TDATA -into $return_group -radix hex
set blocksiggroup [add_wave_group "Block-level IO Handshake" -into $designtopgroup]
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/ap_start -into $blocksiggroup
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/ap_done -into $blocksiggroup
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/ap_ready -into $blocksiggroup
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/ap_idle -into $blocksiggroup
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/ap_rst_n -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_hls_cnn_2d_100s_top/AESL_inst_hls_cnn_2d_100s/ap_clk -into $clockgroup
set testbenchgroup [add_wave_group "Test Bench Signals"]
set tbinternalsiggroup [add_wave_group "Internal Signals" -into $testbenchgroup]
set tb_simstatus_group [add_wave_group "Simulation Status" -into $tbinternalsiggroup]
set tb_portdepth_group [add_wave_group "Port Depth" -into $tbinternalsiggroup]
add_wave /apatb_hls_cnn_2d_100s_top/AUTOTB_TRANSACTION_NUM -into $tb_simstatus_group -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/ready_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/done_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/LENGTH_input_1 -into $tb_portdepth_group -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/LENGTH_layer8_out -into $tb_portdepth_group -radix hex
set tbcoutputgroup [add_wave_group "C Outputs" -into $testbenchgroup]
set tb_return_group [add_wave_group return(axis) -into $tbcoutputgroup]
add_wave /apatb_hls_cnn_2d_100s_top/layer8_out_TREADY -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/layer8_out_TVALID -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/layer8_out_TDATA -into $tb_return_group -radix hex
set tbcinputgroup [add_wave_group "C Inputs" -into $testbenchgroup]
set tb_return_group [add_wave_group return(axis) -into $tbcinputgroup]
add_wave /apatb_hls_cnn_2d_100s_top/input_1_TREADY -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/input_1_TVALID -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hls_cnn_2d_100s_top/input_1_TDATA -into $tb_return_group -radix hex
save_wave_config hls_cnn_2d_100s.wcfg
run all
flush_vcd
                close_vcd
                quit
            

