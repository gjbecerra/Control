function [Aj,Bj,Cj,Dj]=jordanform(Gt)
%JORDANFORM Finds the Jordan form of a LTI MIMO SYS model.
% MIMO SYS model.
%
% Syntax:  [A,B,C,D] = jordanform(SYS)
%
% Inputs:
%    SYS - LTI MIMO system, in Matrix Transfer Function
%    representation.
%
% Outputs:
%    A - 
%    B - 
%    C - 
%    D - space-state representation
%    v  - taman~os de lo bloques de jordan 
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [A,B,C,D,v]=jordanform(Gt)
% 
% Other m-files required: 
% Subfunctions: [rp Dj]=residuem(G); parcial fraction of MTF
%                         [v Q Aj Bj Cj]=canonicalform(a1,b1,c1,'jordan');
%                         [a b c]=jblock(k,Mi);   
%                         Aj=normcell(Aj,'rc');
%                         v=findv(A)
%                         [a b c]=orderblocks(a,b,c);
%
% Author: Franklin Pineda Torres
% email: fept@hotmail.com
% Created: July 2008; 
% Last revision: 7-December-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G=minreal(Gt);
[rp Dj]=mresidue(G);
[a1 b1 c1 d1]=dssdata(Gt);
[frp crp nb]=size(rp);
k1=crp-1;
for i=nb:-1:1,
     M{nb-i+1}=rp(1:frp,1:k1,i);
     pv(nb-i+1)=rp(1,crp,i);
end
k=unique(pv)';
Bj=[];Cj=[];
for i=1:length(k)
    in=find(k(i)==pv);
    for j=1:length(in)
        Mi{j}=M{in(j)};
    end
    [a b c]=jblock(k(i),Mi);
    Aj{i,i}=a;
    Bj=cat(1,Bj,b);
    Cj=cat(2,Cj,c);
    Mi=[];
end
Aj=normcell(Aj,'rc');
Aj=cell2mat(Aj);
sysc=ss(a1,b1,c1,d1);
sys=minreal(sysc);
if length(sys)>length(Aj)
    sysc=canon(sys,'modal');
    a1=sysc.a;b1=sysc.b;c1=sysc.c;
    [v Q a b c]=canonform(a1,b1,c1,'jordan');
    k1=coXm(a,b,c);
    fk1=size(k1);
    if ~isequal(k1(:,2),ones(fk1(1),1))
        clear a b c Aj Bj Cj
        [a1 b1 c1]=gilbertform(Gt);
        [v Q a b c]=canonform(a1,b1,c1,'jordan');
    end
    [Aj Bj Cj]=orderblocks(a,b,c);
end
return
