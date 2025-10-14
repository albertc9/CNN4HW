`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2025/10/14 15:18:20
// Design Name:
// Module Name: CNN4HW_TOP
// Project Name: CNN iCube FPGA
// Target Devices: xcku5p-ffvb676-2-e
// Tool Versions: Vivado 2023.2
// Description: Top-level wrapper for HLS CNN IP with easy-to-use interface
//
// Dependencies: hls_cnn_2d_100s IP (HLS generated)
//
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Added HLS CNN IP wrapper with AXI Stream interface
// Additional Comments:
//   - Input: 32x32 image pixels (1024 pixels total)
//   - Output: Classification result (1 value)
//   - Clock: 200 MHz recommended (max 230 MHz)
//   - Latency: 10,258 cycles (~51.29 us @ 200MHz)
//   - Throughput: ~19,500 inferences/second
//
//////////////////////////////////////////////////////////////////////////////////


module CNN4HW_TOP #(
    parameter DATA_WIDTH = 16,      // Data width for input/output
    parameter IMAGE_SIZE = 1024     // 32x32 = 1024 pixels
)(
    // Clock and Reset
    input  wire                     clk,            // System clock (200 MHz recommended)
    input  wire                     rst_n,          // Active-low reset

    // Simple Control Interface
    input  wire                     start,          // Start inference (pulse)
    output wire                     done,           // Inference complete (pulse)
    output wire                     idle,           // IP is idle and ready
    output wire                     ready,          // IP is ready for new data

    // Input Data Interface - Simple Memory-like
    input  wire [DATA_WIDTH-1:0]    input_data,     // Input pixel data
    input  wire                     input_valid,    // Input data valid
    output wire                     input_ready,    // Ready to accept input

    // Output Data Interface
    output wire [DATA_WIDTH-1:0]    output_data,    // Output result
    output wire                     output_valid,   // Output data valid
    input  wire                     output_ready    // Ready to accept output (usually 1)
);

    //=========================================================================
    // Internal Signals
    //=========================================================================

    // AXI Stream signals for input
    wire [DATA_WIDTH-1:0]   input_axis_tdata;
    wire                    input_axis_tvalid;
    wire                    input_axis_tready;

    // AXI Stream signals for output
    wire [DATA_WIDTH-1:0]   output_axis_tdata;
    wire                    output_axis_tvalid;
    wire                    output_axis_tready;

    // Control signals
    wire                    ap_start;
    wire                    ap_done;
    wire                    ap_idle;
    wire                    ap_ready;

    //=========================================================================
    // Input Interface Adapter (Simple -> AXI Stream)
    //=========================================================================

    // Direct connection for simple interface
    assign input_axis_tdata  = input_data;
    assign input_axis_tvalid = input_valid;
    assign input_ready       = input_axis_tready;

    //=========================================================================
    // Output Interface Adapter (AXI Stream -> Simple)
    //=========================================================================

    assign output_data       = output_axis_tdata;
    assign output_valid      = output_axis_tvalid;
    assign output_axis_tready = output_ready;

    //=========================================================================
    // Control Logic
    //=========================================================================

    // Start pulse handling
    reg start_r1, start_r2;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            start_r1 <= 1'b0;
            start_r2 <= 1'b0;
        end else begin
            start_r1 <= start;
            start_r2 <= start_r1;
        end
    end

    // Generate ap_start pulse (rising edge of start signal)
    assign ap_start = start_r1 & ~start_r2;

    // Output control signals
    assign done  = ap_done;
    assign idle  = ap_idle;
    assign ready = ap_ready;

    //=========================================================================
    // HLS CNN IP Instance
    //=========================================================================

    hls_cnn_2d_100s_0 hls_cnn_inst (
        // Clock and Reset
        .ap_clk             (clk),
        .ap_rst_n           (rst_n),

        // Control Interface
        .ap_start           (ap_start),
        .ap_done            (ap_done),
        .ap_idle            (ap_idle),
        .ap_ready           (ap_ready),

        // Input AXI Stream (from input data)
        .input_1_TDATA      (input_axis_tdata),
        .input_1_TVALID     (input_axis_tvalid),
        .input_1_TREADY     (input_axis_tready),

        // Output AXI Stream (to output data)
        .layer8_out_TDATA   (output_axis_tdata),
        .layer8_out_TVALID  (output_axis_tvalid),
        .layer8_out_TREADY  (output_axis_tready)
    );

endmodule
