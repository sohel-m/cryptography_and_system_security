%% Image Encryption using a combination of Affine and Transposition cipher

% This will use four keys. 2 for affine transformation (k1, k2)
% And other 2 for transposition along rows and columns (rowkey,columnkey)

% This program can handle both grayscale and rgb images of any size

clc;clear variables;close all;

%% Read Image
I = imread('switzerland.jpg');
dim = size(I);
[rows,columns]=deal(dim(1),dim(2));
%% Key generation (randomly)
columnkey = randperm(columns,columns);
rowkey = randperm(rows,rows);
k1 = -1;
while (k1==-1)
    temp = randperm(255,1);
    [mi,gcd] = mulinv(temp,256);
    if gcd == 1
        [k1,k1_inv] = deal(temp,mi);
    end
end
k2 = randperm(255,1);
%% Encryption ( using k1,k2,rowkey,columnkey )
if length(dim)==3 % i.e if RGB image 
    for i = 1:columns
        E1(:,i,:) = I(:,columnkey(i),:);
    end
    imwrite(E1,'stage1.png');
    for i = 1:rows
        E2(i,:,:) = E1(rowkey(i),:,:);
    end
else
    for i = 1:columns
        E1(:,i) = I(:,columnkey(i));
    end
    imwrite(E1,'stage1.png');
    for i = 1:rows
        E2(i,:) = E1(rowkey(i),:);
    end  
end

imwrite(E2,'stage2.png');
E2 = double(E2(:)); % converting to double before applying affine transform 
E2 = uint8(mod(E2*k1+k2,256));
E3 = reshape(E2,dim);
imwrite(E3,'encrypted.png');
%% Decryption ( using k1,k2,rowkey,columnkey )
D1 = imread('encrypted.png');
dim = size(D1);
D1 = double(D1(:)); % converting to double before applying affine transform
D1 = uint8(mod((D1-k2)*k1_inv,256));
D2 = reshape(D1,dim);
if length(dim)==3
    for i = 1:dim(1)
        D3(rowkey(i),:,:) = D2(i,:,:);
    end
    for i = 1:dim(2)
        D(:,columnkey(i),:) = D3(:,i,:);
    end
else
    for i = 1:dim(1)
        D3(rowkey(i),:) = D2(i,:);
    end
    for i = 1:dim(2)
        D(:,columnkey(i)) = D3(:,i);
    end
end
imwrite(D,'decrypted.png');