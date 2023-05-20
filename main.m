clc
clear
close all
% 3. encryption
global N M
P = uint8(imread('lena256.bmp'));
[M, N] = size(P);
[C, hK] = encryption(P);

% decryption
P_2 = decryption(C, hK);

%% ploting result
figure();
subplot(2,2,1)
imshow(P)
title('Plaint image')

subplot(2,2,2)
imshow(C)
title('ciphertext image')

subplot(2,2,3)
imshow(P_2)
title('recovered plaintext image')

%% 4. Simulation results and security analysis
% 4.2 Key space and key sensitivity analyses
fprintf('\nKey space and key sensitivity analyses:\n')
figure()
subplot(2,4,1)
imshow(P)
title('original image')
for i = 2:8
    hk = hK;
    r = randi([1, length(hK)]);
    p = randi([1,4])-1;
    hk(r) = lower(dec2hex(bitxor(hex2dec(hK(r)), 2^p)));
    P1 = decryption(C, hk);
    subplot(2,4,i)
    imshow(P1)
    title('decrypted image using the incorrect key')
    fprintf('after the key is randomly changed by one bit,\n')
    fprintf(['The percentage of different pixels between the two images (', num2str(i-1), ') = '])
    showPercentOfDiffrentPixel(P, P1);
end

%% 4.3. Histogram analysis
path = ["lena256.bmp", "baboon256.bmp", "cameraman256.bmp", "peppers256.bmp"];
ln = length(path);
figure()
for i = 1:ln
    
    P = uint8(imread(path(i)));
    [C, ~] = encryption(P);

    subplot(2,ln,i)
    imhist(P)

    subplot(2,ln,ln+i)
    imhist(C)
end
%% 4.4. Correlation analysis
P = uint8(imread('lena256.bmp'));
[C, ~] = encryption(P);

fprintf('\nCorrelation analysis:')
AdjancyCorrPixelRandNew(P,C);
%% 4.5. Information entropy analysis
disp(['Entropy values of Lena  = ', num2str(entropy(P))])
disp(['Entropy values of Lena in the Proposed algorithm = ', num2str(entropy(C))])

%% 4.6. Differential attack analysis
% % %Encryption and Decryption for 1 bit change in Plain Image
fprintf('\nNPCR, UACI and BACI Test:\n')
fprintf('\n%15s %15s %25s %25s %25s\n',"Test Images", "Type", "Min(%)", "Max(%)", "Mean(%)");
path = ["lena256.bmp", "baboon256.bmp", "cameraman256.bmp", "peppers256.bmp"];
ln = length(path);

for j = 1:ln
    P = uint8(imread(path(j)));
    [C, ~] = encryption(P);
    n = 150;
    npcr = zeros(1, n);
    uaci = zeros(1, n);
    baci = zeros(1, n);
    for i = 1:n
        fprintf('%3.0f%s',(i-1)/n*100,"%");
        P1bit=P;      %Image size 256*256;
        pos1=1+floor(rand(1)*N);
        pos2=1+floor(rand(1)*N);

        % fprintf('\nBefore change 1 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,P1bit(pos1,pos2));
        P1bit(pos1,pos2) =bitxor(P1bit(pos1,pos2), 1);
        % fprintf('\nAfter change 1 bit of PlainImage at location (%d,%d) = %d\n',pos1,pos2,P1bit(pos1,pos2));
        [C1bit, ~] = encryption(P1bit);
        [npcr(i), uaci(i), baci(i)] = NPCR_UACI_BACI(uint8(C), uint8(C1bit));
        fprintf('\b\b\b\b');
    end
    p = char(path(j));
    fprintf('\n%15s %15s %25.4f %25.4f %25.4f\n',p(1:length(p)-7), "NPCR:", min(npcr), max(npcr), mean(npcr));
    fprintf('\n%15s %15s %25.4f %25.4f %25.4f\n'," ", "UACI:", min(uaci), max(uaci), mean(uaci));
    fprintf('\n%15s %15s %25.4f %25.4f %25.4f\n', " ", "BACI:", min(baci), max(baci), mean(baci));
end
%% 4.7 Encryption efficiency
total_time = 0;
n = 100;
fprintf('\nEncryption efficiency Test:\n')
for i = 1:n
    fprintf('%3.0f%s',(i-1)/n*100,"%");
    tic;
    encryption(P);
    total_time = total_time + toc;
    fprintf('\b\b\b\b');
end
average_time = total_time/n;
fprintf('Encryption Time = %f\n',average_time);
imsize = N*M;
ET = imsize/average_time;
fprintf('\nET = %f(Bps)\n', ET);
CPU_speed = 1.1*10^6;
fprintf('\nNumber of cycles per byte = %f \n', CPU_speed/ET);

rP = uint8(reshape(P',1, N*M));
hK = HashFunction(rP, 'SHA-256');
K = generateKey(hK);
tic
[E, E1] = MOTDCM(K);
fprintf('\nObtaining chaotic sequences Time = %f\n\n',toc);

tic
C_ = FShufflingAndDiffusion(rP, E, K(1));
fprintf('Forward shuffling and diffusion process Time = %f\n\n',toc);
tic
C_ = uint8(RDiffusion(C_, E1));
fprintf('Reverse diffusion process Time = %f\n\n',toc);








