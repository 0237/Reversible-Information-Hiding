clear;

%ͼ�����
rng('default');%�Ƚ����������������ΪĬ��ֵ
rng(0);%����α���������Ϊ0
key_e=uint8(round(255*rand(256)));%�������һ��ͼ�������Կkey_e

B1 = imread('����ͼ��_������Ϣ.bmp');
ss = size(B1);
if(length(ss) >= 3)
    P1(:,:,1) = bitxor(B1(:,:,1),key_e);
    P1(:,:,2) = bitxor(B1(:,:,2),key_e);%ȡͼ��ĵڶ���������
    P1(:,:,3) = bitxor(B1(:,:,3),key_e);
    PP1 = P1(:,:,2);
else
    P1 = bitxor(B1, key_e);
    PP1 = P1;
end;
imwrite(P1,'����ͼ��_������Ϣ.bmp');

%��Ϣ��ȡ��ͼ��ָ�
s = 14;%ÿ���Сs*s
k = 8;%ÿk��һ��
t = 3;%ÿ������t������
g = 324;%һ���ֳ���g��
o = 296;%��Ҫo��

rng('default');%�Ƚ����������������ΪĬ��ֵ
rng(1);%����α���������Ϊ1
key_h = randperm(g,o);%������Կ��Ӧo�飬����Կ˳��ÿk��Ϊһ��

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

%����Ϣ���д������˵�������Ϣ
ends='00000';%��β���
l=0;
for i=1:8:size(m) %��Ϊÿ���ַ�����Ϊ8λ�����Լ��Ϊ8
    if m(i:i+4)==ends'
         l=i-1;
         break;
    end;
end;
m0=m(1:l);

%����ȡ��Ϣд���ļ�����
out=bit2str(toBit(m0));
fid=fopen('��ȡ��Ϣ.txt', 'wt');
fwrite(fid, out);
fclose(fid);

%����ָ���ͼƬ
if(length(ss) >= 3)
    P1(:,:,2) = PP1;%ȡͼ��ĵڶ���������
else
    P1 = PP1;
end;
imwrite(P1,'�ָ�ͼ��.bmp');