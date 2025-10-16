# CNN4HW_TOP - CNN加速器顶层模块使用指南 (修正版)

## 📋 模块概述

`CNN4HW_TOP` 是HLS CNN IP (`hls_cnn_2d_100s`) 的易用包装模块，提供简化的接口用于CNN推理加速。

### 关键特性
- ✅ 简化的控制接口（start/done信号）
- ✅ 简单的数据接口（类似内存读写）
- ✅ 内部处理AXI Stream协议
- ✅ 支持连续推理
- ✅ 200MHz工作频率（最高230MHz）

---

## 🔌 接口说明

### 端口列表

| 端口名 | 方向 | 位宽 | 说明 | 引脚位置 |
|--------|------|------|------|----------|
| **时钟和复位** | | | | |
| `clk` | Input | 1 | 系统时钟 (推荐200MHz) | E13 |
| `rst_n` | Input | 1 | 低电平有效复位 | H11 |
| **控制信号** | | | | |
| `start` | Input | 1 | 开始推理（脉冲信号） | G11 |
| `done` | Output | 1 | 推理完成（脉冲信号） | J14 |
| `idle` | Output | 1 | IP空闲，可以开始新推理 | H14 |
| `ready` | Output | 1 | IP准备好接收数据 | H13 |
| **输入数据接口（AXI Stream握手）** | | | | |
| `input_data[15:0]` | Input | 16 | 输入像素数据（ap_fixed<16,2>） | G9-C11 |
| `input_valid` | Input | 1 | 输入数据有效信号 | J12 |
| `input_ready` | Output | 1 | 准备接收输入数据信号 | G14 |
| **输出数据接口（AXI Stream握手）** | | | | |
| `output_data[15:0]` | Output | 16 | 输出结果（ap_fixed<16,2>） | J15-B14 |
| `output_valid` | Output | 1 | 输出数据有效信号 | J13 |
| `output_ready` | Input | 1 | 准备接收输出（通常保持为1） | H12 |

### 信号详细说明

#### 1. 时钟与复位
- **`clk`**: 全局系统时钟，推荐200MHz（周期5ns），最大支持230MHz
- **`rst_n`**: **低电平有效**同步复位，复位期间应保持低电平至少10个时钟周期

#### 2. 控制信号（AP Control协议）
- **`start`**:
  - 功能：启动一次推理
  - 时序：在`idle=1`时拉高1个周期（脉冲）
  - 注意：**不要**在推理期间重复触发

- **`done`**:
  - 功能：指示推理完成
  - 时序：推理完成时拉高1个周期（脉冲）
  - 用途：可用于触发后续处理逻辑

- **`idle`**:
  - 功能：IP空闲状态指示
  - 逻辑：`idle=1` 表示可以接受新的推理请求
  - 注意：复位后`idle`应该为1

- **`ready`**:
  - 功能：IP就绪状态
  - 逻辑：通常在推理开始后变为0，完成后恢复为1

#### 3. 输入数据接口（AXI Stream协议）
- **握手机制**: `input_valid` AND `input_ready` = 数据传输成功
- **数据传输**:
  ```
  当 input_valid=1 且 input_ready=1 时，input_data被成功接收
  如果 input_ready=0，必须保持 input_data 和 input_valid 不变，直到握手成功
  ```
- **背压支持**: `input_ready`可能为0，表示IP暂时无法接收数据

#### 4. 输出数据接口（AXI Stream协议）
- **握手机制**: `output_valid` AND `output_ready` = 数据传输成功
- **Testbench建议**: 保持`output_ready=1`以简化测试
- **输出时序**: 推理完成后，`output_valid`拉高，保持直到握手成功

---

## 📊 网络架构与数据格式

### 输入数据规格

| 参数 | 值 | 说明 |
|------|-----|------|
| **输入形状** | **(4, 256, 1)** | **4行 × 256列 × 1通道** |
| **总像素数** | **1024** | 4×256=1024（注意：不是32×32） |
| **数据类型** | `ap_fixed<16,2>` | 16位定点数，2位整数，14位小数 |
| **数值范围** | [-2.0, 2.0) | 有符号定点数 |
| **传输顺序** | 行优先（Row-major） | 逐行扫描 |

**数据顺序示例**:
```
Pixel #0:    input[0][0]     (第0行第0列)
Pixel #1:    input[0][1]     (第0行第1列)
...
Pixel #255:  input[0][255]   (第0行第255列)
Pixel #256:  input[1][0]     (第1行第0列)
Pixel #257:  input[1][1]     (第1行第1列)
...
Pixel #511:  input[1][255]   (第1行第255列)
Pixel #512:  input[2][0]     (第2行第0列)
...
Pixel #767:  input[2][255]   (第2行第255列)
Pixel #768:  input[3][0]     (第3行第0列)
...
Pixel #1023: input[3][255]   (第3行第255列)
```

### 输出数据规格

| 参数 | 值 | 说明 |
|------|-----|------|
| **输出形状** | **(1,)** | 单个标量值 |
| **数据类型** | `ap_fixed<16,2>` | 16位定点数 |
| **数值范围** | [0.0, 1.0] | Sigmoid激活函数输出 |
| **语义** | 二分类概率 | >0.5为正类，<0.5为负类 |

### 网络层结构

```
输入层: (4, 256, 1)
   ↓
Conv2D Layer 2:
   - 卷积核: 4×10
   - 滤波器数: 20
   - 步长: (1,1)
   - 激活: ReLU
   - 输出: (1, 247, 20)
   ↓
Conv2D Layer 4:
   - 卷积核: 1×10
   - 滤波器数: 10
   - 步长: (1,1)
   - 激活: ReLU
   - 输出: (1, 238, 10)
   ↓
Flatten Layer 6:
   - 展平: 1×238×10 → 2380
   ↓
Dense Layer 7:
   - 全连接: 2380 → 1
   - 激活: Sigmoid
   - 输出: (1,) - 分类概率
```

---

## ⏱️ 性能参数（基于HLS综合报告）

| 参数 | 值 | 说明 |
|------|-----|------|
| **时钟频率** | 200 MHz (推荐) | 5ns周期 |
| **最大时钟频率** | ~230 MHz | 器件依赖 |
| **推理延迟** | **6,162 周期** | **30.81 μs** @ 200MHz |
| **吞吐间隔** | **6,148 周期** | **30.74 μs** @ 200MHz |
| **吞吐率** | **~32,500 推理/秒** | 1/30.74μs @ 200MHz |
| **输入传输时间** | ~1024 周期 | 取决于握手速度 |
| **资源使用（估算）** | | 基于xcku5p-ffvb676-2-e |
| - LUT | ~95K | ~44% |
| - FF | ~95K | ~22% |
| - DSP | ~648 | ~35% |
| - BRAM | ~11.5 | ~2.4% |

**性能数据来源**: `hls_cnn_2d_100s_prj/solution1/syn/report/hls_cnn_2d_100s_csynth.xml`

---

## 🚀 使用方法

### 方法1: 基本使用流程（Testbench推荐）

```verilog
// ========== 初始化 ==========
initial begin
    clk = 0;
    rst_n = 0;
    start = 0;
    input_data = 0;
    input_valid = 0;
    output_ready = 1;  // 始终准备好接收输出

    // 复位10个周期
    repeat(10) @(posedge clk);
    rst_n = 1;
    repeat(5) @(posedge clk);
end

// ========== 单次推理 ==========
integer i;
reg [15:0] test_image [0:1023];  // 4×256=1024像素

task run_inference;
    begin
        // 步骤1: 等待IP空闲
        wait(idle == 1);
        @(posedge clk);

        // 步骤2: 发送start脉冲（1周期）
        start <= 1;
        @(posedge clk);
        start <= 0;

        // 步骤3: 发送1024个像素（AXI Stream握手）
        for (i = 0; i < 1024; i = i + 1) begin
            input_data <= test_image[i];
            input_valid <= 1;
            @(posedge clk);

            // 等待握手成功
            while (!input_ready) begin
                @(posedge clk);
            end
        end

        // 步骤4: 结束输入
        input_valid <= 0;
        input_data <= 0;

        // 步骤5: 等待输出有效
        wait(output_valid == 1);
        @(posedge clk);
        $display("Output Result: %h (decimal: %f)",
                 output_data,
                 $itor(output_data) / 16384.0);  // ap_fixed<16,2>转换

        // 步骤6: 等待完成信号
        wait(done == 1);
        @(posedge clk);
        $display("Inference completed!");
    end
endtask
```

### 方法2: 连续推理（流水线模式）

```verilog
// 可以在done信号后立即开始下一次推理
// 无需等待额外周期（如果idle已经为1）

task continuous_inference(input integer num_inferences);
    integer j;
    begin
        for (j = 0; j < num_inferences; j = j + 1) begin
            // 等待空闲
            wait(idle == 1);

            // 启动推理
            @(posedge clk);
            start <= 1;
            @(posedge clk);
            start <= 0;

            // 发送数据...
            // (省略数据传输代码)

            // 接收结果
            wait(output_valid == 1);
            // 处理结果...

            wait(done == 1);
            $display("Inference %0d completed", j);
        end
    end
endtask
```

---

## 📊 时序图（修正版）

### 单次推理完整时序

```
时钟周期:    0    1    2    3    4    5    ...  1026 1027 ...  6160 6161 6162 6163
             ___  ___  ___  ___  ___  ___       ___  ___       ___  ___  ___  ___
clk      ___|   |___|   |___|   |___|   |___...|   |___|   ...|   |___|   |___|   |___

rst_n    ____________________________________________________________________...______

idle     ___________________________                                         ________
                                    |_______________________________________|

                  ___
start    ________|   |______________________________________________________________

                      ___  ___  ___      ___
input_data XXXXXXXXXX_D0__D1__D2_...___D1023_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                      __________________
input_valid ________|                  |_______________________________________________

input_ready ________|__________________|_______________________________________________
                    (握手成功，每周期传输1个像素)

                                                                           ___
output_valid _____________________________________________________________|   |________

                                                                           ___
output_data  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX_RES________

                                                                               ___
done         _________________________________________________________________|   |____

说明:
- 周期0-10: 复位阶段
- 周期2: start脉冲
- 周期3-1026: 输入数据传输（1024像素）
- 周期1027-6161: 推理计算
- 周期6161: output_valid拉高，输出结果可读
- 周期6162: done脉冲，推理完成
- 总延迟: ~6162周期（30.81μs @ 200MHz）
```

### AXI Stream握手时序细节

```
场景1: 握手成功（input_ready=1）
         ___      ___      ___
clk  ___|   |____|   |____|   |____

         _________
valid   |___________|________
         _________
data    X__DATA1__|__DATA2__
         _________________
ready   |___________________|

结果: DATA1在第1个上升沿被接收


场景2: 背压（input_ready=0）
         ___      ___      ___      ___
clk  ___|   |____|   |____|   |____|   |____

         _____________________________
valid   |_____________________________|
         _____________________________
data    X__________DATA1_____________|
                    _______________
ready   ___________|_______________|

结果: DATA1在第3个上升沿才被接收（必须保持valid和data不变）
```

---

## ⚠️ 关键注意事项（Testbench开发必读）

### 1. 复位时序要求
```verilog
// 正确的复位序列
initial begin
    rst_n = 0;           // 初始复位
    #100;                // 至少10个时钟周期
    @(posedge clk);
    rst_n = 1;           // 释放复位
    repeat(5) @(posedge clk);  // 等待稳定
    // 开始测试...
end
```

### 2. start信号时序
- ✅ **正确**: start必须是1周期脉冲
  ```verilog
  @(posedge clk);
  start <= 1;
  @(posedge clk);
  start <= 0;
  ```
- ❌ **错误**: 持续拉高start
  ```verilog
  start <= 1;  // 会导致多次启动！
  ```

### 3. AXI Stream握手协议
- **规则1**: 数据发送方设置`valid=1`后，**不能**改变`data`，直到握手成功
- **规则2**: 握手成功 = `valid=1` AND `ready=1`在同一个时钟上升沿
- **规则3**: `ready`可以在`valid`之前、同时或之后拉高
- **规则4**: Testbench建议：保持`output_ready=1`以避免输出阻塞

### 4. 数据格式转换（Verilog ↔ Python）

#### Python → Verilog (ap_fixed<16,2>)
```python
import numpy as np

def float_to_apfixed16_2(value):
    """将浮点数转换为ap_fixed<16,2>的16位表示"""
    # ap_fixed<16,2>: 1符号位 + 1整数位 + 14小数位
    # 范围: [-2.0, 2.0)
    # 精度: 1/2^14 = 0.00006103515625

    # 截断到范围内
    value = np.clip(value, -2.0, 1.9999)

    # 缩放并转为整数
    scaled = int(value * (2**14))  # 左移14位

    # 处理负数（二进制补码）
    if scaled < 0:
        scaled = scaled & 0xFFFF  # 16位补码

    return scaled

# 示例
test_values = [-0.5, 0.0, 0.5, 1.0]
for val in test_values:
    hex_val = float_to_apfixed16_2(val)
    print(f"{val:6.3f} → 0x{hex_val:04X} ({hex_val:5d})")
```

输出:
```
-0.500 → 0xE000 (57344)
 0.000 → 0x0000 (    0)
 0.500 → 0x2000 ( 8192)
 1.000 → 0x4000 (16384)
```

#### Verilog → Python (ap_fixed<16,2>)
```python
def apfixed16_2_to_float(hex_value):
    """将16位ap_fixed<16,2>转换为浮点数"""
    # 转为有符号整数（二进制补码）
    if hex_value & 0x8000:  # 符号位为1
        signed_int = hex_value - 65536
    else:
        signed_int = hex_value

    # 右移14位（除以2^14）
    return signed_int / (2**14)

# 示例
test_hex = [0xE000, 0x0000, 0x2000, 0x4000, 0x3333]
for hex_val in test_hex:
    float_val = apfixed16_2_to_float(hex_val)
    print(f"0x{hex_val:04X} → {float_val:8.5f}")
```

### 5. Testbench数据加载

```verilog
// 方法1: 从文本文件加载（推荐）
reg [15:0] test_image [0:1023];
initial begin
    $readmemh("test_input.hex", test_image);  // 十六进制格式
    // 或
    // $readmemb("test_input.bin", test_image);  // 二进制格式
end

// 方法2: Python生成Verilog数组
// Python代码:
//   with open("test_data.v", "w") as f:
//       f.write("initial begin\n")
//       for i, val in enumerate(input_array):
//           hex_val = float_to_apfixed16_2(val)
//           f.write(f"    test_image[{i}] = 16'h{hex_val:04X};\n")
//       f.write("end\n")

`include "test_data.v"  // 包含生成的初始化代码
```

### 6. 常见错误排查

| 症状 | 可能原因 | 解决方法 |
|------|----------|----------|
| `idle`始终为0 | 复位未释放 | 检查`rst_n`时序 |
| 无输出 | 输入数据未发送完整 | 检查是否发送了1024个像素 |
| `output_valid`始终为0 | `start`未触发 | 检查start脉冲时序 |
| 仿真卡死 | 等待握手但`ready`始终为0 | 检查IP是否正确实例化 |
| 输出结果错误 | 数据格式转换错误 | 验证ap_fixed<16,2>编码 |

---

## 📝 Testbench模板

### 完整Testbench示例

```verilog
`timescale 1ns / 1ps

module CNN4HW_TOP_tb;

    // ========== 时钟与复位 ==========
    reg clk;
    reg rst_n;

    // ========== 控制信号 ==========
    reg start;
    wire done;
    wire idle;
    wire ready;

    // ========== 数据接口 ==========
    reg [15:0] input_data;
    reg input_valid;
    wire input_ready;

    wire [15:0] output_data;
    wire output_valid;
    reg output_ready;

    // ========== 测试数据 ==========
    reg [15:0] test_image [0:1023];
    reg [15:0] expected_output;
    integer i;

    // ========== DUT实例化 ==========
    CNN4HW_TOP uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(done),
        .idle(idle),
        .ready(ready),
        .input_data(input_data),
        .input_valid(input_valid),
        .input_ready(input_ready),
        .output_data(output_data),
        .output_valid(output_valid),
        .output_ready(output_ready)
    );

    // ========== 时钟生成: 200MHz (5ns周期) ==========
    always #2.5 clk = ~clk;

    // ========== 初始化 ==========
    initial begin
        // 信号初始化
        clk = 0;
        rst_n = 0;
        start = 0;
        input_data = 0;
        input_valid = 0;
        output_ready = 1;  // 始终准备接收

        // 加载测试数据
        $readmemh("test_input.hex", test_image);
        expected_output = 16'h3000;  // 示例期望值

        // 复位序列
        repeat(10) @(posedge clk);
        rst_n = 1;
        $display("[%0t] Reset released", $time);
        repeat(5) @(posedge clk);

        // 运行测试
        run_inference();

        // 结束仿真
        #1000;
        $display("[%0t] Simulation finished", $time);
        $finish;
    end

    // ========== 推理任务 ==========
    task run_inference;
        real output_float;
        begin
            $display("[%0t] Starting inference...", $time);

            // 等待空闲
            wait(idle == 1);
            @(posedge clk);

            // 发送start脉冲
            start <= 1;
            @(posedge clk);
            start <= 0;
            $display("[%0t] Start pulse sent", $time);

            // 发送1024个像素
            for (i = 0; i < 1024; i = i + 1) begin
                input_data <= test_image[i];
                input_valid <= 1;
                @(posedge clk);

                // 等待握手
                while (!input_ready) begin
                    @(posedge clk);
                end

                if (i % 256 == 0) begin
                    $display("[%0t] Sent %0d pixels", $time, i);
                end
            end

            // 结束输入
            input_valid <= 0;
            input_data <= 0;
            $display("[%0t] All 1024 pixels sent", $time);

            // 等待输出
            wait(output_valid == 1);
            @(posedge clk);

            // 转换为浮点数显示
            output_float = $itor($signed(output_data)) / 16384.0;
            $display("[%0t] Output received: 0x%04h (float: %f)",
                     $time, output_data, output_float);

            // 检查结果
            if (output_data == expected_output) begin
                $display("PASS: Output matches expected value");
            end else begin
                $display("FAIL: Expected 0x%04h, got 0x%04h",
                         expected_output, output_data);
            end

            // 等待完成
            wait(done == 1);
            @(posedge clk);
            $display("[%0t] Inference completed", $time);
        end
    endtask

    // ========== 超时监控 ==========
    initial begin
        #10_000_000;  // 10ms超时
        $display("ERROR: Simulation timeout!");
        $finish;
    end

    // ========== 波形转储 ==========
    initial begin
        $dumpfile("cnn_top_tb.vcd");
        $dumpvars(0, CNN4HW_TOP_tb);
    end

endmodule
```

### Python测试数据生成脚本

```python
#!/usr/bin/env python3
"""
生成CNN testbench的测试数据
"""
import numpy as np

def float_to_apfixed16_2(value):
    """转换浮点数为ap_fixed<16,2>"""
    value = np.clip(value, -2.0, 1.9999)
    scaled = int(value * (2**14))
    if scaled < 0:
        scaled = scaled & 0xFFFF
    return scaled

# 加载真实数据
input_data = np.load("X_pkl-filtered_float32_N_4_256_1.npy")
sample = input_data[0]  # 取第一个样本 (4, 256, 1)

# 展平为1024像素（行优先）
pixels = sample.reshape(-1)  # (1024,)

# 转换为hex格式
with open("test_input.hex", "w") as f:
    for pixel in pixels:
        hex_val = float_to_apfixed16_2(pixel)
        f.write(f"{hex_val:04X}\n")

print(f"Generated test_input.hex with {len(pixels)} pixels")
print(f"Value range: [{pixels.min():.4f}, {pixels.max():.4f}]")
```

---

## 📚 相关文件

- **顶层设计**: `CNN4HW_TOP.v` - 包装模块
- **Testbench**: `CNN4HW_TOP_tb.v` - 验证测试
- **约束文件**: `CNN_iCube_FPGA_b1/CNN_iCube_FPGA_b1.srcs/constrs_1/new/cons4test.xdc`
- **HLS IP**: `hls_cnn_2d_100s/hls_cnn_2d_100s_prj/solution1/impl/ip`
- **配置文件**: `hls_cnn_2d_100s/hls4ml_config.yml`
- **性能报告**: `hls_cnn_2d_100s_prj/solution1/syn/report/hls_cnn_2d_100s_csynth.xml`

---

## 🔄 版本历史

- **v0.03 (2025-10-14)**: 修正输入尺寸、性能参数，添加详细testbench指南
- v0.02 (2025-10-14): 添加HLS CNN IP包装
- v0.01 (2025-10-14): 初始版本

---

## 📧 支持与调试

### 仿真调试步骤
1. 生成测试数据: `python generate_test_data.py`
2. 编译testbench: `vlog CNN4HW_TOP.v CNN4HW_TOP_tb.v`
3. 运行仿真: `vsim -do "run -all" CNN4HW_TOP_tb`
4. 查看波形: `gtkwave cnn_top_tb.vcd`

### 关键波形检查点
- [ ] `rst_n`在t=0时为0，然后释放
- [ ] `idle`在复位后变为1
- [ ] `start`脉冲为1个时钟周期
- [ ] `input_valid`和`input_ready`握手1024次
- [ ] `output_valid`在~6161周期后拉高
- [ ] `done`脉冲在output之后
