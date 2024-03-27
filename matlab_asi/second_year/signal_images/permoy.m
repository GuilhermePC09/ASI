function [s,f]=permoy(sig,fen,dec,Nfft,fe,norm)
% Périodogramme moyenné pour les signaux à valeurs réelles
% estime la densité spectrale ou le spectre de puissance du signal
%
% [s,f]=permoy(sig,fen,dec,Nfft,fe,norm);
%
% Entrées
% sig : échantillons du signal à analyser
% fen : fenêtre de pondération appliquée à chaque bloc,
%       sa longueur fixant la taille N des blocs
% dec : décalage entre deux blocs consécutifs (min=0%, max=100%)
% Nfft: taille de la TFD
%       zero-padding si Nfft>N
% fe  : valeur de la fréquence d'échantillonnage en Hertz
% norm: facteur de normalisation
%  norm = 'DSP' -> densité spectrale de puissance en unités²/Hz (défaut)
%  norm = 'SP'  -> spectre de puissance en unités²
%
% Sorties
% s : grandeur spectrale estimée
% f : vecteur fréquence en Hertz

%% Initialisations
fen=fen(:)';
sig=sig(:)'; %vecteurs colonne
N=length(fen); %taille N des blocs
dec=round(dec/100*N); %décalage en échantillons
nn=1:N; %init temps 1er bloc
cptb=0; %init compteur de blocs
sacc=zeros(1,Nfft); %init accumulation spectres

%% Boucle
% tant que fin du bloc courant <= fin du signal
while (nn(end)<=length(sig))
    %fenêtrage bloc courant
    sigf=sig(nn).*fen;
    %TFD bloc fenêtré avec zero-padding éventuel
    TFD=fft(sigf,Nfft);
    %module carré TFD bloc fenêtré
    modTFD2=TFD.*conj(TFD);
    %accumulation
    sacc=sacc+modTFD2;
    %réactualisation temps fenêtre et nombre de blocs
    nn=nn+dec;
    cptb=cptb+1;
end;

%% Normalisation (défaut = DSP)
FacteurNorm=1/(fen*(fen.'));
if strcmp(norm,'SP')
    FacteurNorm=1/(sum(fen)^2);
end;
s=sacc/cptb*FacteurNorm;

%% Sélection plage fréquentielle positive
fr=((0:Nfft-1)/Nfft); %vecteur fréquence réduite;
f=fr*fe; %vecteur fréquence réelle;
f=f(1:round(Nfft/2));
s=2*s(1:round(Nfft/2));
