%% 3.4 Inverse of forward shuffling and diffusion process
function P = iFShufflingAndDiffusion(C, E, a)
global N  M
[~, S] = sort(E);
R = M*N+1;
L = 0;
J = zeros(1,N*M);
P = uint8(zeros(1,N*M));
index = uint8(mod(a*10^16,2));
if(index)
    R = R -1;
    J(1) = R;
else
    L = L +1;
    J(1) = L;
end
for i=2:M*N
    index = mod(C(i-1), 2);
    if(index)
        R = R -1;
        J(i) = R;
    else
        L = L +1;
        J(i) = L;
    end
end

for ii=0:M*N-2
    i = M*N-ii;
    P(S(J(i))) = bitxor(C(i), bitxor(C(i-1), uint8(mod(E(i)*10^16, 255))));
end
P(S(J(1))) = bitxor(C(1), uint8(mod(E(1)*10^16, 255)));
end