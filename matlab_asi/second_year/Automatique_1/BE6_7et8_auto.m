%% BE 6,7 et 8 
% PIFFER CHRISTO Guilherme

close all
clear
%% Definition des param�tres
m = 0.05;
g = 9.81;
L = 0.01;
R = 1;
K = 0.0001;
ieq = 5;
heq = 0.01;

a1 = -R/L;
a2 = -(2*ieq*K) / (m*heq);
a3 = (K*ieq^2) / (heq^2*m);
b1 = 1/L;

e = 0.5;
wn = 20;
p1 = 50;

%% Definition des matrices du espace d'�tat
A = [a1 0 0; 0 0 1; a2 a3 0];
B = [b1; 0; 0];
C = [0 1 0];

%% Conf�rence de la commandabilit�
Co = ctrb(A, B);
rCo = rank(Co);

if rCo == size(A, 1)
    disp('Commandable');
else
    disp('Pas commandable.');
end

%% D�couvrir F et G
poly1 = [1, p1];
poly2 = [1, 2*e*wn, wn^2];

result_poly = conv(poly1, poly2);
rts = roots(result_poly);

F = place(A,B,rts);
G = inv(-C*inv(A-B*F)*B);
%% R�ponse en fr�quence en boucle ferm�e
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

%% Observateur

L = place(A',C',rts)'; % rts = roots

Ao = (A - L*C);
Bo = [B L];
Co = eye(3);
Do = zeros(3, 2);
%% Integrateur

Ae = [A zeros(3,1); -C 0];
Be = [B; 0];
Ce = [C 0];
wn = 25;
e = 10/wn;

poly3 = [1, 2.1*wn, 3.4*wn^2, 2.7*wn^3, wn^4];
r = roots(poly3);

Fe = acker(Ae, Be, r);
F = [Fe(1) Fe(2) Fe(3)];
G = [Fe(4)];
% 
% Ai = [A-L*C-B*F B*G; 0 0];
% B1 = [0 0 1]';
% B2 = [L(1)' -1]';
% Fi = [F -G];

s = tf('s');
Gs = C * inv(s * eye(size(A)) - A)*B;
Kr_s = Gs - F * inv(s * eye(size(A)) - (A - B*F + L*C)) * B * Gs;
Ky_s = F * inv(s * eye(size(A)) - (A - B*F + L*C)) * L;
% Kr_s = -Fe * inv(s * eye(size(Ai)) - Ai)*B1

S = 1 / 1 + Gs*Ky_s*Kr_s;
T = Gs*Ky_s*Kr_s / 1 + Gs*Ky_s*Kr_s;
SG = S*G;
KS = S*Ky_s*Kr_s;

figure(2);

subplot(2, 2, 1);
bode(S); 
title('S');

subplot(2, 2, 2);
bode(T);
title('T');

subplot(2, 2, 3);
bode(SG);
title('SG');

subplot(2, 2, 4);
bode(KS);
title('KS');





