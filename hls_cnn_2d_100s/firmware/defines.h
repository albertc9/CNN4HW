#ifndef DEFINES_H_
#define DEFINES_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "nnet_utils/nnet_types.h"
#include <cstddef>
#include <cstdio>

// hls-fpga-machine-learning insert numbers
#define N_INPUT_1_1 4
#define N_INPUT_2_1 256
#define N_INPUT_3_1 1
#define OUT_HEIGHT_2 1
#define OUT_WIDTH_2 247
#define N_FILT_2 20
#define OUT_HEIGHT_2 1
#define OUT_WIDTH_2 247
#define N_FILT_2 20
#define OUT_HEIGHT_4 1
#define OUT_WIDTH_4 238
#define N_FILT_4 10
#define OUT_HEIGHT_4 1
#define OUT_WIDTH_4 238
#define N_FILT_4 10
#define N_SIZE_0_6 2380
#define N_LAYER_7 1
#define N_LAYER_7 1

// hls-fpga-machine-learning insert layer-precision
typedef nnet::array<ap_fixed<20,10>, 1*1> input_t;
typedef ap_fixed<24,10> conv2d_accum_t;
typedef nnet::array<ap_fixed<20,10>, 20*1> layer2_t;
typedef ap_fixed<20,10> conv2d_weight_t;
typedef ap_fixed<20,10> conv2d_bias_t;
typedef nnet::array<ap_fixed<20,10>, 20*1> layer3_t;
typedef ap_fixed<18,8> conv2d_relu_table_t;
typedef ap_fixed<24,10> conv2d_1_accum_t;
typedef nnet::array<ap_fixed<20,10>, 10*1> layer4_t;
typedef ap_fixed<20,10> conv2d_1_weight_t;
typedef ap_fixed<20,10> conv2d_1_bias_t;
typedef nnet::array<ap_fixed<20,10>, 10*1> layer5_t;
typedef ap_fixed<18,8> conv2d_1_relu_table_t;
typedef ap_fixed<28,12> dense_accum_t;
typedef nnet::array<ap_fixed<24,10>, 1*1> layer7_t;
typedef ap_fixed<20,10> dense_weight_t;
typedef ap_fixed<20,10> dense_bias_t;
typedef ap_uint<1> layer7_index;
typedef nnet::array<ap_fixed<20,10>, 1*1> result_t;
typedef ap_fixed<18,8> dense_sigmoid_table_t;

#endif
