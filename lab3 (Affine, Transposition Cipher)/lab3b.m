%%   TRANSPOSITION ENCRYPTION
%   This program takes a user message string
%   Asks user to define the null character and the key
%   Encrypts the message according to the key
%   Decrypts and displays the message

clc;clear variables;close all;

%% Get message, null character and key
msg = input('Enter message string -> ','s');
null = input('Enter null character -> ','s');
enc_key = input('Enter encryption key in square brackets -> ');
keysize = length(enc_key);
rows = ceil(length(msg)/keysize);

%% Adding extra null chr
extra = (keysize*rows)-length(msg);
for i = 1:extra
    msg = strcat(msg,null);
end 
msg_matrix = reshape(msg,[keysize,rows])';

%% Encoding
for i = 1:keysize
    enc_matrix(:,i) = msg_matrix(:,enc_key(i));
end
enc_msg = reshape(enc_matrix,[1,rows*keysize]);
fprintf('The encrypted message is  -> "%s"\n',enc_msg);

%% Decoding without Decryption Key 
for i = 1:keysize
    dec_matrix(:,enc_key(i)) = enc_matrix(:,i);
end
dec_msg = reshape(dec_matrix',[1,rows*keysize]);
fprintf('The decrypted message is  -> "%s"',dec_msg);


%% Decryption Key generation
% for i=1:keysize
%     dec_key(i)=find(enc_key==i); 
% end
% fprintf('The decryption key is');
% disp(dec_key);

