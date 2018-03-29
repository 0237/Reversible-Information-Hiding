clear;

%图像加密
rng('default');%先将随机数生成器设置为默认值
rng(0);%设置伪随机数种子为0
key_e=uint8(round(255*rand(256)));%随机生成一个图像加密密钥key_e
%imwrite(key,'key.bmp');

%P = imread('lena_g.bmp');%至少改变到第四个比特位才能完全隐藏，前三个不行
%P = imread('bw_g.bmp');%改变最低有效位即可
%P = imread('lu_g.bmp');
P = imread('lena.bmp');
ss = size(P);
if(length(ss) >= 3)
    B(:,:,1) = bitxor(P(:,:,1),key_e);
    B(:,:,2) = bitxor(P(:,:,2),key_e);%取图像的第二层来隐藏
    B(:,:,3) = bitxor(P(:,:,3),key_e);
    BB = B(:,:,2);
else
    B = bitxor(P, key_e);
    BB = B;
end;
imwrite(B,'加密图像.bmp');

%将秘密信息转化为二进制
msgfid=fopen('隐藏信息.txt','r');%打开秘密文件
[msg,msgcount]=fread(msgfid);
fclose(msgfid);
msg = str2bit(msg);
ends=[0,0,0,0,0,0,0,0];%结尾标记
msg=[msg,ends];
msg = msg';
msgcount=msgcount*8+8;

%嵌入信息
s = floor(sqrt(256*256/(msgcount/3*8)));%每块大小s*s
k = 8;%每k块一组
t = 3;%每组隐藏t个比特
g = (floor(256/s))^2;%一共分成了g块
o = ceil(floor(msgcount/3)*8);%需要o块

rng('default');%先将随机数生成器设置为默认值
rng(1);%设置伪随机数种子为1
key_h = randperm(g,o);%隐藏密钥，按密钥顺序每k块为一组

for i = 1 :  msgcount
    if i*3<=msgcount
        m(i)=bin2dec(toStr(msg(i*3-2:i*3)));
    end;
end;

for i=1:size(m')
    mi = key_h(m(i)+i*k-7)-1;
    x = (floor(mi/floor(256/s)))*s+1;
    y = (mod(mi,floor(256/s)))*s+1;
    T = BB(x:x+s-1,y:y+s-1);
    for j=1:s
        for kk=2:2:s
            if mod(j,2)==0
                T(j,kk)=bitset(T(j,kk),4,~bitget(T(j,kk),4));
            else
                T(j,kk-1)=bitset(T(j,kk-1),4,~bitget(T(j,kk-1),4));
            end;
        end;
    end;
    BB(x:x+s-1,y:y+s-1) = T;
end;
if(length(ss) >= 3)
    B(:,:,2) = BB;%取图像的第二层来隐藏
else
    B = BB;
end;
imwrite(B,'加密图像_隐藏信息.bmp');