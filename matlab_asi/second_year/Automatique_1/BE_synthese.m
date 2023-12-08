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
A = [-alpha1 0; alpha1 -alpha2];
B = [sigma0; 0];
C = eye(2);
D = zeros(2, 2);
E = [0; alpha2];

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
C = [0 1];
s = tf('s');
Gs = C * inv(s * eye(size(A)) - A)*B;

disp(Gs)
%1.4 Question ecrit

%1.5
num = 1;
den = [1 1 0];
Gss = tf(num, den);

Te = 0.3;
Gz = c2d(Gss, Te);

disp(Gz);

%1.7
sys_disc = c2d(sys, Te, 'zoh');

disp(sys_disc)
%% Synthese d'un correcteur numerique RST
% 2.1
% Param�tres du syst�me
tr = 5; % temps de r�ponse � 5%
D = 25; % d�passement en pourcentage
Te = 0.3; % p�riode d'�chantillonnage

% Calcul des caract�ristiques fr�quentielles du syst�me
zeta = -log(D/100) / sqrt(pi^2 + (log(D/100))^2); % coefficient d'amortissement
wd = 2 * pi / tr; % pulsation naturelle non amortie
wn = wd / sqrt(1 - zeta^2); % fr�quence naturelle

% Coeficientes do pc en boucle ferm�e
coeffs_pc = [1 2*zeta*wn wn^2];

% C�lculo des poles en boucle ferm�e
poles_cont = roots(coeffs_pc);

% Calcul des p�les d�sir�s discrets en boucle ferm�e
poles_disc = exp(poles_cont * Te);

% Calcul du polyn�me d�sir� discret en boucle ferm�e
coeffs_pd = poly(poles_disc);

%2.2
Pdes = [coeffs_pd(1) coeffs_pd(2) coeffs_pd(3) 0 0];

k = 1;
Tau = 1;

b1 = k*(Te-Tau+Tau*exp(-Te/Tau));
b2 = k*(Tau - exp(-Te/Tau)*(Tau+Te));
a1 = -1-exp(-Te/Tau);
a2 = exp(-Te/Tau);

% R�solution manuelle de l'�quation de Bezout
ap1=a1-1;
ap2=a2-a1;
ap3=-a2;

x=inv([1 0 0 0 0; ap1 1 b1 0 0; ap2 ap1 b2 b1 0;ap3 ap2 0 b2 b1;...
   0 ap3 0 0 b2])*Pdes';
% param�tres du correcteur
sp1=x(2); % il s'agit de s'1 du cours.
r0=x(3);
r1=x(4);
r2=x(5);

R = [r0 r1 r2];
S = [1 (sp1-1) -sp1];

%2.3 - Simulink
T=polyval(R,1);

%% Commande par retour d etat

F = place(A,B, poles_cont);
G = inv(-C*inv(A-B*F)*B);

% R�ponse en fr�quence en boucle ferm�e
sysbf=ss(A-B*F,[B*G],C,0);
sysubf=ss(A-B*F,[B*G],-F,G); 

figure(1);
bode(sysbf);
title('R�ponse en Fr�quence en Boucle Ferm�e');

% Mesure de la fr�quence de coupure
[mag, phase, wout] = bode(sysbf);
[~, index_wc] = min(abs(mag - 1/sqrt(2)));
wc = wout(index_wc);

disp(['Fr�quence de Coupure (wc) : ', num2str(wc), ' rad/s']);

% V�rification du temps de mont�e
trise_spec = 2.3/wc;
trise_info = stepinfo(sysbf);
trise_actuel = trise_info.RiseTime;

disp(['Temps de Mont�e Sp�cifi� (trise) : ', num2str(trise_spec), ' s']);
disp(['Temps de Mont�e Actuel (trise) : ', num2str(trise_actuel), ' s']);

if trise_actuel <= trise_spec
    disp('Le temps de mont�e est conforme aux sp�cifications.');
else
    disp('Le temps de mont�e PAS conforme aux sp�cifications.');
end

L = place(A',C',poles_cont)';

Ao = (A - L*C);
Bo = [B L];
Co = eye(3);
Do = zeros(3, 2);

Ae = [A zeros(2,1); -C 0];
Be = [B; 0];
Ce = [C 0];

r = [poles_cont(1), poles_cont(2), -1];

Fe = acker(Ae, Be, r);
F = [Fe(1) Fe(2)];
G = [Fe(3)];