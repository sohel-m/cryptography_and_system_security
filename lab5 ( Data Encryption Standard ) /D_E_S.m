function [output64] = D_E_S(input64,key64,mode)
% The input,key should be of 64 bits !!!
% The mode should be either 'enc' or 'dec' for encryption/decryption
% respectively !!!

% permutation.m, sbox_perm.m should be in the same folder !!!

%% DES Fixed Variables (taken from https://en.wikipedia.org/wiki/DES_supplementary_material )
initial_perm_key = [58 50 42 34	26 18 10 2 ...
                    60 52 44 36	28 20 12 4 ...
                    62 54 46 38	30 22 14 6 ...
                    64 56 48 40	32 24 16 8 ...
                    57 49 41 33	25 17 9	 1 ...
                    59 51 43 35	27 19 11 3 ...
                    61 53 45 37	29 21 13 5 ...
                    63 55 47 39	31 23 15 7];
                
final_perm_key = [40 8	48 16 56 24 64 32 ...
                  39 7	47 15 55 23 63 31 ...
                  38 6	46 14 54 22 62 30 ...
                  37 5	45 13 53 21 61 29 ...
                  36 4	44 12 52 20 60 28 ...
                  35 3	43 11 51 19 59 27 ...
                  34 2	42 10 50 18 58 26 ...
                  33 1	41 9  49 17 57 25];

expansion_p_key = [32 1  2  3  4  5  ...
                   4  5  6  7  8  9  ...
                   8  9  10 11 12 13 ...
                   12 13 14 15 16 17 ...
                   16 17 18 19 20 21 ...
                   20 21 22 23 24 25 ...
                   24 25 26 27 28 29 ...
                   28 29 30 31 32 1];
                              
straight_p_key =[16 7  20 21 29 12 28 17 ... 
                 1  15 23 26 5  18 31 10 ...
                 2  8  24 14 32 27 3  9 ...
                 19 13 30 6  22 11 4  25];
                
PC1L_key = [57	49 41 33 25 17	9 ...
            1	58 50 42 34 26	18 ...
            10	2  59 51 43 35	27 ...
            19	11 3  60 52 44	36];
        
PC1R_key = [63 55 47 39	31 23 15 ...
            7  62 54 46	38 30 22 ... 
            14 6  61 53	45 37 29 ...
            21 13 5  28	20 12 4];
         
PC2_key = [14 17 11 24 1  5  3  28 ...
       15 6  21 10 23 19 12 4 ...
       26 8  16	7  27 20 13 2 ...
       41 52 31	37 47 55 30 40 ...
       51 45 33	48 44 49 39 56 ...
       34 53 46	42 50 36 29 32];


%% Round keys generation (for all 16 rounds,stored in 'round_keys')

shift = [1 1 2 2 2 2 2 2 1 2 2 2 2 2 2 1];
round_key = zeros(16,48);
% dropping parity bits, separating into left, right keys
l_key28 = permutation(key64, PC1L_key);
r_key28 = permutation(key64, PC1R_key);
% shifting left,right keys and compressing them to 48 bits
for i = 1:16
    l_key28 = [l_key28(1+shift(i):end),l_key28(1:shift(i))];
    r_key28 = [r_key28(1+shift(i):end),r_key28(1:shift(i))];
    round_key(i,:) = permutation([l_key28,r_key28],PC2_key);
end

%% Initial permutation of the 64-bit input and splitting in left,right parts of 32 bits

input64 = permutation(input64, initial_perm_key);

if mode == 'enc'
    lpt32 = input64(1:32);
    rpt32 = input64(33:64);
elseif mode == 'dec'
    lpt32 = input64(33:64);
    rpt32 = input64(1:32);
else
    fprintf('Enter correct mode - (enc/dec) \n');
    return
end 

%% Feistel/DES function (f) 
for i=1:16
    swap_left = rpt32;
    
    % EXPANSION P BOX 
    rpt48 = permutation(rpt32, expansion_p_key);
    
    % KEY MIXING
    rpt_xor48 = xor(rpt48,round_key(i,:));
    if mode == 'dec'
        rpt_xor48 = xor(rpt48,round_key(17-i,:)); % Applying keys in reverse for decryption
    end
    
    % SUBSTITUTION BOX
    rpt_sbox32 = sbox_perm(rpt_xor48);
    
    % STRAIGHT P BOX 
    rpt32 = permutation(rpt_sbox32, straight_p_key);
    
    % MIXING AND SWAPPING
    swap_right = xor(rpt32,lpt32);
    lpt32 = swap_left;
    rpt32 = swap_right; 
end

%% Combining left,right parts of 32 bits and Final permutation of the 64-bit output 
output64 = [lpt32,rpt32];
if mode == 'dec'
    output64 = [rpt32,lpt32]; % Swapping order for decryption
end
output64 = permutation(output64, final_perm_key);

end