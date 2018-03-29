function [PSNR, MSE] = psnr(I,K) 
% 计算峰值信噪比PSNR  
Diff = double(I)-double(K);
MSE = sum(Diff(:).^2)/numel(I);
PSNR=10*log10(255^2/MSE);
end