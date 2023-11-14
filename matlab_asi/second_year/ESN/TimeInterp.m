function [si]=TimeInterp(s,r)
%fonction réalisant l'interpolation du signal 's' par TFD.
%Après interpolation, le signal interpolé si sera de longueur r x N.
%
% Entrées :
%  - s : signal à interpoler de longueur N
%  - r : facteur d'interpolation
%
% Sortie :
%  - si : signal interpolé de longueur N x r

N=length(s); %taille signal original
TFD=fft(s); %spectre signal original
ZPTFD=[TFD(1:N/2) zeros(1,(r-1)*N) TFD(N/2+1:N)]; %ajout de zéros
si=real(ifft(ZPTFD)*r); %retour en temps
