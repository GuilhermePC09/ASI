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
