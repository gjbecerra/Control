function [i pnc]=islmpfc(P,Q)
% ISLMPFC Determine if the left MPF  is controlable.
%
% Syntax:    i=islmpfc(P,Q)
%  
% Inputs:
%    P,Q -Left Matrices Polynomial Fraction    
%
% Outputs:
%    i : i=1 the system Matrix polynomial is controlable   
%    pnc: no controlables poles 
%
% Other m-files required: 
% Subfunctions: 
%                       none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: January 2008; 
% Last revision: 1-March-2009;
%
%See-also :
%             
%Copyright 2008-2010
%
% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cl=class(P);
switch cl
    case 'cell' 
        [P Q]=cell2sym(P,Q);        
end
dp=det(P);
dpn=sym2poly(dp);
raices=roots(dpn);
raices=unique(raices);
M=cat(2,P,Q);
i=1;pnc=[];
f=size(P);
for j=1:length(raices)
    A=subs(M,'D',raices(j));
    ra=rank(A);   
    if ra<f(1);
        i=0;
        pnc=raices(j);
        break
    end
end
return