function [a b c]=jblock(pole,M)    
[fm cm]=size(M);
N=[];
for i=1:cm,
    N=cat(1,M{i},N);
    r(i)=rank(N);
end
%r(end)=numero de bloques de jordan
orden=length(M);
br1=[];bor=0;
for i=1:orden%longitud  de M
    [fm1 cm1]=size(M{i});
    for j=1:fm1,
        br1=cat(1,br1,M{i}(j,:));
        rb=rank(br1);
        if rb==r(i)
            [fbr1 cbr1]=size(br1);
            if fbr1>r(i)
                br1(end,:)=[];
            end
            break;
        else
            br1(end,:)=[];
        end
    end
    br1tc=conj(br1');
    nb=br1*br1tc;%debe ser nosingular
    if det(nb)~=0 && ~isempty(nb)
        cr1{i}=M{i}*br1tc*inv(nb);
    else
        bor=1;
        break;
    end
end
or=orden;
ta=0;
B=[];C=[];c1=[];i1=1;
[fbr1 cbr1]=size(br1);
for i=1:r(end)
    %tamano de cada bloque en or??
    if bor==1,%bandera para saber cuando no es posible
        %descomponer la matriz ''singular''
        B=eye(cm1);
        C=M{i};
        break;
    else
        b1=zeros(or,cbr1);
        b1(end,:)=br1(i,:);
        B=cat(1,B,b1);
        b1=[];
        for j=i1:length(r)
            c1=cat(2,c1,cr1{j}(:,i));
        end
        C=cat(2,C,c1);
        c1=[];
        i1=i1+1;
        or=or-1;
    end
end
or=orden;
ta=0;
A=[];a=0;
for i=1:r(end)
    if bor==1
        A=pole*eye(cm1);
    else
        ta=or+ta;%tamano del bloque de A
        A(a+1:a+or,a+1:a+or)=orgblock(or,pole);
        a=or+a;
        or=or-1;
    end
end
a=A;b=B;c=C;

%----------SUBFUNCTION-----------%%
function Ar=orgblock(or,pole)
Ar=pole*eye(or);
for i=1:or-1
    Ar(i,i+1)=1;
end


