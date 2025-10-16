`timescale 1ns / 1ps

// Direct testbench for HLS IP (bypassing wrapper)
module tb_hls_direct;

    parameter CLK_PERIOD = 5.0;
    parameter NUM_PIXELS = 1024;
    parameter DATA_WIDTH = 16;

    // Signals
    reg clk;
    reg rst_n;
    reg ap_start;
    wire ap_done;
    wire ap_idle;
    wire ap_ready;

    reg [DATA_WIDTH-1:0] input_tdata;
    reg input_tvalid;
    wire input_tready;

    wire [DATA_WIDTH-1:0] output_tdata;
    wire output_tvalid;
    reg output_tready;

    // Test data
    reg [DATA_WIDTH-1:0] test_image [0:NUM_PIXELS-1];
    integer i, pixel_count;

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // DUT - Direct HLS IP
    hls_cnn_2d_100s_0 dut (
        .ap_clk(clk),
        .ap_rst_n(rst_n),
        .ap_start(ap_start),
        .ap_done(ap_done),
        .ap_idle(ap_idle),
        .ap_ready(ap_ready),
        .input_1_TDATA(input_tdata),
        .input_1_TVALID(input_tvalid),
        .input_1_TREADY(input_tready),
        .layer8_out_TDATA(output_tdata),
        .layer8_out_TVALID(output_tvalid),
        .layer8_out_TREADY(output_tready)
    );

    // Main test
    initial begin
        $display("=== Direct HLS IP Test ===");

        // Initialize
        rst_n = 0;
        ap_start = 0;
        input_tdata = 0;
        input_tvalid = 0;
        output_tready = 1;
        pixel_count = 0;

        // Load data
        $readmemh("test_input_sample0.hex", test_image);
        $display("Data loaded: first=0x%04h last=0x%04h", test_image[0], test_image[NUM_PIXELS-1]);

        // Reset
        repeat(10) @(posedge clk);
        rst_n = 1;
        repeat(5) @(posedge clk);
        $display("[%0t] Reset done, ap_idle=%b", $time, ap_idle);

        // Start - keep high until first data accepted
        ap_start = 1;
        input_tdata = test_image[0];
        input_tvalid = 1;

        @(posedge clk);
        $display("[%0t] ap_start=1, waiting for input_tready...", $time);

        // Wait for IP to be ready
        wait(input_tready == 1);
        @(posedge clk);
        $display("[%0t] First handshake! input_tready=%b", $time, input_tready);

        // Can deassert start after first handshake
        ap_start = 0;
        pixel_count = 1;

        // Send remaining data
        for (i = 1; i < NUM_PIXELS; i = i + 1) begin
            input_tdata = test_image[i];
            input_tvalid = 1;

            @(posedge clk);
            while (!input_tready) @(posedge clk);

            pixel_count = pixel_count + 1;
            if (i % 256 == 0)
                $display("[%0t] Sent %d pixels", $time, i);
        end

        input_tvalid = 0;
        $display("[%0t] All %d pixels sent", $time, pixel_count);

        // Wait for output
        $display("[%0t] Waiting for output...", $time);
        wait(output_tvalid == 1);
        @(posedge clk);
        $display("[%0t] Output received: 0x%04h", $time, output_tdata);

        wait(ap_done == 1);
        $display("[%0t] ap_done asserted, test complete!", $time);

        repeat(10) @(posedge clk);
        $finish;
    end

    // Timeout
    initial begin
        #100000000; // 100us
        $display("[ERROR] Timeout!");
        $finish;
    end

endmodule
