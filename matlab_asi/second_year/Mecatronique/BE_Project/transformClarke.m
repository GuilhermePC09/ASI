function [alpha, beta] = transformClarke(abc)
    T_clarke = sqrt(2/3) * [1 -1/2 -1/2; 0 sqrt(3)/2 -sqrt(3)/2];
    alpha_beta = T_clarke * abc;
    
    alpha = alpha_beta(1);
    beta = alpha_beta(2);
end


