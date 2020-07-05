function [output] = lcm(a,b)

if a>b
    large = a;
else
    large = b;
end

for i = large:a*b
    if mod(i,a)==0 && mod(i,b)==0
        output = i;
        return
    end   
end
end
        