% Paramètres de la fenêtre
Fs = 44100; % Fréquence d'échantillonnage
window_length = 1024;
overlap = 512;
nfft = 1024;

% Charger les fichiers audio
[x, ~] = audioread('signal_principal.wav'); % Le signal avec votre voix
[xevent, ~] = audioread('event_aboiement.wav'); % Le signal de l'événement (aboiement)

% Convertir les signaux en mono (stéréo car enregistré par iphone)
if size(x, 2) == 2
    x = mean(x, 2); % Moyenne des deux canaux pour convertir en mono
end

if size(xevent, 2) == 2
    xevent = mean(xevent, 2); % Moyenne des deux canaux pour convertir en mono
end

% Calculer les spectrogrammes du signal original et de l'événement
[S_x, F_x, T_x] = spectrogram(x, window_length, overlap, nfft, Fs);
[S_xevent, F_xevent, T_xevent] = spectrogram(xevent, window_length, overlap, nfft, Fs);

% Utiliser l'amplitude des spectrogrammes (pas les valeurs complexes)
S_x = abs(S_x); % Magnitude du spectrogramme du signal principal
S_xevent = abs(S_xevent); % Magnitude du spectrogramme de l'événement

% Normalisation des spectrogrammes pour éviter les effets d'amplitude
S_x = S_x ./ max(S_x(:)); % Normalisation du spectrogramme du signal principal
S_xevent = S_xevent ./ max(S_xevent(:)); % Normalisation du spectrogramme de l'événement

% Liste des SNR à tester (en dB)
SNR_values = [5, 10, 15, 20, 25]; % SNR de 5 dB à 25 dB
event_times = zeros(size(SNR_values)); % Tableau pour stocker les temps de détection

% Tester pour chaque valeur de SNR
for snr_idx = 1:length(SNR_values)
    % Définir la puissance du bruit pour ce SNR
    SNR_dB = SNR_values(snr_idx); % SNR actuel
    signal_power = sum(abs(x).^2) / length(x); % Puissance du signal
    noise_power = signal_power / (10^(SNR_dB / 10)); % Calculer la puissance du bruit
    b = sqrt(noise_power) * randn(size(x)); % Générer un bruit blanc aléatoire
    xbruit = x + b; % Ajouter le bruit au signal

    % Calculer le spectrogramme du signal bruité
    [S_xbruit, F_xbruit, T_xbruit] = spectrogram(xbruit, window_length, overlap, nfft, Fs);

    % Utiliser l'amplitude du spectrogramme bruité
    S_xbruit = abs(S_xbruit); % Magnitude du spectrogramme du signal bruité

    % Initialisation du vecteur de similarité pour le signal bruité
    similarity_bruit = zeros(1, length(T_xbruit) - length(T_xevent)); % Vecteur pour stocker la similarité entre l'événement et chaque segment du signal bruité

    % Calcul de la similarité entre le spectrogramme bruité et l'événement
    for i = 1:length(similarity_bruit)
        % Extraire une fenêtre du spectrogramme du signal bruité de la même taille que l'événement
        segment_bruit = S_xbruit(:, i:i+length(T_xevent)-1); % Segment correspondant à la taille de l'événement
        
        % Calculer la similarité en utilisant la corrélation croisée normalisée
        similarity_bruit(i) = sum(sum(segment_bruit .* S_xevent)) / (norm(segment_bruit(:)) * norm(S_xevent(:))); % Produit scalaire normalisé
    end

    % Trouver l'indice du pic de similarité dans le signal bruité
    [~, idx_bruit] = max(similarity_bruit); % Trouver l'indice avec la similarité maximale

    % Convertir l'indice en temps pour localiser l'événement dans le signal bruité
    event_time_bruit = T_xbruit(idx_bruit); % Temps de l'événement détecté dans le signal bruité
    event_times(snr_idx) = event_time_bruit; % Stocker le temps de l'événement

    % Affichage des résultats
    fprintf('SNR = %.2f dB : L aboiement du chien est détecté à %.2f secondes dans le signal bruité.\n', SNR_dB, event_time_bruit);
end

% Plot des résultats : comparaison des temps de détection en fonction du SNR
figure;
plot(SNR_values, event_times, 'o-', 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Temps de détection (s)');
title('Performance de la détection en fonction de la puissance du bruit');
grid on;
