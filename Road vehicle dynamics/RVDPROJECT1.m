%%
% 
% * ITEM1
% * ITEM2
% 
clear all

Gr_Tran = [5,2.2299,1.1839]';
Gr_Ax = 3.73;
for a = 1:3
I_Tran(a) = -(0.005*Gr_Tran(a)-0.058)*Gr_Tran(a);
end
I_e = 0.09;
I_d = 0.12;
I_Ax = 0.003;
theta_e_max = 6500;
W = 15123.95;
m = W/9.81;
g = 9.81;
rho = 1.2754;
A = 2.32258;
Cd = 0.31;
fr = 0.015;
Rt = (((19*25.4)+(2*(305*0.3)))/1000)/2;

It = 1.2;
Eng_speed_RPM = [0;1000;2000;3000;4000;5000;6000;7000;8000];
Eng_speed_radps = (Eng_speed_RPM*2*pi)/60;

m_eq_f = (2*It)/Rt^2;
dt = 0.01;
t = 0:dt:10.4;
xdot(1) = 5/2.23694;
x(1) = 0;
T_e_x = [0;135;220;310;385;629;525;449;347];
T_e = T_e_x./0.73756;
for f = 1:9
HP(f) = (T_e_x(f)*Eng_speed_RPM(f))./5252;
end
for k = 1:3;
for a = 1:9;
road_speed(k,a) = (Rt/(Gr_Tran(k)*Gr_Ax))*(Eng_speed_radps(a));
end
end


for k = 1:3;
    m_eqdt(k,1) = ((Gr_Ax*Gr_Tran(k))^2*(I_e+I_Tran(k))+Gr_Ax^2*I_d+It)/(Rt^2);
    end
N = length(t);
for b = 1:3;
    for c= 1:9;
xddot_gr(b,c) = (((Gr_Ax*Gr_Tran(b,1)*T_e(c))/Rt)-(fr*m*g)-(0.5*rho*Cd*A*road_speed(b,c)^2))/(m+m_eq_f+m_eqdt(b));
    end
end

for k = 1:N-1;
    
    if xdot(1,k) <= (33/2.23694);
         GR = 1;
        engine_speed(k) = (xdot(1,k)*Gr_Ax*Gr_Tran(GR,1))/Rt;
        if engine_speed(k) >= 837.75;
            engine_speed(k) = 837.75;
        else engine_speed(k) = engine_speed(k);
        end
        T_E = (interp1(Eng_speed_radps,T_e,engine_speed(k)));
         if engine_speed(k) >= 837;
            xddot(k) = 0;
        else
        xddot(k) = (((Gr_Ax*Gr_Tran(GR,1)*T_E)/Rt)-(fr*m*g)-(0.5*rho*Cd*A*xdot(1,k)^2))/(m+m_eq_f+m_eqdt(GR,1));
        end
       
        xdot(1,k+1) = xdot(1,k) + xddot(k)*dt;
        x(1,k+1) = x(1,k) + xdot(1,k)*dt;
        
    elseif xdot(1,k)>=(33/2.23694) && xdot(1,k)<(74/2.23694);
        GR = 2;
        engine_speed(k) = (xdot(1,k)*Gr_Ax*Gr_Tran(GR,1))/Rt;
        if engine_speed(k) >= 837.75;
            engine_speed(k) = 837.75;
        else engine_speed(k) = engine_speed(k);
        end
        T_E = (interp1(Eng_speed_radps,T_e,engine_speed(k)));
        if engine_speed(k) >= 837;
            xddot(k) = 0;
        else
        xddot(k) = (((Gr_Ax*Gr_Tran(GR,1)*T_E)/Rt)-(fr*m*g)-(0.5*rho*Cd*A*xdot(1,k)^2))/(m+m_eq_f+m_eqdt(GR,1));
        end
        xdot(1,k+1) = xdot(1,k) + xddot(k)*dt;
        x(1,k+1) = x(1,k) + xdot(1,k)*dt;
        
    else xdot(1,k)>=(74/2.23694) ;
        GR = 3;
        engine_speed(k) = (xdot(1,k)*Gr_Ax*Gr_Tran(GR,1))/Rt;
        if engine_speed(k) >= 837.75;
            engine_speed(k) = 837.75;
        else engine_speed(k) = engine_speed(k);
        end
        T_E = (interp1(Eng_speed_radps,T_e,engine_speed(k)));
     if engine_speed(k) >= 837;
            xddot(k) = 0;
        else
        xddot(k) = (((Gr_Ax*Gr_Tran(GR,1)*T_E)/Rt)-(fr*m*g)-(0.5*rho*Cd*A*xdot(1,k)^2))/(m+m_eq_f+m_eqdt(GR,1));
        end
        xdot(1,k+1) = xdot(1,k) + xddot(k)*dt;
        x(1,k+1) = x(1,k) + xdot(1,k)*dt;
       
        
  
        
    end
    end


figure (1)
    plot(t,x./1609.34,'linew',2)
    grid on
    xlabel('t[s]')
    ylabel('position[m]')
    title('Zr1 position, 5mph rolling start quarter-mile race')
    legend('Zr1 position')
    figure(2)
    plot(t,xdot*2.23694,'linew',2)
    xlabel('t[s]')
    ylabel('velocity[mph]')
     title('Zr1 velocity, 5mph rolling start quarter-mile race')
     legend('Zr1 velocity')
    grid on
    figure(3)
hold on
plot(road_speed(1,:)*2.23694,xddot_gr(1,:)/g,'linew',2);
plot(road_speed(2,:)*2.23694,xddot_gr(2,:)/g,'linew',2);
plot(road_speed(3,:)*2.23694,xddot_gr(3,:)/g,'linew',2);
hold off
ylim([0,2])
grid on
xlabel('road speed [mph]')
ylabel('acceleration [g]')
title('full throttle accelaration vs. road speed for ZR1')
legend('first gear','second gear','third gear')
figure (4)
hold on
    plot(Eng_speed_RPM,T_e_x)
    plot(Eng_speed_RPM,HP)
    legend('Torque','HP')
hold off
[xdot,index] = unique(xdot);
[x,index2] = unique(x);
t_60 = interp1(xdot,t(index),60/2.23694);
t_100 = interp1(xdot,t(index),100/2.23694);
t_quart = interp1(x,t(index2),0.25*1609.34);
format short

fprintf('it takes %f s for the ZR1 to reach 60 mph.\n',t_60)

fprintf('the ZR1 completes the quarter mile in %f s.\n',t_quart)
disp(HP)
disp(Gr_Tran)
disp(T_e_x')
disp(sum(T_e_x))
figure (5)
hold on
yyaxis left
plot(t(:,1:length(xddot)),xddot./9.81)
yyaxis right
plot(t(:,1:length(xddot)),engine_speed)
legend('accelaration','engine speed in Rad/s')
hold off