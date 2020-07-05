function [pad_msg] = padding(msg)

pad_msg=zeros(size(msg));

for i=1:length(msg)
    bin_msg = dec2bin(msg(i)); % msg converted to binary
    bin_pad_msg = strcat(bin_msg,bin_msg);%  binary sequence padded
    pad_msg(i) = bin2dec(bin_pad_msg);% back to decimal form
end

end