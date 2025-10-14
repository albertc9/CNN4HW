`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for CNN4HW_TOP
// Demonstrates how to use the CNN accelerator wrapper
//////////////////////////////////////////////////////////////////////////////////

module CNN4HW_TOP_tb();

    //=========================================================================
    // Parameters
    //=========================================================================
    parameter DATA_WIDTH = 16;
    parameter IMAGE_SIZE = 1024;    // 32x32
    parameter CLK_PERIOD = 5;       // 5ns = 200MHz

    //=========================================================================
    // Signals
    //=========================================================================
    reg                     clk;
    reg                     rst_n;
    reg                     start;
    wire                    done;
    wire                    idle;
    wire                    ready;

    reg  [DATA_WIDTH-1:0]   input_data;
    reg                     input_valid;
    wire                    input_ready;

    wire [DATA_WIDTH-1:0]   output_data;
    wire                    output_valid;
    reg                     output_ready;

    // Test data storage
    reg [DATA_WIDTH-1:0] test_image [0:IMAGE_SIZE-1];
    integer pixel_count;
    integer inference_count;

    //=========================================================================
    // DUT Instantiation
    //=========================================================================
    CNN4HW_TOP #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMAGE_SIZE(IMAGE_SIZE)
    ) dut (
        .clk            (clk),
        .rst_n          (rst_n),
        .start          (start),
        .done           (done),
        .idle           (idle),
        .ready          (ready),
        .input_data     (input_data),
        .input_valid    (input_valid),
        .input_ready    (input_ready),
        .output_data    (output_data),
        .output_valid   (output_valid),
        .output_ready   (output_ready)
    );

    //=========================================================================
    // Clock Generation
    //=========================================================================
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    //=========================================================================
    // Test Image Initialization
    //=========================================================================
    initial begin
        integer i;
        // Initialize test image with sample data
        // In real application, load from file
        for (i = 0; i < IMAGE_SIZE; i = i + 1) begin
            // Simple pattern: alternating values
            test_image[i] = (i % 2) ? 16'h1000 : 16'h0800;
        end
    end

    //=========================================================================
    // Main Test Sequence
    //=========================================================================
    initial begin
        // Initialize signals
        rst_n = 0;
        start = 0;
        input_data = 0;
        input_valid = 0;
        output_ready = 1;  // Always ready to accept output
        pixel_count = 0;
        inference_count = 0;

        // Wait for global reset
        #100;

        // Release reset
        rst_n = 1;
        #(CLK_PERIOD * 10);

        $display("==================================================");
        $display("CNN Accelerator Test Starting");
        $display("Clock Period: %0d ns (Frequency: %0d MHz)", CLK_PERIOD, 1000/CLK_PERIOD);
        $display("Image Size: %0d pixels (32x32)", IMAGE_SIZE);
        $display("Data Width: %0d bits", DATA_WIDTH);
        $display("==================================================");

        // Wait for IP to be idle
        wait(idle == 1);
        $display("[%0t] IP is idle and ready", $time);

        // Run multiple inferences
        repeat(3) begin
            run_inference();
            #(CLK_PERIOD * 100); // Delay between inferences
        end

        // End simulation
        #(CLK_PERIOD * 1000);
        $display("==================================================");
        $display("Test Completed Successfully!");
        $display("Total Inferences: %0d", inference_count);
        $display("==================================================");
        $finish;
    end

    //=========================================================================
    // Task: Run Single Inference
    //=========================================================================
    task run_inference;
        integer i;
        integer start_time, end_time;
        begin
            inference_count = inference_count + 1;

            $display("\n[%0t] ===== Starting Inference #%0d =====", $time, inference_count);

            // Pulse start signal
            @(posedge clk);
            start = 1;
            @(posedge clk);
            start = 0;

            start_time = $time;

            // Send input data (1024 pixels)
            $display("[%0t] Sending %0d pixels...", $time, IMAGE_SIZE);
            pixel_count = 0;

            fork
                // Input data sender
                begin
                    for (i = 0; i < IMAGE_SIZE; i = i + 1) begin
                        @(posedge clk);
                        input_data = test_image[i];
                        input_valid = 1;

                        // Wait for ready handshake
                        while (!input_ready) @(posedge clk);

                        pixel_count = pixel_count + 1;

                        // Progress indicator
                        if (pixel_count % 256 == 0) begin
                            $display("[%0t]   Sent %0d/%0d pixels", $time, pixel_count, IMAGE_SIZE);
                        end
                    end

                    @(posedge clk);
                    input_valid = 0;
                    $display("[%0t] All %0d pixels sent", $time, IMAGE_SIZE);
                end

                // Output monitor
                begin
                    @(posedge output_valid);
                    end_time = $time;
                    $display("[%0t] Output received: 0x%04h", $time, output_data);
                    $display("[%0t] Inference latency: %0d ns (%0d cycles)",
                             $time, end_time - start_time, (end_time - start_time)/CLK_PERIOD);
                end
            join

            // Wait for done signal
            @(posedge done);
            $display("[%0t] Inference #%0d completed", $time, inference_count);
            $display("=========================================\n");
        end
    endtask

    //=========================================================================
    // Monitor
    //=========================================================================
    initial begin
        // Dump waveform for debugging
        $dumpfile("cnn_top_tb.vcd");
        $dumpvars(0, CNN4HW_TOP_tb);
    end

    //=========================================================================
    // Timeout Watchdog
    //=========================================================================
    initial begin
        #(CLK_PERIOD * 1000000); // 1M cycles timeout
        $display("ERROR: Simulation timeout!");
        $finish;
    end

endmodule
