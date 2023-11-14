%BE2 - PIFFER CHRISTO Guilherme
clear 
% Parameters
N = 256;            % Number of samples
f1 = 10;            % Frequency of s1 (Hz)
p1 = 16;
p2 = 15.5;
fs = (f1*N)/p1;
f2 = (p2*fs)/N;          % Frequency of s2 (Hz)
t = (0:N-1) / fs;   % Time vector

% Generate s1 and s2
s1 = 1 * sin(2 * pi * f1 * t);
s2 = 1 * sin(2 * pi * f2 * t);

% Plot s1
subplot(3, 1, 1);
plot(t, s1);
title('Sine Wave s1 with 16 Periods');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot s2
subplot(3, 1, 2);
plot(t, s2);
title('Sine Wave s2 with 15.5 Periods');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

load('SigTest.mat')
[frequencies, DFT_modulus] = myspectrum(s1, fs);

% Plot the modulus of the DFT
figure;
subplot(2, 1, 1);
plot(frequencies, DFT_modulus);
title('DFT Modulus');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Plot the phase of the DFT
subplot(2, 1, 2);
plot(frequencies, DFT_phase);
title('DFT Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
    
% Plot the modulus of the DFT zero padded
figure;
subplot(2, 1, 1);
plot(frequencies_zero_padded, DFT_modulus_zero_padded);
title('DFT Zero Padded Modulus');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Plot the phase of the DFT zero padded
subplot(2, 1, 2);
plot(frequencies_zero_padded, DFT_phase_zero_padded);
title('DFT Zero Padded Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');


function [frequencies, amplitude_spectrum] = myspectrum(signal, sampling_frequency)
    % Calculate the length of the input signal
    N = length(signal);
    
    % Define the factor by which you want to increase spectral resolution (e.g., 16x)
    P = 16;
    M = N * P; % New number of points after zero-paddin
    
    % Compute the FFT of the signal
    DFT = fftshift(fft(signal, M)) / N;

    % Compute the frequencies corresponding to the DFT components
    frequencies = (0:M-1) * (sampling_frequency / M);
    
    % Compute the modulus and phase of the DFT_zero_padded
    amplitude_spectrum = abs(DFT);
    
    % Ensure the frequencies cover the main spectral period
    frequencies = frequencies - sampling_frequency / 2;
end

