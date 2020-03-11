function [M]=normcell(M,op)
%NORMCELL Normalize cell. 
% 
%
% Syntax: [M]=normcell(M,op)
%
% Inputs:
%    M- Matrix in cell format
%    op-  'r' normalize rows
%           'c' normalize columns
%           'rc' columns and rows normalize
%           especific number
%
% Outputs:
%    M- Matrix in cell format normalize
%
%
% Example: 
%  M{1,1}=[1 2]; M{1,2}=[1 2 1]);M{2,1}=[8 1 1 9];
%  [M]=normcell(M,'r')
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

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fm cm]=size(M);
switch op
    case 'r'
        %normaliza por filas
        for i=1:fm,
            lf=0;
            for j=1:cm,
                [fi ci]=size(M{i,j});
                lf(j)=fi;
            end
            g=sort(lf,'descend');
            for j=1:cm,
                while length(M{i,j})<g(1)
                    M{i,j}=cat(1,0,M{i,j});
                end
            end
        end
 
    case 'c'
        %normaliza por columnas
        i=0;
        for j=1:cm,
            lf=0;
            for i=1:fm,
                lf(i)=length(M{i,j});
            end
            g=sort(lf,'descend');
            for i=1:fm,
                while length(M{i,j})<g(1)
                    M{i,j}=cat(2,0,M{i,j});
                end
            end
        end
    case 'rc'
        %normaliza por columnas y filas
       for i=1:fm,
           for j=1:cm,
               if i~=j
                   [fi ci]=size(M{i,i});
                   [fj cj]=size(M{j,j});
                   M{i,j}=zeros(fi,cj);
               end
           end
       end
    case op
       for j=1:cm,
           for i=1:fm,
                while length(M{i,j})<op
                    M{i,j}=cat(2,0,M{i,j});
                end
            end
        end
end

