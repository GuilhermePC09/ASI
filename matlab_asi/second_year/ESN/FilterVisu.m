function [Module,Phase,Freq] = FilterVisu(b,a,w,fe) % trace les p�les et z�ros dans le plan complexe ainsi que l'allure du module de la r�ponse fr�quentielle d'un signal quelconque
[h,Freq]=freqz(b,a,w,fe);
Module = abs(h);  % Donne le module de la r�ponse fr�quentielle
Phase = angle(h); % Donne la phase de la r�ponse fr�quentielle

subplot(3,1,1)
zplane(b,a);
title('Position des p�les et des z�ros dans le plan complexe');
subplot(3,1,2)
plot(Freq,Module)
title('Module de la r�ponse fr�quentielle')
subplot(3,1,3)
plot(Freq,Phase)
title('Phase de la r�ponse fr�quentielle')

end

