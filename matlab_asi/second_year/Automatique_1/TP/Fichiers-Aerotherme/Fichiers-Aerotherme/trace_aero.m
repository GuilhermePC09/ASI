figure

subplot(211)

plot(X.time, X.signals.values(:,1),X.time, X.signals.values(:,3))
legend('Consigne', 'R�ponse')
axis on
grid on
title('Simulation du r�gulateur K3(z) et perturbation � t = 300s')
subplot(212)
plot(X.time, X.signals.values(:,2), X.time, X.signals.values(:,4))
grid on
legend('Commande', 'Perturbation')
axis on

% figure
% plot(X.time, X.signals.values(:,1),X.time, X.signals.values(:,3),X.time, X.signals.values(:,2))
% grid on
