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

% Calculer les spectrogrammes
[S_x, F_x, T_x] = spectrogram(x, window_length, overlap, nfft, Fs);
[S_xevent, F_xevent, T_xevent] = spectrogram(xevent, window_length, overlap, nfft, Fs);

% Initialisation du vecteur de similarité
similarity = zeros(1, length(T_x) - length(T_xevent)); % Vecteur pour stocker la similarité entre l'événement et chaque segment du signal

for i = 1:length(similarity)
    % Extraire une fenêtre du spectrogramme du signal principal de la même taille que l'événement
    segment = S_x(:, i:i+length(T_xevent)-1); % Segment correspondant à la taille de l'événement
    
    % Calculer la similarité (produit scalaire) entre ce segment et le spectrogramme de l'événement
    similarity(i) = sum(sum(abs(segment) .* abs(S_xevent))); % Multiplication élément par élément
end

% Trouver l'indice du pic de similarité
[~, idx] = max(similarity); % Trouver l'indice avec la similarité maximale

% Convertir l'indice en temps pour localiser l'événement
event_time = T_x(idx); % Temps de l'événement détecté
fprintf('L aboiement du chien est détecté à %.2f secondes.\n', event_time);

% Affichage du spectrogramme du signal principal
figure;
subplot(3, 1, 1);
imagesc(T_x, F_x, 10*log10(abs(S_x).^2)); % Spectrogramme du signal principal
axis xy;
colormap('jet');
colorbar;
title('Spectrogramme du signal principal');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');

% Affichage du spectrogramme de l'événement
subplot(3, 1, 2);
imagesc(T_xevent, F_xevent, 10*log10(abs(S_xevent).^2)); % Spectrogramme de l'événement
axis xy;
colormap('jet');
colorbar;
title('Spectrogramme de l événement (aboiement)');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');

% Afficher la similarité dans le temps
subplot(3, 1, 3);
time_similarity = T_x(1:length(similarity)); % Ajuster la taille de T_x pour correspondre à la similarité
plot(time_similarity, similarity, 'LineWidth', 2); % Tracer la similarité par rapport au temps
xlabel('Temps (s)');
ylabel('Similarité');
title('Similarité entre le signal principal et l événement');
grid on;

% Ajouter une ligne verticale au moment où l'événement est détecté
hold on;
plot([event_time event_time], ylim, 'r--', 'LineWidth', 2); % Lieu de l'événement
hold off;
