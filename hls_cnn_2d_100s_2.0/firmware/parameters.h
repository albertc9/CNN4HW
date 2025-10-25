#ifndef PARAMETERS_H_
#define PARAMETERS_H_

#include "ap_fixed.h"
#include "ap_int.h"

#include "nnet_utils/nnet_code_gen.h"
#include "nnet_utils/nnet_helpers.h"
// hls-fpga-machine-learning insert includes
#include "nnet_utils/nnet_activation.h"
#include "nnet_utils/nnet_activation_stream.h"
#include "nnet_utils/nnet_conv2d.h"
#include "nnet_utils/nnet_conv2d_stream.h"
#include "nnet_utils/nnet_dense.h"
#include "nnet_utils/nnet_dense_compressed.h"
#include "nnet_utils/nnet_dense_stream.h"

// hls-fpga-machine-learning insert weights
#include "weights/w2.h"
#include "weights/b2.h"
#include "weights/w4.h"
#include "weights/b4.h"
#include "weights/w7.h"
#include "weights/b7.h"

// hls-fpga-machine-learning insert layer-config
// conv2d
struct config2_mult : nnet::dense_config {
    static const unsigned n_in = 40;
    static const unsigned n_out = 20;
    static const unsigned reuse_factor = 4;
    static const unsigned strategy = nnet::resource;
    static const unsigned n_zeros = 0;
    static const unsigned multiplier_limit = DIV_ROUNDUP(n_in * n_out, reuse_factor) - n_zeros / reuse_factor;
    typedef conv2d_accum_t accum_t;
    typedef conv2d_bias_t bias_t;
    typedef conv2d_weight_t weight_t;
    template<class x_T, class y_T>
    using product = nnet::product::mult<x_T, y_T>;
};

struct config2 : nnet::conv2d_config {
    static const unsigned pad_top = 0;
    static const unsigned pad_bottom = 0;
    static const unsigned pad_left = 0;
    static const unsigned pad_right = 0;
    static const unsigned in_height = 4;
    static const unsigned in_width = 256;
    static const unsigned n_chan = 1;
    static const unsigned filt_height = 4;
    static const unsigned filt_width = 10;
    static const unsigned kernel_size = filt_height * filt_width;
    static const unsigned n_filt = 20;
    static const unsigned stride_height = 1;
    static const unsigned stride_width = 1;
    static const unsigned out_height = 1;
    static const unsigned out_width = 247;
    static const unsigned reuse_factor = 4;
    static const unsigned n_zeros = 0;
    static const unsigned multiplier_limit =
        DIV_ROUNDUP(kernel_size * n_chan * n_filt, reuse_factor) - n_zeros / reuse_factor;
    static const bool store_weights_in_bram = false;
    static const unsigned strategy = nnet::resource;
    static const nnet::conv_implementation implementation = nnet::conv_implementation::linebuffer;
    static const unsigned min_height = 4;
    static const unsigned min_width = 256;
    static const ap_uint<filt_height * filt_width> pixels[min_height * min_width];
    static const unsigned n_partitions = 247;
    static const unsigned n_pixels = out_height * out_width / n_partitions;
    template<class data_T, class CONFIG_T>
    using fill_buffer = nnet::fill_buffer_2<data_T, CONFIG_T>;
    typedef conv2d_accum_t accum_t;
    typedef conv2d_bias_t bias_t;
    typedef conv2d_weight_t weight_t;
    typedef config2_mult mult_config;
    template<unsigned K, unsigned S, unsigned W>
    using scale_index_height = nnet::scale_index_unscaled<K, S, W>;
    template<unsigned K, unsigned S, unsigned W>
    using scale_index_width = nnet::scale_index_unscaled<K, S, W>;
};
const ap_uint<config2::filt_height * config2::filt_width> config2::pixels[] = {0};

// conv2d_relu
struct relu_config3 : nnet::activ_config {
    static const unsigned n_in = 4940;
    static const unsigned table_size = 1024;
    static const unsigned io_type = nnet::io_parallel;
    static const unsigned reuse_factor = 8;
    typedef conv2d_relu_table_t table_t;
};

// conv2d_1
struct config4_mult : nnet::dense_config {
    static const unsigned n_in = 200;
    static const unsigned n_out = 10;
    static const unsigned reuse_factor = 16;
    static const unsigned strategy = nnet::latency;
    static const unsigned n_zeros = 0;
    static const unsigned multiplier_limit = DIV_ROUNDUP(n_in * n_out, reuse_factor) - n_zeros / reuse_factor;
    typedef conv2d_1_accum_t accum_t;
    typedef conv2d_1_bias_t bias_t;
    typedef conv2d_1_weight_t weight_t;
    template<class x_T, class y_T>
    using product = nnet::product::mult<x_T, y_T>;
};

struct config4 : nnet::conv2d_config {
    static const unsigned pad_top = 0;
    static const unsigned pad_bottom = 0;
    static const unsigned pad_left = 0;
    static const unsigned pad_right = 0;
    static const unsigned in_height = 1;
    static const unsigned in_width = 247;
    static const unsigned n_chan = 20;
    static const unsigned filt_height = 1;
    static const unsigned filt_width = 10;
    static const unsigned kernel_size = filt_height * filt_width;
    static const unsigned n_filt = 10;
    static const unsigned stride_height = 1;
    static const unsigned stride_width = 1;
    static const unsigned out_height = 1;
    static const unsigned out_width = 238;
    static const unsigned reuse_factor = 16;
    static const unsigned n_zeros = 0;
    static const unsigned multiplier_limit =
        DIV_ROUNDUP(kernel_size * n_chan * n_filt, reuse_factor) - n_zeros / reuse_factor;
    static const bool store_weights_in_bram = false;
    static const unsigned strategy = nnet::latency;
    static const nnet::conv_implementation implementation = nnet::conv_implementation::linebuffer;
    static const unsigned min_height = 1;
    static const unsigned min_width = 247;
    static const ap_uint<filt_height * filt_width> pixels[min_height * min_width];
    static const unsigned n_partitions = 238;
    static const unsigned n_pixels = out_height * out_width / n_partitions;
    template<class data_T, class CONFIG_T>
    using fill_buffer = nnet::fill_buffer_4<data_T, CONFIG_T>;
    typedef conv2d_1_accum_t accum_t;
    typedef conv2d_1_bias_t bias_t;
    typedef conv2d_1_weight_t weight_t;
    typedef config4_mult mult_config;
    template<unsigned K, unsigned S, unsigned W>
    using scale_index_height = nnet::scale_index_unscaled<K, S, W>;
    template<unsigned K, unsigned S, unsigned W>
    using scale_index_width = nnet::scale_index_unscaled<K, S, W>;
};
const ap_uint<config4::filt_height * config4::filt_width> config4::pixels[] = {0};

// conv2d_1_relu
struct relu_config5 : nnet::activ_config {
    static const unsigned n_in = 2380;
    static const unsigned table_size = 1024;
    static const unsigned io_type = nnet::io_parallel;
    static const unsigned reuse_factor = 8;
    typedef conv2d_1_relu_table_t table_t;
};

// dense
struct config7 : nnet::dense_config {
    static const unsigned n_in = 2380;
    static const unsigned n_out = 1;
    static const unsigned io_type = nnet::io_parallel;
    static const unsigned strategy = nnet::resource;
    static const unsigned reuse_factor = 34;
    static const unsigned n_zeros = 0;
    static const unsigned n_nonzeros = 2380;
    static const unsigned multiplier_limit = DIV_ROUNDUP(n_in * n_out, reuse_factor) - n_zeros / reuse_factor;
    static const bool store_weights_in_bram = false;
    typedef dense_accum_t accum_t;
    typedef dense_bias_t bias_t;
    typedef dense_weight_t weight_t;
    typedef layer7_index index_t;
    template<class x_T, class y_T>
    using product = nnet::product::mult<x_T, y_T>;
};

// dense_sigmoid
struct sigmoid_config8 : nnet::activ_config {
    static const unsigned n_in = 1;
    static const unsigned table_size = 1024;
    static const unsigned io_type = nnet::io_parallel;
    static const unsigned reuse_factor = 8;
    typedef dense_sigmoid_table_t table_t;
};


#endif
