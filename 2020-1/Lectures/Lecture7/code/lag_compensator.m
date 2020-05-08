% ***** Root-locus plots of the compensated system and
% uncompensated system *****
% ***** Enter the numerators and denominators of the
% compensated and uncompensated systems *****
numc = [1 0.05];
denc = [1 3.005 2.015 0.01 0];
num = [1.06];
den = [1 3 2 0];
% ***** Enter rlocus command. Plot the root loci of both
% systems *****
kvec = linspace(0,50,100001);
figure(1),cla
rlocus(tf(num,den),kvec,'r')
hold
% Current plot held
rlocus(tf(numc,denc),kvec,'b')
v = [-3 1 -2 2]; axis(v); %axis('square')
legend('Sistema no Compensado','Sistema Compensado')
% grid
% text(-2.8,0.2,'Compensated system')
% text(-2.8,1.2,'Uncompensated system')
% text(-2.8,0.58,'Original closed-loop pole')
% text(-0.1,0.85,'New closed-')
% text(-0.1,0.62,'loop pole')
% title('Root-Locus Plots of Compensated and Uncompensated Systems')
hold
% Current plot released
%% ***** Plot root loci of the compensated system near the origin *****
figure(2)
rlocus(numc,denc,kvec)
v = [-0.4 0 -0.2 0.2]; axis(v); %axis('square')
% grid
% title('Root-Locus Plot of Compensated System near the Origin')

%% 
% ***** Unit-ramp responses of compensated system and
% uncompensated system *****
% ***** Unit-ramp response will be obtained as the unit-step
% response of C(s)/[sR(s)] *****
% ***** Enter the numerators and denominators of C1(s)/[sR(s)]
% and C2(s)/[sR(s)], where C1(s) and C2(s) are Laplace
% transforms of the outputs of the compensated and un-
% compensated systems, respectively. *****
numc = [1.0235 0.0512];
denc = [1 3.005 2.015 1.0335 0.0512 0];
num = [1.06];
den = [1 3 2 1.06 0];
% ***** Specify the time range (such as t= 0:0.1:50) and enter
% step command and plot command. *****
t = 0:0.1:50;
c1 = step(num,den,t);
c2 = step(numc,denc,t);
plot(t,c1,'-',t,c2,'-',t,t,'--')
grid
legend('Sistema no compensado','Sistema compensado','Rampa unitaria','Location','northwest')
% text(2.2,27,'Compensated system');
% text(26,21.3,'Uncompensated system');
% title('Unit-Ramp Responses of Compensated and Uncompensated Systems')
xlabel('t [s]');
ylabel('Salida C')

%%
% ***** Unit-step responses of compensated system and
% uncompensated system *****
% ***** Enter the numerators and denominators of the
% compensated and uncompensated systems *****
numc = [1.0235 0.0512];
denc = [1 3.005 2.015 1.0335 0.0512];
num = [1.06];
den = [1 3 2 1.06];
% ***** Specify the time range (such as t = 0:0.1:40) and enter
% step command and plot command. *****
t = 0:0.1:40;
c1 = step(num,den,t);
c2 = step(numc,denc,t);
plot(t,c1,'-',t,c2,'-')
grid
legend('Sistema no compensado','Sistema compensado')
% text(13,1.12,'Compensated system')
% text(13.6,0.88,'Uncompensated system')
% title('Unit-Step Responses of Compensated and Uncompensated Systems')
xlabel('t [s]')
ylabel('Salida C')