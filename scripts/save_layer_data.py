import tensorflow as tf
from tensorflow import keras
import numpy as np
import pickle
import json

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
sample_input = first_station['Filtered_Traces']
sample_input_reshaped = np.expand_dims(sample_input, axis=-1)

# First pass to build the model
_ = model.predict(sample_input_reshaped, verbose=0)

# Create a dictionary to store all layer information
layer_data = {
    'model_summary': {
        'total_params': int(np.sum([np.prod(w.shape) for layer in model.layers for w in layer.get_weights()])),
        'input_shape': list(sample_input_reshaped.shape),
        'num_layers': len(model.layers)
    },
    'layers': []
}

# Extract layer-by-layer data
for i, layer in enumerate(model.layers):
    intermediate_model = keras.Model(inputs=model.layers[0].input, outputs=layer.output)
    output = intermediate_model.predict(sample_input_reshaped, verbose=0)

    layer_info = {
        'layer_index': i,
        'layer_name': layer.name,
        'layer_type': type(layer).__name__,
        'output_shape': list(output.shape),
        'output_stats': {
            'min': float(output.min()),
            'max': float(output.max()),
            'mean': float(output.mean()),
            'std': float(output.std())
        }
    }

    # Add input info for first layer
    if i == 0:
        layer_info['input_shape'] = list(sample_input_reshaped.shape)
        layer_info['input_stats'] = {
            'min': float(sample_input_reshaped.min()),
            'max': float(sample_input_reshaped.max()),
            'mean': float(sample_input_reshaped.mean()),
            'std': float(sample_input_reshaped.std())
        }

    # Add weight information
    weights = layer.get_weights()
    if weights:
        layer_info['parameters'] = []
        for j, w in enumerate(weights):
            param_name = "kernel" if j == 0 else "bias"
            param_info = {
                'name': param_name,
                'shape': list(w.shape),
                'dtype': str(w.dtype),
                'stats': {
                    'min': float(w.min()),
                    'max': float(w.max()),
                    'mean': float(w.mean()),
                    'std': float(w.std())
                }
            }
            layer_info['parameters'].append(param_info)

    # Get layer config
    config = layer.get_config()
    if 'filters' in config:
        layer_info['filters'] = config['filters']
    if 'kernel_size' in config:
        layer_info['kernel_size'] = config['kernel_size']
    if 'activation' in config:
        layer_info['activation'] = config['activation']
    if 'rate' in config:  # for dropout
        layer_info['dropout_rate'] = config['rate']

    layer_data['layers'].append(layer_info)

# Save to JSON
with open('layer_data_report.json', 'w') as f:
    json.dump(layer_data, f, indent=2)

print("Layer data saved to layer_data_report.json")

# Also save numpy arrays for detailed analysis
np.savez('layer_data_arrays.npz',
         input=sample_input_reshaped,
         conv2d_output=keras.Model(inputs=model.layers[0].input, outputs=model.layers[0].output).predict(sample_input_reshaped, verbose=0),
         conv2d_1_output=keras.Model(inputs=model.layers[0].input, outputs=model.layers[1].output).predict(sample_input_reshaped, verbose=0),
         dropout_output=keras.Model(inputs=model.layers[0].input, outputs=model.layers[2].output).predict(sample_input_reshaped, verbose=0),
         flatten_output=keras.Model(inputs=model.layers[0].input, outputs=model.layers[3].output).predict(sample_input_reshaped, verbose=0),
         dense_output=keras.Model(inputs=model.layers[0].input, outputs=model.layers[4].output).predict(sample_input_reshaped, verbose=0),
         conv2d_kernel=model.layers[0].get_weights()[0],
         conv2d_bias=model.layers[0].get_weights()[1],
         conv2d_1_kernel=model.layers[1].get_weights()[0],
         conv2d_1_bias=model.layers[1].get_weights()[1],
         dense_kernel=model.layers[4].get_weights()[0],
         dense_bias=model.layers[4].get_weights()[1])

print("Layer arrays saved to layer_data_arrays.npz")
print("\nYou can load the arrays with: data = np.load('layer_data_arrays.npz')")
print("Available arrays:", list(np.load('layer_data_arrays.npz').keys()))
