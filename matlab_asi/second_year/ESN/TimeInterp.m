function [si]=TimeInterp(s,r)
%fonction r�alisant l'interpolation du signal 's' par TFD.
%Apr�s interpolation, le signal interpol� si sera de longueur r x N.
%
% Entr�es :
%  - s : signal � interpoler de longueur N
%  - r : facteur d'interpolation
%
% Sortie :
%  - si : signal interpol� de longueur N x r

N=length(s); %taille signal original
TFD=fft(s); %spectre signal original
ZPTFD=[TFD(1:N/2) zeros(1,(r-1)*N) TFD(N/2+1:N)]; %ajout de z�ros
si=real(ifft(ZPTFD)*r); %retour en temps
