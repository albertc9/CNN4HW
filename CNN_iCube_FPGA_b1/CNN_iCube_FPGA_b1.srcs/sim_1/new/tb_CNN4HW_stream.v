`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Streaming Multi-Sample CNN Testbench
// Performs continuous inference on multiple samples back-to-back
//////////////////////////////////////////////////////////////////////////////////

module tb_CNN4HW_stream;

    //========================================================================
    // Parameters - CONFIGURE HERE
    //========================================================================
    parameter CLK_PERIOD = 5.0;          // 200MHz clock (5ns period)
    parameter NUM_PIXELS = 1024;         // 4x256 = 1024 pixels
    parameter DATA_WIDTH = 16;           // ap_fixed<16,2>
    parameter NUM_SAMPLES = 1340;          // Number of samples to test (CHANGE THIS)
    parameter HEX_DIR = "/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/";
    parameter CSV_OUTPUT = "/home/work1/Work/CNN_iCube_FPGA_b/out/sim_out/inference_results.csv";

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
    integer sample_idx;
    integer pixel_count;
    integer start_time;
    integer end_time;
    integer total_cycles;
    integer csv_file;
    real output_float;
    reg [1024*8-1:0] hex_filename;  // String for filename

    //========================================================================
    // Statistics
    //========================================================================
    integer total_inferences;
    integer total_time_ns;
    real avg_latency_us;

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
    // Main Test Sequence - Streaming Loop
    //========================================================================
    initial begin
        // Print simulation header
        $display("================================================================================");
        $display("CNN4HW_TOP Streaming Multi-Sample Simulation");
        $display("================================================================================");
        $display("Test Configuration:");
        $display("  Clock Frequency : 200 MHz (Period = %0.1f ns)", CLK_PERIOD);
        $display("  Number of Samples: %0d", NUM_SAMPLES);
        $display("  Input Pixels    : %0d (4 x 256 x 1)", NUM_PIXELS);
        $display("  Data Format     : ap_fixed<16,2> (16-bit fixed-point)");
        $display("  Hex File Dir    : %s", HEX_DIR);
        $display("  CSV Output      : %s", CSV_OUTPUT);
        $display("================================================================================");

        // Initialize signals
        rst_n = 0;
        start = 0;
        input_data = 0;
        input_valid = 0;
        output_ready = 1;  // Always ready to receive output
        pixel_count = 0;
        total_inferences = 0;
        total_time_ns = 0;

        // Open CSV file for results
        csv_file = $fopen(CSV_OUTPUT, "w");
        if (csv_file == 0) begin
            $display("[ERROR] Cannot open CSV file: %s", CSV_OUTPUT);
            $finish;
        end
        // Write CSV header
        $fwrite(csv_file, "sample_index,inference_result,latency_ns,timestamp_ns\n");
        $display("\n[%0t ns] CSV output file opened: %s", $time, CSV_OUTPUT);

        // Reset sequence
        $display("\n[%0t ns] ========== RESET SEQUENCE ==========", $time);
        $display("[%0t ns] Asserting reset (rst_n = 0)...", $time);
        repeat(10) @(posedge clk);

        $display("[%0t ns] Releasing reset (rst_n = 1)...", $time);
        rst_n = 1;
        repeat(5) @(posedge clk);

        $display("[%0t ns] Reset sequence completed", $time);
        $display("  IP Status: idle=%b ready=%b", idle, ready);

        if (!idle) begin
            $display("[ERROR] IP is not idle after reset!");
            $finish;
        end

        //====================================================================
        // MAIN STREAMING LOOP - Process all samples
        //====================================================================
        $display("\n[%0t ns] ========== STARTING STREAMING TEST ==========", $time);
        $display("Processing %0d samples...\n", NUM_SAMPLES);

        for (sample_idx = 0; sample_idx < NUM_SAMPLES; sample_idx = sample_idx + 1) begin

            //================================================================
            // Load sample data
            //================================================================
            $sformat(hex_filename, "%stest_input_sample%0d.hex", HEX_DIR, sample_idx);
            $display("[%0t ns] ========== SAMPLE %0d/%0d ==========", $time, sample_idx, NUM_SAMPLES-1);
            $display("[%0t ns] Loading: %s", $time, hex_filename);

            $readmemh(hex_filename, test_image);

            // Validate data loaded
            if (test_image[0] === 16'hxxxx) begin
                $display("[ERROR] Failed to load sample %0d from: %s", sample_idx, hex_filename);
                $fclose(csv_file);
                $finish;
            end
            $display("[%0t ns] Data loaded (first pixel: 0x%04h)", $time, test_image[0]);

            //================================================================
            // Pipelined dataflow IP: No reset needed, no idle wait!
            // The IP's input_ready signal provides automatic backpressure
            //================================================================
            $display("[%0t ns] Starting sample %0d (idle=%b ready=%b)", $time, sample_idx, idle, ready);

            repeat(3) @(posedge clk);

            //================================================================
            // Start inference
            //================================================================
            start_time = $time;
            start = 1;
            repeat(3) @(posedge clk);

            //================================================================
            // Transmit input data (1024 pixels)
            //================================================================
            $display("[%0t ns] Transmitting %0d pixels...", $time, NUM_PIXELS);

            // Send first pixel
            input_data = test_image[0];
            input_valid = 1;
            pixel_count = 0;

            // Wait for first handshake
            @(posedge clk);
            while (!input_ready) begin
                @(posedge clk);
                if ($time > start_time + 100000) begin
                    $display("[ERROR] input_ready timeout for sample %0d", sample_idx);
                    $fclose(csv_file);
                    $finish;
                end
            end
            pixel_count = 1;

            // Send remaining pixels
            for (i = 1; i < NUM_PIXELS; i = i + 1) begin
                input_data = test_image[i];
                input_valid = 1;

                @(posedge clk);
                while (!input_ready) begin
                    @(posedge clk);
                end

                pixel_count = pixel_count + 1;
            end

            // End transmission
            @(posedge clk);
            input_valid = 0;
            input_data = 0;
            $display("[%0t ns] All %0d pixels transmitted", $time, pixel_count);

            //================================================================
            // Wait for computation to complete
            //================================================================
            $display("[%0t ns] Waiting for output...", $time);

            i = 0;
            while (!output_valid && !done && i < 20000) begin
                @(posedge clk);
                i = i + 1;
            end

            if (!output_valid && !done) begin
                $display("[ERROR] Sample %0d: No output after %0d cycles!", sample_idx, i);
                $fclose(csv_file);
                $finish;
            end

            //================================================================
            // Deassert start and capture output
            //================================================================
            start = 0;
            end_time = $time;
            total_cycles = (end_time - start_time) / CLK_PERIOD;

            // Convert output to float
            if (output_data[15] == 1) begin
                output_float = $itor($signed(output_data)) / 16384.0;
            end else begin
                output_float = $itor(output_data) / 16384.0;
            end

            //================================================================
            // Log results to CSV and console
            //================================================================
            $fwrite(csv_file, "%0d,%0.6f,%0d,%0d\n",
                    sample_idx, output_float, end_time - start_time, end_time);

            $display("[%0t ns] OUTPUT: %.6f (0x%04h) | Latency: %0d cycles (%.2f us)",
                     $time, output_float, output_data, total_cycles,
                     total_cycles * CLK_PERIOD / 1000.0);

            // Update statistics
            total_inferences = total_inferences + 1;
            total_time_ns = total_time_ns + (end_time - start_time);

            //================================================================
            // Cleanup after sample completion - Wait for output_valid falling edge, then reset
            //================================================================
            $display("[%0t ns] Sample %0d complete. Waiting for output_valid to go low...", $time, sample_idx);

            // Wait for output_valid falling edge
            @(posedge clk);
            while (output_valid) begin
                @(posedge clk);
            end
            $display("[%0t ns] output_valid deasserted", $time);

            // Perform complete reset (only if not the last sample)
            if (sample_idx < NUM_SAMPLES - 1) begin
                $display("[%0t ns] Performing full reset for next sample...", $time);

                // Assert reset
                rst_n = 0;
                repeat(10) @(posedge clk);
                $display("[%0t ns] Reset asserted", $time);

                // Release reset
                rst_n = 1;
                repeat(10) @(posedge clk);
                $display("[%0t ns] Reset released", $time);

                // Wait for IP to return to idle state
                i = 0;
                while (!idle && i < 100) begin
                    @(posedge clk);
                    i = i + 1;
                end

                if (idle) begin
                    $display("[%0t ns] IP idle and ready for sample %0d", $time, sample_idx + 1);
                end else begin
                    $display("[WARNING] IP not idle after %0d cycles, but continuing...", i);
                end

                // Additional safety margin
                repeat(5) @(posedge clk);
            end

        end // End of sample loop

        //====================================================================
        // Final Statistics
        //====================================================================
        avg_latency_us = (total_time_ns / total_inferences) / 1000.0;

        $display("\n================================================================================");
        $display("STREAMING TEST COMPLETE");
        $display("================================================================================");
        $display("Total Samples Tested : %0d", total_inferences);
        $display("Total Simulation Time: %0.2f ms", $time / 1000000.0);
        $display("Average Latency      : %0.2f us", avg_latency_us);
        $display("Results saved to     : %s", CSV_OUTPUT);
        $display("================================================================================\n");

        // Close CSV file
        $fclose(csv_file);
        $display("[%0t ns] CSV file closed", $time);

        // Cleanup
        repeat(10) @(posedge clk);
        $finish;
    end

    //========================================================================
    // Timeout Watchdog (extended for multi-sample testing)
    //========================================================================
    initial begin
        #500000000;  // 500ms timeout for streaming test
        $display("[ERROR] Simulation timeout!");
        $fclose(csv_file);
        $finish;
    end

endmodule
