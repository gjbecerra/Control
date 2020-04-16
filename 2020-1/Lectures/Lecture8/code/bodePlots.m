%% Basic factors in Bode plots
%% Gain K
close all
K = 5;
T = 1;
w = logspace(-1,2,100);
G1 = tf(K,1);
[magn,phase] = bode(G1,w);
figure(1), set(gcf, 'Position',  [200, 200, 600, 600])
subplot(15,1,1:8), semilogx(w,20*log10(squeeze(magn)),'LineWidth',2.8)
ylim([0 30]), ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
subplot(15,1,9:15), semilogx(w,squeeze(phase),'LineWidth',2.8)
ylim([-100 100]), ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-2 1e-1 1 1e1 1e2])
xticklabels({'0.01','0.1','1','10','100'})
yticks([-90 -45 0 45 90])
saveas(gcf,'../images/bodeGainK.svg')

%% Integral term 1/jw
close all
T = 1;
w = logspace(-1,2,100);
s = tf('s');
G1 = 1/s;
[magn,phase,w] = bode(G1,{1/(100*T),100*T});
figure(1), set(gcf, 'Position',  [200, 200, 600, 600])
subplot(15,1,1:8), semilogx(w,20*log10(squeeze(magn)),'LineWidth',2.8)
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
subplot(15,1,9:15), semilogx(w,squeeze(phase),'LineWidth',2.8)
ylim([-200 20]), ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-2 1e-1 1 1e1 1e2])
xticklabels({'0.01','0.1','1','10','100'})
yticks([-180 -90 0])
saveas(gcf,'../images/bodeIntegral.svg')

%% Derivative term jw
close all
T = 1;
G1 = tf([1 0],1);
[magn,phase,w] = bode(G1,{1/(100*T),100*T});
figure(1), set(gcf, 'Position',  [200, 200, 600, 600])
subplot(15,1,1:8), semilogx(w,20*log10(squeeze(magn)),'LineWidth',2.8)
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
subplot(15,1,9:15), semilogx(w,squeeze(phase),'LineWidth',2.8)
ylim([-20 200]), ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-2 1e-1 1 1e1 1e2])
xticklabels({'0.01','0.1','1','10','100'})
yticks([0 90 180])
saveas(gcf,'../images/bodeDerivative.svg')

%% First-order Integral term 1/(1 + jwT)
close all
s = tf('s');
T = 1;
figure(1), cla, set(gcf, 'Position',  [200, 200, 600, 600])
G1 = 1/(1 + s*T);
[magn,phase,w] = bode(G1,{1/(100*T),100*T});
magn = squeeze(magn);
phase = squeeze(phase);
subplot(15,1,1:8), semilogx(w,20*log10(magn),'LineWidth',2), hold on,
line([w(1) 1],[0 0],'LineWidth',2,'LineStyle','--','Color','k')
line([1 w(end)],[0 20*log10(magn(end))],'LineWidth',2,'LineStyle','--','Color','k')
annotation('textarrow',[0.516 0.516],[0.890 0.84],'String',{'Frecuencia de quiebre'});
annotation('textarrow',[0.331 0.408],[0.312 0.38],'String',{'Aprox. lineal'});
annotation('textarrow',[0.486 0.436],[0.427 0.381],'String',{'Curva exacta'});
ylim([-40 10]), ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
subplot(15,1,9:15), semilogx(w,phase,'LineWidth',2), hold on
line([w(1) 0.1],[0 0],'LineWidth',2,'LineStyle','--','Color','k')
line([0.1 10],[0 -90],'LineWidth',2,'LineStyle','--','Color','k')
line([10 w(end)],[-90 -90],'LineWidth',2,'LineStyle','--','Color','k')
annotation('textarrow',[0.434 0.511],[0.735 0.813],'String',{'Curva exacta'});
annotation('textarrow',[0.609 0.550],[0.860 0.811],'String',{'Curva asintótica'});
ylim([-100 10]), ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-2 1e-1 1 1e1 1e2])
xticklabels({'0.01/T','0.1/T','1/T','10/T','100/T'})
yticks([-90 -45 0])
saveas(gcf,'../images/bodeFirstOrderIntegral.svg')

%% First-order Derivative term 1/(1 + jwT)
close all
s = tf('s');
T = 1;
figure(1), cla, set(gcf, 'Position',  [200, 200, 600, 600])
G1 = (1 + s*T);
[magn,phase,w] = bode(G1,{1/(100*T),100*T});
magn = squeeze(magn);
phase = squeeze(phase);
subplot(15,1,1:8), semilogx(w,20*log10(magn),'LineWidth',2), hold on,
line([w(1) 1],[0 0],'LineWidth',2,'LineStyle','--','Color','k')
line([1 w(end)],[0 20*log10(magn(end))],'LineWidth',2,'LineStyle','--','Color','k')
annotation('textarrow',[0.518 0.518],[0.537 0.581],'String',{'Frecuencia de quiebre'});
annotation('textarrow',[0.347 0.426],[0.312 0.228],'String',{'Aprox. lineal'});
annotation('textarrow',[0.449 0.524],[0.705 0.615],'String',{'Curva exacta'});
ylim([-10 40]), ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
subplot(15,1,9:15), semilogx(w,phase,'LineWidth',2), hold on
line([w(1) 0.1],[0 0],'LineWidth',2,'LineStyle','--','Color','k')
line([0.1 10],[0 90],'LineWidth',2,'LineStyle','--','Color','k')
line([10 w(end)],[90 90],'LineWidth',2,'LineStyle','--','Color','k')
annotation('textarrow',[0.542 0.465],[0.169 0.24],'String',{'Curva exacta'});
annotation('textarrow',[0.609 0.555],[0.569 0.618],'String',{'Curva asintótica'});
ylim([-10 100]), ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-2 1e-1 1 1e1 1e2])
yticks([0 45 90])
xticklabels({'0.01/T','0.1/T','1/T','10/T','100/T'})
saveas(gcf,'../images/bodeFirstOrderDerivative.svg')

%% Second-order Integral term 1/(1 + (2 zeta jw)/wn + (jw/wn)^2)
close all
s = tf('s');
wn = 1;
zeta_vec = [0.1 0.2 0.3 0.5 0.7 1.0];
figure(1), cla, set(gcf, 'Position',  [200, 200, 600, 600])
for k = 1:length(zeta_vec)
    zeta = zeta_vec(k);
    G1 = 1/(1 + 2*zeta*s/wn + (s/wn)^2);
    [magn,phase,w] = bode(G1,{1/(100*T),100*T});
    magn = squeeze(magn);
    phase = squeeze(phase);
    subplot(15,1,1:8), semilogx(w,20*log10(magn),'LineWidth',2), hold on,
end
legend('\zeta = 0.1','\zeta = 0.2','\zeta = 0.3','\zeta = 0.5','\zeta = 0.7','\zeta = 1.0')
ylabel('Magnitud (dB)','FontSize',13), grid on, ylim([-80 20])
set(gca,'Xticklabel',[])
for k = 1:length(zeta_vec)
    zeta = zeta_vec(k);
    G1 = 1/(1 + 2*zeta*s/wn + (s/wn)^2);
    [magn,phase,w] = bode(G1,{1/(100*T),100*T});
    magn = squeeze(magn);
    phase = squeeze(phase);
    subplot(15,1,9:15), semilogx(w,phase,'LineWidth',2), hold on
end
legend('\zeta = 0.1','\zeta = 0.2','\zeta = 0.3','\zeta = 0.5','\zeta = 0.7','\zeta = 1.0')
ylim([-200 20]), ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega/\omega_n','FontSize',13)
yticks([-180 -90 0])
saveas(gcf,'../images/bodeSecondOrderIntegral.svg')

%% Second-order Derivative term (1 + (2 zeta jw)/wn + (jw/wn)^2)
close all
s = tf('s');
T = 1;
wn = 1;
zeta_vec = [0.1 0.2 0.3 0.5 0.7 1.0];
figure(1), cla, set(gcf, 'Position',  [200, 200, 600, 600])
for k = 1:length(zeta_vec)
    zeta = zeta_vec(k);
    G1 = (1 + 2*zeta*s/wn + (s/wn)^2);
    [magn,phase,w] = bode(G1,{1/(100*T),100*T});
    magn = squeeze(magn);
    phase = squeeze(phase);
    subplot(15,1,1:8), semilogx(w,20*log10(magn),'LineWidth',2), hold on,
end
legend('\zeta = 0.1','\zeta = 0.2','\zeta = 0.3','\zeta = 0.5','\zeta = 0.7','\zeta = 1.0','Location','southeast')
ylabel('Magnitud (dB)','FontSize',13), grid on, ylim([-20 80])
set(gca,'Xticklabel',[])
for k = 1:length(zeta_vec)
    zeta = zeta_vec(k);
    G1 = (1 + 2*zeta*s/wn + (s/wn)^2);
    [magn,phase,w] = bode(G1,{1/(100*T),100*T});
    magn = squeeze(magn);
    phase = squeeze(phase);
    subplot(15,1,9:15), semilogx(w,phase,'LineWidth',2), hold on
end
legend('\zeta = 0.1','\zeta = 0.2','\zeta = 0.3','\zeta = 0.5','\zeta = 0.7','\zeta = 1.0','Location','southeast')
ylim([-20 200]), ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega/\omega_n','FontSize',13)
yticks([0 90 180])
saveas(gcf,'../images/bodeSecondOrderDerivative.svg')

%% Example
clc
close all
defcol = [0, 0.4470, 0.7410;
     0.8500, 0.3250, 0.0980;
     0.9290, 0.6940, 0.1250;
     0.4940, 0.1840, 0.5560;
     0.4660, 0.6740, 0.1880;
     0.3010, 0.7450, 0.9330;
     0.6350, 0.0780, 0.1840];
T = 1;
s = tf('s');
G1 = tf(5,1);
G2 = 1/s;
G3 = 1/(1+0.5*s);
G4 = 1+0.1*s;
G5 = 1/(1 + 0.6*s/50 + (s/50)^2);
w = logspace(-3,3,100);
[magn1,phase1] = bode(G1,w);
[magn2,phase2] = bode(G2,w);
[magn3,phase3] = bode(G3,w);
[magn4,phase4] = bode(G4,w);
[magn5,phase5] = bode(G5,w);
magn1 = squeeze(magn1); phase1 = squeeze(phase1);
magn2 = squeeze(magn2); phase2 = squeeze(phase2);
magn3 = squeeze(magn3); phase3 = squeeze(phase3);
magn4 = squeeze(magn4); phase4 = squeeze(phase4);
magn5 = squeeze(magn5); phase5 = squeeze(phase5);
h1 = figure(1); set(gcf, 'Position',  [100, 100, 1000, 800])
subplot(15,1,1:8), set(gca, 'XScale', 'log'), hold on
mx1 = [w(1) w(end)];                  my1 = [20*log10(5) 20*log10(5)];
mx2 = [w(1) w(end)];                  my2 = [60 -60];
mx3 = [w(1) 2; 2 w(end)];             my3 = [0 0; 0 20*log10(magn3(end))];
mx4 = [w(1) 10; 10 w(end)];           my4 = [0 0; 0 20*log10(magn4(end))];
mx5 = [w(1) 50; 50 w(end)];           my5 = [0 0; 0 20*log10(magn5(end))];
semilogx(w,20*log10(magn1),'LineWidth',2, 'LineStyle','--','Color',min(defcol(1,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,20*log10(magn2),'LineWidth',2, 'LineStyle','--','Color',min(defcol(2,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,20*log10(magn3),'LineWidth',2, 'LineStyle','--','Color',min(defcol(3,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,20*log10(magn4),'LineWidth',2, 'LineStyle','--','Color',min(defcol(4,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,20*log10(magn5),'LineWidth',2, 'LineStyle','--','Color',min(defcol(5,:)+[0.25 0.25 0.25],ones(1,3)))

hl1 = line(mx1,my1,'LineWidth',2,'LineStyle','-','Color',defcol(1,:));
hl2 = line(mx2,my2,'LineWidth',2,'LineStyle','-','Color',defcol(2,:));
hl3 = line(mx3,my3,'LineWidth',2,'LineStyle','-','Color',defcol(3,:));
hl4 = line(mx4,my4,'LineWidth',2,'LineStyle','-','Color',defcol(4,:));
hl5 = line(mx5,my5,'LineWidth',2,'LineStyle','-','Color',defcol(5,:));

legend([hl1,hl2,hl3(1),hl4(1),hl5(1)],'|G_1(j\omega)|','|G_2(j\omega)|','|G_3(j\omega)|','|G_4(j\omega)|','|G_5(j\omega)|','Location','southwest')
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
axis([1e-2 1e3 -60 60])

subplot(15,1,9:15), set(gca, 'XScale', 'log'), hold on
px1 = [w(1) w(end)];                 py1 = [0 0];                   
px2 = [w(1) w(end)];                 py2 = [-90 -90];                   
px3 = [w(1) 0.2; 0.2 20; 20 w(end)]; py3 = [0 0; 0 -90; -90 -90];      
px4 = [w(1) 1; 1 100; 100 w(end)];   py4 = [0 0; 0  90;  90  90];      
px5 = [w(1) 5; 5 500; 500 w(end)];   py5 = [0 0; 0 -180; -180 -180];      
semilogx(w,phase1,'LineWidth',2,'LineStyle','--','Color',min(defcol(1,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,phase2,'LineWidth',2,'LineStyle','--','Color',min(defcol(2,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,phase3,'LineWidth',2,'LineStyle','--','Color',min(defcol(3,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,phase4,'LineWidth',2,'LineStyle','--','Color',min(defcol(4,:)+[0.25 0.25 0.25],ones(1,3)))
semilogx(w,phase5,'LineWidth',2,'LineStyle','--','Color',min(defcol(5,:)+[0.25 0.25 0.25],ones(1,3)))

hl1 = line(px1,py1,'LineWidth',2,'LineStyle','-','Color',defcol(1,:));
hl2 = line(px2,py2,'LineWidth',2,'LineStyle','-','Color',defcol(2,:));
hl3 = line(px3,py3,'LineWidth',2,'LineStyle','-','Color',defcol(3,:));
hl4 = line(px4,py4,'LineWidth',2,'LineStyle','-','Color',defcol(4,:));
hl5 = line(px5,py5,'LineWidth',2,'LineStyle','-','Color',defcol(5,:));

ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
legend([hl1,hl2,hl3(1),hl4(1),hl5(1)],'\angleG_1(j\omega)','\angleG_2(j\omega)','\angleG_3(j\omega)','\angleG_4(j\omega)','\angleG_5(j\omega)','Location','southwest')
xticks([1e-3 1e-2 1e-1 1 1e1 1e2 1e3])
xticklabels({'0.001','0.01','0.1','1','10','100','1000'})
yticks([-180 -135 -90 -45 0 45 90 135])
axis([1e-2 1e3 -200 110])
% exportgraphics(gcf,'../images/bodeExample1a.eps')
saveas(gcf,'../images/bodeExample1a.svg')

%%
close all
G = G1*G2*G3*G4*G5;
[magn,phase,w] = bode(G,w);
magn = squeeze(magn); phase = squeeze(phase);
h2 = figure(2); set(gcf, 'Position',  [1000, 100, 1000, 800])
subplot(15,1,1:8), hold on
set(gca, 'XScale', 'log')
mx = [0.001 2; 2 10; 10 50; 50 1000];
my = [73.98 7.96; 7.96 -20; -20 -34.2; -34.2 -112.2];
hl1 = line(mx,my,'LineWidth',2,  'LineStyle','--','Color','k');
hl2 = semilogx(w,20*log10(magn),'LineWidth',2.8);
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
xlim([0.01 1000])
legend([hl1(1), hl2], 'Aprox. lineal', 'Curva exacta')

subplot(15,1,9:15), hold on
set(gca, 'XScale', 'log')
px = [0.001 0.2; 0.2 1;1 5; 5 20; 20 100; 100 500; 500 1000];
py = [-90 -90; -90 -121.45; -121.45 -125.1; -125.1 -175.7;...
      -175.7 -207.1; -207.1 -270; -270 -270];     
hl1 = line(px,py,'LineWidth',2,'LineStyle','--','Color','k');
hl2 = semilogx(w,phase,'LineWidth',2.8);
ylim([-280 -80])
xlim([0.01 1000])
legend([hl1(1), hl2], 'Aprox. lineal', 'Curva exacta')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-2 1e-1 1 1e1 1e2 1e3])
xticklabels({'0.01','0.1','1','10','100','1000'})
yticks([-360 -315 -270 -225 -180 -135 -90 -45 0])
exportgraphics(gcf,'../images/bodeExample1b.eps')

%% Phase and gain margins
close all
s = tf('s');
L = 1/(s*(s+1)*(0.2*s+1));
w = logspace(-1,1,100);
[magn,phase] = bode(L,w);
magn = squeeze(magn);
phase = squeeze(phase);
h3 = figure(3); set(gcf, 'Position',  [100, 100, 800, 800])
subplot(15,1,1:8), grid on
semilogx(w,20*log10(magn),'LineWidth',2.8);
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
subplot(15,1,9:15), grid on
semilogx(w,phase,'LineWidth',2.8);
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-1 1 1e1])
xticklabels({'0.1','1','10'})
yticks([-315 -270 -225 -180 -135 -90])

[Gm,Pm,Wcg,Wcp] = margin(L);

%% Lead Compensator
close all
s = tf('s');
Kc = 1; alpha = 0.1; T = 1;
Gc = Kc*alpha*(s*T+1)/(s*alpha*T+1);
w = logspace(-1,2,1001);
[magn,phase,w] = bode(Gc,w);
magn = squeeze(magn); phase = squeeze(phase);
h3 = figure(3); set(gcf, 'Position',  [1000, 100, 800, 800])
subplot(15,1,1:8), hold on
set(gca, 'XScale', 'log')
mx = [0.1 1; 1 10; 10 100];
my = [-20 -20; -20 0; 0 0];
hl1 = line(mx,my,'LineWidth',2,  'LineStyle','--','Color','k');
hl2 = semilogx(w,20*log10(magn),'LineWidth',2.8);
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
xlim([0.1 100])
ylim([-25 5])
yticks([-20 -10 0 10])
% legend([hl1(1), hl2], 'Aprox. lineal', 'Curva exacta')

subplot(15,1,9:15), hold on
set(gca, 'XScale', 'log')
hl2 = semilogx(w,phase,'LineWidth',2.8);
xlim([0.1 100])
ylim([0 90])
% legend([hl1(1), hl2], 'Aprox. lineal', 'Curva exacta')
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
xticks([1e-1 1 1e1 1e2])
xticklabels({'0.1/T','1/T','10/T','100/T'})
yticks([0 30 60 90])
exportgraphics(gcf,'../images/bodeLeadComp.eps')

%% Lead Compensator Example
s = tf('s');
G1 = 40/(s*(s+2));
margin(G1)
exportgraphics(gcf,'../images/bodeLeadCompExample.eps')
%% Bode diagrams
close all
s = tf('s');
w = logspace(0,2,1001);
G = 4/(s*(s+2));
K = 10.1021;
Gc = K*(0.2036*s+1)/(0.0497*s+1);
figure(1), set(gcf, 'Position',  [50, 200, 800, 600])
cla, hold on
[magnu,phaseu] = bode(G,w);
[magnc,phasec] = bode(G*Gc,w);

magnu = squeeze(magnu); phaseu = squeeze(phaseu);
magnc = squeeze(magnc); phasec = squeeze(phasec);
subplot(15,1,1:8), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,20*log10(magnu),'LineWidth',2)
semilogx(w,20*log10(magnc),'LineWidth',2)
ylabel('Magnitud (dB)','FontSize',13), grid on
set(gca,'Xticklabel',[])
legend('G(s)','G_c(s)G(s)')

subplot(15,1,9:15), cla, hold on
set(gca, 'XScale', 'log')
semilogx(w,phaseu,'LineWidth',2)
semilogx(w,phasec,'LineWidth',2)
ylabel('\phi (grados)','FontSize',13), grid on
xlabel('\omega (rad/s)','FontSize',13)
legend('G(s)','G_c(s)G(s)')
yticks(-180:30:-90)
exportgraphics(gcf,'../images/bodeLeadCompExampleComparison.eps')

%% Step response of compensated system
t = linspace(0,6,1001);
yu = step(feedback(G,1),t);
yc = step(feedback(G*Gc,1),t);
figure(1), set(gcf, 'Position',  [50, 200, 800, 600])
cla, hold on
line([0 6],[1 1],'Color','k','LineStyle','--','LineWidth',1.5)
p1 = plot(t,yu,'LineWidth',2.8);
p2 = plot(t,yc,'LineWidth',2.8);
grid on
xlabel('Time [s]'), ylabel('y(t)')
legend([p1,p2],'No compensado','Compensado')
exportgraphics(gcf,'../images/bodeLeadCompExampleStep.eps')

%% Ramp response of compensated system
t = linspace(0,6,1001);
yu = step(feedback(G,1)/s,t);
yc = step(feedback(G*Gc,1)/s,t);
figure(1), set(gcf, 'Position',  [50, 200, 800, 600])
cla, hold on
line([0 6],[0 6],'Color','k','LineStyle','--','LineWidth',1.5)
p1 = plot(t,yu,'LineWidth',2.8);
p2 = plot(t,yc,'LineWidth',2.8);
grid on
xlabel('Time [s]'), ylabel('y(t)')
legend([p1,p2],'No compensado','Compensado','Location','east')
exportgraphics(gcf,'../images/bodeLeadCompExampleRamp.eps')


