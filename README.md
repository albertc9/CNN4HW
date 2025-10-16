```
 ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█████████████▓▒░  
                                                                                       
                                                                                       
```
2025 Albert Lee-Khai Cheung, UC Irvine, MIT LICENSE
albert.cheung@cern.ch

```
set_property ip_repo_paths {/home/work1/Work/CNN_iCube_FPGA_b/hls_cnn_2d_100s/hls_cnn_2d_100s_prj/solution1/impl/ip} [current_project]
update_ip_catalog
INFO: [IP_Flow 19-234] Refreshing IP repositories
INFO: [IP_Flow 19-1700] Loaded user IP repository '/home/work1/Work/CNN_iCube_FPGA_b/hls_cnn_2d_100s/hls_cnn_2d_100s_prj/solution1/impl/ip'.
1
get_ipdefs -filter {NAME =~ "*hls_cnn_2d_100s*"}
xilinx.com:hls:hls_cnn_2d_100s:1.0
```

update:
```
remove_files [get_files */hls_cnn_2d_100s_0.xci]
/home/work1/Work/CNN_iCube_FPGA_b/CNN_iCube_FPGA_b1/CNN_iCube_FPGA_b1.srcs/sources_1/ip/hls_cnn_2d_100s_0/hls_cnn_2d_100s_0.xci
set_property ip_repo_paths {/home/work1/Work/CNN_iCube_FPGA_b/hls_cnn_2d_100s/hls_cnn_2d_100s_prj/solution1/impl/ip} [current_project]
update_ip_catalog
INFO: [IP_Flow 19-1839] IP Catalog is up to date.
1
get_ipdefs -filter {NAME =~ "*hls_cnn_2d_100s*"}
xilinx.com:hls:hls_cnn_2d_100s:1.0
create_ip -name hls_cnn_2d_100s -vendor xilinx.com -library hls -version 1.0 -module_name hls_cnn_2d_100s_0
/home/work1/Work/CNN_iCube_FPGA_b/CNN_iCube_FPGA_b1/CNN_iCube_FPGA_b1.srcs/sources_1/ip/hls_cnn_2d_100s_0_1/hls_cnn_2d_100s_0.xci
generate_target all [get_files */hls_cnn_2d_100s_0.xci]
INFO: [IP_Flow 19-1686] Generating 'Instantiation Template' target for IP 'hls_cnn_2d_100s_0'...
INFO: [IP_Flow 19-1686] Generating 'Synthesis' target for IP 'hls_cnn_2d_100s_0'...
INFO: [IP_Flow 19-1686] Generating 'Simulation' target for IP 'hls_cnn_2d_100s_0'...
INFO: [IP_Flow 19-1686] Generating 'Miscellaneous' target for IP 'hls_cnn_2d_100s_0'...
```