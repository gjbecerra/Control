s = tf('s');
G = 1/(s*(s+1)*(s+5));
omega = sqrt(5);
Kcr = 30
Pcr = 2*pi/omega

Kp = 0.6*Kcr
Ti = 0.5*Pcr
Td = 0.125*Pcr
% 
% Kp = 0.6*Kcr
% Ti = 1.2*Kcr/Pcr
% Td = 0.6*Kcr*Pcr/8

Gc = Kp*(1+1/(Ti*s)+Td*s)
Glc = feedback(Gc*G,1)
step(Glc)
N = 100

%%
G = tf(1, [1 4 6 4 1]);
step(G)