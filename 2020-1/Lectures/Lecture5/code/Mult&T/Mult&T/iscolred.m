function i=iscolred(M)
% ISCOLRED Determine if the MPF  is column reduced.
%
% Syntax:    i=iscolred(M)
%  
% Inputs:
%    M -Polynomial matrix  
%
% Outputs:
%    i - i=1 the Matrix polynomial is column reduced   
%
% Other m-files required: 
% Subfunctions: 
%                       none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 01-Jan-2009;
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
cl=class(M);
switch cl
    case 'sym'       
        [M]=sym2cell(M);    
end
v=findv(M,'cf');
M=cell2sym(M);
d=det(M);
p=sym2poly(d);
if length(p)-1==sum(v)
    i=1;
else
    i=0;
end
return