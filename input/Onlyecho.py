#Βιβλιοθηκες για τον ήχο 
import wavio
import numpy as np

# συναρτηση για υπολογισμο του rms 
def calculate_rms(window):
    return np.sqrt(np.mean(np.square(window)))

# διαβασε wav file
wav = wavio.read("bigecho.wav")
rate = wav.rate
width = wav.sampwidth
samples = wav.data

# float τα δείγματα 
samples = samples.astype(np.float)

# παράμετροοι
window_size = rate // 10  # 100 ms 
threshold_db = -25  # -25 dB

# λουπα για ήχο 
for i in range(0, len(samples) - window_size, window_size):
    window = samples[i:i + window_size]
    rms_val = calculate_rms(window)

    # RMS σε dB
    rms_db = 20 * np.log10(rms_val / 32767)

    # σιγη για ΄πάνω από -25 
    if rms_db > threshold_db:
        samples[i:i + window_size] = 0

# integer τα δείγματα 
samples = samples.astype(np.int16)

# αποθήκευσε ήχο 
wavio.write("echo.wav", samples, rate, sampwidth=width) 
