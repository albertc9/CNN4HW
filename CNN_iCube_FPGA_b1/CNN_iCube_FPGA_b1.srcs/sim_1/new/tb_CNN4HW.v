`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2025/10/14 23:26:19
// Design Name:
// Module Name: tb_CNN4HW
// Project Name: CNN iCube FPGA Post-Synthesis Simulation
// Target Devices: xcku5p-ffvb676-2-e
// Tool Versions: Vivado 2023.2
// Description: Post-synthesis simulation testbench for CNN4HW_TOP
//              - Tests single sample inference (Sample #0 from dataset)
//              - Clock: 200MHz (5ns period)
//              - Detailed console output for debugging
//
// Dependencies:
//   - CNN4HW_TOP.v
//   - test_input_sample0.hex (1024 pixels in ap_fixed<16,2> format)
//
// How to Run:
//   1. Generate test data (first time only):
//      cd CNN_iCube_FPGA_b1/CNN_iCube_FPGA_b1.srcs/sim_1/new
//      python generate_test_data.py 0
//
//   2. Run simulation in Vivado Tcl Console:
//      set_property top tb_CNN4HW [get_filesets sim_1]
//      launch_simulation               # Behavioral
//      # launch_simulation -mode post-synthesis -type functional  # Post-synth
//      run all
//
//   3. To test different samples:
//      - Change SAMPLE_INDEX parameter (line 38)
//      - Generate corresponding hex file: python generate_test_data.py N
//      - Update $readmemh filename (line 132)
//
//   4. Expected output:
//      - Console shows detailed progress and results
//      - Latency: ~6162 cycles (30.81 μs @ 200MHz)
//      - Output: Sigmoid probability [0.0, 1.0]
//
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Added single sample test with detailed logging
//
//////////////////////////////////////////////////////////////////////////////////

module tb_CNN4HW;

    //========================================================================
    // Parameters
    //========================================================================
    parameter CLK_PERIOD = 5.0;          // 200MHz clock (5ns period)
    parameter NUM_PIXELS = 1024;         // 4x256 = 1024 pixels
    parameter DATA_WIDTH = 16;           // ap_fixed<16,2>
    parameter SAMPLE_INDEX = 0;          // Testing sample #0

    //========================================================================
    // Clock and Reset
    //========================================================================
    reg clk;
    reg rst_n;

    //========================================================================
    // Control Signals
    //========================================================================
    reg start;
    wire done;
    wire idle;
    wire ready;

    //========================================================================
    // Data Interfaces
    //========================================================================
    reg [DATA_WIDTH-1:0] input_data;
    reg input_valid;
    wire input_ready;

    wire [DATA_WIDTH-1:0] output_data;
    wire output_valid;
    reg output_ready;

    //========================================================================
    // Test Data Storage
    //========================================================================
    reg [DATA_WIDTH-1:0] test_image [0:NUM_PIXELS-1];

    //========================================================================
    // Test Control Variables
    //========================================================================
    integer i;
    integer pixel_count;
    integer start_time;
    integer end_time;
    integer total_cycles;
    real output_float;

    //========================================================================
    // DUT Instantiation
    //========================================================================
    CNN4HW_TOP uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(done),
        .idle(idle),
        .ready(ready),
        .input_data(input_data),
        .input_valid(input_valid),
        .input_ready(input_ready),
        .output_data(output_data),
        .output_valid(output_valid),
        .output_ready(output_ready)
    );

    //========================================================================
    // Clock Generation: 200MHz (5ns period)
    //========================================================================
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    //========================================================================
    // Main Test Sequence
    //========================================================================
    initial begin
        // Print simulation header
        $display("================================================================================");
        $display("CNN4HW_TOP Post-Synthesis Simulation");
        $display("================================================================================");
        $display("Test Configuration:");
        $display("  Clock Frequency : 200 MHz (Period = %0.1f ns)", CLK_PERIOD);
        $display("  Sample Index    : %0d", SAMPLE_INDEX);
        $display("  Input Pixels    : %0d (4 x 256 x 1)", NUM_PIXELS);
        $display("  Data Format     : ap_fixed<16,2> (16-bit fixed-point)");
        $display("  Expected Latency: ~6162 cycles (~30.81 μs)");
        $display("================================================================================");

        // Initialize signals
        rst_n = 0;
        start = 0;
        input_data = 0;
        input_valid = 0;
        output_ready = 1;  // Always ready to receive output
        pixel_count = 0;

        // Load test data
        $display("\n[%0t ns] Loading test data from file...", $time);
        $readmemh("test_input_sample0.hex", test_image);
        $display("[%0t ns] Test data loaded", $time);
        $display("  First pixel : 0x%04h", test_image[0]);
        $display("  Pixel[1]    : 0x%04h", test_image[1]);
        $display("  Pixel[10]   : 0x%04h", test_image[10]);
        $display("  Last pixel  : 0x%04h", test_image[NUM_PIXELS-1]);

        // Check if data loaded correctly
        if (test_image[0] === 16'hxxxx) begin
            $display("[ERROR] Test data not loaded! File may not exist.");
            $display("        Looking for: test_input_sample0.hex");
            $display("        Current dir: %m");
            $finish;
        end
        $display("  Data validation: PASS");

        // Reset sequence
        $display("\n[%0t ns] ========== RESET SEQUENCE ==========", $time);
        $display("[%0t ns] Asserting reset (rst_n = 0)...", $time);
        repeat(10) @(posedge clk);

        $display("[%0t ns] Releasing reset (rst_n = 1)...", $time);
        rst_n = 1;
        repeat(5) @(posedge clk);

        $display("[%0t ns] Reset sequence completed", $time);
        $display("[%0t ns] Checking IP status...", $time);
        $display("  idle  = %b (should be 1)", idle);
        $display("  ready = %b (will pulse high after inference completes)", ready);

        if (!idle) begin
            $display("[ERROR] IP is not idle after reset!");
            $finish;
        end

        // Start inference
        $display("\n[%0t ns] ========== START INFERENCE ==========", $time);
        $display("[%0t ns] Waiting for IP to be idle...", $time);
        $display("  Current idle status: %b", idle);

        if (!idle) begin
            $display("[WARNING] IP not idle, waiting...");
            wait(idle == 1);
        end
        $display("[%0t ns] IP is idle, ready to start", $time);

        repeat(3) @(posedge clk);  // Extra cycles for edge detection logic in wrapper

        $display("[%0t ns] Asserting START (will keep HIGH during entire transmission)...", $time);
        start_time = $time;

        // CRITICAL: Keep start HIGH during ENTIRE data transmission!
        start = 1;
        repeat(3) @(posedge clk);
        $display("[%0t ns] START asserted, beginning data transmission...", $time);

        // Present first data
        input_data = test_image[0];
        input_valid = 1;

        // Send input data
        $display("\n[%0t ns] ========== INPUT DATA TRANSMISSION ==========", $time);
        $display("[%0t ns] Transmitting %0d pixels via AXI Stream...", $time, NUM_PIXELS);

        i = 0;  // First pixel already presented

        // Wait for first handshake
        @(posedge clk);
        while (!input_ready) begin
            @(posedge clk);
            if ($time > start_time + 100000) begin
                $display("[ERROR] input_ready timeout! IP not accepting data after 100us");
                $display("  idle=%b ready=%b done=%b", idle, ready, done);
                $finish;
            end
        end

        pixel_count = 1;
        $display("[%0t ns] First pixel accepted, continuing...", $time);

        // Send remaining pixels
        for (i = 1; i < NUM_PIXELS; i = i + 1) begin
            // Present next data
            input_data = test_image[i];
            input_valid = 1;

            // Wait for ready signal (handshake)
            @(posedge clk);
            while (!input_ready) begin
                @(posedge clk);
            end

            // Handshake completed
            pixel_count = pixel_count + 1;

            // Progress reporting every 256 pixels (every row)
            if ((i+1) % 256 == 0) begin
                $display("[%0t ns] Progress: %4d/%4d pixels sent (Row %0d/4 complete)",
                         $time, i+1, NUM_PIXELS, (i+1)/256);
            end
        end

        // End input transmission - deassert valid AND start
        @(posedge clk);
        input_valid = 0;
        input_data = 0;
        start = 0;  // Deassert start AFTER all data sent
        $display("[%0t ns] All %0d pixels transmitted, START deasserted", $time, pixel_count);

        // Wait for computation to complete
        $display("\n[%0t ns] ========== COMPUTATION PHASE ==========", $time);
        $display("[%0t ns] Waiting for output_valid...", $time);
        $display("  (Expected: ~6162 cycles from start)");

        wait(output_valid == 1);
        @(posedge clk);
        end_time = $time;

        // Calculate latency
        total_cycles = (end_time - start_time) / CLK_PERIOD;

        // Receive and display output
        $display("\n[%0t ns] ========== OUTPUT RECEIVED ==========", $time);
        $display("[%0t ns] Output is valid!", $time);
        $display("  Raw Output (hex) : 0x%04h", output_data);
        $display("  Raw Output (dec) : %0d", output_data);

        // Convert ap_fixed<16,2> to float
        // ap_fixed<16,2>: 1 sign bit + 1 integer bit + 14 fractional bits
        // Range: [-2.0, 2.0), Resolution: 1/16384 = 0.00006103515625
        if (output_data[15] == 1) begin
            // Negative number (two's complement)
            output_float = $itor($signed(output_data)) / 16384.0;
        end else begin
            // Positive number
            output_float = $itor(output_data) / 16384.0;
        end

        $display("  Float Value      : %f", output_float);

        // Interpret as classification probability
        if (output_float >= 0.0 && output_float <= 1.0) begin
            $display("  Interpretation   : Valid probability (Sigmoid output)");
            if (output_float >= 0.5) begin
                $display("  Classification   : POSITIVE (prob = %.4f)", output_float);
            end else begin
                $display("  Classification   : NEGATIVE (prob = %.4f)", output_float);
            end
        end else begin
            $display("  [WARNING] Output value %.4f is outside [0,1] range!", output_float);
        end

        // Wait for done signal
        $display("\n[%0t ns] Waiting for DONE signal...", $time);
        wait(done == 1);
        @(posedge clk);
        $display("[%0t ns] DONE signal received", $time);

        // Print performance summary
        $display("\n[%0t ns] ========== PERFORMANCE SUMMARY ==========", $time);
        $display("  Total Latency    : %0d cycles", total_cycles);
        $display("  Total Time       : %0.2f μs", (end_time - start_time) / 1000.0);
        $display("  Expected Latency : ~6162 cycles (~30.81 μs @ 200MHz)");
        if (total_cycles >= 6150 && total_cycles <= 6200) begin
            $display("  Status           : PASS (within expected range)");
        end else begin
            $display("  Status           : WARNING (latency differs from expected)");
        end

        // Check if IP returns to idle
        $display("\n[%0t ns] Checking IP idle state...", $time);
        repeat(5) @(posedge clk);
        if (idle) begin
            $display("[%0t ns] IP returned to IDLE state - Ready for next inference", $time);
        end else begin
            $display("[%0t ns] [WARNING] IP is not idle!", $time);
        end

        // Simulation complete
        $display("\n================================================================================");
        $display("SIMULATION COMPLETED SUCCESSFULLY");
        $display("================================================================================");
        $display("Summary:");
        $display("  - Sample %0d processed", SAMPLE_INDEX);
        $display("  - Output: %.6f (0x%04h)", output_float, output_data);
        $display("  - Latency: %0d cycles (%.2f μs)", total_cycles, (end_time - start_time) / 1000.0);
        $display("================================================================================");

        // Wait a bit before finishing
        repeat(100) @(posedge clk);
        $finish;
    end

    //========================================================================
    // Timeout Monitor (prevents infinite simulation)
    //========================================================================
    initial begin
        #10_000_000;  // 10ms timeout
        $display("\n[ERROR] Simulation timeout at %0t ns!", $time);
        $display("  The inference took longer than expected.");
        $display("  Check if DUT is functioning correctly.");
        $finish;
    end

    //========================================================================
    // Signal Monitoring (Optional - can be disabled for cleaner output)
    //========================================================================
    // Monitor critical signals for debugging
    always @(posedge clk) begin
        if (start)
            $display("[%0t ns] [MONITOR] start asserted", $time);
        if (done)
            $display("[%0t ns] [MONITOR] done pulse", $time);
        if (input_valid && input_ready)
            $display("[%0t ns] [MONITOR] Input handshake: data=0x%04h (pixel #%0d)", $time, input_data, pixel_count);
        if (output_valid && output_ready)
            $display("[%0t ns] [MONITOR] Output handshake: data=0x%04h", $time, output_data);
    end

    //========================================================================
    // Waveform Dump (for GTKWave or Vivado)
    //========================================================================
    initial begin
        $dumpfile("tb_CNN4HW.vcd");
        $dumpvars(0, tb_CNN4HW);
    end

endmodule
