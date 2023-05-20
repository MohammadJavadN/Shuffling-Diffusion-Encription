%% 3.3 Reverse diffusion process
function C = RDiffusion(C, E1)
global N  M
n = N*M;

for ii=0:n-2
    i = n-ii;
    C(i) = bitxor(C(i), bitxor(C(i-1), uint8(mod(E1(i)*10^16, 255))));
end
C(1) = bitxor(C(1), uint8(mod(E1(1)*10^16, 255)));
end