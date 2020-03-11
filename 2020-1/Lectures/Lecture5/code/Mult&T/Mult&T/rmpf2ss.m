function [A B C D]=rmpf2ss(D1,N)
%RMPF2SS Find the realization by method fraction coprime of  a MPF.
% MIMO SYS model
%
% Syntax:  [A,B,C,D] = rmpf2ss(D1,N)
%
% Inputs:
%    SYS - LTI MIMO system, in Matrix Transfer Function
%    representation.
%     
%
% Outputs:
%    A - 
%    B - 
%    C - 
%    D - space-state representation
%
% Example: 
% P{1,1}=[1 -2 0];P{1,2}=1;P{2,1}=[1 -2];P{2,2}=[1 0];
% Q{1,1}=[1 1];Q{1,2}=[4];Q{2,1}=[-1 -1];Q{2,2}=[-3];
% [A,B,C,D]=rmfd2ss(P,Q)
%
% Other m-files required: 
% Subfunctions: v=findv(D)
%                         [Ar]=fcc12(vi,vf,g,i)
%                         G=rmdf2mtf(D1,N);
%                         [Gsp D]=mtfsp(G);
%                  
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
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
G=rcf2mtf(D1,N);
[Gsp D]=mtfsp(G);
[D1 N]=mtf2rmpf(Gsp);
%[D1 N]=sym2cell(D1,N);
v=findv(D1,'cf');
[fd cd1]=size(D1);
fn=size(N);
Dhc=zeros(fd,cd1);
for i=1:fd
    for j=1:cd1
        Dlc{i,j}=D1{i,j};
        for m=1:length(D1{i,j})
            if D1{i,j}(m)~=0
                if length(Dlc{i,j})>1
                    Dlc{i,j}(1)=[];
                    Dhc(i,j)=D1{i,j}(m);
                else
                    Dlc{i,j}=D1{i,j}(m);
                    Dhc(i,j)=0;
                end
                break;
            else
                Dlc{i,j}(1)=[];
            end
        end
        if isempty(Dlc{i,j})
            Dlc{i,j}=0;
        end
    end
end
if det(Dhc)==0
    k=eye(length(Dhc));
else
    k=inv(Dhc);
end
[Dlc]=normcell(Dlc,'c');
DhcxDlc=k*cell2mat(Dlc);
k2(1)=v(1);
k1(1)=1;
for i=1:length(v)-1
    k2(i+1)=k2(i)+v(i+1);
    k1(i+1)=k2(i)+1;
end
for i=1:fd,
    for j=1:cd1,
        D2{i,j}=DhcxDlc(i,k1(j):k2(j));
    end
end

k11=1;
B=[];
for i=1:fn(1),
    for j=1:cd1,
        if v(j)~=0
            try
                fl=N{i,j};
                while length(fl)<v(j)
                    fl=cat(2,0,fl);
                end
                fl=fliplr(fl);
                C(i,k1(j):k2(j))=fl(:,1:v(j));
            end
        end
    end
end
for i=1:fd,
    for j=1:cd1,
        if v(j)~=0
            gi=D2{i,j};
            if j==i
                b=1;
            else
                b=0;
            end
            try
                [Ar]=fcc12(v(i),v(j),gi,b);
            catch
                Ar=[];
            end
            A{i,j}=Ar;
            if k11==1
                b=zeros(v(j),cd1);
                b(v(j),:)=k(j,:);
                B=cat(1,B,b);
            end
        end
    end
    k11=k11+1;
end
A=cell2mat(A);


%%%%%%%-----SUBFUNCTION-----%%%%%
function [Ar]=fcc12(vi,vf,g,i)
g=-fliplr(g);
Ar=zeros(vi,vf);
lg=length(g);
for j=1:vf
    if j<=lg
        Ar(vi,j)=g(j);
    else
        Ar(vi,j)=0;
    end
end
if i==1
    if vi==vf
        Ar(1:(vf-1),2:vf)=eye(vi-1);
    end    
end
return
