function [varargout]=cellround(varargin)
%CELLROUND Round to nearest integer in each cell. 
%
% Syntax: [varargout]=cellround(varargin)
%
% Inputs : 
%           n cells.
%
% Outputs : 
%           n round cells.
%           
% Example
%P{1,1}=[0.1 1 -2 0];P{1.7,2}=1;P{2,1}=[1 -2];P{2,2}=[1 0];
%Q{1,1}=[1 1.5];Q{1,2.4}=[4];Q{2,1}=[-1.1 -1];Q{2,2}=[-3];
%[P Q]=cellround(P,Q)
%
% Other m-files required: 
% Subfunctions: P1=c2s(P)
%                       
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: October 2008; 
% Last revision: 1-Jan-2009;
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
        P1{i,j}=round(P{i,j}*100)/100;        
    end
end 