################################################################################
# DSP Pipeline Optimization Script for HLS CNN
# Purpose: Enable DSP48E2 internal pipeline registers for better timing
# Usage: Run after HLS synthesis before Vivado implementation
################################################################################

puts "=========================================="
puts "Applying DSP Pipeline Optimizations"
puts "=========================================="

# Open the generated HLS project
open_project hls_cnn_2d_100s_prj
open_solution solution1

# ============================================================================
# Method 1: Set global DSP binding with latency hint
# ============================================================================
puts "\n[INFO] Setting global DSP pipeline latency..."

# Force all multiplications to use DSP48 with 3-cycle latency
# This will enable MREG and PREG inside DSP48E2
set_directive_bind_op -op mul -impl dsp -latency 3 hls_cnn_2d_100s

# ============================================================================
# Method 2: Target specific critical functions
# ============================================================================
puts "\n[INFO] Optimizing critical conv2d_1 layer multipliers..."

# The critical path is in conv2d_1 layer's dense_latency multiplier
# Force DSP48 resource with pipeline stages
set_directive_resource -core DSP48 \
    "conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_s/\
dense_latency_ap_fixed_16_2_5_3_0_ap_fixed_12_2_5_3_0_config4_mult_s"

# ============================================================================
# Method 3: Add allocation constraints
# ============================================================================
puts "\n[INFO] Setting DSP allocation limits..."

# Limit total DSP usage to encourage resource sharing and pipelining
# After RF=16, we expect ~400 DSPs (was 520)
set_directive_allocation -limit 450 -type operation hls_cnn_2d_100s mul

# ============================================================================
# Method 4: Pipeline optimization directives
# ============================================================================
puts "\n[INFO] Adding pipeline optimization directives..."

# Ensure dataflow pipeline between layers
set_directive_dataflow hls_cnn_2d_100s

# Pipeline the critical loops with reduced II if possible
set_directive_pipeline -II 1 \
    "conv_2d_cl_array_ap_fixed_20u_array_ap_fixed_12_2_5_3_0_10u_config4_s"

# ============================================================================
# Save and re-run C synthesis
# ============================================================================
puts "\n[INFO] Re-running C synthesis with optimizations..."

csynth_design

puts "\n=========================================="
puts "Optimization Complete!"
puts "Check solution1/syn/report/ for updated timing"
puts "=========================================="

# Export to check latency/resource changes
export_design -format ip_catalog

close_project
exit
