function [S]=modifyQ(A,Q,v,W)
% MODIFYQ - Modify the matrix Q of finds the canonical controlability and observability  forms 
% of nxn LTI MIMO SYS model in r-subsystem or p-subsystem
%
% Syntax:  [S]=modifyQ(A,Q,v,W)
%
% Inputs:
%    A - LTI MIMO system, matrix in space-state representation.
%    Q - Matrix of selection  
%    v - size blocks
%    W - if W==0 is observability form elseif W==1 controlability form
% Outputs:
%    S - Matrix modified  
%
% Other m-files required: 
% Subfunctions: none
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 7-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Qi=Q;
[fq cq]=size(Q);
if fq~=cq
    Q=Q(1:cq,1:cq);
end
if W==1
    Qi=Q';
end
Qi=inv(Qi);
j=1;
for i=1:length(v),
    if v(i)~=0
       for k=1:v(i),
            S(:,j)=Qi(:,v(i)+(j-1));
            if W==0
                S(:,j+(k-1))=(A^(k-1))*S(:,j);
            else
                S(:,j+(k-1))=(S(:,j)'*(A^(k-1)))';
            end        
        end
        j=j+v(i);
    end
end
if W==1
    S=S';
end