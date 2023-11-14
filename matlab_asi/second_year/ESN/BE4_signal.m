%BE4 - PIFFER CHRISTO Guilherme
%% Importing data from .csv
filename = 'power_cons_20160101_20181231.csv';
opts = detectImportOptions(filename);
data = readtable(filename, opts);

%% Config
%Extracting Data
consumption = data{:, 4};

Ts = 1/48;
t = (0:(length(consumption)-1))*Ts;

%% Plot Consumption
% Plot consuption
figure;
plot(t, consumption);
title('Consumption of Energy');
xlabel('Time');
ylabel('Consumption (MW)');
grid on;

%% Spectral analysis
[frequencies, amplitude_spectrum_positive] =  myspectrum(consumption-mean(consumption), 1/Ts);

% Plot the modulus of the DFT
figure;
plot(frequencies, amplitude_spectrum_positive);
title('Spectral Analysis');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%% Digital filtering(Incomp)

% annual
annual_cutoff_frequency = 1 / 365;
frequencies = [0, annual_cutoff_frequency/2];

% Estabeleça as especificações para o filtro
ripple = 0.01; % Ripple na banda passante
attenuation = 40; % Atenuação na banda de rejeição

[n, fo, ao, w] = firpmord(frequencies, [1, 0], [ripple, attenuation], 1/Ts);
annual_filter = firpm(abs(n), fo, ao, w);

% Aplicando o filtro para isolar o ciclo anual
annual_filtered_data = filter(annual_filter, 1, consumption);

% weekly
weekly_cutoff_frequency = 1 / 7; % Frequência de corte semanal (1 semana = 7 dias)
frequencies = [0, weekly_cutoff_frequency/2];

[n, fo, ao, w] = firpmord(frequencies, [1, 0], [ripple, attenuation], 1/Ts);
weekly_filter = firpm(abs(n), fo, ao, w);

% Aplicando o filtro para isolar o ciclo semanal
weekly_filtered_data = filter(weekly_filter, 1, consumption);

% daily
daily_cutoff_frequency = 1; % Frequência de corte diária (1 dia = 24 horas)
frequencies = [0, daily_cutoff_frequency/2];


[n, fo, ao, w] = firpmord(frequencies, [1, 0], [ripple, attenuation], 1/Ts);
daily_filter = firpm(abs(n), fo, ao, w);

% Aplicando o filtro para isolar o ciclo diário

% Plot do sinal filtrado
subplot(3, 1, 1);
plot(annual_filtered_data);
title('Annual Cycle Isolation');
xlabel('Time (years)');
ylabel('Filtered Power Consumption');
grid on;

subplot(3, 1, 2);
plot(weekly_filtered_data);
title('Weekly Cycle Isolation');
xlabel('Time (weeks)');
ylabel('Filtered Power Consumption');
grid on;

subplot(3, 1, 3);
plot(daily_filtered_data);
title('Daily Cycle Isolation');
xlabel('Time (days)');
ylabel('Filtered Power Consumption');
grid on;

%% Auxiliary Functions
function [frequencies, amplitude_spectrum_positive] = myspectrum(signal, sampling_frequency)
    % Calculate the length of the input signal
    N = length(signal);
    
    % Define the factor by which you want to increase spectral resolution (e.g., 16x)
    P = 2;
    M = N * P; % New number of points after zero-paddin
    
    % Compute the FFT of the signal
    DFT = fftshift(fft(signal, M)) / N;

    % Compute the frequencies corresponding to the DFT components
    frequencies = (0:M-1) * (sampling_frequency / M);
    
    % Compute the modulus and phase of the DFT_zero_padded
    amplitude_spectrum = abs(DFT);
    
    % Only positive frequencies
    amplitude_spectrum_positive = amplitude_spectrum(M/2+1:end);
    frequencies = frequencies(1:M/2);
end
