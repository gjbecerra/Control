%% Control 2020-01
% Gerardo Becerra
% Parameters for Lecture 2, example 1.
L1 = 1e-3;
L2 = 2e-3;
C = 250e-6;
R1 = 1;
R2 = 100;

%% Run simulation
sim('example1_simul')

%% Block diagram simulation
figure(1)
subplot(3,1,1), plot(IL1.time, IL1.data), ylabel('I_{L1}')
subplot(3,1,2), plot(IL2.time, IL2.data), ylabel('I_{L2}')
subplot(3,1,3), plot(VC.time, VC.data), xlabel('Time [s]'), ylabel('V_C')

%% State space representation
Am = [-R1/L1 0 -1/L1;...
     0 -R2/L2 1/L2;...
     1/C -1/C 0];
Bm = [1/L1; 0; 0];
Cm = [0 R2 0];
Dm = 0;
% Cm = eye(3);
% Dm = zeros(3,1);

%% Transfer Function
s = tf('s');
Hs = Cm*(s*eye(3) - Am)^-1 * Bm + Dm;

%% First order system
H1 = tf([1],[1 1]);
step(H1)
stepinfo(H1)
hold on
H2 = tf([1],[1 1], 'InputDelay', 2.5);
step(H2)
stepinfo(H2)
hold off