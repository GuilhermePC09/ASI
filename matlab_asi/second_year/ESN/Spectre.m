
function [Modp,Fp] = Spectre(S,fe,r) %Fonction permettant de calculer le spectre d'un signal quelconque sur les fréquences positives

N=length(S);
Nfft=N*r;
%TFD = fftshift(fft(S,Nfft)); % Permet de retourner le spectre
TFD = fft(S,Nfft);
Mod = abs(TFD)/Nfft;  % Donne le module de la TFD rebalancée
i = 0:Nfft-1;
F = i/Nfft * fe;

Modp=Mod(1:Nfft/2+1);
Fp=F(1:Nfft/2+1);
end