function i=isctrb(A,B)
%ISCTRB Determine if the state-space  is controlable. 
%
% Syntax:    i=isctrb(A,B)
%  
% Inputs:
%    A,B -Matrices of LTI system MIMO    
%
% Outputs:
%    i : i=1 the system in state space is controlable   
%     
%
% Other m-files required: 
% Subfunctions: 
%                       none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: May 2000; 
% Last revision: 1-May-2009;
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
U=ctrb(A,B);
ra=rank(A);
ru=rank(U);
if ru>=ra
    i=1;
else
    i=0;
end
