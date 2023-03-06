clear all
m = 1700;
mf = 780;
Iz = 2600;
Izf = 850;
l = 2.7;
lfor = 2.9;
Wf = 0.6;
Wffor = 0.4;
lr = Wf*l;
lrfor = Wffor*lfor;
lf = 1- lr;
lffor = 1- lrfor;
Cf = 85000;
Cffor = 280000;
Cr = 80000;
Crfor = 440000;
Vmph = 60;
V = Vmph*.44704;
Ybeta = -(Cr+Cf) ;
Yr = (Cr*lr-Cf*lf)/V;
Ydelta =Cf;
Nbeta = (Cr*lr-Cf*lf);
Nr = -(Cf*lf^2 + Cr*lr^2)/V;
Ndelta = Cf*lf;

Ybetafor = -(Crfor+Cffor) ;
Yrfor = (Crfor*lrfor-Cffor*lffor)/V;
Ydeltafor =Cffor;
Nbetafor = (Crfor*lrfor-Cffor*lffor);
Nrfor = -(Cffor*lffor^2 + Crfor*lrfor^2)/V;
Ndeltafor = Cffor*lffor;

A = [Ybeta/(m*V), Yr/(m*V)-1;...
    Nbeta/Iz, Nrfor/Iz];
B = [Ydelta/(mf*V); Ndelta/Iz];

Afor = [Ybetafor/(mf*V), Yrfor/(mf*V)-1;...
    Nbetafor/Izf, Nrfor/Izf];
Bfor = [Ydeltafor/(mf*V); Ndeltafor/Izf];

beta0 = 0;
r0 = 0;
states(:,1) = [beta0 ; r0];
statesfor(:,1) = [beta0 ; r0];
dt = 0.01;
eigen = eig(A);
eigenfor = eig(Afor);
eigenboth = [min(real(eigen)),min(real(eigenfor))];
ts = -4/max(eigenboth);

t = (0:dt:2*ts);

delta =(((5*pi)/180) +zeros(length(t),1));


dstates(:,1) = A*statesfor(:,1) + B*delta(1);
dstatesfor(:,1) = Afor*statesfor(:,1) + Bfor*delta(1);
N = length(t);

for k = 1:N-1;
 
    dstates(:,k) = A*states(:,k) + B*delta(k);
    states(:,k+1) = states(:,k) + dstates(:,k)*dt;
dstatesfor(:,k) = Afor*statesfor(:,k) + Bfor*delta(k);
    statesfor(:,k+1) = statesfor(:,k) + dstatesfor(:,k)*dt;
    
end

beta = states(1,:);
r = states(2,:);
betafor = statesfor(1,:);
rfor = statesfor(2,:);

figure (1)
subplot(3,1,1)
plot(t,delta*(180/pi),'linew',2)
ylabel('delta[deg]')
xlabel('t[s]')
grid on
subplot(3,1,2)
hold on
plot(t,beta*(180/pi),'linew',2)
plot(t,betafor*(180/pi),'linew',2)
xlabel('t[s]')
ylabel('beta [deg]')
legend('passenger car','formula car')
hold off
grid on
subplot(3,1,3)
hold on
plot(t,r*(180/pi),'linew',2)
plot(t,rfor*(180/pi),'linew',2)
xlabel('t[s]')
ylabel('r [deg/s]')
legend('passenger car','formula car')
grid on
hold off


psi(1) = 0;
x(1) = 0;
y(1) = 0;
psifor(1) = 0;
xfor(1) = 0;
yfor(1) = 0;
for k = 1:N-1;
    psi(k+1) = psi(k) + r(k)*dt;
    
    Vx(k) = V*cos(psi(k)+beta(k));
    Vy(k) = V*sin(psi(k)+beta(k));
    x(k+1) = x(k) + Vx(k)*dt;
    y(k+1) = y(k) +Vy(k)*dt;
    
    psifor(k+1) = psifor(k) + rfor(k)*dt;
    
    Vxfor(k) = V*cos(psifor(k)+betafor(k));
    Vyfor(k) = V*sin(psifor(k)+betafor(k));
    xfor(k+1) = xfor(k) + Vxfor(k)*dt;
    yfor(k+1) = yfor(k) +Vyfor(k)*dt;
end


   figure(2)
   hold on
plot(y,x,'linew',2)
plot(yfor,xfor,'linew',2)
hold off
xlabel('y [m]')
ylabel('x [m]')
legend('passenger car','formula car')
grid on
axis equal

r_steadystate_passenger = r(1,132)*(180/pi)
beta_steadystate_passenger = beta(1,132)*(180/pi)
R_passenger = V/r_steadystate_passenger

a_passenger = V*(((Nbeta*Ydelta)-(Ndelta*Ybeta))/(Nr*Ybeta-Nbeta*Yr+Nbeta*m*V))*delta(132,1)

r_steadystate_formula = rfor(1,132)*(180/pi)
beta_steadystate_formula = betafor(1,132)*(180/pi)
R_formula = V/r_steadystate_formula

a_formula = V*(((Nbetafor*Ydeltafor)-(Ndeltafor*Ybetafor))/(Nrfor*Ybetafor-Nbetafor*Yrfor+Nbetafor*mf*V))*delta(132,1)
    
    
    
    
    
    
