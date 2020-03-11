function [A B C D]=silvermanform(Gt)
%SILVERMANFORM Finds the minimal realization by method Silverman.
% MIMO SYS model
%
% Syntax:  [A,B,C,D] = silvermanform(SYS)
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
%   [A,B,C,D]=silvermanform(Gt)
%
% Other m-files required: 
% Subfunctions: [A B C D T]=hoform(Gt,0)
%
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 17-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A B C D T]=hoform(Gt,0);
[q cc]=size(C);
[fb p]=size(B);
rho=rank(T);
T=real(T);
[ft ct]=size(T);
Tg=A*T;
d=1;
for i=1:ft,
    g=T(1:i,:);
    gg=Tg(1:i,:);
    if rank(g)==rho
       break;
    end
end
for i=1:(length(g)-rho+1)
   f=g(1:rho,i:(rho-1)+i);
   fg=gg(1:rho,i:(rho-1)+i);
   f1=T(1:q,i:(rho-1)+i);
   if ~isequal((det(f)),0)
       d=0;
        break
    end
end
if d==0
    A1=fg*inv(f);
    B=g(1:rho,1:p);
    C=f1*inv(f);
    la1=length(A1);
    la=length(A);
    A=A1;
    nr=la-la1;
    %disp(sprintf('%d states removed.',nr))
else
    disp('Singular Matrix, reduction not posible')    
end
