clear all
clc
[A B C]=state(10);%A debe estar en forma de Jordan
D=zeros(2,2);
[polo n ni]=polindex(A);
isc=isequal(n,ni);
pd=[-2 -1 -3];
if isequal(isc,1)
    [fb cb]=size(B);
    h=isctrb(A,B);
    if h==1
        vj=findv(A,'jordan');
        v=ones(cb,1);
        Bc=B*v;        
        pol=poly(pd);
        K=acker(A,Bc,pd);
        k=-v*K;
        Ag=A+B*k;
        Bg=B;
        Cg=C+D*k;
        Dg=D;
        sysc=ss(Ag,Bg,Cg,Dg);
        %Gg=ss2mtf(Ag,Bg,Cg,Dg);
    else
        errordlg('The system should be controlable','!!!--ERROR--!!!');
        k=0;
    end
    %no es ciclico
       warndlg('The system not is cyclic, Use place->jordan->cyclic','!!!--Warning--!!');      
end


%G=mtf(11);
%[A B C D]=dssdata(G);
% [A B C]=state(1);
% D=[0;0];
% [fc cc]=size(C);
% [fb cb]=size(B);
% Ei=zeros(fc,cb);
% di=zeros(1,fc);
% F=zeros(fc,cc);
% for i=1:fc,
%     j=0;
%     while isequal(Ei(i,:),zeros(1,cb))
%         if j==length(A)
%             j=length(A)-1;
%             break;
%         else
%             Ei(i,:)=C(i,:)*A^(j)*B;
%             j=j+1;
%         end
%     end
%     %di(i)=j;
%     F(i,:)=C(i,:)*A^(j);
% end
% [fe ce]=size(Ei);
% if isequal(fe,ce)
%     if det(Ei)~=0
%         H=inv(Ei);
%     else
%         sysc=sys;
%         K=0;
%         return
%     end
% else
%     H=pinv(Ei);    
% end
% K=-H*F;
% Ag=A+B*K;
% Bg=B*H;
% Cg=C+D*K;
% Dg=D*H;
% sysc=ss(Ag,Bg,Cg,Dg);
% Gg=ss2mtf(Ag,Bg,Cg,Dg);

%[A B C D]=state(8);
% A=[0 1 0 0;0 0 1 0;-3 1 2 3;2 1 0 0];
% B=[0 0;0 0;1 2;0 2];
% C=[1 0 0 0];
% D=[0 0];
 %A=[-1 0 0 0 0 0;0 0 1 0 0 0;-1 -1 -2 0 0 0;0 0 4 0 1 0;1 2 1 0 0 1;-2 0 0 -1 -1 -1];
 %B=[1 0 0;0 0 0;0 1 0;0 0 0;0 0 0;0 0 1];
 %C=[1 0 0 0 0 0];
 %D=[0 0 0];
% pd=[-2 -1 -3];%el tamano de A= # de polos deseados
% sys=ss(A,B,C,D);
% c=class(sys);
% switch c
%     case 'ss'
%         A=sys.a;B=sys.b;
%         C=sys.c;D=sys.d;
%         [v P Af Bf Cf]=canonform(A,B,C,12);  
%         if ~isequal(v,0)
%             f=0;
%             [fb cb]=size(B);
%             cf=zeros(length(v),length(Af));
%             ck=zeros(length(v),cb);
%             cd=cf;j=1;
%             for i=1:length(v),
%                 f=v(i)+f;   
%                 cf(i,:)=Af(f,:);
%                 ck(i,:)=Bf(f,:);
%                 pl=poly(pd(j:f));
%                 pl=fliplr(pl);
%                 cd(i,j:f)=pl(1:end-1);
%                 j=f+1;
%             end
%             rb=cd+cf;
%             kb=inv(ck)*rb;
%             k=kb*P;
%             %Ag=Af-Bf*kb;
%             %Bg=Bf;
%             %Cg=Cf-D*kb;
%             %Dg=D;
%             Ag=A-B*k;
%             Bg=B;
%             Cg=C-D*k;
%             Gg=ss2mtf(Ag,Bg,Cg,D);
%         end
% end
%     
% 
% 
% 
% % pd=[-2 -1];
% % [sys k kg]=mlyap(sys,pd);
% % if ~isequal(k,0)
% %     [fb cb]=size(sys.b);
% %     ko=zeros(cb,1);
% %     for i=1:cb,
% %         [numz,denz]=ss2tf(sys.a,sys.b,sys.c,sys.d,i);
% %         n=polyval(numz(1,:),1);
% %         m=polyval(denz,1);
% %         ko(i)=m/n;
% %         B(:,i)=sys.b(:,i).*ko(i);
% %     end
% %     % %para normalizar
% %     % ko=ko/ko(1);
% %     % B(:,1)=sys.b(:,1).*ko(1);
% %     % B(:,2)=sys.b(:,2).*ko(2);
% %     % B(:,2)=sys.b(:,3).*ko(3);
% %     Gg=ss2mtf(sys.a,B,sys.c,sys.d);
% %     figure,step(Gg)
% % end
% 
% 
% 
% 
% 
% 
% 
