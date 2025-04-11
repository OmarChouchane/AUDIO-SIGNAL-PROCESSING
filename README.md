# 🎧 TP2 - Audio Signal Processing with MATLAB

![ESC-50 Dataset](https://img.shields.io/badge/Dataset-ESC--50-blue)
![MATLAB](https://img.shields.io/badge/Tool-MATLAB-orange)
![RT3](https://img.shields.io/badge/Level-RT3-lightgrey)

## 📌 Project Overview

This repository contains the implementation and analysis of audio signal processing techniques as part of **TP2** for the **RT3** class at **INSAT**. The project focuses on detecting specific events in an audio signal using **spectrogram analysis** and **template matching**. The main use case is detecting a **dog bark** in an audio recording containing background speech.

## 🧠 Authors

- Karoui Bochra  
- Chouchane Omar  
- Khemiri Sahar  

---

## 🎯 Objectives

1. Explore environmental audio datasets.
2. Visualize time-domain waveforms and spectrograms.
3. Apply short-time Fourier analysis (STFT).
4. Implement and evaluate **Template Matching** techniques.
5. Study the robustness of detection in noisy environments.

---

## 📂 Dataset Used

**ESC-50**: Environmental Sound Classification Dataset

- 🎵 2000 `.wav` files across 50 categories  
- 🕔 5 seconds per file  
- 🔊 44.1 kHz sampling rate, stereo  
- 🔍 Classes include animals, vehicles, tools, human environments

---

## 🧪 Experiments and Analysis

### 1. 🕒 Time-Domain Signal Display

- Visualized raw audio waveforms
- Three different `.wav` files were loaded and plotted

### 2. 🔎 Spectrogram Analysis

Tested effects of:

- 🪟 **Window Length**: 256 / 512 / 1024  
- 🔁 **Overlap Rates**: 25%, 50%, 75%  
- 🎭 **Window Types**: Rectangular, Hamming, Hann, Blackman

### 3. 🎯 Template Matching

- Event Detected: **Dog Bark**
- Technique: Cross-correlation between event and main signal spectrograms
- Result: Localized dog bark at ~**2.26s**

### 4. 🔊 Noise Robustness Test

- Added Gaussian noise at various **SNR levels**: -40, -30, -20, 0, +10 dB
- Observed performance degradation with increasing noise
- Detection stayed accurate for SNR ≥ -20 dB

---

## 📉 Performance Metrics

| SNR (dB) | Detection Error (sec) | Similarity Peak |
|----------|------------------------|------------------|
| -40      | ~2.00                  | Low              |
| -30      | ~1.50                  | Low              |
| -20      | 0.00                   | High             |
| 0        | 0.00                   | High             |
| +10      | 0.00                   | High             |

---

## 🛠️ Technologies

- **Language**: MATLAB
- **Toolkits**: Signal Processing Toolbox
- **Platform**: MATLAB Online

---

## 📷 Visual Samples

<details>
<summary>Click to Expand</summary>
(https://github.com/user-attachments/assets/365a90fb-3392-44d2-824b-7460ea39dd44)
*Sample spectrogram illustration*

</details>

---

## 💡 Learnings & Limitations

### ✅ Pros

- Easy-to-implement and interpret
- Effective for clean signals
- Visual tools enhance understanding

### ❌ Cons

- Sensitive to noise
- Template quality heavily impacts detection
- Computationally heavy for long recordings

---

## 📈 Evaluation Metrics
Temporal Accuracy: Time delta between predicted and true event position

Similarity Peak: Strength of template match

Noise Robustness: Detection under variable SNR levels

---

📢 Citation & Acknowledgments
ESC-50 Dataset: https://github.com/karoldvl/ESC-50

MATLAB Online: https://matlab.mathworks.com

TP Supervised by: Pr. RIM AMARA BOUJEMAA


Institution: INSAT – Institut National des Sciences Appliquées et de Technologie


---



