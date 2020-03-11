function [varargout]=sym2cell(varargin)
%SYM2CELL Sym matrix polynomial format to cell format. 
%
% Syntax: [varargout]=sym2cell(varargin)
%
% Inputs : 
%           n polynomial matrices.
%
% Outputs : 
%           n cells.
%           
% Example
% syms D P Q
% P(1,1)='D^2+2';P(1,2)=1;P(2,1)='D^3+D^2+D';P(2,2)='D+7';
% [P]=sym2cell(P)
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
        P1{i,j}=sym2poly(P(i,j));        
    end
end 
