# Spectral Leakage Analysis in DFT

This project investigates the spectral leakage phenomenon in the Discrete Fourier Transform (DFT) using MATLAB.

## Overview
- Analysis of DFT bin matching and spectral leakage
- Comparison of different window functions
- Observation of frequency resolution and sidelobe behavior

## Methodology
- Generated sinusoidal signals at 50 Hz (no leakage) and 50.5 Hz (leakage case)
- Applied FFT to analyze frequency spectrum
- Used different window functions:
  - Rectangular
  - Hann
  - Hamming
  - Blackman

## Results
- No leakage occurs when the signal frequency matches DFT bins
- Spectral leakage spreads energy across multiple frequency bins
- Windowing reduces sidelobes but widens the main lobe

## Tools
- MATLAB
