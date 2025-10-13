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
    id 2951 \
    name layer3_out \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_layer3_out \
    op interface \
    ports { layer3_out_dout { I 400 vector } layer3_out_num_data_valid { I 9 vector } layer3_out_fifo_cap { I 9 vector } layer3_out_empty_n { I 1 bit } layer3_out_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2952 \
    name layer4_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_layer4_out \
    op interface \
    ports { layer4_out_din { O 200 vector } layer4_out_num_data_valid { I 9 vector } layer4_out_fifo_cap { I 9 vector } layer4_out_full_n { I 1 bit } layer4_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2953 \
    name b4_0 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_0 \
    op interface \
    ports { b4_0 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2954 \
    name b4_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_1 \
    op interface \
    ports { b4_1 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2955 \
    name b4_2 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_2 \
    op interface \
    ports { b4_2 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2956 \
    name b4_3 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_3 \
    op interface \
    ports { b4_3 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2957 \
    name b4_4 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_4 \
    op interface \
    ports { b4_4 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2958 \
    name b4_5 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_5 \
    op interface \
    ports { b4_5 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2959 \
    name b4_6 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_6 \
    op interface \
    ports { b4_6 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2960 \
    name b4_7 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_7 \
    op interface \
    ports { b4_7 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2961 \
    name b4_8 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b4_8 \
    op interface \
    ports { b4_8 { I 20 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2962 \
    name b4_9 \
    type other \
    dir I \
    reset_level 1 \
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


