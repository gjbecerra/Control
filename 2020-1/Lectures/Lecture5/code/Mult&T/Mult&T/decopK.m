function [sysc k H]=decopK(sys)
%DECOPK Desacoupling by state feedback.   
%
%
% Syntax: [sysc k h]=decopK(sys)
%
% Inputs:
%    SYS - LTI MIMO system, in space-state representation.
%
%
% Outputs:
%    sysc - LTI MIMO system, in space-state representation with state feedback. 
%    k - a feedback matrix gain
%    h - a matrix gain series with input 
%
% Example: 
%   [A B C D]=state(8);
%   sys=ss(A,B,C,D);
%   [sysc k h]=decopK(sys)
%
%
% Other m-files required: 
% Subfunctions: 
%                        none
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: May 2008; 
% Last revision: 02-May-2009;
%
% see-also: lyapK,canonK 
%             
% Copyright 2008-2009
%
% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=class(sys);
switch c
    case 'ss'
        A=sys.a;B=sys.b;
        C=sys.c;D=sys.d;
        [fc cc]=size(C);
        [fb cb]=size(B);
        Ei=zeros(fc,cb);
        %di=zeros(1,fc);
        F=zeros(fc,cc);
        for i=1:fc,
            j=0;
            while isequal(Ei(i,:),zeros(1,cb))
                if j==length(A)
                    j=length(A)-1;
                    break;
                else
                    Ei(i,:)=C(i,:)*A^(j)*B;
                    j=j+1;
                end
            end
            %di(i)=j;
            F(i,:)=C(i,:)*A^(j);
        end
        [fe ce]=size(Ei);
        if isequal(fe,ce)
            if det(Ei)~=0
                H=inv(Ei);
            else
                sysc=sys;
                errordlg('The system decoupling not is posible ','!!--ERROR--!!');
                k=0;
                return
            end
        else
            H=pinv(Ei);
        end
        k=-H*F;
        Ag=A+B*k;
        Bg=B*H;
        Cg=C+D*k;
        Dg=D*H;
        sysc=ss(Ag,Bg,Cg,Dg);       
end
end
