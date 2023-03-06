m = 287;
Iz = 61;
l = 1.6;
Wf = [0.3,0.5,0.8];
Ff = Wf*m;
Fr = (1-Wf)*m;
for j = 1:3;
Cf(j) = 2*((-0.01*abs(Ff(j)))^2 + 53*abs(Ff(j)) + 1670);
Cr(j) = 1.7*((-0.01*abs(Fr(j)))^2 + 53*abs(Fr(j)) + 1670);
end
V = 40;
V_amph = linspace(1,40,1200);
Va = V_amph*0.44704;
R = 16.75;
ay = (Va.^2)./R;

for j = 1:3;
lr(j) = Wf(j)*l;
lf(j) = 1- lr(j);
Ybeta(j) = -(Cr(j)+Cf(j)) ;
Yr(j) = (Cr(j)*lr(j)-Cf(j)*lf(j))/V;
Ydelta(j) =Cf(j);
Nbeta(j) = (Cr(j)*lr(j)-Cf(j)*lf(j));
Nr(j) = -(Cf(j)*lf(j)^2 + Cr(j)*lr(j)^2)/V;
Ndelta(j) = Cf(j)*lf(j);
end
for i=1:3
A = [Ybeta(i)/(m*V), Yr(i)/(m*V)-1;...
    Nbeta(i)/Iz, Nr(i)/Iz];
B = [Ydelta(i)/(m*V); Ndelta(i)/Iz];

beta0 = 0;
r0 = 0;
states(:,1) = [beta0 ; r0];
dt = 0.01;
%eigen = eig(A);
%ts = -4/min(real(eigen));

t = (0:dt:12);

delta =(((5*pi)/180) +zeros(length(t),1));
dstates(:,1) = A*states(:,1) + B*delta(1);
N = length(t);

for k = 1:N-1;
 
    dstates(:,k) = A*states(:,k) + B*delta(k);
    states(:,k+1) = states(:,k) + dstates(:,k)*dt;

end
beta = states(1,:);
r = states(2,:);
for a = 1:N-1;
a_f(a,i) = beta(a) + (r(a)*lf(i))/(Va(a))-delta(a);
a_r(a,i) = beta(a) - (r(a)*lr(i))/(Va(a));
end
psi(1) = 0;
x(1) = 0;
y(1) = 0;
r_plot(:,i) = r;
beta_plot(:,i) = beta;

for k = 1:N-1;
    psi(k+1) = psi(k) + r(k)*dt;
    
    Vx(k) = V*cos(psi(k)+beta(k));
    Vy(k) = V*sin(psi(k)+beta(k));
    x(k+1) = x(k) + Vx(k)*dt;
    y(k+1) = y(k) +Vy(k)*dt;
    
    
    
    
    
    
    
end
x_plot(:,i) = x;
y_plot(:,i) = y;
end

figure (1)
subplot(3,1,1)
plot(t,delta*(180/pi),'linew',2)
ylabel('delta[deg]')
xlabel('t[s]')
grid on

subplot(3,1,2)
hold on
plot(t,beta_plot(:,1)*(180/pi),'linew',2)
plot(t,beta_plot(:,2)*(180/pi),'linew',2)
plot(t,beta_plot(:,3)*(180/pi),'linew',2)
xlabel('t[s]')
ylabel('beta [deg]')
legend('Wf = 30%','Wf = 50%','Wf = 80%')
hold off
grid on

subplot(3,1,3)
hold on
plot(t,r_plot(:,1)*(180/pi),'linew',2)
plot(t,r_plot(:,2)*(180/pi),'linew',2)
plot(t,r_plot(:,3)*(180/pi),'linew',2)
xlabel('t[s]')
ylabel('r [deg/s]')
legend('Wf = 30%','Wf = 50%','Wf = 80%')
grid on
hold off


figure(2)
   hold on
plot(y_plot(:,1),x_plot(:,1),'linew',2)
plot(y_plot(:,2),x_plot(:,2),'linew',2)
plot(y_plot(:,3),x_plot(:,3),'linew',2)
hold off
xlabel('y [m]')
ylabel('x [m]')
legend('Wf = 30%','Wf = 50%','Wf = 80%')
grid on
axis equal


figure(4)
plot(Va,ay./9.81)

figure (5)
hold on
plot((ay./9.81),a_f(:,1)./9.81);
plot((ay./9.81),a_f(:,2)./9.81)
plot((ay./9.81),a_f(:,3)./9.81)
hold off

figure(6)
hold on
plot((ay./9.81),a_r(:,1)./9.81);
plot((ay./9.81),a_r(:,2)./9.81)
plot((ay./9.81),a_r(:,3)./9.81)
hold off
























