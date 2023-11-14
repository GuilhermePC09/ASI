function [Module,Phase,Freq] = FilterVisu(b,a,w,fe) % trace les pôles et zéros dans le plan complexe ainsi que l'allure du module de la réponse fréquentielle d'un signal quelconque
[h,Freq]=freqz(b,a,w,fe);
Module = abs(h);  % Donne le module de la réponse fréquentielle
Phase = angle(h); % Donne la phase de la réponse fréquentielle

subplot(3,1,1)
zplane(b,a);
title('Position des pôles et des zéros dans le plan complexe');
subplot(3,1,2)
plot(Freq,Module)
title('Module de la réponse fréquentielle')
subplot(3,1,3)
plot(Freq,Phase)
title('Phase de la réponse fréquentielle')

end

