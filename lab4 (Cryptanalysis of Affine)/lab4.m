%% CRYPTANALYSIS OF AFFINE CIPHER using KNOWN PLAINTEXT
% C1 = (P1*k1 + k2)mod26
% C2 = (P2*k1 + k2)mod26

% mulinv.m should be in the same folder !!!

clc;clear variables;close all;

%% Get corresponding plaintext,ciphertext pairs
p = double(input('Enter Plaintext pair ','s'));
c = double(input('Enter Ciphertext pair ','s'));
p = p - 65*ismember(p,65:90) - 97*ismember(p,97:122); % so that upper/lower case doesnt matter
c = c - 65*ismember(c,65:90) - 97*ismember(c,97:122); % so that upper/lower case doesnt matter

%% Calculate keys
D = p(1)-p(2);
[D_inv,gcd] = mulinv(D,26);
if gcd ~= 1
    fprintf('Calculation of keys not possible for this plaintext pair ');
    return
end
k1 = mod(D_inv*(c(1)-c(2)),26);
k2 = mod(D_inv*(p(1)*c(2)-p(2)*c(1)),26);
k1_inv = mulinv(k1,26);
fprintf('The Keys k1, k2 are %d, %d \n',k1,k2);

%% DECRYPTION
enc_msg = double(input('Enter the encrypted message ','s'));
enc_msg = enc_msg - 65*ismember(enc_msg,65:90) - 97*ismember(enc_msg,97:122); % so that upper/lower case doesnt matter
dec_num = mod((enc_msg-k2)*k1_inv,26);
dec_msg = char(dec_num + 97);
fprintf('The decrypted message is "%s" ',dec_msg);
