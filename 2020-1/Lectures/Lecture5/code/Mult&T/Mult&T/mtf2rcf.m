function [D N]=mtf2rcf(G)
% MTF2RCF Matrix Transfer Function to Right Coprime Fraction. 
% 
%
% Syntax: [D N]=mtf2rcf(G)
%
% Inputs:
%    G- MTF of LTI system MIMO
%    
%
% Outputs:
%    D - Polynomial matrix in sym format. Right coprime Fraction 
%    N - Polynomial matrix in sym format. Right coprime Fraction  
%    G=ND^(-1) 
%
% Example: 
%  G1=tf([1 2],[1 2 1]);G2=tf(1,[1 1]);
%  G3=tf(-1,[1 1]);G4=1;Gt=[G1 G2;G3 G4];
%  [D N]=mtf2rcf(G)
%  
%  
%
% Other m-files required: 
% Subfunctions: 
%                       [A B C]=rmfd2ss(Do,No);
%                       [v Q Af Bf Cf]=canonicalform(A,B,C,12);
%                       [P Q]=ss2rcf(sys,op);            
%                       [D N]=sym2cell(P,Q);
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
[fg cg]=size(G);
l=mindeg(G);
[D N]=mtf2rmpf(G);
band1=0;D1=D;N1=N;
v=findv(D1,'cf');
if sum(v)~=l %no es minima si es igual
    %ya es minima pero D es diagonal
    if fg==cg
        [Do No]=mtf2lmpf(G);
        cn=length(No);
        [S dep]=mSilvester(Do,No,1,'ascend');
        cs=length(S);
        dep1=dep;
        fdp=size(dep);
        if ~isempty(dep)
            if isempty(dep)
                dep=cn;
            end
            z=zeros(cs,length(dep));
            S1=S;
            for i=1:fdp(1),
                s1=null(S1(:,1:dep1(i)));
                if isempty(s1)==1
                    f=size(s1);
                    z1=zeros(f(1),1);
                    z1(end)=1;
                    band(i)=i;%indica si toda la fila fue ceros
                else
                    z1=s1/s1(end);
                end
                z(1:length(z1),i)=z1(:,1);
                S1(:,dep1(i))=[];
                for j=i+1:fdp
                    dep1(j)=dep1(j)-1;
                end
            end
            %iniciar desplazamientos
            s=z;
            [fs cs]=size(s);
            for i=1:length(dep)-1
                for j=1:fs-1
                    z1=s(end-j,i);
                    z1=round(z1*1000)/1000;
                    if z1==1
                        for m1=1:(cs-i),
                            for m=1:j,
                                s(fs-m+1,i+m1)=s(fs-m,i+m1);
                            end
                            s(end-j,i+m1)=0;
                        end
                        break;
                    end
                end
            end
            z=[];
            %organizar en columnas de ni y llenar las que estan vacias
            for i=1:cn,
                [x y]=find(dep==i);
                if ~isempty(x)
                    try
                        [x1]=find(band==x(1));
                        if ~isempty(x1)
                            if length(x)>1
                                x=flipud(x);
                            else
                                s(:,band(x1))=zeros(fs,1);
                                band1(i)=i;
                            end
                        end
                    end
                    z=cat(2,z,s(:,x(1)));
                else
                    z=cat(2,z,zeros(fs,1));
                    band1(i)=i;
                    %z=cat(2,z,S(1:fs,cn+i));
                end
            end
            %organizar en bloques
            S=zeros(cn);
            k1=0;i=1;fcn=1;
            [fz cz]=size(z);
            nb=ceil(fz/cn);
            while fz~=nb*cn
                z=cat(1,z,zeros(1,cz));
                 [fz cz]=size(z);
            end
            while i<=nb
                k1=k1+fcn;
                fcn=cn;
                S(1:fcn,1:cz,i)=z(k1:(k1+fcn-1),:);
                 i=i+1;
            end
            N=[];D=[];
            %organizar N y D
            [fs cs nb]=size(S);
            for j=1:cs,
                for i=1:fs,
                    b=[];c=[];
                    for i1=1:2:nb,
                        b=cat(1,b,S(i,j,i1));
                        try
                            c=cat(1,c,S(i,j,i1+1));
                        end
                    end
                    b=fliplr(b');
                    b=round(b*1000)/1000;
                    c=round(c*1000)/1000;
                    N{i,j}=-b;
                    c=fliplr(c');
                    D{i,j}=c;
                end
            end
            [fd cd]=size(D);
            if ~isequal(band1,0),
                D=D';N=N';
                D1=rot90(D1);
                N1=rot90(N1);
                for i=1:length(band1),
                    if ~isequal(band1(i),0)
                        for j=1:cd
                            D{band1(i),j}=D1{band1(i),j};
                            N{band1(i),j}=N1{band1(i),j};                       
                        end
                    end
                end
                D=D';N=N';               
            end
        else
            %significa que es minima por el otro lado
            [A B C]=lmpf2ss(Do,No);
            [v Q Af Bf Cf]=canonform(A,B,C,12);
            sys=ss(Af,Bf,Cf,zeros(fg,cg));
            [P Q]=ss2rmpf(sys);            
            [D N]=sym2cell(P,Q);
        end
    else
         warndlg('In the moment rcf is posible only square MTF','!! Warning !!')
    end
end
[D N]=cellround(D,N);
[D N]=cell2sym(D,N);