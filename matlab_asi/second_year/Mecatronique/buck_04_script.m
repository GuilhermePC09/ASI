%% Buck

clear all
close all

F = 500e3;
Ve = 5;
L1 = 5e-6;
C1 = 5.5e-6;
L = 1.9e-6;
C = 9.3e-6;
Vs = 3.3;
Ps = 2;
duty = Vs / Ve;
R = Vs^2 / Ps;

sim('buck_04_2018_b');

time = current_L1.time;
iL1 = current_L1.signals.values;
vC1 = voltage_C1.signals.values;
iL = current_L.signals.values;
vC = voltage_C.signals.values;

% Create figure
figure()
subplot(2,1,1)
hold on
plot(time,iL1,'LineWidth',2);
plot(time,iL,'--','LineWidth',2);
hold off
xlabel('Time (s)','FontWeight','bold','FontName','Times');
ylabel('Current','FontWeight','bold','FontName','Times');
legend('i_{L1}','i_{L}')
grid on

subplot(2,1,2)
hold on
plot(time,vC1,'LineWidth',2);
plot(time,vC,'--','LineWidth',2);
hold off
xlabel('Time (s)','FontWeight','bold','FontName','Times');
ylabel('Voltage','FontWeight','bold','FontName','Times');
legend('v_{C1}','v_{C}')
grid on

%% FONCTION DE TRANSFERT A PARTIR DU MODELE SIMULINK %%
[a1,b1,c1,d1] = linmod('buck_04_2018_b',xFinal,0);
[num1,den1] = ss2tf(a1,b1,c1,d1);
H1 = tf(num1,den1);

w=logspace(2,6,1000); % vecteur pulsation

figure(2)
bode(H1,w);
legend('Modèle moyen bilinéaire linéarisé')
title('Fonction de transfert vs/alpha')
grid;

%% Loi de commande
Vout_ref = 3.3;
Kp = 10^(-50/20);
Ti = 1e-6;

num_cor = [Kp*Ti Kp];
den_cor = [Ti 0];

Hcor = tf(num_cor, den_cor);

FTBO = Hcor * H1;

figure(3)
bode(FTBO,w);
legend('Fonction de transfert en Boucle Ouverte AVEC Correcteur')
title('Fonction de transfert Hcor x H1')
grid;

figure(4);
step(FTBO/(1+FTBO));
title('Reponse indicielle en BOUCLE FERMEE')
grid on
xlabel('Temps (s)')
ylabel('Vout (V)')