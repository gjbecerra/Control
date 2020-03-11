function [Gt]=lcf2mtf(D,N,Ginf)
% LCF2MTF Left Coprime Fraction to Matrix Transfer Function.
%
% Syntax:  [G]=lcf2mtf(D,N)
%
% Inputs:
%    D- outputs equations system in cell format or sym
%    N- inputs equations system in cell format or sym
%
% Outputs:
%    Gt 
%    - Matrix Transfer representation
%
% Example: 
%   P{1,1}=[1 -3 2];P{1,2}=0;P{2,1}=[-4 1];P{2,2}=[-1 1];
%   Q{1,1}=[1 1];Q{1,2}=[6];Q{2,1}=[1];Q{2,2}=[5];
%   [Gt]=lcf2mtf(P,Q);
%
% Other m-files required: 
% Subfunctions: G=sym2tf(f2); Symbolic Transfer Function to Numerical
% Transfer Function          
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
[fd cd]=size(D);
[fn cn]=size(N);
switch class(D)
    case 'cell'
        for i=1:fd
            for j=1:cd,
                Pc(i,j)=poly2sym(D{i,j},'D');
            end
        end
        for i=1:fn
            for j1=1:cn,
                Qc(i,j1)=poly2sym(N{i,j1},'D');
            end
        end
    case 'sym'
        Pc=D;
        Qc=N;
end
Gs=simplify(inv(Pc)*Qc);    
Gt=sym2tf(Gs);
Gt=minreal(Gt);
if nargin==3
    Gt=Gt+Ginf;
end