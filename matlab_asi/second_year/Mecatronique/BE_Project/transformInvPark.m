function [alpha, beta] = transformInvPark(d, q, theta)
    T_park_inv = inv([cos(theta) sin(theta); -sin(theta) cos(theta)]);
    
    dq = [d; q];
    alpha_beta = T_park_inv * dq;
    
    alpha = alpha_beta(1);
    beta = alpha_beta(2);
end


