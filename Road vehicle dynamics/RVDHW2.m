M = 112;
It = 0.2;
Rt = 0.4;
P = 750;
P2 = 0;
GR = 11/53;

thetap_dot_RPM = linspace(0,250,501)';
thetap_dot  = thetap_dot_RPM*2*pi/60;
xddot = ((GR/Rt)*(P*thetap_dot))/(M+2*Tt/Rt^2);

%%
dt = 0.0001;
N1 = 80001;
N2 = 5001;
N = 13001
t1 = (0:dt:(N1-1)*dt);
t2 = linspace(8,13,5001);
x(1) = 0;
xdot(1) = 2;

for k = 1:N1-1
    
thetap_dot(k) = (1/Rt)*GR*xdot(k);
xddot(k) = ((GR/Rt)*(P/thetap_dot(k)))/(M+2*It/Rt^2);
xdot(k+1) = xdot(k) + xddot(k)*dt;
x(k+1) = x(k) + xdot(k)*dt;
   
end
xc(1) = x(k)
xdotc(1) = xdot(k)
for i = 1:N2-1
    
thetap_dotc(i) = (1/Rt)*GR*xdotc(i);
xddotc(i) = ((GR/Rt)*(P2/thetap_dotc(i)))/(M+2*It/Rt^2);
xdotc(i+1) = xdotc(i) + xddotc(i)*dt;
xc(i+1) = xc(i) + xdotc(i)*dt;
   
end
figure(1)
hold on
plot(t1,xdot*2.23694,'r')
plot(t2,xdotc*2.23694,'r')
hold off
figure(2)
hold on
plot(linspace(0,8,80000),thetap_dot*(30/pi),'r')
plot(linspace(8,13,5000),thetap_dotc*(30/pi),'r')
hold off