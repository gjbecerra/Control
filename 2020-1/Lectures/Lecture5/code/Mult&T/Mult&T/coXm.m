function k=coXm(A,B,C)
% COXM Check the observability and controlability for mode. 
%
% Syntax: k=coXm(A,B,C)
%
% Inputs:
%    A 
%    B
%    C - space-state representation A,B,C matrices
%
% Outputs:
%    k - 1th column are poles 
%       - 2th column controlable if is one (1), uncontrolable is (0)
%       - 3th column observable if is one (1), unobservable is (0)
%
% Other m-files required: 
% Subfunctions: none
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
[V,Aj] = jordan(A);
Bj=inv(V)*B;
Cj=C*V;
la=length(Aj);
%[fb cb]=size(Bj);
%[fc cc]=size(Cj);
%para calcular los polos del polinomio caracteristico con los index
%k=eig(Aj);
%polo=unique(k);
Ajp=Aj;
Ajp(la+1,la+1)=0;
j=1;
for i=1:la,
    v(i)=Ajp(i,i+1);
    if v(i)==0
        v1(i)=j;
        pv(i)=Aj(i,i);
        j=0;
    end
    j=j+1;
end
r=find(v==1);
pv(r)=[];
v1(r)=[];
v=v1;
lv=1;
pb(1)=v(1);
pc(1)=1;
for i=1:length(v)-1
    lv=v(i)+lv;
    pc(i+1)=lv;
    pb(i+1)=pb(i)+v(i+1);
end
k=unique(pv)';
for i=1:length(k)
    b=[];c=[];
   in=find(k(i)==pv);
   for j=1:length(in)
       b=cat(1,b,Bj(pb(in(j)),:));
       c=cat(2,c,Cj(:,pc(in(j))));       
   end 
   b=round(b*1000)/1000;
   c=round(c*1000)/1000;
   if rank(b)==length(in)
       k(i,2)=1;% el modo es controlable
   else
       k(i,2)=0;%el modo no es controlable
   end
    if rank(c)==length(in)
       k(i,3)=1;% el modo es observable
   else
       k(i,3)=0;%el modo no es observable
    end
end
