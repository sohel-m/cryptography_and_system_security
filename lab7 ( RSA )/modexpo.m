function [out]=modexpo(A,B,n)
out = ones(size(A));
for i=1:length(A)
    a=A(i);
    b=B;
    while b>0    
        if mod(b,2)==1
            out(i) = mod(out(i)*a,n); 
        end
        a = mod(a*a,n);
        b = floor(b/2);
    end
end
end