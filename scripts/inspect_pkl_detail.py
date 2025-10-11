import pickle
import numpy as np

# Load the pickle file
with open('data/filtered_coinc.pkl', 'rb') as f:
    data = pickle.load(f)

# Look at the first event in detail
event_0 = data[0]
print("=== Event 0 Structure ===")
print(f"Keys: {event_0.keys()}")
print(f"\nnumCoincidences: {event_0['numCoincidences']}")
print(f"datetime: {event_0['datetime']}")

# Look at stations structure
stations = event_0['stations']
print(f"\nStations type: {type(stations)}")
print(f"Stations keys: {list(stations.keys())[:10]}")

# Look at first station
first_station_key = list(stations.keys())[0]
first_station = stations[first_station_key]
print(f"\n=== First Station ({first_station_key}) ===")
print(f"Type: {type(first_station)}")
if isinstance(first_station, dict):
    print(f"Keys: {first_station.keys()}")
    for key, value in first_station.items():
        print(f"\n  {key}:")
        print(f"    Type: {type(value)}")
        if isinstance(value, np.ndarray):
            print(f"    Shape: {value.shape}")
            print(f"    Dtype: {value.dtype}")
            print(f"    Sample values: {value.flat[:10] if value.size >= 10 else value}")
        elif isinstance(value, list):
            print(f"    Length: {len(value)}")
            if len(value) > 0:
                print(f"    Sample values: {value[:5]}")
        else:
            print(f"    Value: {value}")
