%% Data Encryption Standard
% Takes a string from user and encrypts it using DES with a random generated 64-bit key 
% It displays encrypted string and decrypts it using DES with the same key

% D_E_S.m, permutation.m, sbox_perm.m should be in the same folder !!!

clc;clear variables;close all;

msg = double(input('Enter message -> ','s'));
bits = 8; % the no. of bits used to represent a symbol. For representing all 
          % ASCII values we need minimum 7 bits, I chose 8 here for
          % convenience

%% Appending spaces(ascii=32) to original msg to make bit stream perfectly divisble into 64-bit blocks
while mod(length(msg)*bits,64) ~= 0
    msg = horzcat(msg,32); 
end
msg_bit = zeros(1,length(msg)*bits);
for i=1:length(msg)
    msg_bit((i-1)*bits+1:i*bits) = de2bi(msg(i),'left-msb',bits);
end

%% Random 64-bit key generated
key = round(rand(8,7));
key(:,8) = mod(sum(key,2),2); % parity column
key = reshape(key',1,64);

%% Encrypting message bits block by block ( of size 64 bits)
enc_bit = zeros(1,length(msg_bit));
for i=1:length(msg_bit)/64
    enc_bit((i-1)*64+1:i*64) = D_E_S(msg_bit((i-1)*64+1:i*64),key,'enc'); % calling DES for encryption
end

%% Displaying Encrypted message
enc_msg = zeros(1,length(enc_bit)/bits);
for i = 1:length(enc_bit)/bits
    enc_msg(i) = bi2de(enc_bit((i-1)*bits+1:i*bits),'left-msb');
end
fprintf('\nThe encrypted message is -> %s\n',char(enc_msg));

%% Decrypting encrypted bits block by block ( of size 64 bits)
dec_bit = zeros(1,length(enc_bit));
for i=1:length(enc_bit)/64
    dec_bit((i-1)*64+1:i*64) = D_E_S(enc_bit((i-1)*64+1:i*64),key,'dec'); % calling DES for decryption
end

%% Displaying Encrypted message
dec_msg = zeros(1,length(dec_bit)/bits);
for i = 1:length(dec_bit)/bits
    dec_msg(i) = bi2de(dec_bit((i-1)*bits+1:i*bits),'left-msb');
end
fprintf('\nThe decrypted message is -> %s\n',char(dec_msg));
