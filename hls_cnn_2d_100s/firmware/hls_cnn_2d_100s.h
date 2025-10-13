#ifndef HLS_CNN_2D_100S_H_
#define HLS_CNN_2D_100S_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"

#include "defines.h"

// Prototype of top level function for C-synthesis
void hls_cnn_2d_100s(
    hls::stream<input_t> &input_1,
    hls::stream<result_t> &layer8_out
);

#endif
