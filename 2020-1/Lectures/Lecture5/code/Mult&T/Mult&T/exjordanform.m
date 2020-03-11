function [Aj,Bj,Cj,Dj]=exjordanform(Gt)
% EXJORDANFORM Finds the extended Jordan form of a LTI MIMO SYS model.
% MIMO SYS model.
%
% Syntax:  [A,B,C,D] = exjordanform(SYS)
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
%   [A,B,C,D,v]=exjordanform(Gt)
% 
% Other m-files required: 
% Subfunctions: 
%                         [v Q Aj Bj Cj]=canonicalform(a1,b1,c1,'jordan');
%                         v=findv(A)
%
% Author: Franklin Pineda Torres
% email: fept@hotmail.com
% Created: July 2008; 
% Last revision: 7-December-2008;
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
[a1 b1 c1 Dj]=dssdata(Gt);
[v Q Aj Bj Cj]=canonform(a1,b1,c1,'jordan'); 
return