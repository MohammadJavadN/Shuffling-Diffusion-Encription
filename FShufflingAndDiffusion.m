%% 3.2 Forward shuffling and diffusion process
function C = FShufflingAndDiffusion(P, E, a)
global N  M
C = uint8(zeros(1,M*N));
[~, S] = sort(E);
R = M*N+1;
L = 0;
index = uint8(mod(a*10^16,2));
if(index)
    R = R -1;
    j = R;
else
    L = L +1;
    j = L;
end
C(1) = bitxor(P(S(j)), uint8(mod(E(1)*10^16, 255)));
for i=2:M*N
    index = mod(C(i-1), 2);
    if(index)
        R = R -1;
        j = R;
    else
        L = L +1;
        j = L;
    end
    C(i) = bitxor(P(S(j)), bitxor(C(i-1), uint8(mod(E(i)*10^16, 255))));
end
end