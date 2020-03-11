function [A B C P]=cx2rJ(A,B,C)
% CX2RJ Complex to real Jordan format. 
%
% Syntax: [A B C P]=cx2rJ(A,B,C)
%
% Inputs:
%    A 
%    B
%    C - space-state representation A,B,C matrices in complex format
%
% Outputs:
%    A -  
%    B -
%    C - space-state representation in real format
%
% Other m-files required: 
% Subfunctions: 
%                       [bloque]=ordenar(v)
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 3-December-2008;
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
polo=eig(A);
v=findv(A,'jordan');
i=1;k=0;i1=1;op=0;
if ~isreal(polo)
    while i1<=length(v)
        k=k+v(i);
        if isreal(polo(k))
            P{i,i}=eye(v(i1)); 
        else
            bloque=ordenar(v(i1));
            P{i,i}=bloque;
            i1=i1+1;
            k=k+1; 
            if isequal(A(k,k),A(k-1,k-1)) && v(k)==1
                op=1;
            end
        end
        i=i+1;
        i1=i1+1;
    end
    P=normcell(P,'rc');
    P=cell2mat(P);
else
    P=eye(length(A));
end
if op==1;
   warndlg('to use jordan ->cx2rJ to organize blocks','complex blocks in disorder')
else
    A=real(P*A*inv(P));
    B=real(P*B);
    C=real(C*inv(P)); 
end
    
function [bloque]=ordenar(v)
i1=cat(2,eye(v),eye(v));
i2=cat(2,j*eye(v),-j*eye(v));
bloque=cat(1,i1,i2);
