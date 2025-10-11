import tensorflow as tf
from tensorflow import keras
import numpy as np
import pickle

# Load the model
model = keras.models.load_model('models/10.07.25_15-31_100s_2D_CNN_model_2Layer.h5')

# Load the data
with open('data/filtered_coinc.pkl', 'rb') as f:
    data = pickle.load(f)

# Extract one sample from the data
event_0 = data[0]
stations = event_0['stations']
first_station_key = list(stations.keys())[0]
first_station = stations[first_station_key]

# Get the filtered traces (this is the input to the CNN)
sample_input = first_station['Filtered_Traces']  # Shape: (1, 4, 256)
print(f"Sample input shape: {sample_input.shape}")
print(f"Sample input range: [{sample_input.min():.6f}, {sample_input.max():.6f}]")
print(f"Sample input dtype: {sample_input.dtype}")

# Reshape to match model input if needed
# The model expects (batch, height, width, channels)
# Current shape is (1, 4, 256) which is (batch, 4 channels, 256 samples)
# Need to reshape to (1, 4, 256, 1) - treating it as 2D with 1 channel
sample_input_reshaped = np.expand_dims(sample_input, axis=-1)
print(f"\nReshaped input shape: {sample_input_reshaped.shape}")

# First, do a forward pass to build the model
_ = model.predict(sample_input_reshaped, verbose=0)

# Create intermediate models for each layer
print("\n" + "="*80)
print("EXTRACTING LAYER-BY-LAYER OUTPUTS")
print("="*80)

for i, layer in enumerate(model.layers):
    # Create a model that outputs this layer
    intermediate_model = keras.Model(inputs=model.layers[0].input, outputs=layer.output)

    # Get the output
    output = intermediate_model.predict(sample_input_reshaped, verbose=0)

    print(f"\n{'='*80}")
    print(f"Layer {i}: {layer.name} ({type(layer).__name__})")
    print(f"{'='*80}")

    if i == 0:
        print(f"Input shape:  {sample_input_reshaped.shape}")
        print(f"Input range:  [{sample_input_reshaped.min():.6f}, {sample_input_reshaped.max():.6f}]")
        print(f"Input sample values:\n{sample_input_reshaped[0, :, :5, 0]}")  # First 5 time steps

    print(f"\nOutput shape: {output.shape}")
    print(f"Output range: [{output.min():.6f}, {output.max():.6f}]")
    print(f"Output mean:  {output.mean():.6f}, std: {output.std():.6f}")

    # Show sample output values
    if len(output.shape) == 4:  # Conv layers
        print(f"\nOutput sample (first feature map, first few positions):")
        if output.shape[2] >= 5:
            print(output[0, 0, :5, 0])  # First 5 positions of first feature map
        else:
            print(output[0, 0, :, 0])
    elif len(output.shape) == 2:  # Dense/Flatten layers
        print(f"\nOutput sample (first 10 values):")
        print(output[0, :10])

    # Show layer parameters if they exist
    weights = layer.get_weights()
    if weights:
        print(f"\nLayer parameters:")
        for j, w in enumerate(weights):
            param_name = "kernel" if j == 0 else "bias"
            print(f"  {param_name}: shape={w.shape}, range=[{w.min():.6f}, {w.max():.6f}]")

print("\n" + "="*80)
print("SUMMARY")
print("="*80)
print(f"Input:  {sample_input_reshaped.shape} -> range [{sample_input_reshaped.min():.6f}, {sample_input_reshaped.max():.6f}]")
final_output = model.predict(sample_input_reshaped, verbose=0)
print(f"Output: {final_output.shape} -> value {final_output[0, 0]:.6f}")
