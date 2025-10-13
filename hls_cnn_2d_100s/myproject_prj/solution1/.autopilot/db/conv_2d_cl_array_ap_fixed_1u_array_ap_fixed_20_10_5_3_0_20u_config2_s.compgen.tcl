# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Native AXIS:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::native_axis_add] == "::AESL_LIB_XILADAPTER::native_axis_add"} {
eval "::AESL_LIB_XILADAPTER::native_axis_add { \
    id 926 \
    name input_1 \
    reset_level 1 \
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


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 927 \
    name layer2_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_layer2_out \
    op interface \
    ports { layer2_out_din { O 400 vector } layer2_out_num_data_valid { I 9 vector } layer2_out_fifo_cap { I 9 vector } layer2_out_full_n { I 1 bit } layer2_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 928 \
    name b2_0 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_0 \
    op interface \
    ports { b2_0 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 929 \
    name b2_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_1 \
    op interface \
    ports { b2_1 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 930 \
    name b2_2 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_2 \
    op interface \
    ports { b2_2 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 931 \
    name b2_3 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_3 \
    op interface \
    ports { b2_3 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 932 \
    name b2_4 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_4 \
    op interface \
    ports { b2_4 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 933 \
    name b2_5 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_5 \
    op interface \
    ports { b2_5 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 934 \
    name b2_6 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_6 \
    op interface \
    ports { b2_6 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 935 \
    name b2_7 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_7 \
    op interface \
    ports { b2_7 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 936 \
    name b2_8 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_8 \
    op interface \
    ports { b2_8 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 937 \
    name b2_9 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_9 \
    op interface \
    ports { b2_9 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 938 \
    name b2_10 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_10 \
    op interface \
    ports { b2_10 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 939 \
    name b2_11 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_11 \
    op interface \
    ports { b2_11 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 940 \
    name b2_12 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_12 \
    op interface \
    ports { b2_12 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 941 \
    name b2_13 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_13 \
    op interface \
    ports { b2_13 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 942 \
    name b2_14 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_14 \
    op interface \
    ports { b2_14 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 943 \
    name b2_15 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_15 \
    op interface \
    ports { b2_15 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 944 \
    name b2_16 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_16 \
    op interface \
    ports { b2_16 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 945 \
    name b2_17 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_17 \
    op interface \
    ports { b2_17 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 946 \
    name b2_18 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_18 \
    op interface \
    ports { b2_18 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 947 \
    name b2_19 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b2_19 \
    op interface \
    ports { b2_19 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } ap_continue { I 1 bit } } \
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
    reset_level 1 \
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
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
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


# RegSlice definition:
set ID 948
set RegSliceName myproject_regslice_both
set RegSliceInstName myproject_regslice_both_U
set CoreName ap_simcore_myproject_regslice_both
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $RegSliceName BINDTYPE interface TYPE interface_regslice INSTNAME $RegSliceInstName
}


if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_regSlice] == "::AESL_LIB_VIRTEX::xil_gen_regSlice"} {
eval "::AESL_LIB_VIRTEX::xil_gen_regSlice { \
    name ${RegSliceName} \
    prefix myproject_ \
    sliceTypeList 0\
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_regSlice, check your platform lib"
}
}


