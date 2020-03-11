function [v Q Af Bf Cf]=canonform(A,B,C,nf)
% CANONFORM Find a observability and controlability canonical form.
% of LTI MIMO SYS model 
%
% Syntax:  [v,Q,Af,Bf,Cf] = canonform(A,B,C,nf)
%
% Inputs:
%    SYS - LTI MIMO system, in space-state representation.
%    nf - number form 1=<nf<=8 observability form and 9<=nf<=16 controlability form 
%    A -
%    B -
%    C - space-state representation omition D because is equal in any
%    representation
% Outputs:
%    v - size of block 
%    Q - matrix of transformation
%    Af - 
%    Bf - 
%    Cf - canonical form representation
%
% Example: 
%   G1=tf([1 0],conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G2=tf(conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G3=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   G4=tf(-conv([1 0],conv([1 1],[1 1])),conv(conv([1 1],[1 1]),conv([1 2],[1 2])));
%   Gt=[G1 G2; G3 G4];
%   [A,B,C,D]=wolovichform(Gt)
%   [v Q Af Bf Cf]=canonform(A,B,C,12)
%
% Other m-files required: 
% Subfunctions: [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
%               [S]=modifyQ(A,Q,v,W);   
%               [Q,v]=rsubsis(A,B,C,W);
%               [Q,v]=psubsis(A,B,C,W);
%
% Author: Franklin Pineda Torres
% email: fe.pineda92@uniandes.edu.co
% Created: June 2008; 
% Last revision: 7-July-2008;
%
% see-also: wolovichform 
%             
% Copyright 2008-2009
%
% May be distributed freely for non-commercial use, 
% but please leave the above info unchanged, for
% credit and feedback purposes

%------------- BEGIN CODE --------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isnumeric(nf)
    if (nf>=1)&&(nf<=8)
        W=0;
        if (nf<=4)
            [Q,v]=rsubsis(A,B,C,W);
            if Q==0
                Af=0;Bf=0;Cf=0;
            else
                if (nf==1)||(nf==2)
                    Af=Q*A*inv(Q);
                    Bf=Q*B;
                    Cf=C*inv(Q);
                    if nf==2
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                    end
                else
                    [S]=modifyQ(A,Q,v,W);
                    Af=inv(S)*A*(S);
                    Bf=inv(S)*B;
                    Cf=C*(S);
                    Q=S;
                    if nf==3
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                    end
                end
            end

        else
            [Q,v]=psubsis(A,B,C,W);
            if Q==0
                Af=0;Bf=0;Cf=0;
            else
                if (nf==5)||(nf==6)
                    Af=Q*A*inv(Q);
                    Bf=Q*B;
                    Cf=C*inv(Q);
                    if nf==6
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                    end
                else
                    [S]=modifyQ(A,Q,v,W);
                    Af=inv(S)*A*(S);
                    Bf=inv(S)*B;
                    Cf=C*(S);
                    Q=S;
                    if nf==7
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                    end
                end
            end

        end

    elseif (nf>=9)&&(nf<=16)
        W=1;
        if (nf<=12)
            [Q,v]=rsubsis(A,B,C,W);
            if Q==0
                Af=0;Bf=0;Cf=0;
            else
                if (nf==9)||(nf==10)
                    Af=inv(Q)*A*(Q);
                    Bf=inv(Q)*B;
                    Cf=C*(Q);
                    if nf==10
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                    end
                else
                    [S]=modifyQ(A,Q,v,W);
                    Af=(S)*A*inv(S);
                    Bf=(S)*B;
                    Cf=C*inv(S);
                    Q=S;
                    if nf==11
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                        %Q=rot90(Q);
                    end
                end
            end
        else
            [Q,v]=psubsis(A,B,C,W);
            if Q==0
                Af=0;Bf=0;Cf=0;
            else
                if (nf==13)||(nf==14)
                    Af=inv(Q)*A*(Q);
                    Bf=inv(Q)*B;
                    Cf=C*(Q);
                    if nf==14
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                    end
                else
                    [S]=modifyQ(A,Q,v,W);
                    Af=(S)*A*inv(S);
                    Bf=(S)*B;
                    Cf=C*inv(S);
                    Q=S;
                    if nf==15
                        [Af Bf Cf]=blockpermute(Af,Bf,Cf,v);
                    end
                end
            end
        end
    else
        errordlg('1<=nf<=16','FORMA CANONICA DESCONOCIDA')
    end
elseif strcmp(nf, 'jordan')
    [Q,Af] = jordan(A);
    Bf=inv(Q)*B;
    Cf=C*Q;
    [v]=findv(Af,'jordan');
end
