% Entrées
X = spectrogramme_du_signal;     % Signal complet
Xref = spectrogramme_template;   % Template à rechercher

% Normalisation
X = X / max(abs(X(:)));
Xref = Xref / max(abs(Xref(:)));

% Corrélation croisée
corr = normxcorr2(Xref, X);     

% Localisation de la correspondance
[~, idx] = max(corr(:));        
[row, col] = ind2sub(size(corr), idx); 
