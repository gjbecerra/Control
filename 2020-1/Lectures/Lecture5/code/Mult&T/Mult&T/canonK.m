function [sysc k kb]=canonK(sys,pd)
%CANONK Canonical form method design state feedback. 
% of LTI MIMO SYS model 
%
% Syntax:  [sysc k kb]=canonK(sys,pd)
%
% Inputs:
%    SYS - LTI MIMO system, in space-state representation.
%    pd - desired eigenvalues 
%
% Outputs:
%    sysc - LTI MIMO system, in space-state representation with state feedback. 
%    k - a feedback matrix gain
%    kb - a feedback matrix gain for canonical form k=kb*P; P is a matrix Transformation 
%
% Example: 
%   [A B C D]=state(8);
%   sys=ss(A,B,C,D);
%   pd=[-1 -2 -3];
%   [sysc k kb]=canonK(sys,pd);
%
%
% Other m-files required: 
% Subfunctions: 
%                [v P Af Bf Cf]=canonform(A,B,C,12);  
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 25-April-2009;
%
% see-also: lyapK 
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
        [v P Af Bf]=canonform(A,B,C,12);  
        if ~isequal(v,0)
            f=0;
            [fb cb]=size(B);
            cf=zeros(length(v),length(Af));
            ck=zeros(length(v),cb);
            cd=cf;j=1;
            for i=1:length(v),
                f=v(i)+f;   
                cf(i,:)=Af(f,:);
                ck(i,:)=Bf(f,:);
                pl=poly(pd(j:f));
                pl=fliplr(pl);
                cd(i,j:f)=pl(1:end-1);
                j=f+1;
            end
            rb=cd+cf;
            kb=inv(ck)*rb;
            k=kb*P;
            %Ag=Af-Bf*kb;es lo mismo de abajo
            %Bg=Bf;
            %Cg=Cf-D*kb;
            %Dg=D;
            Ag=A-B*k;
            Bg=B;
            Cg=C-D*k;
            sysc=ss(Ag,Bg,Cg,D);
        else
            errordlg('The system should be controlable','!!!--ERROR--!!!');
            k=0;
            sysc=sys;
            return;
        end
end
