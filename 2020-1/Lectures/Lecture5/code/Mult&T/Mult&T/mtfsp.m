function [Gsp Ginf]=mtfsp(G)
% MTFSP Strictly Proper Matrix Transfer Function. 
% 
%
% Syntax: [Gsp Ginf]=mtfsp(G)
%
% Inputs:
%    G- MTF of LTI system MIMO
%    
%
% Outputs:
%    Gsp - MTF strictly proper 
%    Ginf - Matrix with the coefficients of Infinity the MTF  
%    G=Gsp+Ginf
%
% Example: 
%  G1=tf([1 2],[1 2 1]);G2=tf(1,[1 1]);
%  G3=tf(-1,[1 1]);G4=1;Gt=[G1 G2;G3 G4];
%  [Gsp Ginf]=mtfsp(G)
%  
%  
%
% Other m-files required: 
% Subfunctions: 
%                       none
%
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 10-Jan-2009;
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
[fg cg]=size(G);
for i=1:fg,
    for j=1:cg,
        [num(i,j) den(i,j)]=tfdata(G(i,j));
        Ginf(i,j)=num{i,j}(1)/den{i,j}(1);
        if Ginf(i,j)~=0
            [num1 den1]=tfdata(G(i,j));
            [r p1 k21]=residue(cell2mat(num1),cell2mat(den1));
            [num{i,j},den{i,j}]=residue(r,p1,0);
        end
        if isempty(num{i,j})
            Gsp(i,j)=0;
        else
            Gsp(i,j)=tf(num{i,j},den{i,j});
        end
    end
end