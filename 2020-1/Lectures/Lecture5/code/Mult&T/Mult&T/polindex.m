function [polo n ni]=polindex(Aj)
%POLINDEX Finds the index of Polynomial characteristic and the minimal. 
%
% Syntax:  [polo n ni]=polindex(A)
%
% Inputs:
%    A - space-state representation matrix A
%
% Outputs:
%    polo - poles 
%    n - index the polynomial characteristic
%    ni - index the polynomial minimal
%
% Other m-files required: 
% Subfunctions: none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 7-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[V,Aj] = jordan(A);
%if V==eye(length(A));
 % Aj=A;
%end
[r m]=size(Aj);
%para calcular los polos del polinomio caracteristico con los index
k=eig(Aj);
polo=unique(k);
%el tamaño de polo indica la cantidad de polos
%n es el index de cada polo
for i=1:length(polo),
    n(i)=length(find(k==polo(i)));
end
n=n';
Ajp=Aj;
Ajp(r+1,m+1)=0;
j=1;
for i=1:m,
    v(i)=Ajp(i,i+1);
    if v(i)==0
        v1(i)=j;
        val(i)=Aj(i,i);
        j=0;
    end
    j=j+1;
end
r=find(v==1);
val(r)=[];
v1(r)=[];
for i=1:length(polo)
    r=find(val==polo(i));
    if length(r)>1
        v2=v1(r);
        or=sortrows(v2);
        ni(i)=or(1);      
    else
        ni(i)=v1(r);
    end
end
ni=ni';
v=v1;
return
