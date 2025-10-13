#include <iostream>

#include "hls_cnn_2d_100s.h"
#include "parameters.h"

void hls_cnn_2d_100s(
    hls::stream<input_t> &input_1,
    hls::stream<result_t> &layer8_out
) {

    // hls-fpga-machine-learning insert IO
    #pragma HLS INTERFACE axis port=input_1,layer8_out 
    #pragma HLS DATAFLOW 

#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        // hls-fpga-machine-learning insert load weights
        nnet::load_weights_from_txt<conv2d_weight_t, 800>(w2, "w2.txt");
        nnet::load_weights_from_txt<conv2d_bias_t, 20>(b2, "b2.txt");
        nnet::load_weights_from_txt<conv2d_1_weight_t, 2000>(w4, "w4.txt");
        nnet::load_weights_from_txt<conv2d_1_bias_t, 10>(b4, "b4.txt");
        nnet::load_weights_from_txt<dense_weight_t, 2380>(w7, "w7.txt");
        nnet::load_weights_from_txt<dense_bias_t, 1>(b7, "b7.txt");
        loaded_weights = true;
    }
#endif

    // ****************************************
    // NETWORK INSTANTIATION
    // ****************************************

    // hls-fpga-machine-learning insert layers

    hls::stream<layer2_t> layer2_out("layer2_out");
    #pragma HLS STREAM variable=layer2_out depth=247
    nnet::conv_2d_cl<input_t, layer2_t, config2>(input_1, layer2_out, w2, b2); // conv2d

    hls::stream<layer3_t> layer3_out("layer3_out");
    #pragma HLS STREAM variable=layer3_out depth=247
    nnet::relu<layer2_t, layer3_t, relu_config3>(layer2_out, layer3_out); // conv2d_relu

    hls::stream<layer4_t> layer4_out("layer4_out");
    #pragma HLS STREAM variable=layer4_out depth=238
    nnet::conv_2d_cl<layer3_t, layer4_t, config4>(layer3_out, layer4_out, w4, b4); // conv2d_1

    hls::stream<layer5_t> layer5_out("layer5_out");
    #pragma HLS STREAM variable=layer5_out depth=238
    nnet::relu<layer4_t, layer5_t, relu_config5>(layer4_out, layer5_out); // conv2d_1_relu

    auto& layer6_out = layer5_out;
    hls::stream<layer7_t> layer7_out("layer7_out");
    #pragma HLS STREAM variable=layer7_out depth=1
    nnet::dense<layer5_t, layer7_t, config7>(layer6_out, layer7_out, w7, b7); // dense

    nnet::sigmoid<layer7_t, result_t, sigmoid_config8>(layer7_out, layer8_out); // dense_sigmoid

}
