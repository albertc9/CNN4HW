#ifndef HLS_CNN_2D_100S_PARALLEL_H_
#define HLS_CNN_2D_100S_PARALLEL_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"

#include "defines.h"

// Prototype of top level function for C-synthesis
void hls_cnn_2d_100s_parallel(
    input_t input_1[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1],
    result_t layer8_out[N_LAYER_7]
);

#endif
