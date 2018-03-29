function [ f ] = SI( P )
%¼ÆËãÍ¼Ïñ¿éÆ½»¬¶È

P = double(P);
[m n] = size(P);
d1=0;
for u=2:m-1
    for v=2:n-1
        d1=d1+abs(P(u,v)-(P(u-1,v)+P(u,v-1)+P(u+1,v)+P(u,v+1))/4);
    end;
end;

d21=0;
d22=0;
for u=1:m
    for v=1:n-1
        d21=d21+abs(P(u,v)-P(u,v+1));
    end;
end;
for u=1:m-1
    for v=1:n
        d22=d22+abs(P(u,v)-P(u+1,v));
    end;
end;
d2=d21+d22;

d31=0;
d32=0;
d33=0;
d34=0;
for v=2:n-1
    d31=d31+abs(P(1,v)-(P(1,v-1)+P(1,v+1)+P(2,v))/3);
    d32=d32+abs(P(m,v)-(P(m,v-1)+P(m,v+1)+P(m-1,v))/3);
end;
for u=2:m-1
    d33=d33+abs(P(u,1)-(P(u-1,1)+P(u+1,1)+P(u,2))/3);
    d34=d34+abs(P(u,n)-(P(u-1,n)+P(u+1,n)+P(u,n-1))/3);
end;
d3=d31+d32+d33+d34+abs(P(1,1)-(P(1,2)+P(2,1))/2)+abs(P(1,n)-(P(1,n-1)+P(2,n))/2)+abs(P(m,1)-(P(m-1,1)+P(m,2))/2)+abs(P(m,n)-(P(m,n-1)+P(m-1,n))/2);

f=d1+d2+d3;

end

