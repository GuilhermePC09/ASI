function [s,f]=permoy(sig,fen,dec,Nfft,fe,norm)
% P�riodogramme moyenn� pour les signaux � valeurs r�elles
% estime la densit� spectrale ou le spectre de puissance du signal
%
% [s,f]=permoy(sig,fen,dec,Nfft,fe,norm);
%
% Entr�es
% sig : �chantillons du signal � analyser
% fen : fen�tre de pond�ration appliqu�e � chaque bloc,
%       sa longueur fixant la taille N des blocs
% dec : d�calage entre deux blocs cons�cutifs (min=0%, max=100%)
% Nfft: taille de la TFD
%       zero-padding si Nfft>N
% fe  : valeur de la fr�quence d'�chantillonnage en Hertz
% norm: facteur de normalisation
%  norm = 'DSP' -> densit� spectrale de puissance en unit�s�/Hz (d�faut)
%  norm = 'SP'  -> spectre de puissance en unit�s�
%
% Sorties
% s : grandeur spectrale estim�e
% f : vecteur fr�quence en Hertz

%% Initialisations
fen=fen(:)';
sig=sig(:)'; %vecteurs colonne
N=length(fen); %taille N des blocs
dec=round(dec/100*N); %d�calage en �chantillons
nn=1:N; %init temps 1er bloc
cptb=0; %init compteur de blocs
sacc=zeros(1,Nfft); %init accumulation spectres

%% Boucle
% tant que fin du bloc courant <= fin du signal
while (nn(end)<=length(sig))
    %fen�trage bloc courant
    sigf=sig(nn).*fen;
    %TFD bloc fen�tr� avec zero-padding �ventuel
    TFD=fft(sigf,Nfft);
    %module carr� TFD bloc fen�tr�
    modTFD2=TFD.*conj(TFD);
    %accumulation
    sacc=sacc+modTFD2;
    %r�actualisation temps fen�tre et nombre de blocs
    nn=nn+dec;
    cptb=cptb+1;
end;

%% Normalisation (d�faut = DSP)
FacteurNorm=1/(fen*(fen.'));
if strcmp(norm,'SP')
    FacteurNorm=1/(sum(fen)^2);
end;
s=sacc/cptb*FacteurNorm;

%% S�lection plage fr�quentielle positive
fr=((0:Nfft-1)/Nfft); %vecteur fr�quence r�duite;
f=fr*fe; %vecteur fr�quence r�elle;
f=f(1:round(Nfft/2));
s=2*s(1:round(Nfft/2));
