clear;

%图像解密
rng('default');%先将随机数生成器设置为默认值
rng(0);%设置伪随机数种子为0
key_e=uint8(round(255*rand(256)));%随机生成一个图像加密密钥key_e

B1 = imread('加密图像_隐藏信息.bmp');
ss = size(B1);
if(length(ss) >= 3)
    P1(:,:,1) = bitxor(B1(:,:,1),key_e);
    P1(:,:,2) = bitxor(B1(:,:,2),key_e);%取图像的第二层来隐藏
    P1(:,:,3) = bitxor(B1(:,:,3),key_e);
    PP1 = P1(:,:,2);
else
    P1 = bitxor(B1, key_e);
    PP1 = P1;
end;
imwrite(P1,'解密图像_隐藏信息.bmp');

%信息提取及图像恢复
s = 14;%每块大小s*s
k = 8;%每k块一组
t = 3;%每组隐藏t个比特
g = 324;%一共分成了g块
o = 296;%需要o块

rng('default');%先将随机数生成器设置为默认值
rng(1);%设置伪随机数种子为1
key_h = randperm(g,o);%隐藏密钥对应o块，按密钥顺序每k块为一组

m=[];
for i=1:k:size(key_h')
    for a=i:i+k-1
        h = key_h(a)-1;
        x = (floor(h/floor(256/s)))*s+1;
        y = (mod(h,floor(256/s)))*s+1;
        T = PP1(x:x+s-1,y:y+s-1);
        f = SI(T);
        for j=1:s
            for kk=2:2:s
                if mod(j,2)==0
                    T(j,kk)=bitset(T(j,kk),4,~bitget(T(j,kk),4));
                else
                    T(j,kk-1)=bitset(T(j,kk-1),4,~bitget(T(j,kk-1),4));
                end;
            end;
        end;
        f1 = SI(T);
        if f>f1
            PP1(x:x+s-1,y:y+s-1) = T;
            m=[m,dec2bin(a-i,3)];
            continue;
        end;
    end;
end;
m=m';

%对信息进行处理，过滤掉其他信息
ends='00000';%结尾标记
l=0;
for i=1:8:size(m) %因为每个字符编码为8位，所以间隔为8
    if m(i:i+4)==ends'
         l=i-1;
         break;
    end;
end;
m0=m(1:l);

%将提取信息写入文件保存
out=bit2str(toBit(m0));
fid=fopen('提取信息.txt', 'wt');
fwrite(fid, out);
fclose(fid);

%保存恢复的图片
if(length(ss) >= 3)
    P1(:,:,2) = PP1;%取图像的第二层来隐藏
else
    P1 = PP1;
end;
imwrite(P1,'恢复图像.bmp');