%% BE 6,7 et 8 
% PIFFER CHRISTO Guilherme

close all
clear
%% Definition des paramètres
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

%% Definition des matrices du espace d'état
A = [l1 0 0; 0 0 1; l2 l3 0];
B = [l4; 0; 0];
C = [0 1 0];

%% Conférence de la commandabilité
Co = ctrb(A, B);
rCo = rank(Co)

if rCo == size(A, 1)
    disp('Commandable');
else
    disp('Pas commandable.');
end

%% Découvrir F et G
poly1 = [1, p1];
poly2 = [1, 2*e*wn, wn^2];

result_poly = conv(poly1, poly2);
roots = roots(result_poly);

F = place(A,B,roots);
G = inv(-C*inv(A-B*F)*B);
%% Réponse en fréquence en boucle fermée
sysbf=ss(A-B*F,[B*G],C,0);
sysubf=ss(A-B*F,[B*G],-F,G); 

figure;
bode(sysbf);
title('Réponse en Fréquence en Boucle Fermée');

% Mesure de la fréquence de coupure
[mag, phase, wout] = bode(sysbf);
[~, index_wc] = min(abs(mag - 1/sqrt(2)));
wc = wout(index_wc);

disp(['Fréquence de Coupure (wc) : ', num2str(wc), ' rad/s']);

% Vérification du temps de montée
trise_spec = 2.3/wc;
trise_info = stepinfo(sysbf);
trise_actuel = trise_info.RiseTime;

disp(['Temps de Montée Spécifié (trise) : ', num2str(trise_spec), ' s']);
disp(['Temps de Montée Actuel (trise) : ', num2str(trise_actuel), ' s']);

if trise_actuel <= trise_spec
    disp('Le temps de montée est conforme aux spécifications.');
else
    disp('Le temps de montée PAS conforme aux spécifications.');
end

