function [G]=ss2mtf(A,B,C,D)
%SS2MTF Convert state-space filter parameters to Matrix Transfer Function.
% function form
%
% Syntax:  [G]=ss2mtf(A,B,C,D)
%
% Inputs:
%    SYS - LTI MIMO system, in state-space representation.
%
% Outputs:
%    Gt 
%    - Matrix Transfer representation
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [A,B,C,D]=hoform(Gt)
%   [G]=ss2mtf(A,B,C,D)
%
% Other m-files required: 
% Subfunctions: none
%               
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 23-Febrary-2009;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fb cb]=size(B);%cb inputs
[fc]=size(C);%fc outputs
if D==0
    D=zeros(fc(1),cb);
end
for i=1:cb,
    for j=1:fc(1),
        [num den]=ss2tf(A,B(:,i),C(j,:),D(j,i));
        num=round(num*1000)/1000;
        den=round(den*1000)/1000;
        Gt1(j,i)=tf(num,den);    
        Gt1=minreal(Gt1(j,i));
        [num den]=tfdata(Gt1);
        [num den]=cellround(num,den);
        num=num{:};
        den=den{:};        
        G(j,i)=tf(num,den);  
    end
end