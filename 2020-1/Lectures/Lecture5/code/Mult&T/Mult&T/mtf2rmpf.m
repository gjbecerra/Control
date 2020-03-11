function [D N]=mtf2rmpf(Gt)
%MTF2RMPF Matrix Transfer Function to Right Matrix Polynomial Fraction.
% of system MIMO
% 
%
% Syntax:  [N D]=mtf2rmpf(Gt)
%
% Inputs:
%   -SYS - LTI MIMO system, in Matrix Transfer Function
%    representation.
%
% Outputs:
%    N - Numerator of descomposition 
%    D - Denominator of descomposition
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [D N]=mtf2rmpf(Gt)
%
% Other m-files required: 
% Subfunctions: [Ar B]=fcc12(v,gi) canical form controlability Nº 12
% 
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: July 2008; 
% Last revision: 31-December-2008;
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
[f c]=size(Gt);
g=[];
k=[];
for j=1:c,
    k1=1;
    for i=1:f,
        [num(i,j) den(i,j)]=tfdata(Gt(i,j));
        p{i,j}=roots(den{i,j});
        p{i,j}=round(p{i,j}*1000)/1000;
        g4=unique(p{i,j});
        for m=1:length(g4),
            [i1 v1 d]=find(p{i,j}==g4(m));
            d1=sum(d);
            k(k1,1,j)=d1;
            k(k1,2,j)=g4(m);
            d=[d1 g4(m)];
            k1=k1+1;
        end        
    end
end
[f1 c1 nb]=size(k);
rij=[];
for nk=1:nb,
    g4=unique(k(:,2,nk));
    g=[];
    for i=1:length(g4),
        k1=1;
        for j=1:f1,
            pl=k(j,2,nk);
            if pl==g4(i);
                g=cat(1,k(j,:,nk),g);
                if k1>1
                    if g(1,1)>=g(2,1)
                        g(2,:)=[];
                    else
                        g(1,:)=[];
                    end
                end
                k1=k1+1;
            end                    
        end
    end
    r=[];
    for i=1:length(g4),
        for j1=1:g(i,1)
           r=cat(2,r,g(i,2));%polos de delta
        end
    end
    for i=1:f,
        lp=length(p{i,nk});%si no esta vacio entra
        r1=r;
        for j=1:lp,
            h=find(r1==p{i,nk}(j));
            if ~isempty(h)
                r1(h(1))=[];
            end
        end
        N{i,nk}=conv(num{i,nk},poly(r1)); 
        while N{i,nk}(1)==0
            N{i,nk}(1)=[];  
            if isempty(N{i,nk})==1
                N{i,nk}=0;
                break;
            end
        end        
    end  
    if isempty(r)
        D{nk,nk}=0;
    else
        D{nk,nk}=poly(r);
    end    
end
return