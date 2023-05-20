function [npcr, uaci, baci] = NPCR_UACI_BACI(ChiperImg,ChiperImg1bit)
    f1 = double(ChiperImg);
    f2 = double(ChiperImg1bit);
    [M, N] = size(f1);
    % NPCR
    d = 0.000000;
    for i = 1 : M
        for j = 1 : N
            if f1(i, j) ~= f2(i, j)         
               d = d + 1;
            end
        end
    end
    npcr = (d / (M * N)*100);

    % UACI
    c = 0.000000;
    for i = 1 : M * N
         c = c + abs(f1(i) -  f2(i));
    end
    uaci = (c / (255 * M * N)*100);
    
    % BACI
    b= 0.000000;
    for i = 1 : M-1
        for j = 1 : N-1
           b = b + m(i, j, f1, f2);
        end
    end
    baci = ( b/( 255*(M-1)*(N-1) ) )*100;
end

function out = m(i, j, P, C)
out = 0.000000;
    for l = 1 : 3
        for k = l+1 : 4
            out = out + abs(d(i,j,l,P,C) - d(i,j,k,P,C));
        end
    end
    out = out/6;
end

function out = d(i, j, k, P, C)
% fprintf('k=%d,  i=%d,  j=%d \n',k,(k>2),(mod(k,2)==0))
out = abs(P(i+(k>2), j+(mod(k,2)==0)) - C(i+(k>2), j+(mod(k,2)==0)));
end



