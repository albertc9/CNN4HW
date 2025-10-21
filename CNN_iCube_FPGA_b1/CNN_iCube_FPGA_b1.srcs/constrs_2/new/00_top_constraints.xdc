################################################################################
# File: 00_top_constraints.xdc
# Purpose: Index of all constraint files used in this project.
# Vivado automatically merges all .xdc files in constrs_1; this file
# documents intended organization and load order.
################################################################################
# 01_clocks.xdc               - main system clocks
# 02_io_delays.xdc            - I/O timing relative to clocks
# 03_clock_groups.xdc         - asynchronous/synchronous clock domain groups
# 04_uncertainty.xdc          - clock jitter / uncertainty models
# 05_multicycle_falsepaths.xdc- multi-cycle and false-path definitions
# 10_io_standards.xdc         - IO voltage standards (LVCMOS18)
# 20_pins.xdc                 - package pin mapping
# 21_diff_pairs.xdc           - LVDS or differential pair assignments
# 22_interface_adc.xdc        - ADC interface constraints
# 23_interface_spi.xdc        - SPI interface constraints
# 24_interface_axi.xdc        - AXI interface constraints
# 30_timing_extras.xdc        - special path or max/min delay constraints
# 40_debug_ila.xdc            - ILA/VIO debug constraints
# 50_power_thermal.xdc        - power/thermal modeling attributes
# 99_local_override.xdc       - temporary overrides during testing
################################################################################
# (This file intentionally contains no active constraint commands.)
