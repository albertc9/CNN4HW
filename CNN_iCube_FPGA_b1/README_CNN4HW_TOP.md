# CNN4HW_TOP - CNN加速器顶层模块使用指南

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

| 端口名 | 方向 | 位宽 | 说明 |
|--------|------|------|------|
| **时钟和复位** | | | |
| `clk` | Input | 1 | 系统时钟 (推荐200MHz) |
| `rst_n` | Input | 1 | 低电平有效复位 |
| **控制信号** | | | |
| `start` | Input | 1 | 开始推理（脉冲信号） |
| `done` | Output | 1 | 推理完成（脉冲信号） |
| `idle` | Output | 1 | IP空闲，可以开始新推理 |
| `ready` | Output | 1 | IP准备好接收数据 |
| **输入数据接口** | | | |
| `input_data` | Input | 16 | 输入像素数据 |
| `input_valid` | Input | 1 | 输入数据有效 |
| `input_ready` | Output | 1 | 准备接收输入数据 |
| **输出数据接口** | | | |
| `output_data` | Output | 16 | 输出结果 |
| `output_valid` | Output | 1 | 输出数据有效 |
| `output_ready` | Input | 1 | 准备接收输出（通常保持为1） |

---

## 🚀 使用方法

### 1. 基本使用流程

```verilog
// 步骤1: 等待IP空闲
wait (idle == 1);

// 步骤2: 发送start脉冲
start <= 1;
@(posedge clk);
start <= 0;

// 步骤3: 发送1024个像素数据
for (i = 0; i < 1024; i = i + 1) begin
    @(posedge clk);
    input_data <= pixel_array[i];
    input_valid <= 1;

    // 等待握手
    while (!input_ready) @(posedge clk);
end
input_valid <= 0;

// 步骤4: 等待输出
@(posedge output_valid);
result = output_data;

// 步骤5: 等待完成
@(posedge done);
// 推理完成，可以开始下一次
```

### 2. 数据格式

**输入数据**:
- 32×32 图像 = 1024个像素
- 每个像素: 16位定点数 `ap_fixed<16,2,AP_TRN,AP_WRAP,0>`
- 顺序: 逐行扫描（行优先）

**输出数据**:
- 1个分类结果值
- 16位定点数 `ap_fixed<16,2,AP_TRN,AP_WRAP,0>`

### 3. 时序要求

```
时钟周期: 5ns (200MHz)
输入数据传输: 1024周期（每周期1个像素）
推理延迟: 10,258周期 (51.29 μs)
吞吐量: 约19,500次推理/秒
```

---

## 📊 时序图

```
              ____      ____      ____      ____      ____
clk      ____|    |____|    |____|    |____|    |____|    |____

         _____                                          __________
rst_n    _____XXXXXXXXXX________________________________

         ___________                              _______________
idle                XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

              _____
start    _____|     |_________________________________________

                    _____ _____ _____ ... _____
input_data   XXXXXXX__D0_X__D1_X__D2_X...X_D1023_XXXXXXXXXXXXX

                    ___________________________
input_valid  _______|                           |_____________

input_ready  XXXXXXX|___________________________X (握手)

                                                      _____
output_valid ________________________________________|     |___

                                                      _____
output_data  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX_RES_XXXX

                                                            ____
done         ______________________________________________|    |_
```

---

## 🔧 集成步骤

### 步骤1: 添加HLS IP到Vivado项目

在Vivado Tcl Console中执行:

```tcl
# 添加IP仓库
set_property ip_repo_paths {/home/work1/Work/CNN_iCube_FPGA_b/hls_cnn_2d_100s/hls_cnn_2d_100s_prj/solution1/impl/ip} [current_project]
update_ip_catalog
```

### 步骤2: 添加源文件

1. 在Vivado中添加 `CNN4HW_TOP.v`
2. 设置为顶层模块（可选）

### 步骤3: 在Block Design中使用

如果使用Block Design:
```tcl
# 创建Block Design中的层次模块
create_bd_cell -type module -reference CNN4HW_TOP cnn_accelerator_0
```

### 步骤4: 连接时钟和复位

确保:
- `clk` 连接到200MHz时钟源
- `rst_n` 连接到同步复位（active-low）

---

## 📝 示例代码

### 示例1: 单次推理

```verilog
module cnn_user_logic (
    input wire clk,
    input wire rst_n,
    input wire run_inference,
    output reg inference_done
);

    // CNN模块接口
    wire start, done, idle, ready;
    reg [15:0] input_data;
    reg input_valid;
    wire input_ready;
    wire [15:0] output_data;
    wire output_valid;

    // CNN实例化
    CNN4HW_TOP cnn_inst (
        .clk(clk), .rst_n(rst_n),
        .start(start), .done(done), .idle(idle), .ready(ready),
        .input_data(input_data), .input_valid(input_valid), .input_ready(input_ready),
        .output_data(output_data), .output_valid(output_valid), .output_ready(1'b1)
    );

    // 状态机控制
    reg [1:0] state;
    localparam IDLE = 0, SEND_DATA = 1, WAIT_RESULT = 2;

    reg [10:0] pixel_cnt;
    reg [15:0] image_buffer [0:1023];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            input_valid <= 0;
            pixel_cnt <= 0;
            inference_done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    inference_done <= 0;
                    if (run_inference && idle) begin
                        start <= 1;
                        state <= SEND_DATA;
                        pixel_cnt <= 0;
                    end
                end

                SEND_DATA: begin
                    start <= 0;
                    if (pixel_cnt < 1024) begin
                        input_data <= image_buffer[pixel_cnt];
                        input_valid <= 1;
                        if (input_ready) begin
                            pixel_cnt <= pixel_cnt + 1;
                        end
                    end else begin
                        input_valid <= 0;
                        state <= WAIT_RESULT;
                    end
                end

                WAIT_RESULT: begin
                    if (done) begin
                        inference_done <= 1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
```

### 示例2: AXI接口封装（用于PS端）

```verilog
// TODO: 添加AXI-Lite控制接口
// TODO: 添加AXI-MM数据接口
```

---

## ⚠️ 注意事项

### 1. 时钟约束
在XDC文件中添加:
```tcl
create_clock -period 5.000 -name sys_clk [get_ports clk]
set_input_delay -clock sys_clk -max 1.0 [get_ports {input_data[*]}]
set_output_delay -clock sys_clk -max 1.0 [get_ports {output_data[*]}]
```

### 2. 复位要求
- 必须使用同步复位
- 复位持续时间 ≥ 10个时钟周期
- 推荐使用 `proc_sys_reset` IP

### 3. 数据顺序
- 输入数据必须按行优先顺序发送
- 第0个数据 = 图像(0,0)
- 第31个数据 = 图像(0,31)
- 第32个数据 = 图像(1,0)

### 4. 握手协议
- 必须等待 `input_ready=1` 才能发送下一个数据
- 不要在 `input_ready=0` 时改变 `input_data`

---

## 📈 性能参数

| 参数 | 值 |
|------|-----|
| 时钟频率 | 200 MHz (推荐) / 230 MHz (最大) |
| 输入延迟 | 1,024 周期 |
| 推理延迟 | 10,258 周期 (51.29 μs) |
| 输出延迟 | 1 周期 |
| 吞吐率 | ~19,500 推理/秒 |
| 资源使用 | LUT: 95K (44%), FF: 95K (22%), DSP: 648 (35%), BRAM: 11.5 (2.4%) |
| 功耗估算 | ~2.5-3.5 W @ 200MHz |

---

## 🐛 故障排除

### 问题1: IP实例化失败
**错误**: `Module 'hls_cnn_2d_100s' not found`

**解决**:
```tcl
# 确认IP已添加到项目
update_ip_catalog
get_ips hls_cnn_2d_100s*
```

### 问题2: 时序不满足
**错误**: Setup violation on path

**解决**:
1. 降低时钟频率（从200MHz降到150MHz）
2. 添加流水线寄存器
3. 使用更快的器件速度等级

### 问题3: 输出无效
**症状**: `output_valid` 始终为0

**检查**:
1. 是否发送了完整的1024个像素
2. `start` 信号是否正确触发
3. `rst_n` 是否正确释放

---

## 📚 相关文件

- `CNN4HW_TOP.v` - 顶层包装模块
- `CNN4HW_TOP_tb.v` - 测试bench
- `import_ip_to_vivado.tcl` - IP导入脚本
- HLS IP路径: `hls_cnn_2d_100s/hls_cnn_2d_100s_prj/solution1/impl/ip`

---

## 🔄 版本历史

- v0.02 (2025-10-14): 添加HLS CNN IP包装
- v0.01 (2025-10-14): 初始版本

---

## 📧 支持

如有问题，请查看:
1. Testbench仿真波形
2. HLS综合报告: `hls_cnn_2d_100s_prj/solution1/syn/report/csynth.rpt`
3. Vivado实现报告
