function [output] = permutation(array,key)
% This function permutates the given array according to given key

output = zeros(size(key)); % size of key will be the size of output
for i=1:length(key)
    output(i) = array(key(i));
end
end
    