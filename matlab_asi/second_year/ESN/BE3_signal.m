%BE3 - Filtrage
clear
%% Transfer functions coef definition

B1 = [1 0 0];
A1 = [1 -0.4 0.6];

B2 = [1 0 1];
A2 = [1 0 0.81];

B3 = [1 1 1];
A3 = [1 0 0];
%% Tf analyse zeros, poles, module et phase

[modulus1, phase1, frequencies1] = FilterVisu(B1, A1, 8192);
[modulus2, phase2, frequencies2] = FilterVisu(B2, A2, 8192);
[modulus3, phase3, frequencies3] = FilterVisu(B3, A3, 8192);
%% Elementary FIR filter design: the window method

% Define parameters
fo = 150;    
fs = 1280; 
N = 101;     
N1 = 9;      
N2 = 51;    

% Calculate ideal impulse response
n = -(N - 1) / 2 : (N - 1) / 2;
hi = 2 * fo / fs * sinc(2 * fo / fs * n);

% Calculate rectangular windows
w1 = ones(1, N1);
w2 = ones(1, N2);

% Calculate causal filters
N1 = 9;
n1 = -(N1 - 1) / 2 : (N1 - 1) / 2;
h1 = 2 * fo / fs * sinc(2 * fo / fs * n1);

N2 = 51;
n2 = -(N2 - 1) / 2 : (N2 - 1) / 2;
h2 = 2 * fo / fs * sinc(2 * fo / fs * n2);

wh = hann(N2)';
h2wh = h2.*wh;

wb = blackman(N2)';
h2wb = h2.*wb;

% Plot impulse responses
subplot(5,1,1);
stem(n, hi);
title('Ideal Impulse Response (hi[n])');

subplot(5,1,2);
stem(n1, h1);
title('Causal Filter h1[n]');

subplot(5,1,3);
stem(n2, h2);
title('Causal Filter h2[n]');

subplot(5,1,4);
stem(n2, h2wh);
title('Causal Filter h2wh[n]');
subplot(5,1,5);
stem(n2, h2wb);
title('Causal Filter h2wb[n]');

[modulus_pm_h1, phase_pm_h1, frequencies_pm_h1] = FilterVisu(h1, 1, 8192);
[modulus_pm_h2, phase_pm_h2, frequencies_pm_h2] = FilterVisu(h2, 1, 8192);
[modulus_pm_h2wh, phase_pm_h2wh, frequencies_pm_h2wh] = FilterVisu(h2wh, 1, 8192);
[modulus_pm_h2wb, phase_pm_h2wb, frequencies_pm_h2wb] = FilterVisu(h2wb, 1, 8192);

%% FIR filter design: comparison of methods

% Define parameters
fo1 = 150;
fo2 = 300;
transf = 20;
stopband = 0.01;
fs = 1280;

% Design filter using the window method (fir1)
filter_window = fir1(48, [fo1 fo2] / (fs / 2));
[modulus_window, phase_window, frequencies_window] = FilterVisu(filter_window, 1, 8192);

% Design filter using the Parks-McClellan method (firpmord)

[n,fo,ao,w] = firpmord([150 300],[1 0],[1 stopband],fs);
filter_pm = firpm(n,fo,ao,w);
[modulus_pm, phase_pm, frequencies_pm] = FilterVisu(filter_pm, 1, 8192);
%% IIR filter design
% Specifications
d = 2;                  % Filter order
fo = 150;               % Cutoff frequency in Hz
fs = 1280;              % Sampling frequency in Hz

% Calculate the analog prototype Butterworth filter
n = d;% Order of the Butterworth filter
[num, den] = butter(n, 2 * fo / fs);
H = tf(num, den);


% Calculate the bilinear transform
% T = 1/fs;
% [num_z, den_z] = bilinear(num, den, fs);
% 
% Hz = tf(num, den, 1/fs);

% Plot filters
[modulus_window_iirs, phase_window_irrs, frequencies_window_irrs] = FilterVisu(num, den, 8192);
% [modulus_window_iirz, phase_window_irrz, frequencies_window_irrz] = FilterVisu(num_z, den_z, 8192);



