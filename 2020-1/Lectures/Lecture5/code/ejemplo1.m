%% Metodo Matematico
% 1. Polinomio deseado
syms zeta
zetasol = solve(0.05 == exp(-zeta*pi/sqrt(1-zeta^2)))
zetasol = vpa(zetasol)
zeta = zetasol(1)

omegan = 4/(0.005*zeta)

[1 2*zeta*omegan omegan^2]

Kd = double((2*zeta*omegan - 361.2)/4500)
Kp = double(omegan^2/4500)

s = tf('s')
T = (4500*(Kp + Kd*s))/(s^2 + (361.2+4500*Kd)*s + 4500*Kp)

pole(T)
zero(T)

%%
syms s Kd Kp a b
Sol_ab = solve(a*b == 4500*Kp, a+b == 361.2+4500*Kd,a,b)
Sol_ab.a
Sol_ab.b

Sol_num_a = matlabFunction(Sol_ab.a(2));
Sol_num_b = matlabFunction(Sol_ab.b(2));

Kpvec = linspace(0,500,200);
Kdvec = linspace(0,1,100);
[X,Y] = meshgrid(Kpvec,Kdvec);
Pa = zeros(length(Kpvec),length(Kdvec));
Pb = zeros(length(Kpvec),length(Kdvec));
for row = 1:size(Pa,1)
    for col = 1:size(Pa,2)
        Kp = Kpvec(row);
        Kd = Kdvec(col);
        Pa(row,col) = Sol_num_a(Kp,Kd);
        Pb(row,col) = Sol_num_b(Kp,Kd);
    end
end
subplot(1,2,1), surf(X,Y,Pa')
xlabel('Kp')
ylabel('Kd')
zlabel('Pa')
subplot(1,2,2), surf(X,Y,Pb')
xlabel('Kp')
ylabel('Kd')
zlabel('Pa')

