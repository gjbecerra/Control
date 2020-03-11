function [Q v]=rsubsis(A,B,C,W)
% RSUBSIS - Finds the canonical controlability and observability  forms 
% of nxn LTI MIMO SYS model in r-susbsystems
%
% Syntax:  [Q v]=rsubsis(A,B,C,W)
%
% Inputs:
%    SYS - LTI MIMO system, in space-state representation.
%    W - number form W==0 observability form and W==1 controlability form 
%    A -
%    B -
%    C - space-state representation omition D because is equal in any
%    representation
% Outputs:
%    v - size of block 
%    Q - matrix of transformation
%
% Other m-files required: 
% Subfunctions: none
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 7-July-2008;

% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if W==0
    oc=obsv(A,C);
    [r q]=size(C);%numero de salidas en r
else
    oc=(ctrb(A,B))';
    [q r]=size(B);%numero de entradas en r
end
[fa ca]=size(A);
y=rank(A);
if y<rank(oc)%si es menor el rank(A) que rank(ob)puede funcionar no al reves
    y=rank(oc);
end
if y==rank(oc) && ca==y
    mS(1,:)=oc(1,:);
    p(1)=1;
    for i=2:length(oc),
        j=i;
        while rank(mS)<y
            mS(i,:)=oc(j,:);%mS es la matriz de Seleccion
            p(i)=j;%posiciones de la matriz de observabilidad
            r1=rank(mS);
            if r1==i
                break;
            else
                j=j+1;
            end
        end
        if rank(mS)==y
            break;
        end
    end
    vec=1:max(p);
    cvec=ceil(length(vec)/r); %las filas del vector son los grupos
    while mod(length(vec),r)~=0        
        vec(end+1)=0;
    end
    vec=reshape(vec,r,cvec);
    q1=cell(r,1);
    v=zeros(1,r);
    for i=1:y,
        [x y1]=find(p(i)==vec);
        b=q1{x};
        b=cat(1,b,mS(i,:));
        q1{x}=b;
        v(x)=v(x)+1;
    end
    Q=cell2mat(q1);
    if W==1
         Q=Q';
     end    
        
else
    if W==0
        errordlg('The System not is Observable','Error!!');
    else
        errordlg('The System not is Controllable','Error!!');
    end
    Q=0;v=0;
end
