function [sysc k kg]=lyapK(sys,pd)
%LYAPK Lyapunov method design state feedback. 
% of LTI MIMO SYS model 
%
% Syntax:  [sysc k kg]=lyapK(sys,pd)
%
% Inputs:
%    SYS - LTI MIMO system, in space-state representation.
%    pd - desired eigenvalues 
%
% Outputs:
%    sysc - LTI MIMO system, in space-state representation with state feedback. 
%    k - a feedback matrix gain
%    kg - a feedback matrix gain arbitrary 
%
% Example: 
%   [A B C D]=state(8);
%   sys=ss(A,B,C,D);
%   pd=[-1 -2 -3];
%   [sysc k kg]=lyapK(sys,pd);
%
%
% Other m-files required: 
% Subfunctions: 
%                none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 1-May-2009;
%
% see-also: canonK,cyclicK 
%             
% Copyright 2008-2009
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
        A=sys.a;B=sys.b;
        C=sys.c;D=sys.d;
        [fb cb]=size(B);
        la=length(A);
        h=isctrb(A,B);
        if h==1
            F=zeros(la);
            ii=1;
            for i=1:length(pd)
                if isreal(pd(i))
                    F(ii,ii)=pd(i);
                    ii=ii+1;
                else
                    pr=real(pd(i));
                    pc=imag(pd(i));
                    f=[pr pc;-pc pr];
                    F(ii:ii+1,ii:ii+1)=f;%es complejo
                    ii=ii+2;
                end
            end
            F=F(1:la,1:la);
            nf=rank(F);
            nv=0;n1=1;
            T=0;
            while nv<nf || isequal(det(T),0)
                if n1~=20
                    kg=round(rand(cb,la)*1.5);
                    V=obsv(F,kg);
                    nv=rank(V);
                    try
                        T=lyap(A,-F,-B*kg);
                    catch
                         n1=n1+1;
                        continue;
                    end
                    k=kg*inv(T);
                    Ag=A-B*k;
                    n1=n1+1;
                else
                    disp('not posible find a kg, Try new poles desired')
                    k=0;
                    Ag=A;
                    break;
                end
            end
            sysc=ss(Ag,B,C,D);
        else
            errordlg('The system should be controlable','!!!--ERROR--!!!');
            k=0;
            sysc=sys;
            return;
        end
end
