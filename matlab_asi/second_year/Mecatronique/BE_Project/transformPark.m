function [d, q] = transformPark(alpha, beta, theta)
    T_park = [cos(theta) sin(theta); -sin(theta) cos(theta)];
    
    dq = T_park * [alpha; beta];
    
    d = dq(1);
    q = dq(2);
end