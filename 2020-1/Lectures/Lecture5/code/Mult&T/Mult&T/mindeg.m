function n=mindeg(sys)
%MINDEG Degree minimal of LTI MIMO SYS model.
% 
%
% Syntax: n=mindeg(sys)
%
% Inputs:
%    sys- LTI system MIMO in representation MTF or state-space
%
%
% Outputs:
%    n- Degree minimal 
%
%
% Example: 
%  A=[-1 0 -1;0 0 1;1 -1 -1];B=[1 0 0]';C=[1 -1 -1;0 1 0];D=[0];        %1I-2O
%  sys=ss(A,B,C,D);
%  n=mindeg(sys)
%
% Other m-files required: 
% Subfunctions: 
%                       none
%
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 16-July-2008;
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
sys = ss(sys,'min');
n=length(sys.a);
return
