function [Q v]=psubsis(A,B,C,W)
% PSUBSIS - Finds the canonical controlability and observability  forms 
% of 3x3 LTI MIMO SYS model in p-susbsystems
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
%
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
    M=C;
else
    oc=(ctrb(A,B))';
    [q r]=size(B);%numero de entradas en r
    M=B;
end

y=rank(A);
if y<rank(oc)%si es menor el rank(A) que rank(ob)puede funcionar no al reves
    y=rank(oc);
end

k=0;
for j=1:r,
    a=1;
    for i=1:length(A)
        if W==0
            mS(i+k,:)=M(j,:)*a;
        else
            mS(:,i+k)=a*M(:,j);
        end
        a=A*a;
    end
    k=k+i;
end
oc=mS;
if W==1
    oc=oc';
end
band=0;
clear mS;
if y==rank(oc)
    mS(1,:)=oc(1,:);
    p(1)=1;
    for i=2:length(oc),
        j=i;
        while rank(mS)<y
            if j>length(oc)
                mS(i,:)=oc(i,:);
                band=1;
                break;
            end
            mS(i,:)=oc(j,:);%mS es la matriz de Seleccion
            p(i)=j;%posiciones de la matriz de observabilidad
            if band==0
                r1=rank(mS);%congelar el rango mas alto
            end
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
    if band==1
        r3=r1+1;
        while length(mS)>y
            r2=rank(mS(1:r3,:));
            if r2<=r1
                mS(r3,:)=[];
                p(r3)=[];
            else
                r3=r3+1;
            end
        end
    end    
    Q=mS;
    if W==1
        Q=Q';
    end
    for i=1:r,
        v1(i)=length(find(p<=y*i));
    end
    v(1)=v1(1);
    for i=2:length(v1)
        v(i)=v1(i)-v1(i-1);%el v(1) siempre será la 1 longitud
    end        
else
    if W==0
        errordlg('The System not is Observable','ERROR!!');
    else
        errordlg('The system not is Controllable','ERROR!!');
    end
    Q=0;v=0;
end
