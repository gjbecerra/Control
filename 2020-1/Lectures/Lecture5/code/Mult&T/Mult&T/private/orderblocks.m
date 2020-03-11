function [Aj Bj Cj]=orderblocks(a,b,c)
%a,b,c deben estar en forma de jordan
v1=findv(a,'jordan');
lv=length(v1);
j=v1(1);
j1=j;
for i=1:lv,%hallar los polos asociados por bloque "M"
    pv(i)=a(j1,j1);
    Ma{i}=a(j1-v1(i)+1:j1,j1-v1(i)+1:j1);
    Mb{i}=b(j1-v1(i)+1:j1,:);
    Mc{i}=c(:,j1-v1(i)+1:j1);
    %j=j+v1(i);
    if i~=lv
        j1=j1+v1(i+1);
    end
end
[pv,in] = sort(pv);
j=1;
while j<=length(in)
    Na{j,j}=Ma{in(j)};
    Nb{j}=Mb{in(j)};
    Nc{j}=Mc{in(j)};
   % v(j)=v1(in(j));
    j=j+1;
end
Na=normcell(Na,'rc');
Aj=cell2mat(Na);
Bj=cell2mat(Nb');
Cj=cell2mat(Nc);
