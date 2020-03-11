function [A B C D]=minhoform(sys)
%MINHOFORM Finds the Minimal realization by method Ho.
%
% Syntax:  [A B C D]=minhoform(Gt)
%
% Inputs:
%    SYS - LTI MIMO system, in Matrix Transfer Function
%    representation or state-space.
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
%   [A,B,C,D]=minhoform(Gt)
%
% Other m-files required: 
% Subfunctions: [A B C D]=hoform(Gt,0) canical form observability by method Ho. 
% 
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: August 2008; 
% Last revision: 11-August-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch class(sys)
    case 'tf'
        [A B C D T]=hoform(sys,0);
        [q cc]=size(C);
        [fb p]=size(B);
        %Tg=T*A; con la forma de controlabilidad
        Tg=A*T;
    case 'ss'
        [A B C D] =ssdata(sys);
        [v Q A B C]=canonicalform(A,B,C,4);
        if A==0
            [A B C D] =ssdata(sys);
        end
        n=length(A);
        V=obsv(A,C);
        U=ctrb(A,B);
        [q cc]=size(C);
        [fb p]=size(B);
        r=ceil(n/q);
        T=V*U;
        T=T(1:n,1:r*p);        
        Tg=V*A*U;
        Tg=Tg(1:n,1:r*p);        
end
n=rank(T);
[K,S,L] = svd(T);
Lt=L';
Kg=K(:,1:n);
Lgt=Lt(1:n,:);
Sg=S(1:n,1:n);
Ho=Kg*sqrt(Sg);
Hc=sqrt(Sg)*Lgt;
Hopi=pinv(Ho);
Hcpi=pinv(Hc);
%Tg=A*T;
A1=Hopi*Tg*Hcpi;
B=real(Hc(:,1:p));
C=real(Ho(1:q,:));
la1=length(A1);
la=length(A);
nr=la-la1;
%disp(sprintf('%d states removed.',nr))
A=real(A1);
