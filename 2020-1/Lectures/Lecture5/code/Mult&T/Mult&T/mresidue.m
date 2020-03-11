function [rp k]=mresidue(Gt)
% MRESIDUE  Partial fraction expansion of Matrix Transfer Function.
% 
%
% Syntax:  [rp k]=residuem(Gt)
%
% Inputs:
%    SYS - LTI MIMO system, in Matrix Transfer representation.
%
% Outputs:
%    rp - matrix with residues and the last column is the poles of block 
%    k -  matrix of G(Inf)
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [rp k]=residuem(Gt)
%
% Other m-files required: 
% Subfunctions: none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 9-July-2008;
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
[f c]=size(Gt);
g=[];
gp=[];
for i=1:f,
    for j=1:c,
        [num(i,j) den(i,j)]=tfdata(Gt(i,j));
        [r{i,j} p{i,j} k]=residue(num{i,j},den{i,j});
        p{i,j}=round(p{i,j}*1000)/1000; 
        r{i,j}=round(r{i,j}*1000)/1000;  
        g=cat(1,g,[p{i,j} r{i,j}]);
        for m=1:length(p{i,j})
            gp=cat(1,gp,[i j]);
        end                   
       D(i,j)=num{i,j}(1)/den{i,j}(1);
    end
end
g4=unique(g(:,1));
k=0;k1=1;i11=1;
for i=1:length(g4)
    [f1 c11 nb]=size(k);
    if i>1
        i11=nb+1;
    end
    for j=1:length(g),
        if g4(i)==g(j,1)
            if j>1 && gp(j,1)==gp(j-1,1) && gp(j,2)==gp(j-1,2) && g(j,1)==g(j-1,1)
                k(gp(j,1),gp(j,2),k1+1)=g(j,2);
                k(1:f,c+1,k1+1)=g(j,1);
                k1=k1+1;
            else
                k(gp(j,1),gp(j,2),i11)=g(j,2);
                k(1:f,c+1,i11)=g(j,1);
                k1=i11;
            end
        end                    
    end
end
rp=k;
k=D;