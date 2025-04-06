% Paramètres de la fenêtre
Fs = 44100; % Fréquence d'échantillonnage
window_length = 1024;
overlap = 512;
nfft = 1024;

% Charger les fichiers audio
[x, ~] = audioread('signal_principal.wav');
[xevent, ~] = audioread('event_aboiement.wav');

% Convertir en mono si stéréo
if size(x, 2) == 2
    x = mean(x, 2);
end
if size(xevent, 2) == 2
    xevent = mean(xevent, 2);
end

% Spectrogramme de l’événement
[S_xevent, F_xevent, T_xevent] = spectrogram(xevent, window_length, overlap, nfft, Fs);

% Référence temporelle de l’événement dans le signal propre
event_time_reference = 2.26;  % À adapter selon votre signal propre

% SNRs à tester
snr_values = [-40, -30, -20, 0, 10];
event_times_detected = zeros(size(snr_values));
errors = zeros(size(snr_values));

% Affichage de la détection
fprintf('Évaluation de la détection selon le SNR :\n');

figure('Name', 'Comparaison des similarités pour différents SNRs');
for k = 1:length(snr_values)
    snr = snr_values(k);

    % Générer bruit blanc aléatoire
    bruit = randn(size(x));

    % Calculer puissance du signal et ajuster le bruit
    signal_power = mean(x.^2);
    noise_power = signal_power / (10^(snr / 10));
    bruit = sqrt(noise_power) * bruit / std(bruit);

    % Ajouter bruit au signal
    x_bruit = x + bruit;

    % Spectrogramme du signal bruité
    [S_xbruit, F_x, T_x] = spectrogram(x_bruit, window_length, overlap, nfft, Fs);

    % Template matching
    similarity = zeros(1, length(T_x) - length(T_xevent));
    for i = 1:length(similarity)
        segment = S_xbruit(:, i:i+length(T_xevent)-1);
        similarity(i) = sum(sum(abs(segment) .* abs(S_xevent)));
    end

    % Détection de l’événement
    [~, idx] = max(similarity);
    event_time_detected = T_x(idx);
    erreur = abs(event_time_detected - event_time_reference);

    % Sauvegarder pour analyse
    event_times_detected(k) = event_time_detected;
    errors(k) = erreur;

    % Affichage dans la console
    fprintf('SNR = %.2f dB : Détection à %.2f s (erreur %.2fs)\n', ...
        snr, event_time_detected, erreur);

    % Tracé des courbes de similarité
    subplot(length(snr_values), 1, k);
    plot(T_x(1:length(similarity)), similarity, 'b', 'LineWidth', 1.5);
    hold on;
    plot([event_time_detected event_time_detected], ylim, 'r--', 'LineWidth', 2);
    title(sprintf('Similarité pour SNR = %.0f dB', snr));
    xlabel('Temps (s)');
    ylabel('Similarité');
    grid on;
end

% Tracer l'erreur de détection en fonction du SNR
figure('Name', 'Erreur de détection vs SNR');
plot(snr_values, errors, '-o', 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Erreur temporelle (s)');
title('Erreur de détection en fonction du SNR');
grid on;

% Tracer les temps détectés
figure('Name', 'Temps détecté vs SNR');
plot(snr_values, event_times_detected, '-s', 'LineWidth', 2);
yline(event_time_reference, 'r--', 'LineWidth', 1.5, 'Label', 'Temps Référence');
xlabel('SNR (dB)');
ylabel('Temps détecté (s)');
title('Temps de détection de l’événement en fonction du SNR');
grid on;
