%% 3.4 Inverse of reverse diffusion process
function C = iRDiffusion(C, E1)
global N  M
C(1) = bitxor(C(1), uint8(mod(E1(1)*10^16, 255)));
for i=2:M*N
    C(i) = bitxor(C(i), bitxor(C(i-1), uint8(mod(E1(i)*10^16, 255))));
end
end