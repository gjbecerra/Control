function v=findv(M,op)
% FINDV Find the blocks in matrix Jordan or the indices of MPF.
% MPF Matrix Fraction Description.
%
%Syntax:    v=findv(M,op)
%  
%
% Inputs:
%    M -Polynomial matrix or Real matrix in format Jordan  
%    op - 'Jordan'
%           'cf'
%
% Outputs:
%    v - index or size blocks in format Jordan   
%
% Other m-files required: 
% Subfunctions: 
%                       none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 3-December-2008;
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

 [fd cd]=size(M);
if strcmp(op, 'jordan')
    M(fd+1,fd+1)=0;
    j=1;
    for i=1:fd,
        v(i)=M(i,i+1);
        if v(i)==0
            v1(i)=j;
            j=0;
        end
        j=j+1;
    end
    r=find(v==1);
    v1(r)=[];
    v=v1;
    return
elseif strcmp(op, 'cf')
    cl=class(M);
    if strcmp(cl, 'sym')
        [M]=sym2cell(M);
    end
    for j=1:cd,
        for i=1:fd
            p{i,j}=roots(M{i,j});
            lp(i)=length(p{i,j});
            if i>1
                if lp(i)~=0
                    if lp(i)>lp(i-1)
                        if lp(i)>v(j)
                            v(j)=lp(i);
                        end
                    else
                        if lp(i-1)>v(j)
                            v(j)=lp(i-1);
                        end
                    end
                end
            else
                v(j)=lp(i);
            end
        end
    end
    return
end