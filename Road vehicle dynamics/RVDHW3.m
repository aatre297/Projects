Gr_Tran = [4.56;2.97;2.08;1.69;1.27;1.00;0.85;0.65];
Gr_Ax = 2.41;
I_Tran = [0.147;0.113;0.090;0.074;0.051;0.034;0.032;0.029];
I_e = 0.09;
I_d = 0.12;
I_Ax = 0.003;
theta_e_max = 6500;
m = 1665;
g = 9.81;
rho = 1.2754;
h = 1.23;
w = 1.97;
A = h*w;
Cd = 0.28;
fr = 0.015;
Rtf = 0.3268;
Rtr = 0.33775;
It = 1.2;
Eng_speed_RPM = [500;1000;1500;2000;2100;2300;2500;3000;3500;4000;4500;5000;5500;6000;6500];
Eng_speed_radps = (Eng_speed_RPM*2*pi)/60;
HP = [10;40;80;160;220;240;270;330;400;480;540;620;660;670;675];
road_speed = zeros(8,15);

for k = 1:8;
for a = 1:15;
road_speed(k,a) = (Rtr/(Gr_Tran(k)*Gr_Ax))*(Eng_speed_radps(a));
end
end

for j = 1:15
T_e(1,j) = (HP(j)*746)/(Eng_speed_radps(j));
end

m_eq_f = (2*It)/Rtf^2;
xddot = zeros(8,15);
for i =1:8;
m_eqdt(i,1) = ((Gr_Ax*Gr_Tran(i))^2*(I_e+I_Tran(i))+Gr_Ax^2*I_d+It)/(Rtr^2);
end
for b = 1:8;
    for c= 1:15;
xddot(b,c) = (((Gr_Ax*Gr_Tran(b,1)*T_e(c))/Rtr)-(fr*m*g)-(0.5*rho*Cd*A*road_speed(b,c)^2))/(m+m_eq_f+m_eqdt(b));
    end
end
figure(1)
plot(linspace(1,8,8),m_eqdt,'--dk','linew',2,'markerfacecolor','k','markersize',10);
grid on
xlabel('gear');
ylabel('equivalent mass of drivetrain [kg]');
title('ZR1 requivalent mass of drivetrain');

figure(2)
hold on
plot(road_speed(1,:)*2.23694,xddot(1,:)/g,'linew',2);
plot(road_speed(2,:)*2.23694,xddot(2,:)/g,'linew',2);
plot(road_speed(3,:)*2.23694,xddot(3,:)/g,'linew',2);
plot(road_speed(4,:)*2.23694,xddot(4,:)/g,'linew',2);
plot(road_speed(5,:)*2.23694,xddot(5,:)/g,'linew',2);
plot(road_speed(6,:)*2.23694,xddot(6,:)/g,'linew',2);
plot(road_speed(7,:)*2.23694,xddot(7,:)/g,'linew',2);
plot(road_speed(8,:)*2.23694,xddot(8,:)/g,'linew',2);
hold off
ylim([0,1.5])
grid on
xlabel('road speed [mph]')
ylabel('acceleration [g]')
title('full throttle accelaration vs. road speed for ZR1')
legend('first gear','second gear','third gear','fourth gear','fifth gear','sixth gear','seventh gear','eighth gear')


xddot_10mph = (interp1(road_speed(1,:),xddot(1,:),10/2.23694))/g
xddot_30mph = (interp1(road_speed(1,:),xddot(1,:),30/2.23694))/g
xddot_60mph = (interp1(road_speed(2,:),xddot(2,:),60/2.23694))/g
xddot_100mph = (interp1(road_speed(4,:),xddot(4,:),100/2.23694))/g
xddot_150mph = (interp1(road_speed(5,:),xddot(5,:),150/2.23694))/g






