function out = bit2str(in)
% 将比特串解码为字符串

out = [''];
len = round(length(in)/8);
for n = 1:len
    temp = in((n - 1) * 8 + 1:n * 8);
    temp = toStr(temp);
    out(n) = bin2dec(temp);
end

end