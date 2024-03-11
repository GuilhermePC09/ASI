% BE 4 et 5 - PIFFER CHRISTO Guilherme 
%% Définition des variables
global m l k g;
m=0.35;
l=0.5;
k=0.15;
g=9.81;
x0=[-pi/5; pi/6];
omega = 0;
amp = 0;

%% Représentation d'état du pendule
A=[0 1; -g/l -k/m];
B=[0; 1/(m*l*l)];
C=[1 0];

%% Tracer le plan de phase du syst`eme lin´eaire
tspan = [0, 10];
sys = ss(A, B, C, 0);

t = linspace(tspan(1), tspan(2), 1000); 
u = zeros(size(t));                   
[y, ~, x] = lsim(sys, u, t, x0);

% Plote o plano de fase.
figure;
plot(x(:,1), x(:,2), 'b', 'LineWidth', 2);
xlabel('x1');
ylabel('x2');
grid on;

%% Régime forcé

omega_values = 1:10;

for i = 1:length(omega_values)
    omega = omega_values(i);
    set_param('BE4et5simu/Sine Wave', 'Frequency', num2str(omega));

    simOut = sim('BE4et5simu'); 
end

%% Choix de la période d'échantillonnage

Te1 = 0.01;
sysd = c2d(sys,Te1);

[num, den] = ss2tf(sysd.A, sysd.B, sysd.C, sysd.D);
Hz = tf(num, den);

