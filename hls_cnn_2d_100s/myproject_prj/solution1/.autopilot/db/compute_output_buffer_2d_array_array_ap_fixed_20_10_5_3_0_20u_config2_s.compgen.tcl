# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 904 \
    name in_elem_0_0_0_0_0_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_in_elem_0_0_0_0_0_val \
    op interface \
    ports { in_elem_0_0_0_0_0_val { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 905 \
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
    id 906 \
    name biases_0_val1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_0_val1 \
    op interface \
    ports { biases_0_val1 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 907 \
    name biases_1_val2 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_1_val2 \
    op interface \
    ports { biases_1_val2 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 908 \
    name biases_2_val3 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_2_val3 \
    op interface \
    ports { biases_2_val3 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 909 \
    name biases_3_val4 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_3_val4 \
    op interface \
    ports { biases_3_val4 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 910 \
    name biases_4_val5 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_4_val5 \
    op interface \
    ports { biases_4_val5 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 911 \
    name biases_5_val6 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_5_val6 \
    op interface \
    ports { biases_5_val6 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 912 \
    name biases_6_val7 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_6_val7 \
    op interface \
    ports { biases_6_val7 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 913 \
    name biases_7_val8 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_7_val8 \
    op interface \
    ports { biases_7_val8 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 914 \
    name biases_8_val9 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_8_val9 \
    op interface \
    ports { biases_8_val9 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 915 \
    name biases_9_val10 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_9_val10 \
    op interface \
    ports { biases_9_val10 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 916 \
    name biases_10_val11 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_10_val11 \
    op interface \
    ports { biases_10_val11 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 917 \
    name biases_11_val12 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_11_val12 \
    op interface \
    ports { biases_11_val12 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 918 \
    name biases_12_val13 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_12_val13 \
    op interface \
    ports { biases_12_val13 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 919 \
    name biases_13_val14 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_13_val14 \
    op interface \
    ports { biases_13_val14 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 920 \
    name biases_14_val15 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_14_val15 \
    op interface \
    ports { biases_14_val15 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 921 \
    name biases_15_val16 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_15_val16 \
    op interface \
    ports { biases_15_val16 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 922 \
    name biases_16_val17 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_16_val17 \
    op interface \
    ports { biases_16_val17 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 923 \
    name biases_17_val18 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_17_val18 \
    op interface \
    ports { biases_17_val18 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 924 \
    name biases_18_val19 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_18_val19 \
    op interface \
    ports { biases_18_val19 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 925 \
    name biases_19_val20 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_biases_19_val20 \
    op interface \
    ports { biases_19_val20 { I 20 vector } } \
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


