a=imread('lena_g.bmp');
b=imread('�ָ�ͼ��.bmp');
%b=imread('lena_g.bmp');
[PSNR, MSE]=psnr(a,b)
% 
c=imread('����ͼ��_������Ϣ.bmp');
[PSNR1, MSE1]=psnr(a,c)