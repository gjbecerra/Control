function [ar br cr dr]=minjordanform(sys)
% MINJORDANFORM Finds the Minimal realization by method irreducible Jordan.
% Form of LTI.
% SYS model
%
% Syntax:  [A B C D]=minjordanform(Gt)
%
% Inputs:
%    SYS - LTI MIMO system, in Matrix Transfer Function
%    representation or state-space.
%
% Outputs:
%    A - 
%    B - 
%    C - 
%    D - space-state representation
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [A,B,C,D]=minjordanform(Gt)
%
% Other m-files required: 
% Subfunctions: [A B C D]=jordanform(Gt)
%                       k1=coXm(aj,bj,cj); 
%                       n=normcell(Ar1,'rc');
% 
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: August 2008; 
% Last revision: 11-August-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=class(sys);
switch c
    case 'tf'
        [aj,bj,cj,dr]=jordanform(sys);        
    case 'ss'
        [aj bj cj]=orderblocks(sys.a,sys.b,sys.c);
        dr=sys.d;        
end
k1=coXm(aj,bj,cj);
[fk1 ck1]=size(k1);
ban=0;
if ~isequal(k1(:,2),ones(fk1,1))
    warndlg('The System not is Controllable','Irreducible Jordan not is posible!!');
    ban=1;
end
v=findv(aj,'jordan');
lv=length(v);
j=v(1);
for i=1:lv,%hallar los polos asociados por bloque "M"
    pv(i)=aj(j,j);
    Ma{i}=aj(j-v(i)+1:j,j-v(i)+1:j);
    Mb{i}=bj(j-v(i)+1:j,:);
    Mc{i}=cj(:,j-v(i)+1:j);
    if i~=lv
        j=j+v(i+1);
    end
end
k=unique(pv);
j=1;
while j<=length(k)
    p=find(pv==k(j));
    br=[];cr=[];Ar1=[];
    for i=1:length(p)
        Ar1{i,i}=Ma{p(i)};
        br=cat(1,br,Mb{p(i)});
        cr=cat(2,cr,Mc{p(i)});         
    end
    n=normcell(Ar1,'rc');
    ar=cell2mat(n);
    ro=rank(obsv(ar,cr));
    un=length(ar)-ro;
    if ban==1 && length(ar)==2
        un=1;
    end    
    if un~=0
        for o=1:un,
            [ar br cr]=jreduction(ar,br,cr);
        end
    end
    arj=ar;brj=br;crj=cr;
    Ar{j}=arj;Br{j}=brj;Cr{j}=crj;
    j=j+1;
end
clear Ar1 n
br=[];cr=[];
for i=1:length(k)
    Ar1{i,i}=Ar{i};
    br=cat(1,br,Br{i});
    cr=cat(2,cr,Cr{i});
end
n=normcell(Ar1,'rc');
ar=cell2mat(n);