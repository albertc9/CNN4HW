`timescale 1ns / 1ps

module tb_CNN4HW;

    //========================================================================
    // Parameters
    //========================================================================
    parameter CLK_PERIOD = 5.0;          // 200MHz clock (5ns period)
    parameter NUM_PIXELS = 1024;         // 4x256 = 1024 pixels
    parameter DATA_WIDTH = 16;           // ap_fixed<16,2>
    parameter DEBUG_HANDSHAKE = 0;       // Set to 1 to print every handshake

    // Streaming Test Parameters
    parameter NUM_SAMPLES = 10;          // Number of samples to test
    parameter START_SAMPLE_ID = 0;       // Starting sample ID

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

    // Streaming Test Variables
    integer sample_id;
    reg [128*8-1:0] filename;   // 128 characters max
    reg [128*8-1:0] data_path;  // 128 characters max

    // Result Storage
    reg [DATA_WIDTH-1:0] results [0:NUM_SAMPLES-1];
    integer latencies [0:NUM_SAMPLES-1];
    integer inference_start_times [0:NUM_SAMPLES-1];
    integer inference_end_times [0:NUM_SAMPLES-1];

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
        $display("CNN4HW_TOP Streaming Inference Test");
        $display("================================================================================");
        $display("Test Configuration:");
        $display("  Clock Frequency : 200 MHz (Period = %0.1f ns)", CLK_PERIOD);
        $display("  Number of Samples: %0d", NUM_SAMPLES);
        $display("  Start Sample ID : %0d", START_SAMPLE_ID);
        $display("  Input Pixels    : %0d (4 x 256 x 1)", NUM_PIXELS);
        $display("  Data Format     : ap_fixed<16,2> (16-bit fixed-point)");
        $display("================================================================================");

        // Initialize signals
        rst_n = 0;
        start = 0;
        input_data = 0;
        input_valid = 0;
        output_ready = 1;  // Always ready to receive output
        pixel_count = 0;

        // Set data path
        data_path = "/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/";

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

        // Start streaming inference loop
        $display("\n[%0t ns] ========== START STREAMING INFERENCE ==========", $time);

        total_cycles = 0;
        start_time = $time;

        for (sample_id = START_SAMPLE_ID; sample_id < START_SAMPLE_ID + NUM_SAMPLES; sample_id = sample_id + 1) begin
            // Load data for this sample
            // Note: Use case statement to avoid $sformat string padding issues
            $display("\n[%0t ns] Loading sample #%0d...", $time, sample_id);

            case (sample_id)
                0:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample0.hex", test_image);
                1:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample1.hex", test_image);
                2:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample2.hex", test_image);
                3:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample3.hex", test_image);
                4:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample4.hex", test_image);
                5:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample5.hex", test_image);
                6:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample6.hex", test_image);
                7:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample7.hex", test_image);
                8:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample8.hex", test_image);
                9:  $readmemh("/home/work1/Work/CNN_iCube_FPGA_b/data/testhex/test_input_sample9.hex", test_image);
                default: begin
                    $display("[ERROR] Sample ID %0d not supported in case statement!", sample_id);
                    $finish;
                end
            endcase

            // Check if data loaded correctly
            if (test_image[0] === 16'hxxxx) begin
                $display("[ERROR] Failed to load sample #%0d!", sample_id);
                $finish;
            end

            // Record inference start time
            inference_start_times[sample_id - START_SAMPLE_ID] = $time;

            // Run inference for this sample
            run_single_inference(sample_id, latencies[sample_id - START_SAMPLE_ID], results[sample_id - START_SAMPLE_ID]);

            // Record inference end time
            inference_end_times[sample_id - START_SAMPLE_ID] = $time;
        end

        end_time = $time;
        total_cycles = (end_time - start_time) / CLK_PERIOD;

        // Print summary
        $display("\n");
        $display("================================================================================");
        $display("STREAMING INFERENCE SUMMARY");
        $display("================================================================================");
        $display("Total Samples    : %0d", NUM_SAMPLES);
        $display("Total Time       : %0d cycles (%0.2f us)", total_cycles, total_cycles * CLK_PERIOD / 1000.0);
        $display("Average Latency  : %0d cycles (%0.2f us)", total_cycles / NUM_SAMPLES, (total_cycles / NUM_SAMPLES) * CLK_PERIOD / 1000.0);

        // Calculate throughput
        if (total_cycles > 0) begin
            $display("Throughput       : %0.2f inferences/sec", (NUM_SAMPLES * 1000000000.0) / (total_cycles * CLK_PERIOD));
        end

        $display("================================================================================");
        $display("\nDetailed Results:");
        $display("--------------------------------------------------------------------------------");
        $display("Sample_ID | Output_Hex | Output_Float     | Latency_Cycles | Latency_us");
        $display("--------------------------------------------------------------------------------");

        for (i = 0; i < NUM_SAMPLES; i = i + 1) begin
            if (results[i][15] == 1) begin
                output_float = $itor($signed(results[i])) / 16384.0;
            end else begin
                output_float = $itor(results[i]) / 16384.0;
            end
            $display("%9d | 0x%04h     | %16.10f | %14d | %10.2f",
                     START_SAMPLE_ID + i, results[i], output_float, latencies[i], latencies[i] * CLK_PERIOD / 1000.0);
        end

        $display("================================================================================\n");

        repeat(10) @(posedge clk);
        $finish;
    end

    //========================================================================
    // Task: Run Single Inference
    //========================================================================
    task run_single_inference;
        input integer inf_sample_id;
        output integer inf_latency;
        output [DATA_WIDTH-1:0] inf_result;
        begin
            $display("\n[%0t ns] ========== INFERENCE #%0d ==========", $time, inf_sample_id);

            // Wait for idle
            if (!idle) begin
                $display("[%0t ns] Waiting for IP to be idle...", $time);
                wait(idle == 1);
            end
            @(posedge clk);

            $display("[%0t ns] Starting inference for sample %0d...", $time, inf_sample_id);
            $display("[%0t ns] ========== INPUT DATA TRANSMISSION ==========", $time);

            // Reset pixel counter
            pixel_count = 0;

            // Assert start and present first pixel
            start = 1;
            start_time = $time;
            input_data = test_image[0];
            input_valid = 1;

            i = 0;

            // Wait for first handshake
            @(posedge clk);
            while (!input_ready) begin
                @(posedge clk);
                if ($time > start_time + 100000) begin
                    $display("[ERROR] input_ready timeout!");
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

            // End input transmission
            @(posedge clk);
            input_valid = 0;
            input_data = 0;
            $display("[%0t ns] All %0d pixels transmitted", $time, pixel_count);

            // Wait for ready rising edge to deassert start
            $display("[%0t ns] Waiting for ready rising edge to deassert start...", $time);
            @(posedge clk);
            while (!ready) begin
                @(posedge clk);
                if ($time > start_time + 100000) begin
                    $display("[ERROR] ready signal timeout! Never went high after data transmission");
                    $display("  Current time: %0t, start_time: %0d", $time, start_time);
                    $display("  ready=%b, done=%b, idle=%b", ready, done, idle);
                    $finish;
                end
            end

            start = 0;
            $display("[%0t ns] ready rising edge detected, start deasserted (ready=%b)", $time, ready);

            // Wait for computation to complete (wait for done)
            $display("[%0t ns] ========== COMPUTATION PHASE ==========", $time);
            i = 0;
            while (!done && i < 20000) begin
                @(posedge clk);
                i = i + 1;
            end

            if (!done) begin
                $display("[ERROR] No done signal after %0d cycles!", i);
                $finish;
            end

            $display("[%0t ns] done=1 detected", $time);

            // Wait one more cycle for idle to return to 1
            @(posedge clk);
            if (!idle) begin
                $display("[%0t ns] Waiting for idle to return to 1...", $time);
                wait(idle == 1);
                @(posedge clk);
            end

            $display("[%0t ns] IP returned to idle", $time);
            end_time = $time;

            // Calculate latency
            inf_latency = (end_time - start_time) / CLK_PERIOD;
            inf_result = output_data;

            // Convert to float for display
            if (output_data[15] == 1) begin
                output_float = $itor($signed(output_data)) / 16384.0;
            end else begin
                output_float = $itor(output_data) / 16384.0;
            end

            $display("[%0t ns] ========== INFERENCE #%0d COMPLETE ==========", $time, inf_sample_id);
            $display("  Output (hex)  : 0x%04h", inf_result);
            $display("  Output (float): %f", output_float);
            $display("  Latency       : %0d cycles (%0.2f μs)", inf_latency, inf_latency * CLK_PERIOD / 1000.0);
        end
    endtask

    //========================================================================
    // Monitor
    //========================================================================
    reg start_prev, done_prev, idle_prev, ready_prev;
    reg output_valid_prev;

    initial begin
        start_prev = 0;
        done_prev = 0;
        idle_prev = 0;
        ready_prev = 0;
        output_valid_prev = 0;
    end

    always @(posedge clk) begin
        // Edge detection for start signal
        if (start && !start_prev) begin
            $display("[%0t ns] [MONITOR] start: 0 -> 1 (rising edge)", $time);
        end else if (!start && start_prev) begin
            $display("[%0t ns] [MONITOR] start: 1 -> 0 (falling edge)", $time);
        end
        start_prev <= start;

        if (done != done_prev) begin
            $display("[%0t ns] [MONITOR] ap_done: %b -> %b", $time, done_prev, done);
            done_prev = done;
        end
        if (idle != idle_prev) begin
            $display("[%0t ns] [MONITOR] ap_idle: %b -> %b", $time, idle_prev, idle);
            idle_prev = idle;
        end
        if (ready != ready_prev) begin
            $display("[%0t ns] [MONITOR] ap_ready: %b -> %b", $time, ready_prev, ready);
            ready_prev = ready;
        end

        if (output_valid != output_valid_prev) begin
            $display("[%0t ns] [MONITOR] output_valid: %b -> %b", $time, output_valid_prev, output_valid);
            if (output_valid) begin
                $display("[%0t ns] [MONITOR] OUTPUT: data=0x%04h", $time, output_data);
            end
            output_valid_prev = output_valid;
        end
    end

    //========================================================================
    // Timeout Watchdog
    //========================================================================
    initial begin
        #50000000;  // 50ms timeout
        $display("[ERROR] Simulation timeout!");
        $finish;
    end

endmodule
