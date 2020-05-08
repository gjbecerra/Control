%% Lag-Lead Compensator
% Assume gamma = beta
beta = 10;
gamma = beta;
Kc = 1;
T1 = 1;
T2 = 10*T1;
s = tf('s');
w = logspace(-4,3,1001)';
Gc = Kc*((s+1/T1)/(s+gamma/T1))*((s+1/T2)/(s+1/(beta*T2)));
[magn,phase] = bode(Gc,w);
magn = squeeze(magn);
phase = squeeze(phase);

try close(1);
catch warning('Figure 1 already closed');
end
figure(1), set(gcf, 'Position',  [100, 200, 800, 600])
subplot(15,1,1:8), cla, hold on
set(gca, 'XScale', 'log')
mx = [0.0001/T1 0.01/T1; 0.01/T1 0.1/T1; 0.1/T1 1/T1; 1/T1 10/T1; 10/T1 1000/T1];
my = [0 0; 0 -20; -20 -20; -20 0; 0 0];
hl1 = semilogx(w,20*log10(magn),'LineWidth',2.8);
hl2 = line(mx,my,'LineWidth',2,  'LineStyle','--','Color','k');
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
% xlim([0.001 100])
ylim([-22 2])
legend([hl2(1), hl1], 'Aprox. lineal', 'Curva exacta','Location','east')

subplot(15,1,9:15), hold on
set(gca, 'XScale', 'log')
hl2 = semilogx(w,phase,'LineWidth',2.8);
line([1/sqrt(T1*T2) 1/sqrt(T1*T2)],[0 -90],'LineStyle','--','Color','r')
text(0.9/sqrt(T1*T2),-65,'\omega_1','FontSize',13,'Color','r','LineWidth',1.5)
xlim([0.001 100])
ylim([-60 60])
% legend([hl1(1), hl2], 'Aprox. lineal', 'Curva exacta')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-4 1e-3 1e-2 1e-1 1 1e1 1e2 1e3])
xticklabels({'0.0001/T_1','0.001/T_1','0.01/T_1','0.1/T_1','1/T_1','10/T_1','100/T_1','1000/T_1'})
yticks(-90:15:90)
exportgraphics(gcf,'../images/bodeLagLeadComp.eps')

%% Lag-Lead Compensator Design
s = tf('s');
G = 1/(s*(s+1)*(s+2));
w = logspace(-2,2,1001)';

% Requirements: Kv = 10 sec^-1, PM = 50 deg, GM = 10 dB
% 1. Compute Kc such that Kv requirement is satisfied
Kc = 20;

%% 2. Draw the Bode plot for the gain adjusted uncompensated system
% Obtain the phase margin
[Gm,Pm,Wcg,Wcp] = margin(Kc*G);
[magnu,phaseu] = bode(Kc*G,w);
magnu = squeeze(magnu);
phaseu = squeeze(phaseu);

try close(2); catch warning('Figure 2 already closed'); end
figure(2), set(gcf, 'Position',  [100, 400, 800, 600])
subplot(15,1,1:8), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,20*log10(magnu),'LineWidth',2)
line([Wcp Wcp],[0 -100],'Color','k','LineStyle','-.')
line([Wcg Wcg],[0 -20*log10(Gm)],'Color','g','LineWidth',2)
line([Wcg Wcg],[-100 0],'Color','k','LineStyle','-.')
text(Wcg,-20*log10(Gm)+5,...
    sprintf('GM = %0.3g dB',20*log10(Gm)),'Color','g')
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
% xlim([0.1 10])
% ylim([-40 40])
% yticks(-100:10:80)

subplot(15,1,9:15), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,phaseu,'LineWidth',2)
line([Wcp Wcp],[-80 -180],'Color','k','LineStyle','-.')
line([Wcp Wcp],[-180 -180+Pm],'Color','r','LineWidth',2)
line([Wcg Wcg],[-80 -180],'Color','k','LineStyle','-.')
text(1.05*Wcp,-175+Pm,...
    sprintf('PM = %0.3g^o',Pm),'Color','r')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
% xlim([0.1 10])
ylim([-280 -80])
yticks(-270:30:-90)
exportgraphics(gcf,'../images/marginsExample2.eps')

%% 3. Choose a new gain crossover frequency and set the
%  corner frequency one decade below (lag zero frequency)
% Frequency where phase = -180
wc = 1.41;
wz_lag = wc/10;
T2 = 1/wz_lag;

%% 4. Compute beta from the formula and place the corner 
%  frequency (lag pole frequency)
syms beta
beta = double(solve(sin(50*pi/180) == (beta-1)/(beta+1)));
wp_lag = 1/(beta*T2);

%% 5. Obtain the gain at the crossover frequency
syms wp_lead wz_lead
% wp_lead = double(solve(20 == (13)/(log10(wp_lead)-log10(1.5))));
% wz_lead = double(solve(20 == (-13+20)/(log10(1.5)-log10(wz_lead))));
wp_lead = double(solve(20 == (0-20*log10(Gm))/(log10(wp_lead)-log10(wc))));
wz_lead = double(solve(20 == (20*log10(Gm)+20)/(log10(wc)-log10(wz_lead))));
Gc = Kc*((s+wz_lag)/(s+wp_lag))*((s+wz_lead)/(s+wp_lead));

[magnc,phasec] = bode(G*Gc,w);
magnc = squeeze(magnc); phasec = squeeze(phasec);
[Gmc,Pmc,Wcgc,Wcpc] = margin(Gc*G);
[Gmc,Pmc,Wcgc,Wcpc]

try close(3); catch warning('Figure 3 already closed'); end
figure(3), set(gcf, 'Position',  [1000, 200, 800, 600])
subplot(15,1,1:8), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,20*log10(magnu),'LineWidth',2)
semilogx(w,20*log10(magnc),'LineWidth',2)
line([Wcpc Wcpc],[0 -100],'Color','k','LineStyle','-.')
line([Wcgc Wcgc],[-100 0],'Color','k','LineStyle','-.')
line([Wcgc Wcgc],[0 -20*log10(Gmc)],'Color','g','LineWidth',2)
text(1.05*Wcgc,-20*log10(Gmc)+15,...
    sprintf('GM = %0.3g dB',20*log10(Gmc)),'Color','g')
legend('G_1(s)','G_c(s)G(s)')
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])

subplot(15,1,9:15), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,phaseu,'LineWidth',2)
semilogx(w,phasec,'LineWidth',2)
line([Wcpc Wcpc],[-80 -180],'Color','k','LineStyle','-.')
line([Wcpc Wcpc],[-180 -180+Pmc],'Color','r','LineWidth',2)
line([Wcgc Wcgc],[-80 -180],'Color','k','LineStyle','-.')
text(1.05*Wcpc,-175+Pmc,...
    sprintf('PM = %0.3g^o',Pmc),'Color','r')
ylim([-270 -90])
yticks(-270:30:-90)
legend('G_1(s)','G_c(s)G(s)')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
exportgraphics(gcf,'../images/lagLeadExample2Comparison.eps')

%% Time responses
Tf = 25;
% Step response
[ysu,tsu] = step(feedback(G,1),Tf);
[ysc,tsc] = step(feedback(Gc*G,1),Tf);
try close(4); catch warning('Figure 1 already closed'); end
figure(4), cla, hold on
set(gcf, 'Position',  [100, 200, 800, 600])
plot(tsu,ysu,'LineWidth',3);
plot(tsc,ysc,'LineWidth',3);
line([0 Tf],[1 1],'Color','k','LineStyle','--','LineWidth',1.5);
grid on, xlim([0 Tf])
xlabel('Time [s]'), ylabel('y(t)')
legend('G(s)','G_c(s)G(s)','Location','east')
exportgraphics(gcf,'../images/stepRespLagLeadCompExample2.eps')

% Ramp response
[yru,tru] = step(feedback(G,1)*(1/s),Tf);
[yrc,trc] = step(feedback(Gc*G,1)*(1/s),Tf);
try close(5); catch warning('Figure 1 already closed'); end
figure(5), cla, hold on
set(gcf, 'Position',  [1000, 200, 800, 600])
h2 = plot(tru,yru,'LineWidth',3);
h3 = plot(trc,yrc,'LineWidth',3);
h1 = line([0 Tf],[0 Tf],'Color','k','LineStyle','--','LineWidth',1.5);
grid on
xlabel('Time [s]'), ylabel('y(t)')
legend([h2,h3],'G(s)','G_c(s)G(s)','Location','east')
exportgraphics(gcf,'../images/rampRespLagLeadCompExample2.eps')







