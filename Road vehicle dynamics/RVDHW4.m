
Gr_Tran = [3,2,1]';
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
Rt = ((19*25.4)+(2*(305*0.3)))/1000;

It = 1.2;
Eng_speed_RPM = [0;1000;2000;3000;4000;5000;6000;7000;8000];
Eng_speed_radps = (Eng_speed_RPM*2*pi)/60;
HP = [10;40;80;160;220;240;270;330;400;480;540;620;660;670;675];
m_eq_f = (2*It)/Rt^2;
dt = 0.01;
t = 0:dt:11;
xdot(1) = 5/2.23694;
x(1) = 0;
T_e = [0;175;300;325;425;425;425;400;350]./0.73756;
for k = 1:3;
    m_eqdt(k,1) = ((Gr_Ax*Gr_Tran(k))^2*(I_e+I_Tran(k))+Gr_Ax^2*I_d+It)/(Rt^2);
    end
N = length(t);

for k = 1:N-1;
    if xdot(1,k) < (45/2.23694);
         GR = 1;
        engine_speed = (xdot(1,k)*Gr_Ax*Gr_Tran(GR,1))/Rt;
        T_E = (interp1(Eng_speed_radps,T_e,engine_speed));
        xddot(k) = (((Gr_Ax*Gr_Tran(GR,1)*T_E)/Rt)-(fr*m*g)-(0.5*rho*Cd*A*xdot(1,k)^2))/(m+m_eq_f+m_eqdt(GR,1));
        xdot(1,k+1) = xdot(1,k) + xddot(k)*dt;
        x(1,k+1) = x(1,k) + xdot(1,k)*dt;
        
    elseif xdot(1,k)>=(45/2.23694) && xdot(1,k)<(70/2.23694);
        GR = 2;
        engine_speed = (xdot(1,k)*Gr_Ax*Gr_Tran(GR,1))/Rt;
        T_E = (interp1(Eng_speed_radps,T_e,engine_speed,'nearest'));
        xddot(k) = (((Gr_Ax*Gr_Tran(GR,1)*T_E)/Rt)-(fr*m*g)-(0.5*rho*Cd*A*xdot(1,k)^2))/(m+m_eq_f+m_eqdt(GR,1));
        xdot(1,k+1) = xdot(1,k) + xddot(k)*dt;
        x(1,k+1) = x(1,k) + xdot(1,k)*dt;
        
    elseif xdot(1,k)>=(70/2.23694) && xdot(1,k)<(100/2.23694)
        GR = 3;
        engine_speed = (xdot(1,k)*Gr_Ax*Gr_Tran(GR,1))/Rt;
        T_E = (interp1(Eng_speed_radps,T_e,engine_speed,'nearest'));
        xddot(k) = (((Gr_Ax*Gr_Tran(GR,1)*T_E)/Rt)-(fr*m*g)-(0.5*rho*Cd*A*xdot(1,k)^2))/(m+m_eq_f+m_eqdt(GR,1));
        xdot(1,k+1) = xdot(1,k) + xddot(k)*dt;
        x(1,k+1) = x(1,k) + xdot(1,k)*dt;
        
  
        
    end
end
figure (1)
    plot(t,x,'linew',2)
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
    

t_60 = interp1(xdot,t,60/2.23694);
t_100 = interp1(xdot,t,100/2.23694);
t_quart = interp1(x,t,0.25*1609.34);
format short

fprintf('it takes %f s for the ZR1 to reach 60 mph.\n',t_60)

fprintf('the ZR1 completes the quarter mile in %f s.\n',t_quart)













