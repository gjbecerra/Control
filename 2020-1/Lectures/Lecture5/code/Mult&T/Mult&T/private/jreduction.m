function [ar br cr]=jreduction(aj,bj,cj)
v=findv(aj,'jordan');
la=length(aj);
%ro=rank(obsv(aj,cj));
%un=length(aj)-ro;
if la==1
    %disp('El sistema ya es mínimo')
    ar=aj;br=bj;cr=cj;
    return
else
    k=0;
    mv=max(v);
    for i=1:length(v)%separar y normalizar cada matrix
        k=k+v(i);
        Mc{i}=cj(:,(k-v(i)+1):k);
        [fmc cmc]=size(Mc{i});
        if cmc~=mv
            Mc{i}=cat(2,Mc{i},zeros(fmc,mv-cmc));
        end
        Mb{i}=bj((k-v(i)+1):k,:);
        [fmb cmb]=size(Mb{i});
        if fmb~=mv
            Mb{i}=cat(1,Mb{i},zeros(mv-fmb,cmb));
        end
    end
    %calcular a1 y a2...an
    ne=length(v)-1;%numero de ecuaciones
    if ne>fmc
        ne=fmc;
    end
    z=-Mc{end}(1:ne,1);
    m=[];
    for i=1:ne
        m=cat(2,m,Mc{i}(1:ne,1));
    end
    nc=0;
    if det(m)==0
        for i=1:(ne-1)
            x(i)=(-1)^(i);
            nc=nc+x(i)*Mc{i}(1,1);
        end
        if isempty(i)
            i=0;
        end
        x(i+1)=(z(1)-nc)/Mc{i+1}(1,1);
        for i=1:length(x)
            if isinf(x(i)) || isnan(x(i));
                x(i)=-1;
            end
        end
    else
        x=inv(m)*z;
    end
    for i=1:ne,%aplicar regla de combinacion
        Mb{i}=Mb{i}-x(i)*Mb{end};
        Mc{end}=Mc{end}+x(i)*Mc{i};
    end
    %aplicar regla de desplazamiento
    vb= circshift(Mc{end},[0 -1]);
    Mc{end}=vb;
    vb=circshift(Mb{end},[-1 0]);
    Mb{end}=vb;
    m=[];
    for i=1:length(v)
        m=cat(2,m,Mc{i}(:,1));
    end
    for i=1:length(v)
        cr{i}=Mc{i}(:,1:v(i));
        br{i}=Mb{i}(1:v(i),:);
    end
    cr{end}(:,end)=[];
    br{end}(end,:)=[];
    br=br';
    ar=aj;
    ar(end,:)=[];
    ar(:,end)=[];
    cr=cell2mat(cr);
    br=cell2mat(br);    
end
return
         
