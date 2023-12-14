function [abc] = transformInvClarke(alpha, beta)
    T_clarke_inv = sqrt(2/3) * inv([1 -1/2 -1/2; 0 sqrt(3)/2 -sqrt(3)/2]);
    
    alpha_beta = [alpha; beta];
    abc = T_clarke_inv * alpha_beta;
end

