%% RABIN  CRYPTOSYSTEM
% Two distinct prime nos. chosen by 1st party (private key) -> p and q
% public key of 1st party -> n (= p * q)

% the prime pairs selected should be such that 0 <= m < n ; where m is any plaintext !!!
% n should be chosen according to the padding scheme, here it should be
% larger than binary replication of m

% checkPrime.m, mulinv.m, padding.m, modexpo.m, CRT.m should be in the same folder !!!

% some large primes congruent to 3mod4 => 9007,9043,9067,9127,9187,9227,9283,9319,9787 
clc;clear variables;close all;

%% Getting Valid primes p and q
[p,q] = deal(-1,-1);
while (p == -1) || (q == -1)
    if p == -1
        temp = input('Enter a distinct prime no. p such that mod(p,4)=3  ->');
        if checkPrime(temp) && mod(p,4)==3
            p = temp;
        end
    elseif q == -1
        temp = input('Enter another distinct prime no. q such that mod(q,4)=3 ->');
        if checkPrime(temp) && mod(p,4)==3 && (temp~=p)
            q = temp;
        end
    end
end

%% KEY GENERATION
n = p*q;

%% KEY DISTRIBUTION
% The second party gets the public key (n)

%% ENCRYPTION
msg = double(input('Enter the message to be encrypted by 2nd party -> ','s'));

%padding message by replication since we need to select correct message from 4 different outputs !
pad_msg = padding(msg);

if any(pad_msg > n)
    fprintf('The chosen primes should be larger for encrypting this message\n')
    return
end
enc_msg = modexpo(pad_msg,2,n);

%% DECRYPTION
dec_msg = zeros(size(enc_msg));
for i=1:length(enc_msg)
    
    a1 = modexpo(enc_msg(i),(p+1)/4,p);
    b1 = modexpo(enc_msg(i),(q+1)/4,q);
    a2 = -a1;
    b2 = -b1;
    
    p1 = CRT([a1,b1],[p,q]);
    p2 = CRT([a1,b2],[p,q]);
    p3 = CRT([a2,b1],[p,q]);
    p4 = CRT([a2,b2],[p,q]);

    choices = [p1,p2,p3,p4];
    
    for j=1:4
        m_bin = dec2bin(choices(j));
        pl = length(m_bin);
        if mod(pl,2)==0
            if m_bin(1:end/2) == m_bin(end/2 +1 : end)
                dec_msg(i) = bin2dec(m_bin(1:end/2));
            end
        end
    end
end
fprintf('The message decrypted by the first party is -> %s \n',char(dec_msg));

