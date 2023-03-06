M = 112;
It = 0.2;
Rt = 0.4;
P = 750;
P2 = 0;
GR = 11/53;

dt = 0.001;
N1 = 8001;
N2 = 5001;
t1 = (0:dt:(N1-1)*dt);
t2 = linspace(8,13,5001);
x(1) = 0;
xdot(1) = 2;

for k = 1:N1-1
    
thetap_dot(k) = (1/Rt)*GR*xdot(k);
xddot(k) = ((GR/Rt)*(P/thetap_dot(k)))/(M+2*It/Rt^2);
xdot(k+1) = xdot(k) + xddot(k)*dt;
x(k+1) = x(k) + xdot(k)*dt;
   Fx(k) = ((GR/Rt)*(P/thetap_dot(k)))-(It*xddot(k));
   Ff(k) = (It*xddot(k))/Rt^2;
end
xc(1) = 57.3373;
xdotc(1) = 10.4308;
for i = 1:N2-1
    
thetap_dotc(i) = (1/Rt)*GR*xdotc(i);
xddotc(i) = ((GR/Rt)*(P2/thetap_dotc(i)))/(M+2*It/Rt^2);
xdotc(i+1) = xdotc(i) + xddotc(i)*dt;
xc(i+1) = xc(i) + xdotc(i)*dt;
   Fxc(i) = ((GR/Rt)*(P2/thetap_dotc(i)))-(It*xddotc(i));
   Ffc(i) = (It*xddotc(i))/Rt^2;
end
figure(1)
hold on
plot(t1,xdot*2.23694,'-dr','Markerindices',1:1000:8000,'linew',2)
plot(t2,xdotc*2.23694,'-dr','Markerindices',1:1000:8000,'linew',2)
grid on
hold off
xlabel('t[s]')
ylabel('velocity[mph]')
title('velocity as a function of time')
figure(2)
hold on
plot(linspace(0,8,8000),thetap_dot*(30/pi),'-db','Markerindices',1:1000:8000,'linew',2)
plot(linspace(8,13,5000),thetap_dotc*(30/pi),'-db','Markerindices',1:1000:5000,'linew',2)
grid on
hold off
ylabel('pedal angular velocity[RPM]')
xlabel('t[s]')
title('pedal angular velocity as a function of time')
figure(3)
hold on
plot(linspace(0,8,8000),Fx,'-pr','Markerindices',1:1000:length(Fx),'Markersize',10,'linew',2)
plot(linspace(0,8,8000),Ff,'-sg','Markerindices',1:1000:length(Ff),'Markersize',10,'linew',2)
plot(linspace(8,13,5000),Fxc,'-pr','Markerindices',1:1000:length(Fxc),'Markersize',10,'linew',2)
plot(linspace(8,13,5000),Ffc,'-sg','Markerindices',1:1000:length(Ffc),'Markersize',10,'linew',2)
xlabel('t[s]')
ylabel('force[N]')
title('tractive force at rear(driven) tire and frictionl force at driven tire')
legend('Fx','Ff')
hold off