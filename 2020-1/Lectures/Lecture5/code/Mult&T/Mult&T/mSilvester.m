function [S dep lidep]=mSilvester(D,N,op,mode)
% MSILVESTER Find the Matrix Silvester.
% And the dependent and independent rows or columns
%                         
% 
%
%Syntax:   [S dep lidep]=mSilvester(D,N,op,mode)
%  
%
% Inputs:
%    D -Matrix Fraction Description  
%    N -Matrix Fraction Description
%    op- 1 if the MPF is Right or op=0 if Left MPF
%    mode- 'ascend'
%               'descend'
%
% Outputs:
%    S - Matriz Silvester  
%    dep- rows or columns dependent in Matrix Silvester
%    lidep -number of states linearly independent 
%
% Other m-files required: 
% Subfunctions: 
%                       [Df]=mfliplr(D)
%                       D=normcell(D,ld(1));
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 3-December-2008;
%
%See-also :
%             
%Copyright 2008-2009
%
% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%op=1 significa busqueda de izquierda deerecha
%op=0 siginifica busqueda de arriba hacia abajo
[fd cd]=size(D);
[fn cn]=size(N);
v=findv(D,'cf');
ld=v+1;
ld=sort(ld,'descend');
N=normcell(N,ld(1));    
if strcmp(mode, 'descend')      
    D=normcell(D,ld(1));
    D=mfliplr(D);
    N=mfliplr(N);        
end
om=ld(1)-1; %orden de la descomposición
tv=fd*ld(1);   %tama~no de cada vector=length(n)=length(d)
d=mexpand(D,'c');
if op==1
    n=mexpand(N,'c');
elseif op==0
    n=mexpand(N,'r');
end
tc=om*(fd+cn);%tamaño de S en columnas q*orden en filas
tf=2*fd*om;     %tamaño de las filas de S
dn=cat(1,d,n)';
S=zeros(tc);
[fdn cdn]=size(dn);
for i=1:om,
    ifs=fd*(i-1)+1;
    ffs=ifs+(tv-1);
    fcs=i*cdn;
    ics=(i-1)*cdn+1;
    S(ifs:ffs,ics:fcs)=dn;
end
j=0;
for i=1:om,
    k1=1;
    icn=(fd+1)+j;
    for j=icn:(icn+cn-1)
        ni(k1,i)=j; %posiciones de cada n_{i}
        k1=k1+1;
    end
end
[q r]=qr(S);
r=round(r*1000)/1000;
[fr cr]=size(r);
dep=[];
for i=1:fr,
    for j=1:cr,
        if i==j
            if r(i,j)==0
                dep=cat(1,dep,i);%columnas L. dependientes
            end
        end
    end
end
for i=1:length(dep)
    [x,y] = find(dep(i)==ni);
    if ~isempty(x)
        dep(i,2)=x;
    else
        dep(i,2)=0;
    end
end
[f2 f1]=find(dep==0);
dep(f2,:)=[];
[fni cni]=size(ni);
for i=1:fni,
    if ~isempty(dep)
        [x,y] = find(dep(:,2)==i);
        lidep(i)=cni-length(x);%L.independientes
    else
        lidep=cni;
    end
end
%ojo con esto porque no estaba
if op==0
    S=S';
end
function [Df]=mfliplr(D)
[fd cd]=size(D);
for i=1:fd,
    for j=1:cd,
        Df{i,j}=fliplr(D{i,j});
    end
end
return
      