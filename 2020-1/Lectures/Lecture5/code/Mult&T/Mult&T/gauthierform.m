function [A B C D]=gauthierform(P,Q)
%GAUTHIERFORM Gauthier minimal algoritm of a MPF model.
%
% Syntax:  [A B C D]=gauthierform(P,Q)
%
% Inputs:
%    P - Matrix cell or sym form of outputs in differential operator
%    Q - Matrix cell or sym form of inputs in differential operator
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
%   [P Q]=mtf2lcf(Gt);
%   [A,B,C,D]=gauthierform(P,Q)
%
% Other m-files required: 
% Subfunctions: [Ar]=fcc4(vi,vf,g,i) canical form observability  Nº 4
% 
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 13-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fp cp]=size(P);
[fq cq]=size(Q);
switch class(P)
    case 'sym'
        Pc=cell(fp,cp);
        Qc=cell(fq,cq);
        for i=1:fp
            for j=1:cp,
               Pc{i,j}=sym2poly(P(i,j)); 
            end
            for j1=1:cq,
                Qc{i,j1}=sym2poly(Q(i,j1)); 
            end
        end
        Q=Qc;
        P=Pc;
end
v=findv(P,'cf');
[fp cp]=size(P);
k=zeros(fp,cp);
l=zeros(1,fp);
for i=1:fp,
    l(i)=length(P{i,1});
    for j=1:cp,
        if l(i)<length(P{i,j})
            l(i)=length(P{i,j});
        end
    end
    for j=1:cp,
        if l(i)==length(P{i,j})
            k(i,j)=P{i,j}(1);
        end
    end
end
L=cell2sym(P);
%pc=det(L);%polinomio caracteristico
%orden=sum(v);
try
    k=inv(k);
    Lb=L*k;
    C=[];
    k1=1;
    for i=1:fq,
        for m=1:v(i),
            for j=1:cq,
                lf=length(roots(Q{i,j}));
                if lf==v(i)
                    D(i,j)=Q{i,j}(1);
                else
                    D(i,j)=0;
                end
                M(i,j)=poly2sym(Q{i,j},'D');
            end
        end
    end
    Qb=M-L*D;
    for i=1:fq,
        k2=1;
        for m=1:v(i),
            for j=1:cq,
                Qb1{i,j}=sym2poly(Qb(i,j));
                lf=length(roots(Qb1{i,j}));
                if lf>=(m-1)
                    if m==1
                        pos=lf+1;
                    else
                        pos=lf-(m-2);
                    end
                    B(k1,j)=Qb1{i,j}(pos);
                else
                    B(k1,j)=0;
                end
            end
            k1=k1+1;
            if k2==v(i),
                C=cat(2,C,k(:,i));
            else
                C=cat(2,C,zeros(fq,1));
            end
            k2=k2+1;
        end
        for j1=1:cp,
            g=sym2poly(Lb(i,j1));
            if j1==i
                b=1;
            else
                b=0;
            end
            Ar{i,j1}=fcc4(v(i),v(j1),g,b);
        end
    end
    A=cell2mat(Ar);
catch
    errordlg('Try reduced the System with Button [min] or function [mpfred]','Error!!!')
    A=0;B=0;C=0;D=0;
    return
end

%%%%%%%---SUBFUNCTIONS---%%%%%%%%
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
