function P = decryption(C, hK)
global M  N
K = generateKey(hK);
[E, E1] = MOTDCM(K);
C = reshape(C',1, M*N);
C = iRDiffusion(C, E1);
P = iFShufflingAndDiffusion(C, E, K(1));
P = reshape(P, M, N)';
end