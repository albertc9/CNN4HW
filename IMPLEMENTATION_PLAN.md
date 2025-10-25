# CNN HLS项目优化实施计划
**目标**：将io_parallel项目改造为支持片上BRAM访问的AXI Master + 内部Stream架构

**预期效果**：
- 外部接口：从16384-bit并行端口 → AXI4 Master (64-bit总线)
- 资源消耗：从无法综合 → <30% LUT使用率
- 综合时间：从OOM崩溃 → 正常完成（~2-3小时）

---

## 📋 阶段1：配置准备与代码生成（15分钟）

### 步骤1.1：备份当前项目
```bash
cd /home/work1/Work/CNN_iCube_FPGA_b
cp -r hls_cnn_2d_100s_parallel hls_cnn_2d_100s_parallel_backup_$(date +%Y%m%d_%H%M%S)
```

**检查点**：确认备份目录创建成功

---

### 步骤1.2：修改hls4ml转换脚本

**文件**：`scripts/convert_cnn_hls4ml.py`

**修改位置1** - CONFIG字典（第39-54行）：
```python
# 修改前：
"outdir": "hls_cnn_2d_100s_parallel",
"io": "io_parallel",
"reuse": 8,
"reuse_conv2d": 4,

# 修改后：
"outdir": "hls_cnn_2d_100s_axi_stream",  # 新项目名
"io": "io_stream",                        # 内部使用stream
"reuse": 16,                              # 降低资源消耗
"reuse_conv2d": 8,                        # 第一层RF加倍
```

**修改位置2** - make_hls_config函数（第163行）：
```python
# 修改前：
'InputArrayPartition': 'complete' if io_type == 'io_parallel' else None,

# 修改后：
'InputArrayPartition': None,  # 不使用complete partition
```

**原因**：io_stream模式下不需要完全分区，节省资源

---

### 步骤1.3：重新生成HLS项目

```bash
cd /home/work1/Work/CNN_iCube_FPGA_b
python scripts/convert_cnn_hls4ml.py
```

**预期输出**：
- 创建新目录：`hls_cnn_2d_100s_axi_stream/`
- 包含文件：
  - `firmware/hls_cnn_2d_100s_axi_stream.cpp`
  - `firmware/parameters.h`
  - `build_prj.tcl`
  - `project.tcl`

**检查点**：
```bash
ls -lh hls_cnn_2d_100s_axi_stream/firmware/
# 应该看到 .cpp, .h 等文件，时间戳为刚才生成
```

---

## 📋 阶段2：修改核心函数接口（20分钟）

### 步骤2.1：创建AXI Master接口包装器

**文件**：`hls_cnn_2d_100s_axi_stream/firmware/hls_cnn_2d_100s_axi_stream.cpp`

**当前代码**（第6-15行）：
```cpp
void hls_cnn_2d_100s_axi_stream(
    input_t input_1[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1],
    result_t layer8_out[N_LAYER_7]
) {
    #pragma HLS ARRAY_RESHAPE variable=input_1 complete dim=0
    #pragma HLS ARRAY_PARTITION variable=layer8_out complete dim=0
    #pragma HLS INTERFACE ap_vld port=input_1,layer8_out
    #pragma HLS DATAFLOW
```

**修改后的完整代码**：
```cpp
void hls_cnn_2d_100s_axi_stream(
    input_t *input_1,        // ← 改为指针（AXI Master）
    result_t *layer8_out     // ← 改为指针
) {
    // ========== 接口配置：AXI Master ==========
    #pragma HLS INTERFACE m_axi port=input_1 offset=slave bundle=gmem0 \
        depth=1024 max_read_burst_length=256 num_read_outstanding=4
    #pragma HLS INTERFACE m_axi port=layer8_out offset=slave bundle=gmem1 \
        depth=1 max_write_burst_length=1 num_write_outstanding=1
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    // ========== 本地缓冲区：适度分区 ==========
    input_t input_local[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1];
    #pragma HLS ARRAY_PARTITION variable=input_local cyclic factor=4 dim=1

    result_t output_local[N_LAYER_7];
    #pragma HLS ARRAY_PARTITION variable=output_local complete dim=0

#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        nnet::load_weights_from_txt<conv2d_weight_t, 800>(w2, "w2.txt");
        nnet::load_weights_from_txt<conv2d_bias_t, 20>(b2, "b2.txt");
        nnet::load_weights_from_txt<conv2d_1_weight_t, 2000>(w4, "w4.txt");
        nnet::load_weights_from_txt<conv2d_1_bias_t, 10>(b4, "b4.txt");
        nnet::load_weights_from_txt<dense_weight_t, 2380>(w7, "w7.txt");
        nnet::load_weights_from_txt<dense_bias_t, 1>(b7, "b7.txt");
        loaded_weights = true;
    }
#endif

    // ========== Burst读取输入数据 ==========
    LOAD_INPUT: for(int i = 0; i < N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1; i++) {
        #pragma HLS PIPELINE II=1
        input_local[i] = input_1[i];
    }

    // ========== 神经网络推理（Dataflow） ==========
    #pragma HLS DATAFLOW

    layer2_t layer2_out[OUT_HEIGHT_2*OUT_WIDTH_2*N_FILT_2];
    #pragma HLS STREAM variable=layer2_out depth=2
    nnet::conv_2d_cl<input_t, layer2_t, config2>(input_local, layer2_out, w2, b2);

    layer3_t layer3_out[OUT_HEIGHT_2*OUT_WIDTH_2*N_FILT_2];
    #pragma HLS STREAM variable=layer3_out depth=2
    nnet::relu<layer2_t, layer3_t, relu_config3>(layer2_out, layer3_out);

    layer4_t layer4_out[OUT_HEIGHT_4*OUT_WIDTH_4*N_FILT_4];
    #pragma HLS STREAM variable=layer4_out depth=2
    nnet::conv_2d_cl<layer3_t, layer4_t, config4>(layer3_out, layer4_out, w4, b4);

    layer5_t layer5_out[OUT_HEIGHT_4*OUT_WIDTH_4*N_FILT_4];
    #pragma HLS STREAM variable=layer5_out depth=2
    nnet::relu<layer4_t, layer5_t, relu_config5>(layer4_out, layer5_out);

    auto& layer6_out = layer5_out;
    layer7_t layer7_out[N_LAYER_7];
    #pragma HLS STREAM variable=layer7_out depth=2
    nnet::dense<layer5_t, layer7_t, config7>(layer6_out, layer7_out, w7, b7);

    nnet::sigmoid<layer7_t, result_t, sigmoid_config8>(layer7_out, output_local);

    // ========== Burst写回输出结果 ==========
    STORE_OUTPUT: for(int i = 0; i < N_LAYER_7; i++) {
        #pragma HLS PIPELINE II=1
        layer8_out[i] = output_local[i];
    }
}
```

**关键修改点**：
1. **函数签名**：数组 → 指针（支持AXI）
2. **接口pragma**：ap_vld → m_axi（内存总线）
3. **本地缓冲**：添加input_local和output_local
4. **Burst传输**：添加LOAD_INPUT和STORE_OUTPUT循环
5. **Stream标注**：中间层添加HLS STREAM pragma

---

### 步骤2.2：修改函数头文件

**文件**：`hls_cnn_2d_100s_axi_stream/firmware/hls_cnn_2d_100s_axi_stream.h`

**修改前**：
```cpp
void hls_cnn_2d_100s_axi_stream(
    input_t input_1[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1],
    result_t layer8_out[N_LAYER_7]
);
```

**修改后**：
```cpp
void hls_cnn_2d_100s_axi_stream(
    input_t *input_1,
    result_t *layer8_out
);
```

---

### 步骤2.3：修改测试文件

**文件**：`hls_cnn_2d_100s_axi_stream/hls_cnn_2d_100s_axi_stream_test.cpp`

**需要修改的地方**（找到调用函数的位置）：

**修改前**：
```cpp
input_t input_1[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1];
result_t layer8_out[N_LAYER_7];
// ... 初始化数据 ...
hls_cnn_2d_100s_axi_stream(input_1, layer8_out);
```

**修改后**：
```cpp
input_t input_1[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1];
result_t layer8_out[N_LAYER_7];
// ... 初始化数据 ...
// 对于C仿真，传递数组首地址即可
hls_cnn_2d_100s_axi_stream(input_1, layer8_out);  // 不需要改
```

**注意**：C仿真时，数组名和指针兼容，不需要修改调用代码

---

## 📋 阶段3：优化层配置参数（15分钟）

### 步骤3.1：修改激活层配置

**文件**：`hls_cnn_2d_100s_axi_stream/firmware/parameters.h`

**查找并修改** relu_config3（约第84-90行）：
```cpp
// 修改前：
struct relu_config3 : nnet::activ_config {
    static const unsigned n_in = 4940;
    static const unsigned table_size = 1024;
    static const unsigned io_type = nnet::io_parallel;  // ← 这里
    static const unsigned reuse_factor = 8;
};

// 修改后：
struct relu_config3 : nnet::activ_config {
    static const unsigned n_in = 4940;
    static const unsigned table_size = 1024;
    static const unsigned io_type = nnet::io_stream;    // ← 改为stream
    static const unsigned reuse_factor = 8;
};
```

**查找并修改** relu_config5（约第148-154行）：
```cpp
struct relu_config5 : nnet::activ_config {
    static const unsigned n_in = 2380;
    static const unsigned table_size = 1024;
    static const unsigned io_type = nnet::io_stream;    // ← 改为stream
    static const unsigned reuse_factor = 8;
};
```

**查找并修改** sigmoid_config8（约第170-176行）：
```cpp
struct sigmoid_config8 : nnet::activ_config {
    static const unsigned n_in = 1;
    static const unsigned table_size = 1024;
    static const unsigned io_type = nnet::io_stream;    // ← 改为stream
    static const unsigned reuse_factor = 8;
};
```

---

### 步骤3.2：验证卷积层配置

**查找** config2（第42-80行），确认strategy已经是合理值：
```cpp
struct config2 : nnet::conv2d_config {
    // ... 其他配置 ...
    static const unsigned reuse_factor = 8;     // ← 确认是8（不是4）
    static const unsigned strategy = nnet::resource;  // ← 保持resource
    // ...
};
```

**查找** config4（第107-145行）：
```cpp
struct config4 : nnet::conv2d_config {
    // ... 其他配置 ...
    static const unsigned reuse_factor = 16;    // ← 确认是16
    static const unsigned strategy = nnet::latency;  // ← 保持latency
    // ...
};
```

---

## 📋 阶段4：调整构建脚本（5分钟）

### 步骤4.1：优化build_prj.tcl

**文件**：`hls_cnn_2d_100s_axi_stream/build_prj.tcl`

**在第169行后添加**（create_clock之后）：
```tcl
# 添加AXI接口优化配置
config_interface -m_axi_latency 64
config_interface -m_axi_alignment_byte_size 64
config_interface -m_axi_max_widen_bitwidth 512

# 降低综合时的激进优化（减少编译时间和内存）
config_compile -pipeline_loops 64
```

**检查第164行**（可能会报错，但可以忽略）：
```tcl
catch {config_array_partition -maximum_size 4096}
# 这行会报ERROR但不影响，是hls4ml生成的遗留代码
```

---

### 步骤4.2：修改project.tcl时钟设置（可选）

**文件**：`hls_cnn_2d_100s_axi_stream/project.tcl`

**如果希望降低时钟频率以提高成功率**（第8行）：
```tcl
# 修改前：
set clock_period 5          # 200 MHz

# 修改后（更保守）：
set clock_period 6.67       # 150 MHz

# 或者更保守：
set clock_period 10         # 100 MHz
```

**建议**：第一次综合先用5ns（200MHz），如果timing不过再降低

---

## 📋 阶段5：C仿真验证（10分钟）

### 步骤5.1：运行C仿真

```bash
cd hls_cnn_2d_100s_axi_stream
vitis_hls -f build_prj.tcl csim=1 synth=0 cosim=0 export=0
```

**预期结果**：
```
***** C SIMULATION *****
INFO: [SIM 211-2] *************** CSIM start ***************
INFO: Unable to open input/predictions file, using default input.
0.999023
INFO: Saved inference results to file: tb_data/csim_results.log
INFO: [SIM 211-1] CSim done with 0 errors.
***** C SIMULATION COMPLETED IN 0h0m13s *****
```

**检查点**：
- 确认"CSim done with 0 errors"
- 输出结果约为0.999（与原来一致）

**如果失败**：
- 检查是否有编译错误
- 确认所有头文件包含正确
- 检查函数签名是否匹配

---

## 📋 阶段6：HLS综合（2-3小时）

### 步骤6.1：运行完整综合

```bash
cd hls_cnn_2d_100s_axi_stream
vitis_hls -f build_prj.tcl
```

**或者分步骤运行**（推荐）：
```bash
# 只运行综合，不运行cosim
vitis_hls -f build_prj.tcl csim=0 synth=1 cosim=0 export=0
```

---

### 步骤6.2：监控综合进度

**打开新终端**，实时监控日志：
```bash
tail -f hls_cnn_2d_100s_axi_stream/vitis_hls.log
```

**关键阶段标志**：
1. **Source Analysis** (~1分钟)
   ```
   INFO: [HLS 200-111] Finished Source Code Analysis
   ```

2. **Unroll/Inline** (~5分钟)
   ```
   WARNING: [HLS 200-1995] There were XXX instructions after 'Unroll/Inline'
   ```
   期望：<500,000条指令（之前是24,804,538）

3. **Array/Struct** (~10分钟) - **关键阶段**
   ```
   INFO: [HLS 200-111] Finished Loop, function and other optimizations
   ```
   期望：不出现巨大的指令数跳增

4. **Architecture Synthesis** (~30分钟)
   ```
   INFO: [HLS 200-111] Finished Architecture Synthesis
   current allocated memory: X.XXX GB
   ```
   期望：内存<8GB（之前是28GB+）

5. **Hardware Synthesis** (~1-2小时)
   ```
   INFO: [HLS 200-10] Synthesizing 'hls_cnn_2d_100s_axi_stream' ...
   INFO: [HLS 200-42] -- Implementing module 'fill_buffer'
   INFO: [HLS 200-42] -- Implementing module 'conv_2d_resource_cl...'
   ```

6. **RTL生成** (~10分钟)
   ```
   INFO: [HLS 200-10] -- Generating RTL for module 'XXX'
   INFO: [RTGEN 206-100] Finished creating RTL model
   ```

---

### 步骤6.3：综合完成检查

**成功标志**：
```bash
grep "Finished C/RTL SYNTHESIS" hls_cnn_2d_100s_axi_stream/vitis_hls.log
# 应该看到：
# ***** C/RTL SYNTHESIS COMPLETED IN Xh Xm Xs *****
```

**查看综合报告**：
```bash
cat hls_cnn_2d_100s_axi_stream/hls_cnn_2d_100s_axi_stream_prj/solution1/syn/report/hls_cnn_2d_100s_axi_stream_csynth.rpt
```

**关键指标检查**：

1. **Timing**（报告开头）：
   ```
   + Timing:
       * Summary:
       |  Clock |  Target | Estimated| Uncertainty|
       |ap_clk  |  5.00 ns|  4.5X ns |     0.62 ns|
   ```
   ✅ Estimated < Target → timing满足

2. **Latency**：
   ```
   + Latency:
       |  Latency (cycles) |
       |   min   |   max   |
       |    XXXX |   XXXX  |
   ```
   记录下来用于性能评估

3. **资源使用**（最重要）：
   ```
   * Summary:
   +-----------------+---------+------+--------+--------+-----+
   |       Name      | BRAM_18K|  DSP |   FF   |   LUT  | URAM|
   +-----------------+---------+------+--------+--------+-----+
   |Total            |      XXX|   XXX|    XXXX|   XXXXX|    X|
   +-----------------+---------+------+--------+--------+-----+
   |Available        |      960|  1824|  433920|  216960|   64|
   +-----------------+---------+------+--------+--------+-----+
   |Utilization (%)  |       XX|    XX|      XX|      XX|   XX|
   +-----------------+---------+------+--------+--------+-----+
   ```

   **期望值**：
   - LUT: <30% (之前fill_buffer就用了26%)
   - FF: <40%
   - BRAM: <50%
   - DSP: <60%

---

## 📋 阶段7：问题排查与优化（如需要）

### 情况A：综合仍然OOM或时间过长

**可能原因**：ReuseFactor仍然太小

**解决方案**：
1. 修改`scripts/convert_cnn_hls4ml.py`：
   ```python
   "reuse": 32,              # 再加倍
   "reuse_conv2d": 16,       # 再加倍
   "reuse_conv2d_1": 32,     # 再加倍
   ```
2. 重新生成项目（从阶段1.3开始）

---

### 情况B：Timing不满足（Estimated > Target）

**可能原因**：时钟频率太高

**解决方案**：
1. 修改`hls_cnn_2d_100s_axi_stream/project.tcl`：
   ```tcl
   set clock_period 6.67     # 降到150MHz
   ```
2. 只重新运行综合（不需要改代码）

---

### 情况C：C仿真结果不一致

**可能原因**：数据传递错误

**排查步骤**：
1. 检查input_local数组大小是否正确：
   ```cpp
   // 应该是1024 = 4*256*1
   input_t input_local[N_INPUT_1_1*N_INPUT_2_1*N_INPUT_3_1];
   ```
2. 检查LOAD_INPUT循环边界
3. 添加调试打印验证数据

---

## 📋 阶段8：RTL协同仿真（可选，30分钟）

### 步骤8.1：运行CoSim

```bash
cd hls_cnn_2d_100s_axi_stream
vitis_hls -f build_prj.tcl csim=0 synth=0 cosim=1 export=0
```

**注意**：需要先完成综合（阶段6）

**预期时间**：20-30分钟

---

### 步骤8.2：验证CoSim结果

**成功标志**：
```
***** C/RTL VALIDATION *****
INFO: Test PASSED
```

**查看报告**：
```bash
cat hls_cnn_2d_100s_axi_stream/hls_cnn_2d_100s_axi_stream_prj/solution1/sim/report/hls_cnn_2d_100s_axi_stream_cosim.rpt
```

---

## 📋 阶段9：导出IP核（5分钟）

### 步骤9.1：导出为Vivado IP

```bash
cd hls_cnn_2d_100s_axi_stream
vitis_hls -f build_prj.tcl csim=0 synth=0 cosim=0 export=1
```

**或者在综合成功后直接**：
```bash
vitis_hls -f build_prj.tcl synth=0 export=1
```

---

### 步骤9.2：验证导出结果

**导出目录**：
```
hls_cnn_2d_100s_axi_stream/hls_cnn_2d_100s_axi_stream_prj/solution1/impl/
└── ip/
    └── xilinx_com_hls_hls_cnn_2d_100s_axi_stream_1_0.zip
```

**IP接口确认**：
```bash
unzip -l hls_cnn_2d_100s_axi_stream_prj/solution1/impl/ip/*.zip | grep "component.xml"
```

**查看component.xml**确认接口：
- `m_axi` 端口：gmem0（input），gmem1（output）
- `s_axilite` 端口：control（启动/状态）

---

## 📋 阶段10：集成到Vivado设计（30分钟）

### 步骤10.1：在Vivado中添加IP

1. **打开Vivado项目**
2. **添加IP仓库**：
   - Tools → Settings → IP → Repository
   - 添加路径：`.../hls_cnn_2d_100s_axi_stream/hls_cnn_2d_100s_axi_stream_prj/solution1/impl/ip`
3. **在Block Design中添加IP**：
   - 搜索：`hls_cnn_2d_100s_axi_stream`

---

### 步骤10.2：连接AXI接口

**典型连接方案**：

```
[BRAM Controller] ←→ AXI Interconnect ←→ [HLS IP gmem0]
                                      ←→ [HLS IP gmem1]
[PS/MicroBlaze]   ←→ AXI Interconnect ←→ [HLS IP control]
```

**地址分配**：
- BRAM：0x4000_0000（存放1024个输入）
- HLS Control：0x4400_0000（寄存器控制）

---

### 步骤10.3：软件驱动示例

```c
// 伪代码：从CPU启动HLS加速器
#define HLS_CTRL_ADDR  0x44000000
#define BRAM_BASE      0x40000000
#define INPUT_SIZE     1024
#define OUTPUT_SIZE    1

// 1. 将数据写入BRAM
float *input_data = (float*)BRAM_BASE;
for (int i = 0; i < INPUT_SIZE; i++) {
    input_data[i] = pixel_data[i];
}

// 2. 配置HLS加速器
volatile uint32_t *hls_ctrl = (uint32_t*)HLS_CTRL_ADDR;
hls_ctrl[0x10/4] = BRAM_BASE;              // 设置input地址
hls_ctrl[0x18/4] = BRAM_BASE + 0x1000;     // 设置output地址

// 3. 启动加速器
hls_ctrl[0x00/4] = 0x01;  // AP_START

// 4. 等待完成
while (!(hls_ctrl[0x00/4] & 0x02));  // 等待AP_DONE

// 5. 读取结果
float *output = (float*)(BRAM_BASE + 0x1000);
float result = output[0];
```

---

## 📊 预期结果对比表

| 指标 | io_parallel版本 | io_stream+AXI版本 | 改进 |
|------|----------------|------------------|------|
| **外部接口** | 16,384-bit并行端口 | AXI4 64-bit总线 | 256倍↓ |
| **设计指令数** | 24,804,538 | ~300,000 | 80倍↓ |
| **综合内存** | 28GB+ (OOM) | <4GB | 7倍↓ |
| **fill_buffer LUT** | 58,120 (26%) | ~2,000 (<1%) | 29倍↓ |
| **总LUT使用** | 无法综合 | ~25% | ✅可综合 |
| **综合时间** | 崩溃 | 2-3小时 | ✅完成 |
| **BRAM访问** | ❌不支持 | ✅Burst读取 | ✅支持 |
| **延迟** | N/A | ~50-100us | - |
| **吞吐量** | N/A | ~10-20k推理/秒 | - |

---

## ⚠️ 常见问题FAQ

### Q1：为什么不直接使用io_stream，还要手动添加AXI？
**A**：hls4ml的io_stream会生成`hls::stream`类型的参数，这要求上层也使用stream，无法直接连接到BRAM。AXI Master接口允许我们直接访问内存地址空间。

### Q2：如果综合时间还是很长怎么办？
**A**：进一步增大ReuseFactor（如32、64），牺牲一些吞吐量换取资源。

### Q3：CoSim必须运行吗？
**A**：不是必须的，但强烈推荐。它验证RTL实现与C模型的功能一致性。

### Q4：可以同时保留io_parallel版本吗？
**A**：可以，两个项目目录是独立的。建议保留io_parallel作为参考。

### Q5：如何进一步优化性能？
**A**：
1. 降低ReuseFactor（需要更多资源）
2. 调整FIFO深度（在Stream pragma中）
3. 优化数据类型精度（如ap_fixed<12,2>）
4. 使用BRAM存储权重而非LUT

---

## 📝 检查清单

在每个阶段完成后，勾选确认：

- [ ] 阶段1：配置文件修改完成，新项目生成成功
- [ ] 阶段2：核心函数接口改为AXI Master
- [ ] 阶段3：所有层配置改为io_stream
- [ ] 阶段4：构建脚本优化完成
- [ ] 阶段5：C仿真通过，结果正确
- [ ] 阶段6：HLS综合成功，资源<30% LUT
- [ ] 阶段7：Timing满足5ns时钟周期
- [ ] 阶段8：CoSim通过（可选）
- [ ] 阶段9：IP核导出成功
- [ ] 阶段10：在Vivado中集成测试（可选）

---

## 📞 需要帮助时

如果遇到问题，提供以下信息：
1. 当前在哪个阶段
2. 错误日志（vitis_hls.log最后100行）
3. 综合报告（如果到了阶段6）
4. 具体的错误信息

---

**预计总时间**：3-4小时（不含Vivado集成）
**难度等级**：中等（需要理解HLS接口和Pragma）
**成功率**：>90%（按照步骤执行）

祝顺利！ 🚀
