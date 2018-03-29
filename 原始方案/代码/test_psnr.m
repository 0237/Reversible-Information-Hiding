a=imread('lena_g.bmp');
b=imread('»Ö¸´Í¼Ïñ.bmp');
%b=imread('lena_g.bmp');
[PSNR, MSE]=psnr(a,b)
% 
c=imread('½âÃÜÍ¼Ïñ_Òş²ØĞÅÏ¢.bmp');
[PSNR1, MSE1]=psnr(a,c)