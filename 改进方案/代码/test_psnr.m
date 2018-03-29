a=imread('lena.bmp');
b=imread('»Ö¸´Í¼Ïñ.bmp');

[PSNR, MSE]=psnr(a,b)

c=imread('½âÃÜÍ¼Ïñ_Òş²ØĞÅÏ¢.bmp');
[PSNR1, MSE1]=psnr(a,c)