function [P Q]=ss2rmpf(sys)
%SS2RMPF State-space to Right Matrix Polynomial Fraction. 
% of system MIMO
% 
%
% Syntax:  [P Q]=ss2rmpf(sys)
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
%   [P Q]=ss2rmpf(sys);
%
% Other m-files required: 
% Subfunctions: [Ar B]=fcc12(v,gi) canical form controlability Nº 12
%                       [v Q Af Bf Cf]=canonicalform(sys.a,sys.b,sys.c,12);
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
[v Q Af Bf Cf]=canonform(sys.a,sys.b,sys.c,12);
D1=sys.d;
if ~isequal(Af,0)
    ev=find(v==0);
    try
        v(ev)=[];
    catch
    end
    C=[];i1=0;M=[];ki=[];
    for i=1:length(v)
        i1=i1+v(i);
        i2=i1-v(i)+1;
        C=cat(2,C,Cf(:,i2:i1));
        ki=cat(1,ki,Bf(i1,:));
        M(i,:)=-Af(i1,:);
    end
    try
        K=inv(ki);
    catch
        K=ki*pinv(ki);
    end
    M=K*M;
    Pb=fcc12i(M,v);
    syms D s
    for i=1:length(v)
        s(i,i)=D^v(i);
    end
    K=K*s;
    P=Pb+K;
    Qb=fcc12i(C,v);
    Q=Qb+D1*P;
else
    disp('Use SS->MTF, MTF->MPF')
    P=[];Q=[];
end

%%%%----SUBFUNCTION----%%%%%
function [Af]=fcc12i(M,v)
fb=size(M);
syms D Af
Af=sym(zeros(fb(1),length(v)));
j1=1;
for i=1:length(v)
    for j=1:v(i)
        pb=D^(j-1)*M(:,j1); 
        Af(:,i)=pb+Af(:,i);
        j1=j1+1;
    end
end
