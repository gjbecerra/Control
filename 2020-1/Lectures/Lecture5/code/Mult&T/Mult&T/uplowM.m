function [Dhc Dlc]=uplowM(D)
%UPLOWM Find the matrices with the hight and low coeficients.
% 
%
% Syntax:  [Dhc Dlc]=uplowM(D)
%
% Inputs:
%    M Matrix in cell format
%
% Outputs:
%    Dhc - Dhc matrix with hight coeficients.  
%    Dlc  - Dlc matrix with low coeficients in cell format.
%
%
% Example: 
%   [P Q]=lmpf(3);
%   [Dhc Dlc]=uplowM(P);
%
% Other m-files required: none
% Subfunctions: none
%
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: March 2009; 
% Last revision: 7-Abril-2009;
%
% see-also: lmpf 
%             
% Copyright 2008-2009
%
% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fd cd]=size(D);
v=findv(D,'cf');
Dlc=D;
Dhc=zeros(fd,cd);
for i=1:fd
    for j=1:cd
        for m=1:length(D{i,j})
            if D{i,j}(m)~=0
                if length(D{i,j})>1
                    Dhc(i,j)=D{i,j}(m);                     
                else
                    Dhc(i,j)=0;
                end                
            else
                Dhc(i,j)=0;                 
            end           
            break;
        end
        if length(D{i,j})==(v(j)+1)
                Dlc{i,j}(1)=[];                
        end
    end
end
% Ds=cell2sym(D);
% Dlcs=inv(Dhc)*Ds;
% Dlc=sym2cell(Dlcs);
% for i=1:fd
%     for j=1:cd
%         if length(Dlc{i,j})>1
%             Dlc{i,j}(1)=[];
%         else
%             continue;
%         end
%     end
% end

% for i=1:fd
%     for j=1:cd
%         Dlc{i,j}=D{i,j};        
%         for m=1:length(D{i,j})
%             if D{i,j}(m)~=0
%                 if length(Dlc{i,j})>1
%                     if length(Dlc{i,j})>=length(D{i,i})
%                         Dlc{i,j}(1)=[];
%                     end
%                     Dhc(i,j)=D{i,j}(m);
%                 else
%                     Dlc{i,j}=D{i,j}(m);
%                     Dhc(i,j)=0;
%                 end
%                 break;
%             else
%                 Dlc{i,j}(1)=[];
%             end
%         end        
%         if isempty(Dlc{i,j})
%             Dlc{i,j}=0;
%         end
%     end
% end
