[audio, Fs] = audioread('1-137-A-32.wav');
nfft = 1024;
win_len = 512;                 % Longueur fixe de la fenêtre
win = hamming(win_len);       % Fenêtre Hamming

figure;

% Overlap 25%
subplot(3,1,1);
overlap = round(0.25 * win_len);
spectrogram(audio, win, overlap, nfft, Fs, 'yaxis');
title('Spectrogramme - Overlap = 25%');

% Overlap 50%
subplot(3,1,2);
overlap = round(0.50 * win_len);
spectrogram(audio, win, overlap, nfft, Fs, 'yaxis');
title('Spectrogramme - Overlap = 50%');

% Overlap 75%
subplot(3,1,3);
overlap = round(0.75 * win_len);
spectrogram(audio, win, overlap, nfft, Fs, 'yaxis');
title('Spectrogramme - Overlap = 75%');
