function [varargout]=cell2sym(varargin)
%CELL2SYM Cell format to sym format in operator differential. 
%
% Syntax: [varargout]=cell2sym(varargin)
%
% Inputs : 
%           n cells.
%
% Outputs : 
%           n polynomial matrices.
%           
% Example
%P{1,1}=[1 -2 0];P{1,2}=1;P{2,1}=[1 -2];P{2,2}=[1 0];
%Q{1,1}=[1 1];Q{1,2}=[4];Q{2,1}=[-1 -1];Q{2,2}=[-3];
%[P Q]=cell2sym(P,Q)
%
% Other m-files required: 
% Subfunctions: P1=c2s(P)
%                       
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: October 2008; 
% Last revision: 1-Jan-2009;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin==nargout
    for i=1:nargin
        varargout{i}=c2s(varargin{i});
    end
end

%--------------SUBFUNCTION--------------------%
function P1=c2s(P)
[fp cp]=size(P);
for i=1:fp,
    for j=1:cp
        P1(i,j)=poly2sym(P{i,j},'D');        
    end
end 
