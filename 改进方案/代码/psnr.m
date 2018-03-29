function [PSNR, MSE] = psnr(I,K) 
% �����ֵ�����PSNR  
Diff = double(I)-double(K);
MSE = sum(Diff(:).^2)/numel(I);
PSNR=10*log10(255^2/MSE);
end