function [P Q]=ss2lmpf(sys)
%SS2LMPF State-space to Left Matrix Polynomial Fraction.
% of system MIMO
% 
%
% Syntax:  [P Q]=ss2lmpf(sys)
%
% Inputs:
%   -SYS - LTI MIMO system, in state space
%    representation.
%
% Outputs:
%    N - Numerator of descomposition 
%    D - Denominator of descomposition
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [a b c d]=ssdata(Gt);
%   sys=ss(a,b,c,d);
%   [P Q]=ss2lmpf(sys);
%
% Other m-files required: 
% Subfunctions: [Ar B]=fcc4(v,gi) canical form controlability Nº 4
%                       [v Q Af Bf Cf]=canonicalform(sys.a,sys.b,sys.c,4);
%
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 31-December-2008;
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
[v Q Af Bf Cf]=canonform(sys.a,sys.b,sys.c,4);
D1=sys.d;
if ~isequal(Af,0)
    [fd1 cd1]=size(D1);
    d1=zeros(fd1,cd1);
    ev=find(v==0);
    try
        v(ev)=[];
    end
    ki=[];i1=0;M=[];
    %---------------
    for i=1:length(v)
        i1=i1+v(i);
        ki=cat(2,ki,Cf(:,i1));
        M(:,i)=-Af(:,i1);
    end
    try
        K=inv(ki);
    catch
        K=ki*pinv(ki);
    end
    %encontrar Qb
    [Qb]=fcc4i(Bf,v);
    %Sacar Pb
    syms D
    [Pb]=fcc4i(M,v);
    [fp cp]=size(Pb);
    for i=1:fp,
        for j=1:cp,
            if i==j
                Pb(i,j)=Pb(i,j)+D^(v(i));
            end
        end
    end
    digits(3)
    P=vpa(Pb*K(1:fp,1:cp));
    if ~isequal(D1,d1)
        Q=vpa(Qb+P*D1);
    else
        Q=vpa(Qb);
    end
else
    disp('Use SS->MTF, MTF->MPF')
    P=[];Q=[];
end
%%%%----SUBFUNCTION----%%%%%
function [Af]=fcc4i(M,v)
[fb cb]=size(M);
syms D Af
Af=sym(zeros(length(v),cb));
j1=1;
for i=1:length(v)
    for j=1:v(i)
        pb=D^(j-1)*M(j1,:); 
        Af(i,:)=pb+Af(i,:);
        j1=j1+1;
    end
end
