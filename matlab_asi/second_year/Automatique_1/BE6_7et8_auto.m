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
ieq = 7;
heq = K*ieq*ieq / m*g;
l1 = -R/L;
l2 = -2*ieq*K / m*heq;
l3 = K*ieq*ieq / heq*heq*m;
l4 = 1/L;

e = 1;
wn = 40;
p1 = 100;

%% Definition des matrices du espace d'�tat
A = [l1 0 0; 0 0 1; l2 l3 0];
B = [l4; 0; 0];
C = [0 1 0];

%% Conf�rence de la commandabilit�
Co = ctrb(A, B);
rCo = rank(Co)

if rCo == size(A, 1)
    disp('Commandable');
else
    disp('Pas commandable.');
end

%% D�couvrir F et G
poly1 = [1, p1];
poly2 = [1, 2*e*wn, wn^2];

result_poly = conv(poly1, poly2);
roots = roots(result_poly);

F = place(A,B,roots);
G = inv(-C*inv(A-B*F)*B);
%% R�ponse en fr�quence en boucle ferm�e
sysbf=ss(A-B*F,[B*G],C,0);
sysubf=ss(A-B*F,[B*G],-F,G); 

figure;
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

