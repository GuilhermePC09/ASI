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
Ps = 15;
duty = Vs / Ve;
R = Vs^2 / Ps;

sim('buck_01_2018_b');

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
