function [A B C D]=wolovichform(Gt)
%WOLOVICHFORM Realization by method Wolovich of a LTI MIMO SYS model.
% MIMO SYS model
%
% Syntax:  [A,B,C,D] = wolovichform(SYS)
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
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [A,B,C,D]=wolovichform(Gt)
%
% Other m-files required: 
% Subfunctions: [Ar B]=fcc12(v,gi) canical form controlability Nº 12
%                       [rij delta]=mtf2rmfd(Gt); rigth matrix fraction description
%                       [Gsp D]=mtfsp(Gt);
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 31-Dec-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Gsp D]=mtfsp(Gt);
[delta rij]=mtf2rmpf(Gt);
v=findv(delta,'cf');
[fd cd]=size(delta);
[frij crij]=size(rij);
for i=1:frij,
    for j=1:cd,
        d=length(delta{j,j})-length(rij{i,j});
        if d~=0
            for m=1:d,
                rij{i,j}=cat(2,0,rij{i,j});
            end
        end
    end
end
Dxd=[];
B=[];
k11=1;
k2(1)=v(1);
k1(1)=1;
for i=1:length(v)-1
    k2(i+1)=k2(i)+v(i+1);
    k1(i+1)=k2(i)+1;
end
A=zeros(sum(v));
rijmD=[];
for i=1:frij,
    for j=1:cd,
           Dxd{i,j}=D(i,j)*delta{j,j};
           rijmD{i,j}=rij{i,j}-Dxd{i,j};
           if v(j)~=0
               fl=fliplr(rijmD{i,j});
               C(i,k1(j):k2(j))=fl(:,1:v(j));
               if k11==1
                   gi=delta{j,j};
                   gi(1)=[];
                   [Ar]=fcc12(v(j),-fliplr(gi));
                   A(k1(j):k2(j),k1(j):k2(j))=Ar;  
                   b=zeros(v(j),cd);
                   b(v(j),j)=1;
                   B=cat(1,B,b);
               end                              
           end           
    end
    k11=k11+1;
end
function [Ar B]=fcc12(v,gi)
Ar=zeros(v);
gi=gi(1,1:v);
Ar(1:(v-1),2:v)=eye(v-1);
Ar(v,:)=gi;
return
