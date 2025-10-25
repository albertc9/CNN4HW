#!/usr/bin/env python3
"""Quick test of HLS model using Python"""

import numpy as np
import sys
sys.path.append('/home/work1/Work/CNN_iCube_FPGA_b/hls_cnn_2d_100s')

# Import the HLS model
from hls_cnn_2d_100s import hls_cnn_2d_100s

# Load test data
data = np.load('/home/work1/Work/CNN_iCube_FPGA_b/out/X_pkl-filtered_float32_N_4_256_1.npy')
print(f"Data shape: {data.shape}")
print(f"Data range: [{data.min():.6f}, {data.max():.6f}]")

# Test with sample 0
sample = data[0]
print(f"\nTesting with sample 0, shape: {sample.shape}")
print(f"First 5 pixels: {sample.flatten()[:5]}")

# Run inference
print("\nRunning HLS inference...")
try:
    result = hls_cnn_2d_100s(sample)
    print(f"SUCCESS! Result: {result}")
    print(f"Result shape: {result.shape if hasattr(result, 'shape') else 'scalar'}")
except Exception as e:
    print(f"ERROR: {e}")
    import traceback
    traceback.print_exc()
