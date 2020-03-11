function [A B C D]=gilbertform(Gt)
%GILBERTFORM Finds the Gilbert form of a LTI MIMO SYS model.
%
% Syntax:  [A,B,C,D] = gilbertform(SYS)
%
% Inputs:
%    SYS - LTI MIMO system, in Matrix Transfer Function "MTF"
%    representation. The MTF should'n complex conjugate poles. 
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
%   [A,B,C,D]=gilbertform(Gt)
%
% Other m-files required: 
% Subfunctions: [rp k]=residuem(Gt)
%                         [A B C]=cx2rJ(A,B,C);   
% 
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 8-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Gt=minreal(Gt);
[f c]=size(Gt);
[rp k]=mresidue(Gt);
D=k;k=rp;
mO=[];B=[];A=[];C=[];
v=1;
[f1 c11 nb]=size(k);% nb Nº de bloques dado por cada polo
for i=1:f1,
    mul=0;
    for j=1:nb,
         pl=k(i,c11,j);
        if isequal(k(i,1:(c11-1),j),zeros(1,(c11-1)))==0
            mO=cat(1,mO,k(i,:,j));%si es igual no entra
            B=cat(1,B,k(i,1:(c11-1),j));
            A(v,v)=pl;
            C(i,v)=1;
            if j>1
                pl1=k(i,c11,j-1);
                if pl==pl1
                    mul=mul+1;
                    for mul1=1:mul,
                        C(i,v)=0;
                        v=v+1;
                        B=cat(1,B,zeros(1,c11-1));
                        A(v,v-1)=1;
                        A(v,v)=pl;
                        C(i,v)=1;                        
                    end
                else
                    mul=0;
                end
                              
            end
            v=v+1;
            
        else
            if j>1
                pl1=k(i,c11,j-1);
                if pl==pl1
                    mul=mul+1;
                end
            end
        end
             
    end
end
[f2 c2]=size(A);
if isequal(f2,c2)==0
    A(:,c2+1)=0;
end
w=eig(A);
if ~isreal(w)
    disp('eigenvalues complex')
    [A B C]=cx2rJ(A,B,C);   
end
return
    
