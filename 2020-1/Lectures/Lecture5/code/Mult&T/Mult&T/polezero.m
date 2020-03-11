function [p,z] = polezero(sys)
%POLEZERO Pole and zeros of LTI MIMO SYS model.
% Syntax:  [poles,zeros] = polezeroform(SYS)
%
% Inputs:
%    SYS - LTI MIMO system, either in State Space or Matrix Transfer Function
%    representation.
%
% Outputs:
%    poles - Poles of the Smith-McMillan Matrix
%    zeros - Zeros of the Smith-McMillan Matrix
%
% Example: 
%   g11=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   g12=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   g21=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   g22=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G=[g11 g12; g21 g22];
%   [poles,zeros]=polezero(G)
%
% Other m-files required: 
% Subfunctions: 
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: 01-January 2009; 
% Last revision: 01-Jan-2009;
%
%See-also :
%             
%Copyright 2008-2009
%
% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%%%%%%%%%------- BEGIN CODE --------------
[p z]=pzmap(sys);
z1=[];
for i=1:length(z)
    o=round(z(i)*1000)/1000;
    [x]=find(p==o);
    if ~isempty(x)
        p(x(1))=[];
        z1=cat(1,z1,i);
    end
end
z(z1)=[];
if isempty(p)
    [p z]=pzmap(sys);
end
%------------- END OF CODE --------------
