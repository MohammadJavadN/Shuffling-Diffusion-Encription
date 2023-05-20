function [E, E1] = MOTDCM(K)
global N  M
N0 = 300;
% [a, b, lambda1, lambda2, x, y] = K(:);
a = K(1);
b = K(2);
lambda1 = K(3);
lambda2 = K(4);
x = K(5);
y = K(6);
E = zeros(1, N0+N*M);
E1 = zeros(1, N0+N*M);
E(1) = mod(4*a*x*(1-x) + lambda1*y^2, 1);
E1(1) = mod(4*b*F(y)*(1-F(y)) + lambda2*x^2, 1);
for i = 2 : N*M + N0
    E(i) = mod(4*a*E(i-1)*(1-E(i-1)) + lambda1*E1(i-1)^2, 1);
    E1(i) = mod(4*b*F(E1(i-1))*(1-F(E1(i-1))) + lambda2*E(i-1)^2, 1);
end
E = E(N0+1 : N0+N*M); 
E1 = E1(N0+1 : N0+N*M); 
end

function out = F(x)
out = 3*sin(pi*x);
end

