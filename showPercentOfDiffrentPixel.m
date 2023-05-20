function dp = showPercentOfDiffrentPixel(A, B)
% percentage of different pixels between the two images 
global N
cnt = 0;
for i = 1:N
    for j = 1:N
        if(A(i,j)~=B(i,j))
            cnt = cnt + 1;
        end
    end
end
dp = cnt/N/N*100;
disp([num2str(cnt), '/', num2str(N*N), ' = ', num2str(dp), '%'])
disp(' ')
end
