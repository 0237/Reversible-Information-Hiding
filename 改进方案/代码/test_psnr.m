a=imread('lena.bmp');
b=imread('�ָ�ͼ��.bmp');

[PSNR, MSE]=psnr(a,b)

c=imread('����ͼ��_������Ϣ.bmp');
[PSNR1, MSE1]=psnr(a,c)