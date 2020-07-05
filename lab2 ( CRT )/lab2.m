%%   Chinese Remainder Theorem 
%   Asks for 'k' no of equations in form of remainders, divisors
%   Displays the solution if all divisors coprime

% mulinv.m should be in the same folder !!!

clc;clear variables;close all;

%% Get remainders and divisors
k = input('Enter number of equations ');
M = 1;
for i = 1:k
    [rem(i),div(i)] = deal(input('Enter remainder '),input('Enter divisor '));
    M = M*div(i);
end

%% Checking if all divisors are coprime
for i = 1:k
    for j = i+1:k
        [mi,gcd] = mulinv(div(i),div(j));
        if(gcd ~= 1)
            fprintf('The calculation of answer not possible since the divisors are not coprime');
            return
        end
    end
end

%% Calculate answer if all the divisors are coprime
fprintf('The divisors are coprime\n');
for i = 1:k
    m(i) = M/div(i);
    minv(i) = mulinv(m(i),div(i));       
end
x = mod(sum(rem .* m .* minv),M);
fprintf('Answer: %d\n',x);