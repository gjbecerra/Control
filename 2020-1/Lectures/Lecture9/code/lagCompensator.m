%% Lag Compensator Bode Diagram
% close all
s = tf('s');
Kc = 1; beta = 10; T = 1;
Gc = Kc*beta*(s*T+1)/(beta*T*s+1);
w = logspace(-2,1,1001);
[magn,phase,w] = bode(Gc,w);
magn = squeeze(magn); phase = squeeze(phase);
h3 = figure(3); set(gcf, 'Position',  [100, 100, 900, 800])
subplot(15,1,1:8), hold on
set(gca, 'XScale', 'log')
mx = [0.01 0.1; 0.1 1; 1 10];
my = [20 20; 20 0; 0 0];
hl1 = line(mx,my,'LineWidth',2,  'LineStyle','--','Color','k');
hl2 = semilogx(w,20*log10(magn),'LineWidth',2.8);
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
% xlim([0.1 100])
ylim([-5 25])
yticks([-10 0 10 20])
% legend([hl1(1), hl2], 'Aprox. lineal', 'Curva exacta')

subplot(15,1,9:15), hold on
set(gca, 'XScale', 'log')
hl2 = semilogx(w,phase,'LineWidth',2.8);
% xlim([0.1 100])
ylim([-90 0])
% legend([hl1(1), hl2], 'Aprox. lineal', 'Curva exacta')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-2 1e-1 1 1e1])
xticklabels({'0.01/T','0.1/T','1/T','10/T'})
yticks(-90:30:0)
exportgraphics(gcf,'../images/bodeLagComp.eps')

%% Bode Diagram for gain-adjusted uncompensated system
close all
s = tf('s');
w = logspace(-1,1,1001);
G = 1/(s*(s+1)*(0.5*s+1));
K = 5;
G1 = K*G;

figure(1), set(gcf, 'Position',  [100, 200, 800, 600])
cla, hold on
[magnu,phaseu] = bode(G1,w);
magnu = squeeze(magnu); phaseu = squeeze(phaseu);
subplot(15,1,1:8), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,20*log10(magnu),'LineWidth',2)
line([1.8 1.8],[0 -50],'Color','k','LineStyle','-.')
line([1.41 1.41],[0 4.44],'Color','g','LineWidth',2)
line([1.41 1.41],[-50 0],'Color','k','LineStyle','-.')
text(1.41,7,'GM = -4.44dB','Color','g')
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
xlim([0.1 10])
ylim([-40 40])
yticks(-100:10:80)

subplot(15,1,9:15), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,phaseu,'LineWidth',2)
line([1.8 1.8],[-90 -180],'Color','k','LineStyle','-.')
line([1.8 1.8],[-180 -180-13],'Color','r','LineWidth',2)
line([1.41 1.41],[-90 -180],'Color','k','LineStyle','-.')
text(1.85,-188,'PM = -13^o','Color','r')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xlim([0.1 10])
ylim([-255 -95])
yticks(-240:30:-120)
exportgraphics(gcf,'../images/bodeGainAdjustedSystem.eps')

%% Bode Diagram for gain-adjusted uncompensated system
%  showing the new crossover frequency
close all
s = tf('s');
w = logspace(-1,1,1001);
G = 1/(s*(s+1)*(0.5*s+1));
K = 5;
G1 = K*G;

figure(1), set(gcf, 'Position',  [100, 200, 800, 600])
cla, hold on
[magnu,phaseu] = bode(G1,w);
magnu = squeeze(magnu); phaseu = squeeze(phaseu);
subplot(15,1,1:8), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,20*log10(magnu),'LineWidth',2)
% line([1.8 1.8],[0 -50],'Color','k','LineStyle','-.')
% line([1.41 1.41],[0 4.44],'Color','g','LineWidth',2)
line([0.56 0.56],[17.51 0],'Color','r','LineWidth',2)
line([0.56 0.56],[-0 -50],'Color','k','LineStyle','-.')
text(0.32,9,'17.51 dB','Color','r','FontSize',12)
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
xlim([0.1 10])
ylim([-40 40])
yticks(-100:10:80)

subplot(15,1,9:15), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,phaseu,'LineWidth',2)
% line([1.8 1.8],[-90 -180],'Color','k','LineStyle','-.')
line([0.56 0.56],[-180 -135],'Color','r','LineWidth',2)
text(0.31,-155,'\phi_m = 45^o','Color','r','FontSize',12)
text(0.58,-240,"\omega_c^'= 0.56",'Color','r','FontSize',12)
line([0.56 0.56],[-90 -135],'Color','k','LineStyle','-.')
line([0.56 0.56],[-180 -260],'Color','k','LineStyle','-.')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xlim([0.1 10])
ylim([-255 -95])
yticks(-240:30:-120)
exportgraphics(gcf,'../images/bodeCrossoverFrequency.eps')

%% Comparison of Bode Diagrams for uncompensated and
%  compensated systems
close all
s = tf('s');
w = logspace(-3,2,1001);
G = 1/(s*(s+1)*(0.5*s+1));
K = 5;
G1 = K*G;

figure(1), set(gcf, 'Position',  [100, 200, 800, 600])
cla, hold on
[magnu,phaseu] = bode(G1,w);
magnu = squeeze(magnu); phaseu = squeeze(phaseu);
subplot(15,1,1:8), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,20*log10(magnu),'LineWidth',2)
ylabel('Magnitud (dB)','FontSize',13), grid on
ylim([-100 100])
set(gca,'Xticklabel',[])

subplot(15,1,9:15), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,phaseu,'LineWidth',2)
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
ylim([-280 -80])
yticks(-270:30:-90)

% Computes the margins
[Gm,Pm,Wcg,Wcp] = margin(G1); % PM = 13 deg at 1.8 rad/s

% Desired PM = 40 + 5
% New crossover frecuency: wc' = 0.56 rad/s
% Compensator zero location: wz = 0.056 rad/s
wz = 0.056;
% Attenuation needed at wc': 20*log10(alpha) = 17.51
syms beta
beta = double(solve(20*log10(1/beta) == -17.51));
% beta = 7.5076
% Pole location wp = 1/alpha*T = wz / alpha
wp = wz / beta;
T = 1/(beta*wp);
Kc = K/beta;
s = tf('s');
Gc = Kc*beta*((1+s*T)/(1+s*beta*T));

[magnc,phasec] = bode(G*Gc,w);
magnc = squeeze(magnc); phasec = squeeze(phasec);
subplot(15,1,1:8)
semilogx(w,20*log10(magnc),'LineWidth',2)
line([1.36 1.36],[0 -12.4],'Color','g','LineWidth',2)
line([1.36 1.36],[-12.4 -100],'Color','k','LineStyle','-.')
line([0.562 0.562],[-100 0],'Color','k','LineStyle','-.')
legend('G_1(s)','G_c(s)G(s)')

subplot(15,1,9:15)
semilogx(w,phasec,'LineWidth',2)
line([0.562 0.562],[-180 -180+40.1],'Color','r','LineWidth',2)
line([0.562 0.562],[-180+40.1 -80],'Color','k','LineStyle','-.')
line([1.36 1.36],[-80 -180],'Color','k','LineStyle','-.')
legend('G_1(s)','G_c(s)G(s)')
exportgraphics(gcf,'../images/bodeLagCompExampleComparison.eps')

%% Time responses
Tf = 30;
% Step response
[ysu,tsu] = step(feedback(G,1),Tf);
[ysc,tsc] = step(feedback(Gc*G,1),Tf);
figure(2), cla, hold on
set(gcf, 'Position',  [100, 200, 800, 600])
plot(tsu,ysu,'LineWidth',2);
plot(tsc,ysc,'LineWidth',2);
grid on
xlabel('Time [s]'), ylabel('y(t)')
legend('G(s)','G_c(s)G(s)')
exportgraphics(gcf,'../images/stepRespLagCompExampleComparison.eps')

% Ramp response
[yru,tru] = step(feedback(G,1)*(1/s),Tf);
[yrc,trc] = step(feedback(Gc*G,1)*(1/s),Tf);
figure(3), cla, hold on
set(gcf, 'Position',  [100, 200, 800, 600])
h1 = line([0 Tf],[0 Tf],'Color','k','LineStyle','--');
h2 = plot(tru,yru,'LineWidth',2);
h3 = plot(trc,yrc,'LineWidth',2);
grid on
xlabel('Time [s]'), ylabel('y(t)')
legend([h2,h3],'G(s)','G_c(s)G(s)')
exportgraphics(gcf,'../images/rampRespLagCompExampleComparison.eps')