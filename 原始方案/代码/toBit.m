function y = toBit( x )
%��01�ַ���תΪ01���ֱ��ش�

y = [];
for n = 1:length(x)
    if(x(n) == '1')
       y(n) = 1;
    else
       y(n) = 0;
    end
end

end

