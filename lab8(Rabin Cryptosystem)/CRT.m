function [x] = CRT(a,d)
if length(a)~=length(d)
    fprintf('Dimensions of given arrays do not match');
    return
end
k = length(d);
M = 1;
%% Checking if all divisors are coprime
for i = 1:k
    M = M * d(i);
    for j = i+1:k
        [mi,gcd] = mulinv(d(i),d(j));
        if(gcd ~= 1)
            fprintf('\nThe calculation of answer not possible since the divisors are not coprime\n');
            return
        end
    end
end
%% Calculate answer if all the divisors are coprime
%fprintf('The divisors are coprime\n');
for i = 1:k
    m(i) = M/d(i);
    minv(i) = mulinv(m(i),d(i));       
end
x = mod(sum(a .* m .* minv),M);
%fprintf('Answer: %d\n',x);
end