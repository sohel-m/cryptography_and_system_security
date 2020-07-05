% Extended Euclidean Theorem to calculate GCD, Multiplicative Inverse

% mulinv.m should be in the same folder !!!

clc;clear variables;close all;

r1 = input('Enter a ');
r2 = input('Enter b ');

[mi,gcd] = mulinv(r1,r2);
if gcd == 1
    fprintf('GCD( %d, %d)= %d and the Multiplicative inverse is %d\n ',r1,r2,gcd,mi);
else
    fprintf('GCD( %d, %d)= %d and hence Multiplicative inverse does not exist.\n ',r1,r2,gcd);
end
    
