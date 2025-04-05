[audio, Fs] = audioread('1-137-A-32.wav');
nfft = 1024;
win_len = 512;
overlap = round(0.5 * win_len);  % 50% overlap

figure;

% 1. Fenêtre Rectangulaire
subplot(4,1,1);
win = rectwin(win_len);
spectrogram(audio, win, overlap, nfft, Fs, 'yaxis');
title('Spectrogramme - Fenêtre Rectangulaire');

% 2. Fenêtre Hamming
subplot(4,1,2);
win = hamming(win_len);
spectrogram(audio, win, overlap, nfft, Fs, 'yaxis');
title('Spectrogramme - Fenêtre Hamming');

% 3. Fenêtre Hann
subplot(4,1,3);
win = hann(win_len);
spectrogram(audio, win, overlap, nfft, Fs, 'yaxis');
title('Spectrogramme - Fenêtre Hann');

% 4. Fenêtre Blackman
subplot(4,1,4);
win = blackman(win_len);
spectrogram(audio, win, overlap, nfft, Fs, 'yaxis');
title('Spectrogramme - Fenêtre Blackman');
