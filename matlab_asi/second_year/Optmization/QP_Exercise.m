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
    'Algorithm', 'interior-point-convex',...
    'TolConSQP', 1e-6);

warning off

% Number of MPC iterations (simulation length)
mpciterations = 50;

% Prediction time (continuous prediction horizon)
T = 4;

% Discretization steps
delta = 0.1;

% Prediction horizon
N = T/delta;

% System dynamics (continous)
Ac = [-1 1;0 0.5];
Bc = [0;1];

n = length(Ac(1,:)); % state dimension
m = length(Bc(1,:)); % input dimension

sysc = ss(Ac,Bc,eye(n),zeros(n,m));

% System dynamics (discrete-time) by exact discretization (zero-order hold)
sysd = c2d(sysc, delta, 'zoh');
Ad = sysd.A;
Bd = sysd.B;

% Terminal state
xTerm = [0.0; 0.0];

% Cost parameters
Q = 0.5*eye(n);
R = 1;

% initial conditions
tmeasure        = 0.0;          % initial time
xmeasure        = [0.6;0.8];   % initial state

% Initial guess for open-loop input sequence
u0              = repmat(zeros(m,1),N,1);
% Initial guess for the open-loop state sequence (order: [x_1(0);x_2(0);x_1(1);x_2(1);...])
x0              = repmat(xmeasure, N+1,1);

% Inequality constraints (H_x*x <= k_x   and   H_u*u <= k_u)
H_x = [1 0;
    -1 0;
    0 1;
    0 -1];
k_x = [1;
    1;
    1;
    1];

H_u = [1;
    -1];
k_u = [1;
    1];
%% 
% ==============================================
% Implement the MPC iteration
% ==============================================

% Use the quadprog command to solve the optimization problem
% quadprog has the following command

%x = quadprog(H,f,A,b,Aeq,beq,[],[],x0,options)

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
    Ax=[];
    bx=[];
    Au=[];
    bu=[];
    for k = 1:N
       Ax=blkdiag(Ax,H_x); 
       bx=[bx;k_x];
       Au=blkdiag(Au,H_u);
       bu=[bu;k_u];
    end 
    clear ('k')
    
    Ax=blkdiag(Ax,H_x);
    bx=[bx;k_x];
    
    A=blkdiag(Ax,Au);
    b=[bx;bu];
    % Equality constraints (dynamics)
   Aeq=zeros(n*(N+2),n*(N+1)+m*N);
   beq=zeros(n*(N+2),1);
    for k = 0:N-1
        Aeq(n*k+1:n*(k+1), 1:n*(N+1))=[zeros(n,n*k),Ad,-eye(n),zeros(n,n*(N-1-k))];
        Aeq(n*k+1:n*(k+1),n*(N+1)+1:end)=[zeros(n,m*k),Bd,zeros(n,m*(N-1-k))];
    end
    
    clear('k')
    % Equality constraints (initial constraint)
    Aeq(n*N+1:n*(N+1),:)=[eye(n),zeros(n,m*N+n*N)];
    beq(n*N+1:n*(N+1))=xmeasure;
    
    % Equality constraints (terminal constraint)
    Aeq(n*(N+1)+1:n*(N+2),:)=[zeros(n,n*N),eye(n),zeros(n,m*N)];
    beq(n*(N+1)+1:n*(N+2))=xTerm;
    
    % Cost function
    %stage cost
    Qstack=[];
    Rstack=[];
    for k = 1:N
        Qstack = blkdiag(Qstack,delta*Q);
        Rstack = blkdiag(Rstack,delta*R);
    end
    clear('k')
    %terminal cost=0
    Qstack = blkdiag(Qstack,zeros(n));
    
    %overall cost
    H = blkdiag(Qstack, Rstack);
    f = zeros(1,n*(N+1)+m*N);
 %%    
% Print Header
fprintf('   k  |      u(k)        x(1)        x(2)     Time \n');
fprintf('---------------------------------------------------\n');


for ii = 1:mpciterations
       
    %update constraints (initial constraint) based on current state x_measure
    beq(n*N+1:n*(N+1))=xmeasure;   
    
    t_Start = tic;
    
    % Solve optimization problem
    solutionOL = quadprog(H, f, A, b, Aeq, beq, [], [], [x0;u0], options);
    
    % Derive the optimal predicted state and input sequence
    x_OL_tilde=solutionOL(1:n*(N+1),1);
    u_OL_tilde=solutionOL(n*(N+1)+1:end,1);
    x_OL = reshape(x_OL_tilde,n,N+1);
    u_OL = reshape(u_OL_tilde,m,N);
    
    t_Elapsed = toc( t_Start );
    
    % Store closed-loop data
    t = [ t, tmeasure ];
    x = [ x, xmeasure ];
    u = [ u, u_OL(:,1) ];
    
    % Update the closed-loop system
    tmeasure = tmeasure + delta;
    xmeasure = Ad * xmeasure + Bd * u_OL(1:m);
    
    % Prepare warmstart solution for next time step (take the endpiece of the optimal open-loop solution 
    % and add a last piece)
    x0 = [x_OL_tilde(n+1:end);zeros(n,1)];
    u0=[u_OL_tilde(m+1:end);zeros(m,1)];
    
    
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