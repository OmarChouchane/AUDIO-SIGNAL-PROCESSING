% Lecture de trois fichiers audio (modifie les noms si besoin)
[audio1, Fs1] = audioread('1-29680-A-21.wav');
[audio2, Fs2] = audioread('2-124564-A-15.wav');
[audio3, Fs3] = audioread('3-146972-A-5.wav');

% Création d’un vecteur temps pour chaque signal
t1 = (0:length(audio1)-1)/Fs1;
t2 = (0:length(audio2)-1)/Fs2;
t3 = (0:length(audio3)-1)/Fs3;

% Affichage des courbes
figure;
subplot(3,1,1);
plot(t1, audio1, "r");
title(['Signal 1 - Fs = ', num2str(Fs1), ' Hz, Durée = ', num2str(length(audio1)/Fs1), ' s']);
xlabel('Temps (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t2, audio2, "b");
title(['Signal 2 - Fs = ', num2str(Fs2), ' Hz, Durée = ', num2str(length(audio2)/Fs2), ' s']);
xlabel('Temps (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t3, audio3, "g");
title(['Signal 3 - Fs = ', num2str(Fs3), ' Hz, Durée = ', num2str(length(audio3)/Fs3), ' s']);
xlabel('Temps (s)');
ylabel('Amplitude');
