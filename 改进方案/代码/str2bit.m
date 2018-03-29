function data = str2bit(varargin)
% 将字符串编码为比特串

source = '';
str = '';
if nargin == 0
	source = input('please enter the plain text you want to send:\n', 's');
else
    source = varargin{1};
end
source_len = length(source) * 8;
data = zeros(1, source_len);
for n = 1:length(source)
    temp = dec2bin(source(n), 8);
    str = strcat(str, temp);
end
for n = 1:source_len
    if str(n) == '0'
        data(n) = 0; 
    elseif str(n) == '1'
        data(n) = 1;
    else
        fprintf(1, 'error bit');
        return
    end
end

end