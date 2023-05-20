function CC=AdjancyCorrPixelRandNew(Orignal,Encrypted) 
    Orignal=double(Orignal);
    Encrypted=double(Encrypted);
    %
    k = 1000;
    [m,n] = size(Orignal);    %// works with 3- and 1-channel images
    m=m-1;
    n=n-1;
    s = randsample(m*n, k);        %// get k random indices
    [X, Y] = ind2sub([m, n], s);   %// convert indices to x,y coordinates
    %
    figure,  title('horizontal Original')
    subplot(2,4,1),imshow(uint8(Orignal));
    subplot(2,4,5),imshow(uint8(Encrypted));
    % horizontal
    CC(1,:) = plotCC(Orignal, Encrypted, X, Y, 'horizontal');
    
    % vertical 
    CC(2,:) = plotCC(Orignal, Encrypted, X, Y, 'vertical');

    % diagonal 
    CC(3,:) = plotCC(Orignal, Encrypted, X, Y, 'diagonal');
    
    fprintf('\n\n%20s %15s %15s %15s %15s\n'," ", "Vertical", "Horizontal", "Diagonal", "Average value");
    fprintf('Lena%16s %15.4f %15.4f %15.4f %15.4f\n'," ", CC(2,1), CC(1,1), CC(3,1), (CC(3,1)+CC(1,1)+CC(2,1))/3);
    fprintf('%20s %15.4f %15.4f %15.4f %15.4f\n\n',"Cipher-image of Lena", CC(2,2), CC(1,2), CC(3,2), (CC(3,2)+CC(1,2)+CC(2,2))/3);

end

function CC = plotCC(Orignal, Encrypted, X, Y, adjacent)
    switch(adjacent)
        case 'horizontal'
            x =0;y=1;n=2;
        case 'vertical'
            x =1;y=0;n=3;
        case 'diagonal'
            x =1;y=1;n=4;
    end
    xO = Orignal(X,Y); 
    yO = Orignal(X+x,Y+y); 
    o_xy = corrcoef(xO,yO);
    subplot(2,4,n),% title('Diagonal Original')
    scatter(xO(:),yO(:),'.')
    axis([0 255 0 255]) 
    box on
    xlabel('Pixel gray value on location (x,y)') 
    ylabel(['Pixel gray value on location (x+',num2str(x),', y+',num2str(y),')']) 
    
    xE = Encrypted(X,Y); 
    yE = Encrypted(X+x,Y+y); 
    e_xy = corrcoef(xE,yE);
    subplot(2,4,n+4), %title('Diagonal Encrypted')
    scatter(xE(:),yE(:),'.')
    axis([0 255 0 255])
    box on
    xlabel('Pixel gray value on location (x,y)') 
    ylabel(['Pixel gray value on location (x+',num2str(x),', y+',num2str(y),')']) 
    
    CC(1,1:2)=[o_xy(1,2),e_xy(1,2)];
end
