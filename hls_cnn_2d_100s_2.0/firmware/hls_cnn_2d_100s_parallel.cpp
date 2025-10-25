#include <iostream>

#include "hls_cnn_2d_100s_parallel.h"
#include "parameters.h"

void hls_cnn_2d_100s_parallel(
    input_t input_1[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1],
    result_t layer8_out[N_LAYER_7]
) {

    // hls-fpga-machine-learning insert IO
    #pragma HLS ARRAY_RESHAPE variable=input_1 complete dim=0
    #pragma HLS ARRAY_PARTITION variable=layer8_out complete dim=0
    #pragma HLS INTERFACE ap_vld port=input_1,layer8_out 
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

    layer2_t layer2_out[OUT_HEIGHT_2*OUT_WIDTH_2*N_FILT_2];
    #pragma HLS ARRAY_PARTITION variable=layer2_out complete dim=0
    nnet::conv_2d_cl<input_t, layer2_t, config2>(input_1, layer2_out, w2, b2); // conv2d

    layer3_t layer3_out[OUT_HEIGHT_2*OUT_WIDTH_2*N_FILT_2];
    #pragma HLS ARRAY_PARTITION variable=layer3_out complete dim=0
    nnet::relu<layer2_t, layer3_t, relu_config3>(layer2_out, layer3_out); // conv2d_relu

    layer4_t layer4_out[OUT_HEIGHT_4*OUT_WIDTH_4*N_FILT_4];
    #pragma HLS ARRAY_PARTITION variable=layer4_out complete dim=0
    nnet::conv_2d_cl<layer3_t, layer4_t, config4>(layer3_out, layer4_out, w4, b4); // conv2d_1

    layer5_t layer5_out[OUT_HEIGHT_4*OUT_WIDTH_4*N_FILT_4];
    #pragma HLS ARRAY_PARTITION variable=layer5_out complete dim=0
    nnet::relu<layer4_t, layer5_t, relu_config5>(layer4_out, layer5_out); // conv2d_1_relu

    auto& layer6_out = layer5_out;
    layer7_t layer7_out[N_LAYER_7];
    #pragma HLS ARRAY_PARTITION variable=layer7_out complete dim=0
    nnet::dense<layer5_t, layer7_t, config7>(layer6_out, layer7_out, w7, b7); // dense

    nnet::sigmoid<layer7_t, result_t, sigmoid_config8>(layer7_out, layer8_out); // dense_sigmoid

}
