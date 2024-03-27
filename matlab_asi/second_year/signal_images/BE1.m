%Be_1 - Guilherme PIFFER CHRISTO
close all;
clear all;
clc;

%% IV. An�lise Espectral do Sinal de Corrente Estat�rica

load('signalcrt.mat');

figure;
plot(crt);
xlabel('N�mero de Amostras');
ylabel('Corrente Estat�rica (A)');
title('Sinal de Corrente Estat�rica');

N = 1024;

padding = 4;

[s,f] = permoy(crt, boxcar(N), 100, N, fe, 'SP');

figure;
plot(f, 10*log10(s));
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Espectro de Pot�ncia da Corrente Estat�rica');

% IV.2 
N = round(fe / 30); 

[s,f] = permoy(crt, boxcar(N), 100, N, fe, 'SP');

figure;
plot(f, 10*log10(s));
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Espectro de Pot�ncia da Corrente Estat�rica (Ajuste de N)');

% IV.3
N = round(4 *fe / 30); 

[s_with_padding, f_with_padding] = permoy(crt, boxcar(N), 100, padding*N, fe, 'SP');

figure;
plot(f, 10*log10(s), 'b', f_with_padding, 10*log10(s_with_padding), 'r');
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Compara��o do Espectro de Pot�ncia com e sem Zero-Padding');
legend('Sem Zero-Padding', 'Com Zero-Padding');

% IV.4 
[s_hanning, f_hanning] = permoy(crt, hanning(N), 100, padding*N, fe, 'SP');
[s_blackman, f_blackman] = permoy(crt, blackman(N), 100, padding*N, fe, 'SP');

s_hanning_interp = interp1(f_hanning, s_hanning, f, 'linear', 'extrap');
s_blackman_interp = interp1(f_blackman, s_blackman, f, 'linear', 'extrap');

figure;
plot(f, 10*log10(s), 'b', f, 10*log10(s_hanning_interp), 'g', f, 10*log10(s_blackman_interp), 'r');
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Compara��o dos Espectros com Diferentes Janelas de Pondera��o');
legend('Retangular', 'Hanning', 'Blackman');

%%

load('signalvib.mat');

figure;
plot(vib);
xlabel('N�mero de Amostras');
ylabel('Corrente Estat�rica (A)');
title('Sinal de Corrente Estat�rica');

N = 1024;

padding = 2;

[s,f] = permoy(vib, boxcar(N), 100, N, fe, 'SP');

figure;
plot(f, 10*log10(s));
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Espectro de Pot�ncia da Corrente Estat�rica');

% IV.2 
N = round(fe / 30); 

[s,f] = permoy(vib, boxcar(N), 100, N, fe, 'SP');

figure;
plot(f, 10*log10(s));
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Espectro de Pot�ncia da Corrente Estat�rica (Ajuste de N)');

% IV.3
N = round(4 *fe / 30); 

[s_with_padding, f_with_padding] = permoy(vib, boxcar(N), 100, padding*N, fe, 'SP');

figure;
plot(f, 10*log10(s), 'b', f_with_padding, 10*log10(s_with_padding), 'r');
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Compara��o do Espectro de Pot�ncia com e sem Zero-Padding');
legend('Sem Zero-Padding', 'Com Zero-Padding');

% IV.4 
[s_hanning, f_hanning] = permoy(vib, hanning(N), 100, padding*N, fe, 'SP');
[s_blackman, f_blackman] = permoy(vib, blackman(N), 100, padding*N, fe, 'SP');

s_hanning_interp = interp1(f_hanning, s_hanning, f, 'linear', 'extrap');
s_blackman_interp = interp1(f_blackman, s_blackman, f, 'linear', 'extrap');

figure;
plot(f, 10*log10(s), 'b', f, 10*log10(s_hanning_interp), 'g', f, 10*log10(s_blackman_interp), 'r');
xlabel('Frequ�ncia (Hz)');
ylabel('Espectro de Pot�ncia (dB)');
title('Compara��o dos Espectros com Diferentes Janelas de Pondera��o');
legend('Retangular', 'Hanning', 'Blackman');
