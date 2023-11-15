%% BE1 - PIFFER CHRISTO Guilherme (Not working yet)
clear all;
close all;

%%
% Question 1: Ballistic Trajectory

% Given parameters
x0 = 0;
y0 = 0;
V = 15;
theta = 75;
g = 9.8;
t_flight = 5;

% Calculate components of initial velocity
u0 = V * cosd(theta);
v0 = V * sind(theta);

% Time vector
t = linspace(0, t_flight, 100);

% Trajectory equations
x = u0 * t + x0;
y = y0 + v0 * t - 0.5 * g * t.^2;

% Plot the ballistic trajectory
figure;
plot(x, y);
title('Ballistic Trajectory');
xlabel('Horizontal Distance (m)');
ylabel('Vertical Distance (m)');
grid on;

%%
% Question 2: Lotka–Volterra Model

% Given parameters
a = 1;
b = 1;
df = 1;

% Define the Lotka–Volterra model equations
f = @(t, x) [b*x(1) - a*x(1)*x(2); b*x(1)*x(2) - df*x(2)];

% Time vector
tspan = linspace(0, 10, 100);

% Initial conditions
x0 = [2, 1];

% Solve the system of differential equations
[t, x] = ode45(f, tspan, x0);

% Plot the phase portrait
figure;
plot(x(:,1), x(:,2));
title('Lotka–Volterra Phase Portrait');
xlabel('Prey Population (x1)');
ylabel('Predator Population (x2)');
grid on;

%%
% Question 3: Flower Function

% Given parameters
a = 1;
b = 1;
c = 4;

% Define the flower function
f = @(x) a * norm(x) + b * sin(c * atan2(x(2), x(1)));

% Generate grid for plotting
[X1, X2] = meshgrid(linspace(-3, 3, 100), linspace(-3, 3, 100));
Z = arrayfun(@(x1, x2) f([x1, x2]), X1, X2);

% Plot the flower function
figure;
surf(X1, X2, Z);
title('Flower Function');
xlabel('x1');
ylabel('x2');
zlabel('f(x)');
%%
% Question 4: Rosenbrock Function and Gradient

% Given parameters
a = 1;
b = 4;

% Rosenbrock function
f = @(x) b * (x(2) - x(1)^2)^2 + (a - x(1))^2;

% Gradient of the Rosenbrock function at a symbolic point
syms x1 x2
gradient_f_symbolic = gradient(f([x1; x2]));

% Substitute the point of interest into the symbolic gradient
gradient_f_numeric = subs(gradient_f_symbolic, [x1; x2], x_point);

disp('Gradient at the point [1, 2]:');
disp(gradient_f_numeric);

%%
% Questão 5: Gradiente e Hessiana

syms x y;

% Função dada
f = 1/2 * (x - 1)^2 + 1/2 * (10 * (y - x^2))^2 + 1/2 * y^2;

% Calcula o gradiente
gradient_f = gradient(f, [x, y]);

% Calcula a hessiana
hessian_f = hessian(f, [x, y]);

% Mostra o gradiente e a hessiana
disp('Gradiente:');
disp(gradient_f);

disp('Hessiana:');
disp(hessian_f);


%%
% Questão 6(a): Condições de Otimização de Kuhn-Tucker

syms x1 x2 lambda;

% Função objetivo
f = -x1^2 - 2*x2^2;

% Restrição
g = 1/16 * (x1^2 + x2^2) - 4;

% Condições de KKT
KKT_conditions = [gradient(f, [x1, x2]) - lambda * gradient(g, [x1, x2]);
                  g];

% Mostra as condições de KKT
disp('Condições de KKT:');
disp(KKT_conditions);


%%
% Questão 6(b): Representação Gráfica

% Define a função objetivo
fun = @(x) -x(1)^2 - 2*x(2)^2;

% Restrição
nonlcon = @(x) deal([1/16 * (x(1)^2 + x(2)^2) - 4], []); % Restrição de desigualdade

% Resolve o problema de otimização com restrição
x0 = [0, 0];
options = optimoptions('fmincon', 'Display', 'off');
[x, fval] = fmincon(fun, x0, [], [], [], [], [], [], nonlcon, options);

% Mostra a solução
disp('Solução do Problema de Otimização:');
disp(['x1 = ', num2str(x(1))]);
disp(['x2 = ', num2str(x(2))]);

% Plot da região factível e solução
figure;
fcontour(fun, 'LevelList', 0:10:80);
hold on;

% Desenha a restrição de desigualdade
fimplicit(@(x, y) nonlcon([x, y]), [0, 8], 'LineWidth', 2, 'Color', 'r');

% Plota a solução
scatter(x(1), x(2), 100, 'Marker', 'x', 'LineWidth', 2, 'Color', 'k');
title('Problema de Otimização com Restrição');
xlabel('x1');
ylabel('x2');
legend('Função Objetivo', 'Restrição', 'Solução');
hold off;



%%
% Questão 7(a): Condições Necessárias de KKT

syms x1 x2 lambda1 lambda2 lambda3 lambda4;

% Função objetivo
f = x2;

% Restrições
g1 = (x1 + 1)^2 + x2^2 - 1;
g2 = (x1 - 2)^2 + x2^2 - 4;
g3 = 4*x2 - x1 - 2;
g4 = x1 + 1;

% Condições de KKT
KKT_conditions = [gradient(f, [x1, x2]) - lambda1 * gradient(g1, [x1, x2]) - lambda2 * gradient(g2, [x1, x2]) - lambda3 * gradient(g3, [x1, x2]) - lambda4 * gradient(g4, [x1, x2]);
                  g1;
                  g2;
                  g3;
                  g4];

% Mostra as condições de KKT
disp('Condições de KKT:');
disp(KKT_conditions);

%%
% Questão 7(b): Solução Gráfica e Verificação KKT

% Define as funções das restrições
g1 = @(x) (x(1) + 1)^2 + x(2)^2 - 1;
g2 = @(x) (x(1) - 2)^2 + x(2)^2 - 4;
g3 = @(x) 4*x(2) - x(1) - 2;
g4 = @(x) x(1) + 1;

% Resolve o problema de otimização com restrições
x0 = [0, 0];
options = optimoptions('fmincon', 'Display', 'off');
[x, fval, exitflag, output, lambda] = fmincon(@(x) x(2), x0, [], [], [], [], [], [], @(x) constraints(x, g1, g2, g3, g4), options);

% Mostra a solução
disp('Solução do Problema de Otimização:');
disp(['x1 = ', num2str(x(1))]);
disp(['x2 = ', num2str(x(2))]);

% Mostra os multiplicadores de Lagrange
disp('Multiplicadores de Lagrange:');
disp(lambda.ineqnonlin);

% Verifica as condições KKT
check_KKT_conditions = checkKKT(x, lambda, [g1(x), g2(x), g3(x), g4(x)]);

% Mostra o resultado da verificação
disp('Condições KKT Verificadas:');
disp(check_KKT_conditions);

% Plot das restrições e solução
figure;
fcontour(@(x) x(2), 'LevelList', 0:0.1:5, 'ShowText', 'on');
hold on;
fimplicit(g1, 'LineWidth', 2, 'Color', 'r');
fimplicit(g2, 'LineWidth', 2, 'Color', 'g');
fimplicit(g3, 'LineWidth', 2, 'Color', 'b');
fimplicit(g4, 'LineWidth', 2, 'Color', 'm');
scatter(x(1), x(2), 100, 'Marker', 'x', 'LineWidth', 2, 'Color', 'k');
title('Problema de Otimização com Restrições Não-Lineares');
xlabel('x1');
ylabel('x2');
legend('Função Objetivo', 'g1', 'g2', 'g3', 'g4', 'Solução');
hold off;

%%
% Questão 8(a): Formulação do Problema

% Dados do problema
beads_cost = 0.25;
string_cost = 0.70;
wire_cost = 1.5;

% Parâmetros do problema
selling_price = [25.0, 45.0, 10.0];
assemble_time = [2.5, 4.0, 1.5];
min_production = [2, 2, 2];
material_per_unit = [15, 0.6, 0.15; 80, 2.5, 0.2; 4, 0.1, 0.15];

% Variáveis de decisão
syms x1 x2 x3;

% Função objetivo
profit = selling_price(1) * x1 + selling_price(2) * x2 + selling_price(3) * x3 - ...
    (beads_cost * material_per_unit(1, 1) * x1 + string_cost * material_per_unit(1, 2) * x1 + wire_cost * material_per_unit(1, 3) * x1 + ...
    beads_cost * material_per_unit(2, 1) * x2 + string_cost * material_per_unit(2, 2) * x2 + wire_cost * material_per_unit(2, 3) * x2 + ...
    beads_cost * material_per_unit(3, 1) * x3 + string_cost * material_per_unit(3, 2) * x3 + wire_cost * material_per_unit(3, 3) * x3);

% Restrições de tempo
time_available = 40;
time_spent = assemble_time(1) * x1 + assemble_time(2) * x2 + assemble_time(3) * x3;

% Restrições de produção mínima
min_prod_constraints = [x1 >= min_production(1), x2 >= min_production(2), x3 >= min_production(3)];

% Mostra as restrições de produção mínima
disp('Restrições de Produção Mínima:');
disp(min_prod_constraints);

% Restrições de igualdade
eq_constraints = time_spent - time_available;

% Mostra a restrição de igualdade
disp('Restrição de Tempo:');
disp(eq_constraints);

% Função objetivo e restrições para fmincon
objective = -profit; % Negativo porque o fmincon minimiza
constraints_f = [min_prod_constraints, eq_constraints];

%%
% Questão 8(b): Solução Gráfica

% Define as funções das restrições
time_constraint = @(x) assemble_time(1) * x(1) + assemble_time(2) * x(2) + assemble_time(3) * x(3) - time_available;
min_prod_constraints = @(x) [x(1) - min_production(1); x(2) - min_production(2); x(3) - min_production(3)];

% Resolve o problema de otimização com restrições
x0 = [0, 0, 0];
options = optimoptions('fmincon', 'Display', 'off');
[x, fval] = fmincon(objective, x0, [], [], [], [], [], [], @(x) constraints(x, time_constraint, min_prod_constraints), options);

% Mostra a solução
disp('Solução do Problema de Otimização:');
disp(['Quantidade de Braceletes (x1) = ', num2str(x(1))]);
disp(['Quantidade de Colares (x2) = ', num2str(x(2))]);
disp(['Quantidade de Brincos (x3) = ', num2str(x(3))]);

% Plot das restrições e solução
figure;
fcontour(@(x1, x2) -profit.eval(x1, x2, 0), 'ShowText', 'on');
hold on;
fimplicit(@(x1, x2) time_constraint([x1, x2, 0]), 'LineWidth', 2, 'Color', 'r');
scatter(x(1), x(2), 100, 'Marker', 'x', 'LineWidth', 2, 'Color', 'k');
title('Problema de Otimização de Produção de Jóias');
xlabel('Quantidade de Braceletes (x1)');
ylabel('Quantidade de Colares (x2)');
legend('Função Objetivo', 'Restrição de Tempo', 'Solução');
hold off;

%%

% Função para verificar as condições KKT
function conditions = checkKKT(x, lambda, g_values)
    tol = 1e-6; % Tolerância para verificar se as condições KKT são satisfeitas
    
    conditions = true; % Inicialmente assume que todas as condições são satisfeitas
    
    % Verifica se as condições de complementaridade são satisfeitas
    for i = 1:length(g_values)
        if abs(g_values(i)) > tol && abs(lambda.ineqnonlin(i)) > tol
            conditions = false;
            break;
        end
    end
    
    % Verifica se as condições de viabilidade primal e dual são satisfeitas
    if ~all(g_values <= 0) || ~all(lambda.ineqnonlin >= 0)
        conditions = false;
    end
end

% Função para impor as restrições no fmincon
function [c, ceq] = constraints(x, g1, g2, g3, g4)
    c = [g1(x); g2(x); g3(x); g4(x)];
    ceq = [];
end






