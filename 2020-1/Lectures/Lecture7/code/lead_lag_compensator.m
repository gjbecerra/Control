s = tf('s');
Gunc = 4/(s^2 + 0.5*s);
Gcom = (s + 0.2)/(s*(s+5.02)*(s+0.01247));
figure(1), rlocus(Gunc)
figure(2), rlocus(Gcom)
figure(3), rlocus(Gcom), axis([-0.5 0.1 -0.25 0.25])

%% Respuesta paso
figure(1), cla
step(feedback(Gunc,1)), hold on
step(feedback(25.4*Gcom,1)), hold off
legend('Sistema no compensado','Sistema compensado')
axis([0 8 0 1.8])

%% Respuesta rampa
[yunc,tunc] = step(feedback(Gunc,1)/s);
[ycom,tcom] = step(feedback(25.4*Gcom,1)/s);
figure(2), cla
plot(tunc,yunc), hold on
plot(tcom,ycom)
plot(tunc,tunc,'--'), hold off
xlabel('t [s]')
ylabel('Salida C')
legend('Sistema no compensado','Sistema compensado','Rampa unitaria')
axis([0 10 0 10])