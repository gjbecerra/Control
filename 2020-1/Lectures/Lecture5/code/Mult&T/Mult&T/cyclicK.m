function [sysc k v]=cyclicK(sys,pd)
%CYCLICK Cyclic method design state feedback.
% of LTI MIMO SYS model 
%
% Syntax:  [sysc k v]=cyclicK(sys,pd)
%
% Inputs:
%    SYS - LTI MIMO system, in space-state representation.
%    pd - desired eigenvalues 
%
% Outputs:
%    sysc - LTI MIMO system, in space-state representation with state feedback. 
%    k - a feedback matrix gain
%    v - a vector gain arbitrary 
%
% Example: 
%   [A B C D]=state(28);
%   sys=ss(A,B,C,D);
%   pd=[-1 -2 -3];
%   [sysc k v]=cyclicK(sys,pd);
%
%
% Other m-files required: 
%                               [polo n ni]=polindex(A);
% Subfunctions: 
%                               none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: May 2009; 
% Last revision: 1-May-2009;
%
% see-also: canonK,lyapK 
%             
% Copyright 2009-20010
%
% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning off all
c=class(sys);
switch c
    case 'ss'
        sysc=canon(sys,'modal');
        A=sysc.a;B=sysc.b;
        C=sysc.c;D=sysc.d;
        h=isctrb(A,B);
        if h==1
            [v Q A B C]=canonform(A,B,C,'jordan');
            [polo n ni]=polindex(A);
            isc=isequal(n,ni);
            la=length(A);
            pd1=zeros(1,la);
            if isequal(isc,0)%no es ciclico
                for i=1:la,
                    pd1(i)=-i;
                end
                k1=place(A,B,pd1);
                Ag=A-B*k1;
                Cg=C-D*k1;%ya es ciclico
                sys=ss(Ag,B,Cg,D);
                sysc=canon(sys,'modal');  
                A=sysc.a;
                B=sysc.b;
                C=sysc.c;
            end
            [fb cb]=size(B);h=0;            
            while h~=1 %no es controlable
                v=round(randn(cb,1)*2);
                Bc=B*v;
                h=isctrb(A,Bc);
            end
            k2=acker(A,Bc,pd);
            k=-v*k2;
            Ag=A+B*k;
            Bg=B;
            Cg=C+D*k;
            sysc=ss(Ag,Bg,Cg,D);
            return
            %Gg=ss2mtf(Ag,Bg,Cg,Dg);
        else
            errordlg('The system should be controlable','!!!--ERROR--!!!');
            sysc=sys;
            k=0;v=0;
        end
end