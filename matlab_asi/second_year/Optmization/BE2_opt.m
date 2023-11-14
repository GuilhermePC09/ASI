%BE2 - Optimization
%% Definition of the coefs

% Define the coefficients of the objective function
c = -[1200; 1200; 1200; 850; 850; 850; 175; 175; 175]';

% Define the coefficients of the usable land constraints
A_land = [1 0 0 1 0 0 1 0 0; 
          0 1 0 0 1 0 0 1 0; 
          0 0 1 0 0 1 0 0 1];
b_land = [400; 600; 300];

% Define the coefficients of the water available constraints
A_water = [3 0 0 2 0 0 1 0 0; 
           0 3 0 0 2 0 0 1 0; 
           0 0 3 0 0 2 0 0 1];
b_water = [600; 800; 375];

% Define the coefficients of the maximum quota constraints
A_quota = [1 1 1 0 0 0 0 0 0; 
           0 0 0 1 1 1 0 0 0; 
           0 0 0 0 0 0 1 1 1];
b_quota = [600; 500; 325];

% Define the lower bounds for xi variables
lb = zeros(9, 1);
%% Equation solve

% Ineq
A_ineq = [A_land; A_water; A_quota];
b_ineq = [b_land; b_water; b_quota];

% Eq
A_eq = [600 -400 0 600 -400 0 600 -400 0;
        0 300 -600 0 300 -600 0 300 -600];
b_eq = zeros(2, 1);

% Solve the linear programming problem
x = linprog(c, A_ineq, b_ineq, A_eq, b_eq, lb);
optimal_net_return = -c * x; % The maximum net return is the negation of the cost function
disp(['Optimal acreage for each product: ', num2str(x')]);
disp(['Maximum Net Return: £', num2str(optimal_net_return)]);

% Active constrains
ac = A_ineq * x - b_ineq;
disp(['Actives constrains: ', num2str(ac')])
%% Increase in corn value to make it profitable
corn = 175;
i = 1;
while x(7)==0||x(8)==0||x(9)==0  
    cc = -[1200; 1200; 1200; 850; 850; 850; corn * i; corn * i; corn* i]';
    x = linprog(cc, A_ineq, b_ineq, A_eq, b_eq, lb);
    i = i+0.05;
end

disp(['Minimal corn net: ', num2str(corn * i)])
disp(['% increase: ', num2str((i-1)*100)])
%% With water restriction

wr = 0.6;
b_water_r = b_water * wr;
b_ineq_r = [b_land; b_water_r; b_quota];

% Solve the linear programming problem with the restriction
x_r = linprog(c, A_ineq, b_ineq_r, A_eq, b_eq, lb);
optimal_net_return_r = -c * x; % The maximum net return is the negation of the cost function

d = optimal_net_return_r / optimal_net_return;
disp(['Optimal acreage for each product with the water restriction: ', num2str(x_r')]);
disp(['Maximum Net Return with the water restriction: £', num2str(optimal_net_return_r)]);
disp(['Deference Net Return with the water restriction: %', num2str((1-d)*100)]);



