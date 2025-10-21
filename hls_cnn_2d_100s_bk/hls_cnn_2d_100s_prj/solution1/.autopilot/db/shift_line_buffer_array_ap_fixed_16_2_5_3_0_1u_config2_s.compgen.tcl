# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler hls_cnn_2d_100s_shift_line_buffer_array_ap_fixed_16_2_5_3_0_1u_config2_s_void_conv_2d_buffer_bkb BINDTYPE {storage} TYPE {shiftreg} IMPL {auto} LATENCY 1 ALLOW_PRAGMA 1
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2 \
    name in_elem_0_0_0_0_0_val \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_in_elem_0_0_0_0_0_val \
    op interface \
    ports { in_elem_0_0_0_0_0_val { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_8 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_8 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_8_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_8_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_8_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_9 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_9 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_9 { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_9_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_28 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_28 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_28_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_28_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_28_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_29 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_29 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_29 { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_29_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_18 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_18 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_18_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_18_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_18_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_19 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_19 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_19 { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_19_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_8 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_8 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_8_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_8_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_8_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_9 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_9 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_9 { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_9_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_7 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_7 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_7_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_7_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_7_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_27 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_27 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_27_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_27_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_27_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_17 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_17 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_17_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_17_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_17_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 14 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_7 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_7 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_7_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_7_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_7_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 15 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_6 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_6 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_6_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_6_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_6_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 16 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_26 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_26 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_26_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_26_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_26_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 17 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_16 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_16 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_16_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_16_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_16_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 18 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_6 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_6 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_6_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_6_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_6_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 19 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_5 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_5 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_5_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_5_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_5_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 20 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_25 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_25 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_25_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_25_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_25_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 21 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_15 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_15 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_15_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_15_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_15_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 22 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_5 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_5 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_5_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_5_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_5_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 23 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_4 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_4 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_4_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_4_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_4_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 24 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_24 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_24 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_24_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_24_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_24_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 25 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_14 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_14 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_14_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_14_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_14_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 26 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_4 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_4 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_4_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_4_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_4_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 27 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_3 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_3 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_3_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_3_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_3_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 28 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_23 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_23 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_23_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_23_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_23_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 29 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_13 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_13 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_13_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_13_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_13_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 30 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_3 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_3 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_3_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_3_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_3_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 31 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_2 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_2 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_2_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_2_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_2_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 32 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_22 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_22 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_22_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_22_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_22_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 33 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_12 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_12 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_12_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_12_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_12_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 34 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_2 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_2 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_2_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_2_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_2_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 35 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_1 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_1 \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_1_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_1_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_1_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 36 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_21 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_21 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_21_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_21_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_21_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 37 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_11 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_11 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_11_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_11_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_11_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 38 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_1 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_1 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_1_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_1_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_1_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 39 \
    name void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig \
    op interface \
    ports { void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_i { I 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_o { O 16 vector } void_compute_output_buffer_2d_array_const_ap_shift_reg_n_chan_stream_weig_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 40 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_20 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_20 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_20_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_20_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_20_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 41 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_10 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_10 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_10_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_10_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_10_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 42 \
    name p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9 \
    op interface \
    ports { p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_i { I 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_o { O 16 vector } p_ZZN4nnet24compute_output_buffer_2dINS_5arrayI8ap_fixedILi16ELi2EL9ap_q_mode5EL9_o_ap_vld { O 1 bit } } \
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


# Adapter definition:
set PortName ap_ce
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_ce] == "cg_default_interface_gen_ce"} {
eval "cg_default_interface_gen_ce { \
    id -4 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_ce \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


