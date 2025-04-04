[audio, Fs] = audioread('1-137-A-32.wav');
nfft = 1024;               % Nombre de points pour la FFT
overlap = 0.5;             % Taux de recouvrement (50%)

figure;

% Petite fenêtre (256)
subplot(3,1,1);
win_len = 256;
win = hamming(win_len);
spectrogram(audio, win, round(overlap*win_len), nfft, Fs, 'yaxis');
title('Hamming - WinLen = 256');

% Moyenne fenêtre (512)
subplot(3,1,2);
win_len = 512;
win = hamming(win_len);
spectrogram(audio, win, round(overlap*win_len), nfft, Fs, 'yaxis');
title('Hamming - WinLen = 512');

% Grande fenêtre (1024)
subplot(3,1,3);
win_len = 1024;
win = hamming(win_len);
spectrogram(audio, win, round(overlap*win_len), nfft, Fs, 'yaxis');
title('Hamming - WinLen = 1024');
