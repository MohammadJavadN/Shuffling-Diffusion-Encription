function [C, hK] = encryption(P)
global N  M
[M, N] = size(P); 
P = reshape(P',1, N*M);
hK = HashFunction(P, 'SHA-256');
K = generateKey(hK);
[E, E1] = MOTDCM(K);
C = FShufflingAndDiffusion(P, E, K(1));
C = uint8(RDiffusion(C, E1));
C = reshape(C, M, N)';
end