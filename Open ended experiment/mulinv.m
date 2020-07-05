function [mi,gcd,s1,t1] = mulinv(r1,r2)
% This function calculates the greatest common divisor(gcd) of r1 & r2 and the 
% multiplicative inverse(mi) of r1 in modulus of r2. 
% It also returns 's1' and 't1' of the Extended Euclidean Algorithm
% 'mi' is valid only if 'gcd' == 1 !!!

[a,b,s1,s2,t1,t2] = deal(r1,r2,1,0,0,1);

while(r2 ~= 0)
    q = floor(r1/r2);
    r = r1-(r2*q);
    s = s1-(s2*q);
    t = t1-(t2*q);   
    [r1,r2,s1,s2,t1,t2] = deal(r2,r,s2,s,t2,t);
end
gcd = r1;
mi = mod(s1,b);
end
