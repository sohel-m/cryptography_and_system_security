%%   AFFINE CIPHER
%   This program takes a user message string
%   Asks user for VALID multiplicative and additive cipher keys [k1,k2] 
%   Encrypts the message according to the key   C=(P*k1+k2)mod26
%   Decrypts and displays the message           D=((C-k2)*k1_inv))mod26

% mulinv.m should be in the same folder !!!

clc;clear variables;close all;

%% Getting Valid keys
[k1,k2] = deal(-1,-1);
while (k1==-1) || (k2==-1)
    if k1==-1
        temp = input('Enter multiplicative cipher key in Z-26* ');
        [mi,gcd] = mulinv(temp,26);
        if gcd == 1
            [k1,k1_inv] = deal(temp,mi);
        end
    elseif k2==-1
        temp = input('Enter additive cipher key in Z-26 ');
        if (temp>0) && (temp<26)
            k2=temp;
        end
    end
end

%% ENCRYPTION
msg = double(input('Enter message to be encrypted ','s'));
msg = msg - 65*ismember(msg,65:90) - 97*ismember(msg,97:122); % so that upper/lower case doesnt matter
enc_num = mod(msg*k1 + k2, 26);
enc_msg = char(enc_num + 97);
fprintf('The encrypted message is "%s"\n',enc_msg);

%% DECRYPTION
dec_num = mod((double(enc_msg)-97-k2)*k1_inv,26);
dec_msg = char(dec_num + 97);
fprintf('The decrypted message is "%s" ',dec_msg);
