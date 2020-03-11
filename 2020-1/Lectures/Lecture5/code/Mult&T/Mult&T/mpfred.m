function [Pm Qm]=mpfred(P,Q)
% MPFRED  Finds the minimal reduction of MPF.
%
% Syntax:  [Pm Qm]=odreduction(P,Q)
%
% Inputs:
%    P- outputs equations system in cell format or sym
%    Q- inputs equations system in cell format or sym
%
% Outputs:
%    Pm - Matrix in sym format by outputs equations 
%    Qm - Matrix in sym format by inputs equations 
%
% Example: 
%  P{1,1}=[2];P{1,2}=[3 0 0];P{1,3}=[1 0];P{2,1}=[1 0 0];P{2,2}=[0];P{2,3}=[1];P{3,1}=[1 0];P{3,2}=[1 1 1];P{3,3}=[0];
%  Q{1,1}=[-1];Q{1,2}=[-3 0];Q{1,3}=[-3 0];Q{2,1}=[-1 0];Q{2,2}=[0];Q{2,3}=[-1];Q{3,1}=0;Q{3,2}=[1 -1];Q{3,3}=[-1];
%  [Pm Qm]=odreduction(P,Q)
%  det(Pm)
%  
%
% Other m-files required: 
% Subfunctions: [PQ b]=reduction2x2(PQ) reduction of union matrix P and Q 
%               [PQ lp]=monicos(varargin) monics terms of matrix P
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
[fp cp]=size(P);
[fq cq]=size(Q);
switch class(P)
    case 'cell'
        [Ps Qs]=cell2sym(P,Q);
        PQ=cat(2,Ps,Qs);
    case 'sym'
        PQ=cat(2,P,Q);
end
%D1=det(PQ(1:fp,1:fp));
if fp==2
    [PQ b]=reduction2x2(PQ);
    if b==1
        %errordlg('EL SISTEMA ES IMPROPIO','ERROR')
        disp('ES IMPROPIO EL SISTEMA')
    end
elseif fp==3
    for i=1:2
        [QP b]=reduction2x2(PQ(1:2,:));
        PQ(1:2,:)=QP;
        if b==0
           break
        else
            PQ(:,2:3)=fliplr(PQ(:,2:3));
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:2,
        PQ(:,2:3)=fliplr(PQ(:,2:3));
        PQ(2:3,:)=flipud(PQ(2:3,:));
        [QP b]=reduction2x2(PQ(1:2,:));
        if b==0 %esta bien
            PQ(1:2,:)=QP;
            PQ(2:3,:)=flipud(PQ(2:3,:));
            PQ(:,2:3)=fliplr(PQ(:,2:3));
            break;
        else
            PQ(:,2:3)=fliplr(PQ(:,2:3));
            continue;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PQ(:,1:2)=fliplr(PQ(:,1:2));
    PQ(:,2:3)=fliplr(PQ(:,2:3));
    PQ(1:2,:)=flipud(PQ(1:2,:));
    PQ(2:3,:)=flipud(PQ(2:3,:));
    [QP]=reduction2x2(PQ(1:2,:));
    PQ(1:2,:)=QP;
    PQ(2:3,:)=flipud(PQ(2:3,:));
    PQ(1:2,:)=flipud(PQ(1:2,:));
    PQ(:,2:3)=fliplr(PQ(:,2:3));
    PQ(:,1:2)=fliplr(PQ(:,1:2));
end
Pm=PQ(1:fp,1:fp);
Qm=PQ(1:fp,fp+1:fp+cq);
% D2=det(Pm);
% if isequal(D1,D2)==1
%     W=1;
% else
%     W=0;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [PQ b]=reduction2x2(PQ)
[PQ lp]=monicos(PQ);
k1=0;k2=0;
%Asegurar A>C , A>B , C<=D 
if (lp(1,1)==0 && lp(2,1)==0) || (lp(1,2)==0 && lp(2,2)==0)
    %errordlg('EL SISTEMA ES IMPROPIO','ERROR')
    b=1;
else
    while lp(1,1)<=lp(2,1) || lp(2,1)>lp(2,2) || lp(1,1)<lp(1,2)
        if  lp(2,1)>lp(1,1)
            PQ=flipud(PQ);
        end
        if lp(1,1)>lp(2,1)
            ed=lp(1,1)-lp(2,1);
            m=sym([1 0;0 1]);
            m(1,2)=sprintf('D^%d',ed);
            m(1,2)=-m(1,2);
            PQ=simplify(m*PQ);
        elseif lp(1,1)==lp(2,1)
            PQ=[1 0;-1 1]*PQ;
        end
        [PQ lp]=monicos(PQ);
        if lp(1,1)>lp(2,1) && lp(1,1)<lp(1,2)
            PQ(:,1:2)=fliplr(PQ(:,1:2));
            k1=k1+1;
        end
        if k2==5;
            b=1;
            break
        end
        k2=k2+1;
    end
    k2=0;
    %Asegurar que B<D
    [PQ lp]=monicos(PQ);
    [PQ lp]=monicos(PQ,1);
    while lp(1,2)>=lp(2,2)
        pB=sym2poly(PQ(1,2));
        pD=sym2poly(PQ(2,2));
        ed=lp(1,2)-lp(2,2);
        de=pB(1)/pD(1);
        m=sym([1 0;0 1]);
        m(1,2)=sprintf('D^%d',ed);
        m(1,2)=-de*m(1,2);
        PQ=simplify(m*PQ);
        [PQ lp]=monicos(PQ,1);
        if k2==5;
            b=1;
            break
        end
        k2=k2+1;
    end
    if k1==1
        PQ(:,1:2)=fliplr(PQ(:,1:2));
    end
    [PQ lp]=monicos(PQ);
    [PQ lp]=monicos(PQ,1);
    b=0;
end
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [PQ lp]=monicos(varargin)
PQ=varargin{1};
[fp cp]=size(PQ);
for i=1:fp
    for j=1:fp,
        p{i,j}=sym2poly(PQ(i,j));
        lp(i,j)=length(roots(p{i,j}));
    end
end
if nargin==1
    for i=1:fp,
        if lp(i,1)>0
            if p{i,1}(1)~=1
                if i==1
                    PQ=[1/p{i,1}(1) 0;0 1]*PQ;
                elseif i==2
                    PQ=[1 0;0 1/p{i,1}(1)]*PQ;
                end
            end
        end
    end
end

if nargin==2
    if p{2,2}(1)~=1
        PQ=[1 0;0 1/p{2,2}(1)]*PQ;
    end
end
return