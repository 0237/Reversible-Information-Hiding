function y = toBit( x )
%将01字符串转为01数字比特串

y = [];
for n = 1:length(x)
    if(x(n) == '1')
       y(n) = 1;
    else
       y(n) = 0;
    end
end

end

