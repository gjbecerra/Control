function [A2 B2 C2]=blockpermute(A1,B1,C1,v)
% BLOCKPERMUTE - Finds the canonical controlability and observability  forms 
% of nxn LTI MIMO SYS model in r-susbsystems or p-susbsystem, with
% rotations and permutations.
%
% Syntax:  [A2 B2 C2]=blockpermute(A1,B1,C1,v)
%
% Inputs:
%    SYS - LTI MIMO system, in space-state representation.
%    v - size of blocks
%    A -
%    B -
%    C - space-state representation omition D because is equal in any
%    representation
% Outputs:
%    A2 - 
%    B2 - 
%    C2 - space-state representation
%
% Other m-files required: 
% Subfunctions: none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 7-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v1=v;
fz=find(v==0);
v(fz)=[];
lv=length(v);
j(1)=1;f=0;
for i=1:length(v),
    f=v1(i)+f;
    j(i+1)=f+1;
end
for nd=1:lv,
    for nb=1:lv,
        a=A1(j(nb):(j(nb+1)-1),j(nd):(j(nd+1)-1)); 
        a=rot90(rot90(a));
        A2(j(nb):(j(nb+1)-1),j(nd):(j(nd+1)-1))=a;
        if nd==1
            b=B1(j(nb):(j(nb+1)-1),:); 
            b=rot90(rot90(b));
            b=fliplr(b);
            B2(j(nb):(j(nb+1)-1),:)=b;
        end
        if nb==1
            c=C1(:,j(nd):(j(nd+1)-1));
            c=rot90(rot90(c));
            c=flipud(c);
            C2(:,j(nd):(j(nd+1)-1))=c;
        end
    end
end
return 