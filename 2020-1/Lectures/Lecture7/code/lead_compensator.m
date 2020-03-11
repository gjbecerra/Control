num1 = [12.287 23.876];
den1 = [1 5.646 16.933 23.876];
% num2 = [9];
% den2 = [1 3 9];
num = [10];
den = [1 1 10];
t = 0:0.05:5;
c1 = step(num1,den1,t);
% c2 = step(num2,den2,t);
c = step(num,den,t);
plot(t,c1,'-',t,c,'x')
grid
% title('Unit-Step Responses of Compensated Systems and Uncompensated System')
xlabel('t [s]')
ylabel('Salida C')
text(1.51,1.48,'Sistema Compensado')
% text(0.9,0.48,'Compensated System (Method 2)')
text(2.51,0.67,'Sistema no Compensado')

%%
% ***** Unit-Ramp Responses of Compensated Systems *****
num1 = [12.287 23.876];
den1 = [1 5.646 16.933 23.876 0];
% num2 = [9];
% den2 = [1 3 9 0];
t = 0:0.05:5;
c1 = step(num1,den1,t);
% c2 = step(num2,den2,t);
plot(t,c1,'-',t,t,'-')
grid
% title('Unit-Ramp Responses of Compensated Systems')
xlabel('t [s]')
ylabel('Entrada Rampa-Unitaria y Salida C')
% text(2.55,3.8,'Input')
% text(0.55,2.8,'Sistema Compensado')
% text(2.35,1.75,'Compensated System (Method 2)')