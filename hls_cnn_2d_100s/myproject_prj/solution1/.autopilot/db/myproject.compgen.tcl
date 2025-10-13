# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_fifo_w400_d247_A BINDTYPE {storage} TYPE {fifo} IMPL {memory} ALLOW_PRAGMA 1 INSTNAME {layer2_out_U}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_fifo_w400_d247_A BINDTYPE {storage} TYPE {fifo} IMPL {memory} ALLOW_PRAGMA 1 INSTNAME {layer3_out_U}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_fifo_w200_d238_A BINDTYPE {storage} TYPE {fifo} IMPL {memory} ALLOW_PRAGMA 1 INSTNAME {layer4_out_U}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_fifo_w200_d238_A BINDTYPE {storage} TYPE {fifo} IMPL {memory} ALLOW_PRAGMA 1 INSTNAME {layer5_out_U}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_fifo_w24_d1_S BINDTYPE {storage} TYPE {fifo} IMPL {srl} ALLOW_PRAGMA 1 INSTNAME {layer7_out_U}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_start_for_relu_array_ap_fixed_20u_array_ap_fixed_20_10_5_3_0_20u_relu_config3fYi BINDTYPE {storage} TYPE {fifo} IMPL {srl} ALLOW_PRAGMA 1 INSTNAME {start_for_relu_array_ap_fixed_20u_array_ap_fixed_20_10_5_3_0_20u_relu_config3fYi_U}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_start_for_relu_array_ap_fixed_10u_array_ap_fixed_20_10_5_3_0_10u_relu_config5g8j BINDTYPE {storage} TYPE {fifo} IMPL {srl} ALLOW_PRAGMA 1 INSTNAME {start_for_relu_array_ap_fixed_10u_array_ap_fixed_20_10_5_3_0_10u_relu_config5g8j_U}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler myproject_start_for_sigmoid_array_array_ap_fixed_20_10_5_3_0_1u_sigmoid_config8_U0 BINDTYPE {storage} TYPE {fifo} IMPL {srl} ALLOW_PRAGMA 1 INSTNAME {start_for_sigmoid_array_array_ap_fixed_20_10_5_3_0_1u_sigmoid_config8_U0_U}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# Native AXIS:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::native_axis_add] == "::AESL_LIB_XILADAPTER::native_axis_add"} {
eval "::AESL_LIB_XILADAPTER::native_axis_add { \
    id 10120 \
    name input_1 \
    reset_level 0 \
    sync_rst true \
    corename {} \
    metadata {  } \
    op interface \
    ports { input_1_TDATA { I 32 vector } input_1_TVALID { I 1 bit } input_1_TREADY { O 1 bit } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'input_1'"
}
}


# Native AXIS:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::native_axis_add] == "::AESL_LIB_XILADAPTER::native_axis_add"} {
eval "::AESL_LIB_XILADAPTER::native_axis_add { \
    id 10121 \
    name layer8_out \
    reset_level 0 \
    sync_rst true \
    corename {} \
    metadata {  } \
    op interface \
    ports { layer8_out_TDATA { O 32 vector } layer8_out_TVALID { O 1 bit } layer8_out_TREADY { I 1 bit } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'layer8_out'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10122 \
    name b2_0 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_0 \
    op interface \
    ports { b2_0 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10123 \
    name b2_1 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_1 \
    op interface \
    ports { b2_1 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10124 \
    name b2_2 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_2 \
    op interface \
    ports { b2_2 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10125 \
    name b2_3 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_3 \
    op interface \
    ports { b2_3 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10126 \
    name b2_4 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_4 \
    op interface \
    ports { b2_4 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10127 \
    name b2_5 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_5 \
    op interface \
    ports { b2_5 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10128 \
    name b2_6 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_6 \
    op interface \
    ports { b2_6 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10129 \
    name b2_7 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_7 \
    op interface \
    ports { b2_7 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10130 \
    name b2_8 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_8 \
    op interface \
    ports { b2_8 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10131 \
    name b2_9 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_9 \
    op interface \
    ports { b2_9 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10132 \
    name b2_10 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_10 \
    op interface \
    ports { b2_10 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10133 \
    name b2_11 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_11 \
    op interface \
    ports { b2_11 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10134 \
    name b2_12 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_12 \
    op interface \
    ports { b2_12 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10135 \
    name b2_13 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_13 \
    op interface \
    ports { b2_13 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10136 \
    name b2_14 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_14 \
    op interface \
    ports { b2_14 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10137 \
    name b2_15 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_15 \
    op interface \
    ports { b2_15 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10138 \
    name b2_16 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_16 \
    op interface \
    ports { b2_16 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10139 \
    name b2_17 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_17 \
    op interface \
    ports { b2_17 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10140 \
    name b2_18 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_18 \
    op interface \
    ports { b2_18 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10141 \
    name b2_19 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b2_19 \
    op interface \
    ports { b2_19 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10142 \
    name b4_0 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_0 \
    op interface \
    ports { b4_0 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10143 \
    name b4_1 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_1 \
    op interface \
    ports { b4_1 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10144 \
    name b4_2 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_2 \
    op interface \
    ports { b4_2 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10145 \
    name b4_3 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_3 \
    op interface \
    ports { b4_3 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10146 \
    name b4_4 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_4 \
    op interface \
    ports { b4_4 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10147 \
    name b4_5 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_5 \
    op interface \
    ports { b4_5 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10148 \
    name b4_6 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_6 \
    op interface \
    ports { b4_6 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10149 \
    name b4_7 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_7 \
    op interface \
    ports { b4_7 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10150 \
    name b4_8 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_8 \
    op interface \
    ports { b4_8 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10151 \
    name b4_9 \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_b4_9 \
    op interface \
    ports { b4_9 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 0 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 0 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst_n
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 0 \
    sync_rst true \
    corename apif_ap_rst_n \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


