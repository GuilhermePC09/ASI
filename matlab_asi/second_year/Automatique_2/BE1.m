%% BE1 - PIFFER CHRISTO Guilherme
clear;
close all;
clc;

%% Matrices

A = [1.5 0 0 0; 0 3 0 0; 0 0 0.5 0; 0 0 0 0.9];
R = [5 0; 0 1];
Q = [20 0; 0 1];

% Validation

% 1st cas
% B = [1 1; 1 0; 0 1; 1 2];
% C = [1 1 1 0; 0 1 3 1];

% 2nd cas
% B = [1 1; 1 0; 0 1; 1 2];
% C = [1 1 1 0; 0 1 3 0];

% 3th cas
% B = [1 1; 1 0; 0 1; 1 2];
% C = [0 1 1 0; 0 1 3 1];

% 4th cas
B = [1 2; 1 2; 0 0; 1 2];
C = [1 1 1 0; 0 1 3 1];

% 5th cas
% B = [2 1; 0 0; 2 1; 4 2];
% C = [1 1 1 0; 0 1 3 1];

%% prep

N = 20;
x0 = [2 2 2 2]';

%% Itération
P = zeros(4);
Fhorizon = [];

x_history = zeros(length(x0), N+1);
x_history(:,1) = x0;

for i = 1:N
    F = inv(R + B'*P*B)*B'*P*A;
    Fhorizon = [F; Fhorizon];
    P = A'*P*A - A'*P*B*inv(R + B'*P*B)*B'*P*A + C'*Q*C; 
end

for i = 1:N
    x_next = A * x_history(:,i) + B * (-Fhorizon(2*i-1:2*i,:) * x_history(:,i));
    x_history(:,i+1) = x_next; 
end

% Plot evolution du sys
figure(1);
plot(0:N, x_history);
xlabel('Temp');
ylabel('State');
legend('x1', 'x2', 'x3', 'x4');
title('Évolution des variables du système dans le temps');
grid on;

% Commandabilité et Observabilité

Cr = ctrb(A,B);
rank(Cr)

O = obsv(A,C);
rank(O)

if length(A)- rank(Cr) == 0
    disp('Commandable');
else
    disp('Non commandable');
end



