function [A B C D]=lcfform(Gt)
% LCFFORM Finds the minimal realization by method fraction left coprime.
%
% Syntax:  [A,B,C,D] = lcfform(SYS)
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
%   [A,B,C,D]=lcfform(Gt)
%
% Other m-files required: 
% Subfunctions: [Gsp Ginf]=mtfsp(Gt);
%                         [D N]=mtf2lcf(Gsp);               
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: December 2008; 
% Last revision: 31-Dec-2008;
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
[Gsp Ginf]=mtfsp(Gt);
[P N]=mtf2lcf(Gsp);
[P Q]=sym2cell(P,N);
D=Ginf;
[fq cq]=size(Q);
[fp cp]=size(P);
 v=findv(P,'cf');
Dhc=uplowM(P);
if det(Dhc)==0
    k=eye(length(Dhc));
else
    k=inv(Dhc);
end
k1=1;C=[];
for i=1:fp,
        k2=1;
        for m=1:v(i),
            for j=1:cp,
               lf=length(roots(P{i,j}));
                if lf>=(m-1)
                    if m==1
                        pos=lf+1;
                    else
                        pos=lf-(m-2);
                    end
                    Dlc(k1,j)=P{i,j}(pos);
                else
                    Dlc(k1,j)=0;
                end
            end
            k1=k1+1;
            if k2==v(i),
                C=cat(2,C,k(:,i));
            else
                C=cat(2,C,zeros(fp,1));
            end
            k2=k2+1;
        end        
end
DlcxDhc=Dlc*k;
D2=cell(fp,cp);
k2(1)=v(1);
k1(1)=1;
for i=1:length(v)-1
    k2(i+1)=k2(i)+v(i+1);
    k1(i+1)=k2(i)+1;
end
for j=1:fp,
     for i=1:cq,
       D2{j,i}=DlcxDhc(k1(j):k2(j),i);     
    end
end
B=[];
Ql=transpose(Q);
for i=1:fq,
    for j=1:cq,
        if v(j)~=0
            try
                fl=Ql{i,j};
                while length(fl)<v(j)
                    fl=cat(2,0,fl);
                end
                fl=fliplr(fl);
                B(i,k1(j):k2(j))=fl(:,1:v(j));
            end
        end
    end
    for j1=1:cp,
        g=D2{i,j1};
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
B=B';
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
