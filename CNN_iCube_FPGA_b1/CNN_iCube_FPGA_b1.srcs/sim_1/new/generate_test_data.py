#!/usr/bin/env python3
"""
生成CNN testbench的测试数据

用法:
    python generate_test_data.py [sample_index]

参数:
    sample_index: 要生成的样本索引 (默认: 0)
                 如果设置为 'all'，则生成所有样本

输出:
    test_input_sampleN.hex - 包含1024个像素的16位十六进制数据
"""

import sys
import numpy as np
import os

def float_to_apfixed16_2(value):
    """
    将浮点数转换为ap_fixed<16,2>的16位表示

    ap_fixed<16,2>格式:
      - 总位宽: 16位
      - 整数位: 2位 (包括符号位)
      - 小数位: 14位
      - 范围: [-2.0, 2.0)
      - 精度: 1/2^14 = 0.00006103515625
    """
    # 范围限制
    value = np.clip(value, -2.0, 1.9999)

    # 缩放: 左移14位 (乘以2^14 = 16384)
    scaled = int(value * 16384)

    # 处理负数（16位二进制补码）
    if scaled < 0:
        scaled = scaled & 0xFFFF

    return scaled


def generate_sample_hex(data, sample_idx, output_dir):
    """
    生成单个样本的hex文件

    Args:
        data: numpy数组，形状为(N, 4, 256, 1)
        sample_idx: 样本索引
        output_dir: 输出目录
    """
    if sample_idx >= data.shape[0]:
        print(f"错误: 样本索引 {sample_idx} 超出范围 [0, {data.shape[0]-1}]")
        return False

    # 提取样本
    sample = data[sample_idx]  # (4, 256, 1)

    # 展平为1024像素（行优先）
    pixels = sample.reshape(-1)  # (1024,)

    # 生成hex文件名
    hex_file = os.path.join(output_dir, f"test_input_sample{sample_idx}.hex")

    # 写入hex文件
    with open(hex_file, "w") as f:
        for pixel in pixels:
            hex_val = float_to_apfixed16_2(pixel)
            f.write(f"{hex_val:04X}\n")

    # 打印统计信息
    print(f"\n样本 {sample_idx}:")
    print(f"  形状: {sample.shape}")
    print(f"  范围: [{sample.min():.6f}, {sample.max():.6f}]")
    print(f"  均值: {sample.mean():.6f}")
    print(f"  标准差: {sample.std():.6f}")
    print(f"  生成文件: {hex_file}")

    # 显示前5个像素的转换结果
    print(f"  前5个像素:")
    for i in range(min(5, len(pixels))):
        hex_val = float_to_apfixed16_2(pixels[i])
        print(f"    [{i:4d}]: {pixels[i]:+.6f} → 0x{hex_val:04X}")

    return True


def main():
    # 数据路径
    data_path = "/home/work1/Work/CNN_iCube_FPGA_b/out/X_pkl-filtered_float32_N_4_256_1.npy"
    output_dir = os.path.dirname(os.path.abspath(__file__))

    # 检查数据文件是否存在
    if not os.path.exists(data_path):
        print(f"错误: 找不到数据文件: {data_path}")
        sys.exit(1)

    # 加载数据
    print("="*80)
    print("CNN测试数据生成器")
    print("="*80)
    print(f"加载数据: {data_path}")
    data = np.load(data_path)
    print(f"数据形状: {data.shape}")
    print(f"总样本数: {data.shape[0]}")
    print(f"数据范围: [{data.min():.6f}, {data.max():.6f}]")

    # 解析命令行参数
    if len(sys.argv) > 1:
        arg = sys.argv[1]
        if arg.lower() == 'all':
            # 生成所有样本
            print(f"\n生成所有 {data.shape[0]} 个样本的hex文件...")
            for idx in range(data.shape[0]):
                generate_sample_hex(data, idx, output_dir)
                if (idx + 1) % 100 == 0:
                    print(f"\n进度: {idx+1}/{data.shape[0]} 样本已生成")
            print(f"\n完成! 共生成 {data.shape[0]} 个hex文件")
        else:
            # 生成指定样本
            try:
                sample_idx = int(arg)
                if sample_idx < 0 or sample_idx >= data.shape[0]:
                    print(f"错误: 样本索引必须在 [0, {data.shape[0]-1}] 范围内")
                    sys.exit(1)
                generate_sample_hex(data, sample_idx, output_dir)
            except ValueError:
                print(f"错误: 无效的样本索引 '{arg}'")
                print(f"用法: python {sys.argv[0]} [sample_index | 'all']")
                sys.exit(1)
    else:
        # 默认生成样本0
        sample_idx = 0
        generate_sample_hex(data, sample_idx, output_dir)

    print("\n" + "="*80)
    print("生成完成!")
    print("="*80)


if __name__ == "__main__":
    main()
