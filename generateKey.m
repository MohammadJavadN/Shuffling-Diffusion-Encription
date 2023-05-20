function K = generateKey(h)
K = hex2dec(reshape(h,2,32)')';
% K = KeyDecimal(h);
h1 = bitXOR(K(1:8))/32;
h2 = h1 + bitXOR(K(9:16))/64;
h3 = h2 + bitXOR(K(17:24))/128;
h4 = h3 + bitXOR(K(24:32))/256;
a = 5 + mod((h1+h2)*10^14,255)/256;
b = 5 + mod((h1+h3)*10^14,255)/256;
lambda1 = 2 + mod((h1+h4)*10^14,255)/256;
lambda2 = 2 + mod((h1+h3)*10^14,255)/256;
x0 = 0.2 + mod((h2+h4)*10^14,255)/256;
y0 = 0.3 + mod((h3+h4)*10^14,255)/256;
K = [a, b, lambda1, lambda2, x0, y0];
end

function x = bitXOR(k)
ln = length(k);
for i = 1:ln-1
    k(i+1) = bitxor(k(i),k(i+1));
end
x = k(ln);
end



