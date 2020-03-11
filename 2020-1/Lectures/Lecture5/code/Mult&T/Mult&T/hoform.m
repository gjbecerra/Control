function [A B C D T]=hoform(Gt,W)
%HOFORM Finds the Ho canonical form of a LTI MIMO SYS model. 
%
% Syntax:  [A,B,C,D] = hoform(SYS,W)
%
% Inputs:
%    SYS - LTI MIMO system, in Matrix Transfer Function
%    representation.
%   -W canonical form W=0 observability form and W=1 controlability form
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
%   [A,B,C,D]=hoform(Gt)
%
% Other m-files required: 
% Subfunctions: [rp k]=residuem(Gt) residues of matrix and matrix of gain
%                       [M]=mident(f,c)  Identity matrix M of fxc 
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 10-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rp k]=mresidue(Gt);
D=k;
[f c]=size(Gt);
rp1=rp(:,1:c,:);
[f1 c1 nb]=size(rp);
polos=[];pl=1;pc=[];
pcb1=zeros(nb);
for i=1:nb,
    pc=cat(1,pc,rp(1,c+1,i));%raices del polinomio caracteristico    
end
q=length(pc);
a=poly(pc);
for i=1:nb,
    pc1=pc;
    polos=cat(1,polos,rp(1,c+1,i));
    if i>1
        if rp(1,c+1,i)~=rp(1,c+1,i-1)
            pl=rp(1,c+1,i);  
            pcb{i}=poly(pl);
        else
            pcb{i}=conv(pcb{i-1},poly(rp(1,c+1,i)));       
        end        
    else
        pcb{i}=poly(polos);
    end
    pcbr=roots(pcb{i});
    pcbr=round(pcbr*1000)/1000;
    pc1=round(pc1*1000)/1000;
    for i1=1:length(pcbr)        
        for j=1:length(pc)
            if pc1(j)==pcbr(i1)
                pc1(j)=[];
                break
            end                                
        end
    end
    l=poly(pc1);
    l1=length(l)-1;
    pcb1(i,(nb-l1):nb)=poly(pc1);      
end
r=[];
[f1 c1 nb]=size(rp1);
for i=1:nb,
    for j=1:nb,
        if j>1
            r{i}=pcb1(j,i)*rp1(:,:,j)+r{i};
        else
            r{i}=pcb1(j,i)*rp1(:,:,j);
        end
    end
end
H{1}=r{1};
ch=2*q-1;
for i=2:q,
    j=1;r1=zeros(f1,c1);
    m=2;
    H{i}=r{i};
    while j<i
        r1=r1+a(m)*H{i-j};
        j=j+1;
        m=m+1;
    end     
    H{i}=H{i}-r1;
end
[f11 j1]=size(H);
for i=(j1+1):ch,
    H{i}=zeros(f1,c1);
    for j=2:(q+1)
        H{i}=H{i}-a(j)*H{i-j+1};     
    end    
end
B1=mident(c,c*q);
C1=mident(f,f*q);
T=[];
if W==1
    N=cell(q);
    for i=1:q
        m=i;
        for j=1:q,
            T{i,j}=H{m};
            m=m+1;
            N{j,i}=zeros(c);
        end
        if i~=q
            N{i+1,i}=eye(c);
        else
            for j1=1:q
                N{(q+1)-j1,q}=-a(j1+1)*eye(c);
            end
        end
    end
    N=cell2mat(N);
    T=cell2mat(T);
    A = N;
    B=B1';
    C=real(C1*T);
else
    M=cell(q);
    for i=1:q
        m=i;
        for j=1:q,
            T{i,j}=H{m};
            m=m+1;
            M{i,j}=zeros(f);
        end
        if i~=q
            M{i,i+1}=eye(f);
        else
            for j1=1:q
                M{q,(q+1)-j1}=-a(j1+1)*eye(f);
            end
        end
    end
    A=cell2mat(M);
    T=cell2mat(T);
    B=real(T*B1');
    C=C1;
end


function [M]=mident(f,c)
m1=eye(f);
m2=zeros(f,c-f);
M=cat(2,m1,m2);
return
