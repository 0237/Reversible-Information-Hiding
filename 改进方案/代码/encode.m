clear;

%ͼ�����
rng('default');%�Ƚ����������������ΪĬ��ֵ
rng(0);%����α���������Ϊ0
key_e=uint8(round(255*rand(256)));%�������һ��ͼ�������Կkey_e
%imwrite(key,'key.bmp');

%P = imread('lena_g.bmp');%���ٸı䵽���ĸ�����λ������ȫ���أ�ǰ��������
%P = imread('bw_g.bmp');%�ı������Чλ����
%P = imread('lu_g.bmp');
P = imread('lena.bmp');
ss = size(P);
if(length(ss) >= 3)
    B(:,:,1) = bitxor(P(:,:,1),key_e);
    B(:,:,2) = bitxor(P(:,:,2),key_e);%ȡͼ��ĵڶ���������
    B(:,:,3) = bitxor(P(:,:,3),key_e);
    BB = B(:,:,2);
else
    B = bitxor(P, key_e);
    BB = B;
end;
imwrite(B,'����ͼ��.bmp');

%��������Ϣת��Ϊ������
msgfid=fopen('������Ϣ.txt','r');%�������ļ�
[msg,msgcount]=fread(msgfid);
fclose(msgfid);
msg = str2bit(msg);
ends=[0,0,0,0,0,0,0,0];%��β���
msg=[msg,ends];
msg = msg';
msgcount=msgcount*8+8;

%Ƕ����Ϣ
s = floor(sqrt(256*256/(msgcount/3*8)));%ÿ���Сs*s
k = 8;%ÿk��һ��
t = 3;%ÿ������t������
g = (floor(256/s))^2;%һ���ֳ���g��
o = ceil(floor(msgcount/3)*8);%��Ҫo��

rng('default');%�Ƚ����������������ΪĬ��ֵ
rng(1);%����α���������Ϊ1
key_h = randperm(g,o);%������Կ������Կ˳��ÿk��Ϊһ��

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
    B(:,:,2) = BB;%ȡͼ��ĵڶ���������
else
    B = BB;
end;
imwrite(B,'����ͼ��_������Ϣ.bmp');