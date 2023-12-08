%% BE Synthèse - PIFFER CHRISTO Guilherme
close all
clear

%% Coefficients relatifs du sys
sigma0 = 1;
sigma1 = 100;
alpha1 = 1;
alpha2 = 100;

%% Modélisation du système
% 1.1
A = [-alpha1 0; alpha1 -alpha2];
B = [sigma0; 0];
C = eye(2);
D = zeros(2, 2);
E = [0; alpha2];

sys = ss(A, [B E], C, D);

P = pole(sys);

Co = ctrb(sys);
rCo = rank(Co);
if rCo == size(A, 1)
    disp('Commandable');
else
    disp('Pas commandable.');
end

O = obsv(sys);
rO = rank(O);
if rO == size(A, 1)
    disp('Observable');
else
    disp('Pas observable');
end

%1.2 Avec graph tool

%1.3
C = [0 1];
s = tf('s');
Gs = C * inv(s * eye(size(A)) - A)*B

%1.4 Question écrit

%1.5
num = 1;
den = [1 1 0];
Gss = tf(num, den);

Te = 0.3;
Gz = c2d(Gss, Te);

%1.7
sys_disc = c2d(sys, Te, 'zoh')
%% Synthèse d'un correcteur numérique RST

