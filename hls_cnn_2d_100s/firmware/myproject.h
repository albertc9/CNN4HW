#ifndef MYPROJECT_H_
#define MYPROJECT_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"

#include "defines.h"

// Prototype of top level function for C-synthesis
void myproject(
    hls::stream<input_t> &input_1,
    hls::stream<result_t> &layer8_out,
    conv2d_weight_t w2[800], 
    conv2d_bias_t b2[20], 
    conv2d_1_weight_t w4[2000], 
    conv2d_1_bias_t b4[10], 
    dense_weight_t w7[2380]
);

#endif
