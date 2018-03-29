function y = toStr(x)
%将比特串转为01字符串

y = '';
for n = 1:length(x)
    if(x(n) == 1)
       y = strcat(y, '1');
    else
       y = strcat(y, '0');
    end
end

end