`timescale 1ns / 1ps

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

        repeat(3) @(posedge clk);

        $display("[%0t ns] Starting inference...", $time);
        start_time = $time;

        start = 1;
        repeat(3) @(posedge clk);
        $display("[%0t ns] START asserted, transmitting data...", $time);

        input_data = test_image[0];
        input_valid = 1;

        $display("\n[%0t ns] ========== INPUT DATA TRANSMISSION ==========", $time);
        $display("[%0t ns] Transmitting %0d pixels via AXI Stream...", $time, NUM_PIXELS);

        i = 0;

        // Wait for handshake
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

        for (i = 1; i < NUM_PIXELS; i = i + 1) begin
            input_data = test_image[i];
            input_valid = 1;

            @(posedge clk);
            while (!input_ready) begin
                @(posedge clk);
            end

            pixel_count = pixel_count + 1;

            if ((i+1) % 256 == 0) begin
                $display("[%0t ns] Progress: %4d/%4d pixels sent (Row %0d/4 complete)",
                         $time, i+1, NUM_PIXELS, (i+1)/256);
            end
        end

        @(posedge clk);
        input_valid = 0;
        input_data = 0;
        $display("[%0t ns] All %0d pixels transmitted", $time, pixel_count);

        $display("\n[%0t ns] ========== COMPUTATION PHASE ==========", $time);
        $display("[%0t ns] Waiting for output or done signal...", $time);

        i = 0;
        while (!output_valid && !done && i < 20000) begin
            @(posedge clk);
            i = i + 1;
            if (i % 200 == 0) begin
                $display("[%0t ns] Waiting (cycle %0d)... done=%b idle=%b ready=%b output_valid=%b",
                         $time, i, done, idle, ready, output_valid);
            end
        end

        if (!output_valid && !done) begin
            $display("\n[ERROR] No output or done signal after %0d cycles!", i);
            $display("  Time elapsed: %0.2f μs", ($time - start_time) / 1000.0);
            $display("  IP Status: done=%b idle=%b ready=%b", done, idle, ready);
            $finish;
        end

        start = 0;
        $display("[%0t ns] Output detected", $time);
        end_time = $time;

        // Calculate latency
        total_cycles = (end_time - start_time) / CLK_PERIOD;

        $display("\n[%0t ns] ========== OUTPUT RECEIVED ==========", $time);
        $display("  Raw Output (hex) : 0x%04h", output_data);
        $display("  Raw Output (dec) : %0d", output_data);

        if (output_data[15] == 1) begin
            output_float = $itor($signed(output_data)) / 16384.0;
        end else begin
            output_float = $itor(output_data) / 16384.0;
        end

        $display("  Float Value      : %f", output_float);
        $display("\n[%0t ns] ========== INFERENCE COMPLETE ==========", $time);
        $display("  Total Cycles     : %0d", total_cycles);
        $display("  Total Time       : %0.2f μs", total_cycles * CLK_PERIOD / 1000.0);
        $display("================================================================================\n");

        repeat(10) @(posedge clk);
        $finish;
    end

    //========================================================================
    // Monitor
    //========================================================================
    reg done_prev, idle_prev, ready_prev;
    reg output_valid_prev;

    initial begin
        done_prev = 0;
        idle_prev = 0;
        ready_prev = 0;
        output_valid_prev = 0;
    end

    always @(posedge clk) begin
        if (start) begin
            $display("[%0t ns] [MONITOR] start asserted", $time);
        end
        if (input_valid && input_ready) begin
            $display("[%0t ns] [MONITOR] Input handshake: data=0x%04h (pixel #%0d)", $time, input_data, pixel_count);
        end

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
