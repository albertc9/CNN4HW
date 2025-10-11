import tensorflow as tf
from tensorflow import keras
import numpy as np

# Load the model
model = keras.models.load_model('models/10.07.25_15-31_100s_2D_CNN_model_2Layer.h5')

print("=== Model Summary ===")
model.summary()

print("\n=== Layer Details ===")
for i, layer in enumerate(model.layers):
    print(f"\nLayer {i}: {layer.name}")
    print(f"  Type: {type(layer).__name__}")
    print(f"  Output shape: {layer.output.shape}")
    print(f"  Config: {layer.get_config()}")

    # Get weights if available
    weights = layer.get_weights()
    if weights:
        print(f"  Number of weight arrays: {len(weights)}")
        for j, w in enumerate(weights):
            print(f"    Weight {j} shape: {w.shape}, dtype: {w.dtype}")
            print(f"    Weight {j} range: [{w.min():.6f}, {w.max():.6f}]")
            print(f"    Weight {j} mean: {w.mean():.6f}, std: {w.std():.6f}")
            if w.size <= 50:
                print(f"    Weight {j} all values:\n{w}")
            else:
                print(f"    Weight {j} sample values: {w.flat[:10]}")
