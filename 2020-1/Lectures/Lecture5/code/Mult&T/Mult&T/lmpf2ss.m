function [A B C D]=lmpf2ss(D1,N)
%LMPF2SS Finds the  realization by method fraction coprime of a LTI
% MIMO SYS model
%
% Syntax:  [A,B,C,D] = lmpf2ss(D,N)
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
%   [A,B,C,D]=lmpf2ss(Gt)
%
% Other m-files required: 
% Subfunctions: v=findv(D)
%                         [Ar]=fcc4(vi,vf,g,i)
%                         G=rmdf2mtf(D1,N);
%                         [Gsp D]=mtfsp(G);
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
G=lcf2mtf(D1,N);
[Gsp D]=mtfsp(G);
[D1 N]=mtf2lmpf(Gsp);
v=findv(D1,'cf');
[fd cd1]=size(D1);
k1=1;C=[];
k=eye(length(v));
[fn cn]=size(N);
for i=1:fn,
    k2=1;
    for m=1:v(i),
        for j=1:cn,
            while N{i,j}(1)==0
                N{i,j}(1)=[];
                if length(N{i,j})==1||length(N{i,j})==0
                    if isempty(N{i,j})
                        N{i,j}=0;
                    end
                    break;
                end
            end
            lf=length(roots(N{i,j}));
            if lf>=(m-1)
                if m==1
                    pos=lf+1;
                else
                    pos=lf-(m-2);
                end
                B(k1,j)=N{i,j}(pos);
            else
                B(k1,j)=0;
            end
        end
        k1=k1+1;
        if k2==v(i),
            C=cat(2,C,k(:,i));
        else
            C=cat(2,C,zeros(fn,1));
        end
        k2=k2+1;
    end
    for j1=1:cd1,
        g=D1{i,j1};
        if j1==i
            b=1;
        else
            b=0;
        end
        if v(i)==0 || v(j1)==0
            continue;
        end
        Ar{i,j1}=fcc4(v(i),v(j1),g,b);
    end
end
A=cell2mat(Ar);

%%%%%%%-----SUBFUNCTION-----%%%%% 
function [Ar]=fcc4(vi,vf,g,i)
g=-fliplr(g);
Ar=zeros(vi,vf);
lg=length(g);
for j=1:vi
    if j<=lg
        Ar(j,vf)=g(j);
    else
        Ar(j,vf)=0;
    end
end
if i==1
    if vi==vf
        Ar(2:vf,1:(vf-1))=eye(vi-1);
    end    
end
return
