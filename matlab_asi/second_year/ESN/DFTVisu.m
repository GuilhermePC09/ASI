function [module, phi, spectre] = DFTVisu(signal,fe,Nfft)

fftsignal = fftshift(fft(signal,Nfft)) ;
module = abs(fftsignal)/length(signal) ;
phi = phase(fftsignal) ;

pas = (0:Nfft-1)/Nfft ;
spectre = pas*fe - fe/2 ;

end

