% BE3 - Optimization
% PIFFER CHRISTO Guilherme
%% Question 1 - 5
%{
    All of the answer of this questions can be seeing in the answer of the
    question 6!
%}
%% Question 6
% Load the data from the data1.mat file
load('data1.mat');

% Compute the least squares matrices A and B
[A, B] = computeMatrices(Y, tau);

% Solve the least squares problem to estimate v*
v_estimated = A \ B;

% Calculate the predicted values using the estimated parameters
predicted_values = A * v_estimated;

% Calculate the residual (difference between measured and predicted values)
residual = B - predicted_values;

% Calculate the L2 norm of the residual
residual_norm = norm(residual);

% Display the residual norm
disp(['The L2 norm of the residual is ', num2str(residual_norm)]);

%% Question 7
% Define the initial conditions based on the first row of Y
P0 = Y(1, 1);
Q0 = Y(1, 2);

% Define the initial conditions from your measurement data
initial_conditions = [P0, Q0];  % Replace with your actual initial values

% Define the time span for simulation
tspan = [0, 50];  % Replace T with the desired simulation time

% Simulate the system 
[t, y] = ode45(@(t, y) predator_prey_system(t, y, v_estimated), tspan, initial_conditions);

% Plot the results
figure;
plot(t, y(:, 1), 'b', 'DisplayName', 'Prey (P)');
hold on;
plot(t, y(:, 2), 'r', 'DisplayName', 'Predator (Q)');

% Plot the experimental data
plot(Y(:, 1), 'LineStyle', '-', 'Color', '#0072BD', 'DisplayName', 'Experimental Prey');
plot(Y(:, 2), 'LineStyle', '-', 'Color', 'm', 'DisplayName', 'Experimental Predator');

xlabel('Time');
ylabel('Population');

% Create the legend
legend('show');

%% Question 8
% Same process of topics 6 and 7 but with data2.mat
% Load the data from the data2.mat file
load('data2.mat');

% Compute the least squares matrices A and B
[A, B] = computeMatrices(Y, tau);

% Solve the least squares problem to estimate v*
v_estimated = A \ B;

% Extract the estimated model parameters
r_estimated = v_estimated(1);
K_estimated = v_estimated(2);
s_estimated = v_estimated(3);
alpha_estimated = v_estimated(4);
beta_estimated = v_estimated(5);

% Calculate the predicted values using the estimated parameters
predicted_values = A * v_estimated;

% Calculate the residual (difference between measured and predicted values)
residual = B - predicted_values;

% Calculate the L2 norm of the residual
residual_norm = norm(residual);

% Display the residual norm
disp(['The L2 norm of the residual is ', num2str(residual_norm)]);

% Define the initial conditions based on the first row of Y
P0 = Y(1, 1);
Q0 = Y(1, 2);

% Define the initial conditions from your measurement data
initial_conditions = [P0, Q0];  % Replace with your actual initial values

% Define the time span for simulation
tspan = [0, 250];  % Replace T with the desired simulation time

% Simulate the system 
[t, y] = ode45(@(t, y) predator_prey_system(t, y, v_estimated), tspan, initial_conditions);

% Plot the results
figure;
plot(t, y(:, 1), 'b', 'DisplayName', 'Prey (P)');
hold on;
plot(t, y(:, 2), 'r', 'DisplayName', 'Predator (Q)');

% Plot the experimental data
plot(Y(:, 1), 'LineStyle', '-', 'Color', '#0072BD', 'DisplayName', 'Experimental Prey');
plot(Y(:, 2), 'LineStyle', '-', 'Color', 'm', 'DisplayName', 'Experimental Predator');

xlabel('Time');
ylabel('Population');

% Create the legend
legend('show');

%% Question 9
% Load the data from data2.mat
load('data2.mat');

% Define the dimension of measurements at each step
Np = 50;

% Extract the number of measurements N
N = size(Y, 1);

% Initialize empty matrices for estimated parameters
estimated_parameters = zeros(N - Np + 1, 5);

% Create a time vector for plotting
time = (Np:N)';

% Loop through successive pairs (Aj, bj) to estimate parameters
for j = 1:(N - Np + 1)
    % Extract measurements for the current window of Np measurements
    Y_window = Y(j:(j + Np - 1), :);
    
    % Compute the least squares matrices A and B for this window
    [A, B] = computeMatrices(Y_window, tau);
    v_estimated = A \ B;

    % Apply the recursive least squares update
    lambda = 0.5;
    r_estimated = lambda * r_estimated + (1 - lambda) * v_estimated(1);
    K_estimated = lambda * K_estimated + (1 - lambda) * v_estimated(2);
    s_estimated = lambda * s_estimated + (1 - lambda) * v_estimated(3);
    alpha_estimated = lambda * alpha_estimated + (1 - lambda) * v_estimated(4);
    beta_estimated = lambda * beta_estimated + (1 - lambda) * v_estimated(5);
    
    % Store the estimated parameters for this window
    estimated_parameters(j, :) = [r_estimated, K_estimated, s_estimated, alpha_estimated, beta_estimated];
end

% Plot the estimated parameters
subplot(3, 2, 1);
plot(time, estimated_parameters(:, 1));
title('Estimated r');
xlabel('Time');
ylabel('r');

subplot(3, 2, 2);
plot(time, estimated_parameters(:, 2));
title('Estimated K');
xlabel('Time');
ylabel('K');

subplot(3, 2, 3);
plot(time, estimated_parameters(:, 3));
title('Estimated s');
xlabel('Time');
ylabel('s');

subplot(3, 2, 4);
plot(time, estimated_parameters(:, 4));
title('Estimated alpha');
xlabel('Time');
ylabel('alpha');

subplot(3, 2, 5);
plot(time, estimated_parameters(:, 5));
title('Estimated beta');
xlabel('Time');
ylabel('beta');

%% Auxiliary functions
function dydt = predator_prey_system(t, y, v)
    P = y(1);
    Q = y(2);

    r = v(1);
    K = v(2);
    s = v(3);
    alpha = v(4);
    beta = v(5);

    dydt = [r * (1 - P / K) - s * Q; -alpha + beta * P];
end

function [A, B] = computeMatrices(Y, tau)
    % Extract the number of measurements N
    N = size(Y, 1);
    
    % Initialize empty matrices A and B
    A = zeros(2 * (N - 1), 5);
    B = zeros(2 * (N - 1), 1);
    
    for k = 1:N - 1
        % Extract measurements at time step k and k+1
        Pk = Y(k, 1);
        Qk = Y(k, 2);
        Pk1 = Y(k + 1, 1);
        Qk1 = Y(k + 1, 2);
        
        % Calculate L matrix for this time step
        L = tau * [1 -Pk -Qk 0 0; 0 0 0 -1 Pk];
        
        % Calculate q vector for this time step
        q = [Pk1 - Pk; Qk1 - Qk];
        
        % Assign L and q to the appropriate rows in matrices A and B
        A(2 * k - 1:2 * k, :) = L;
        B(2 * k - 1:2 * k, 1) = q;
    end
end


