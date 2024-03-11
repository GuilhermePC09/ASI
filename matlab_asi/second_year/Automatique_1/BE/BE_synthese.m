%% BE Synthese - PIFFER CHRISTO Guilherme
close all
clear

%% Coefficients relatifs du sys
sigma0 = 1;
sigma1 = 100;
alpha1 = 1;
alpha2 = 100;

%% Modelisation du systeme
% 1.1
A = [-alpha1 0 0;alpha1 -alpha2 0; 0 1 0];
B = [sigma0; 0; 0];
C = eye(3);
D = zeros(3, 2);
E = [0; alpha2; 0];

sys = ss(A, [B E], C, D);

P = pole(sys);
disp(P);

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
C = [0 0 1];
s = tf('s');
Gs = C * inv(s * eye(size(A)) - A)*B;

%1.4 Question ecrit

%1.5
num = 1;
den = [1 1 0];
Gss = tf(num, den);

Te = 0.3;
Gz = c2d(Gs, Te)

%1.7
sys_disc = c2d(sys, Te, 'zoh');

disp(sys_disc);
%% Synthese d'un correcteur numerique RST
% 2.1
% Paramètres du système
tr = 5; % temps de réponse à 5%
D = 25; % dépassement en pourcentage
Te = 0.3; % période d'échantillonnage

% Calcul des caractéristiques fréquentielles du système
zeta = -log(D/100) / sqrt(pi^2 + (log(D/100))^2); % coefficient d'amortissement
wd = 2 * pi / tr; % pulsation naturelle non amortie
wn = wd / sqrt(1 - zeta^2); % fréquence naturelle

% Coeficientes do pc en boucle fermée
coeffs_pc = [1 2*zeta*wn wn^2];

% Cálculo des poles en boucle fermée
poles_cont = roots(coeffs_pc);

% Calcul des pôles désirés discrets en boucle fermée
poles_disc = exp(poles_cont * Te);

% Calcul du polynôme désiré discret en boucle fermée
coeffs_pd = poly(poles_disc);

%2.2
Pdes = [coeffs_pd(1) coeffs_pd(2) coeffs_pd(3) 0 0];

k = 1;
Tau = 1;

b1 = k*(Te-Tau+Tau*exp(-Te/Tau));
b2 = k*(Tau - exp(-Te/Tau)*(Tau+Te));
a1 = -1-exp(-Te/Tau);
a2 = exp(-Te/Tau);

% Résolution manuelle de l'équation de Bezout
ap1=a1-1;
ap2=a2-a1;
ap3=-a2;

x=inv([1 0 0 0 0; ap1 1 b1 0 0; ap2 ap1 b2 b1 0;ap3 ap2 0 b2 b1;...
   0 ap3 0 0 b2])*Pdes';
% paramètres du correcteur
sp1=x(2); % il s'agit de s'1 du cours.
r0=x(3);
r1=x(4);
r2=x(5);

R = [r0 r1 r2]
S = [1 (sp1-1) -sp1]

%2.3 - Simulink
T=polyval(R,1)

%% Commande par retour d etat

p = [poles_cont(1), poles_cont(2), -0.5];
F = place(A,B, p);
G = inv(-C*inv(A-B*F)*B);

L = place(A',C',p)'

Ao = (A - L*C);
Bo = [B  L];
Co = eye(3);
Do = zeros(3, 2);

Ae = [A zeros(3,1); -C 0];
Be = [B;0];
Ce = [C 0];

p = [poles_cont(1), poles_cont(2), -0.5, -0.5];
Fe = acker(Ae, Be, p);
F = [Fe(1) Fe(2) Fe(3)]
G = [Fe(4)]