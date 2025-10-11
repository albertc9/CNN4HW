#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
export_hls4ml_vitis.py
----------------------
Create hls4ml/Vitis-ready NumPy arrays for a 2D CNN (channels_last).

Default PKL: /home/work1/Work/CNN_iCube_FPGA_b/data/filtered_coinc.pkl
Model (for reference only): /home/work1/Work/CNN_iCube_FPGA_b/models/10.07.25_15-31_100s_2D_CNN_model_2Layer.h5

- Input (PKL): choose "Filtered_Traces" or "Traces" per your training.
- Input (NPY): one or many single-event files shaped (4,256) or (256,4).
- Output: (N, 4, 256, 1) float32/float16 array, plus a metadata CSV.

Examples:
  # Default run (Filtered_Traces)
  python export_hls4ml_vitis.py

  # With SNR filter
  python export_hls4ml_vitis.py --snr-min 4.0

  # Combine with .npy events
  python export_hls4ml_vitis.py --npy-glob "/path/to/*.npy"
"""
import argparse, pickle, numpy as np, pandas as pd, glob
from pathlib import Path
from typing import Dict, Any, Optional


def first_scalar(x):
    if x is None:
        return np.nan
    try:
        a = np.array(x)
        return float(a.ravel()[0])
    except Exception:
        try:
            return float(x)
        except Exception:
            return np.nan


def ensure_4x256(a: np.ndarray) -> Optional[np.ndarray]:
    """Coerce an array into (4,256) if possible."""
    if a is None:
        return None
    a = np.squeeze(a)
    if a.ndim == 3 and a.shape[0] == 1:
        a = a[0]
    if a.shape == (256, 4):
        a = a.T
    if a.size == 4 * 256 and a.shape != (4, 256):
        a = a.reshape(4, 256)
    return a if a.shape == (4, 256) else None


def pick_station_array(st: Dict[str, Any], use_filtered: bool) -> Optional[np.ndarray]:
    """Extract (4,256) array from station dict."""
    key = "Filtered_Traces" if use_filtered else "Traces"
    if key not in st:
        return None
    arr = np.array(st[key])
    if arr.ndim == 3 and arr.shape[0] == 1:
        arr = arr[0]
    arr = np.squeeze(arr)
    return ensure_4x256(arr)


def load_from_pkl(pkl_path: Path, use_filtered: bool, snr_min=None, dtype="float32"):
    with open(pkl_path, "rb") as f:
        coinc = pickle.load(f)

    samples, meta = [], []
    for ev_id, ev in coinc.items():
        for st_id, st in ev.get("stations", {}).items():
            arr = pick_station_array(st, use_filtered)
            if arr is None:
                continue
            snr = first_scalar(st.get("SNR"))
            if snr_min is not None and not np.isnan(snr) and snr < snr_min:
                continue
            arr = arr.astype(dtype)[..., None]
            samples.append(arr)
            meta.append({
                "event_idx": ev_id,
                "station": int(st_id),
                "snr": snr,
                "ChiRCR": first_scalar(st.get("ChiRCR")),
                "Chi2016": first_scalar(st.get("Chi2016")),
                "ChiBad": first_scalar(st.get("ChiBad")),
            })
    if not samples:
        raise SystemExit("No samples found in PKL.")
    X = np.stack(samples, axis=0)
    return X, meta


def load_from_npy_glob(pattern: str, dtype="float32"):
    paths = sorted(glob.glob(pattern))
    if not paths:
        raise SystemExit(f"No files matched: {pattern}")
    samples, meta = [], []
    for i, p in enumerate(paths):
        a = ensure_4x256(np.load(p))
        if a is None:
            continue
        samples.append(a.astype(dtype)[..., None])
        meta.append({"file": p})
    X = np.stack(samples, axis=0)
    return X, meta


def main():
    ap = argparse.ArgumentParser("Export (N,4,256,1) NHWC numpy arrays for hls4ml/Vitis Conv2D")
    ap.add_argument("--pkl", type=Path,
                    default=Path("/home/work1/Work/CNN_iCube_FPGA_b/data/filtered_coinc.pkl"),
                    help="Path to PKL file (default path included)")
    ap.add_argument("--field", choices=["filtered", "traces"], default="filtered",
                    help="Use Filtered_Traces or Traces")
    ap.add_argument("--npy-glob", type=str, help="Glob for single-event .npy files")
    ap.add_argument("--out-dir", type=Path,
                    default=Path("/home/work1/Work/CNN_iCube_FPGA_b/out"),
                    help="Output directory")
    ap.add_argument("--dtype", choices=["float32", "float16"], default="float32")
    ap.add_argument("--snr-min", type=float, default=None, help="Keep SNR >= threshold")
    args = ap.parse_args()

    args.out_dir.mkdir(parents=True, exist_ok=True)

    X_list, meta_list = [], []
    if args.pkl:
        use_filtered = args.field == "filtered"
        X, meta = load_from_pkl(args.pkl, use_filtered, args.snr_min, args.dtype)
        X_list.append(X)
        meta_list.extend(meta)
    if args.npy_glob:
        Xn, metan = load_from_npy_glob(args.npy_glob, args.dtype)
        X_list.append(Xn)
        meta_list.extend(metan)

    if not X_list:
        raise SystemExit("No data to export.")

    X = np.concatenate(X_list, axis=0)
    df = pd.DataFrame(meta_list)

    out_npy = args.out_dir / "X_pkl-filtered_float32_N_4_256_1.npy"
    out_csv = args.out_dir / "X_pkl-filtered_float32_N_4_256_1_meta.csv"

    np.save(out_npy, X)
    df.to_csv(out_csv, index=False)
    print(f"[OK] Saved {out_npy}  shape={X.shape}")
    print(f"[OK] Saved {out_csv}  rows={len(df)}")


if __name__ == "__main__":
    main()
