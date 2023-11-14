function QP_Exercise


% clear workspace, close open figures, clear command window
clear all
close all
clc


% Set options
tol_opt       = 1e-8;
options = optimset('Display','off',...
    'TolFun', tol_opt,...
    'MaxIter', 10000,...
    'Algorithm', 'active-set',...
    'TolConSQP', 1e-6);

warning off

% Number of MPC iterations (simulation length)
mpciterations = 50;

% Prediction time (continuous prediction horizon)
T = ???;

% Discretization steps
delta = ???;

% Prediction horizon
N = ???;

% System dynamics (continous)
Ac = ???;
Bc = ???;

n = length(Ac(1,:)); % state dimension
m = length(Bc(1,:)); % input dimension

sysc = ss(Ac,Bc,eye(n),zeros(n,m));

% System dynamics (discrete-time) by exact discretization (zero-order hold)
sysd = c2d(sysc, delta, 'zoh');
Ad = sysd.A;
Bd = sysd.B;

% Terminal state
xTerm = ???;

% Cost parameters
Q = ???;
R = ???;

% initial conditions
tmeasure        = 0.0;          % initial time
xmeasure        = ???;   % initial state

% Initial guess for open-loop input sequence
u0              = ???;
% Initial guess for the open-loop state sequence (order: [x_1(0);x_2(0);x_1(1);x_2(1);...])
x0              = ???;

% Inequality constraints (H_x*x <= k_x   and   H_u*u <= k_u)
H_x = ???;
k_x = ???;

H_u = ???;
k_u = ???;

% ==============================================
% Implement the MPC iteration
% ==============================================

% Use the quadprog command to solve the optimization problem
% quadprog has the following command
%
% x = quadprog(H,f,A,b,Aeq,beq,[],[],x0,options)
%
% x:        optimal solution
%
% H:        quadratic part of the cost
% f:        linear part of the cost
% A, b:     inequality constraints A x <= b
% Aeq, beq: equality constraints Aeq x = beq
% x0:       inital guess for the optimization
% options:  options for the solver


% Set variables for output
t = [];
x = [];
u = [];

% Define Matrices for quadprog
% State, input, and terminal constraints and constraints for dynamics
% Use matlab functions repmat if necessary
 
    % Inequality constraints
    ???
    
    
    % Equality constraints (dynamics)
    ???
    
    
    % Equality constraints (initial constraint)
    ???
    
    % Equality constraints (terminal constraint)
    ???
    
    % Cost function
    H = ???;
    f = ???;

% Print Header
fprintf('   k  |      u(k)        x(1)        x(2)     Time \n');
fprintf('---------------------------------------------------\n');


for ii = 1:mpciterations
       
    %update constraints (initial constraint) based on current state x_measure
    ???;   
    
    t_Start = tic;
    
    % Solve optimization problem
    solutionOL = ???;
    
    % Derive the optimal predicted state and input sequence
    x_OL = ???;
    u_OL = ???;
    
    t_Elapsed = toc( t_Start );
    
    % Store closed-loop data
    t = [ t, tmeasure ];
    x = [ x, xmeasure ];
    u = [ u, u_OL(:,1) ];
    
    % Update the closed-loop system
    xmeasure = ???;
    tmeasure = ???;
    
    % Prepare warmstart solution for next time step (take the endpiece of the optimal open-loop solution 
    % and add a last piece)
    x0 = ???;
    u0 = ???;
    
    
    % Print results
    fprintf(' %3d  | %+11.6f %+11.6f %+11.6f  %+6.3f\n', ii, u(end),...
        x(1,end), x(2,end),t_Elapsed);
    
    % Plot state sequences (open-loop and closed-loop) in state space plot (x_1;x_2)
    f1 = figure(1);
    plot(x(1,:),x(2,:),'b'), grid on, hold on,
    plot(x_OL(1,:),x_OL(2,:),'g')
    plot(x(1,:),x(2,:),'ob')
    xlabel('x(1)')
    ylabel('x(2)')
    title('state space')
    drawnow
    
    % Plot input sequences (open-loop and closed-loop) over time
    f2 = figure(2);
    stairs(t(end)+delta*(0:1:N-1),u_OL), grid on, hold on,
    plot(t(end),u(end),'bo')
    xlabel('prediction time')
    ylabel('uOL')
    drawnow
    
end


f3 = figure(3);
stairs(t,u);
xlabel('t')
ylabel('u')
title('closed-loop input')


end