function [output] = checkPrime(p)
% returns 1 if prime ; 0 if not

if p == 1 
    output = 0; % 1 is neither prime nor composite
    return
end

output = 1;

for i = 2:ceil(p^0.5)     
    if i~=p && ~mod(p,i) 
        output = 0;
        return     
    end
end
end
