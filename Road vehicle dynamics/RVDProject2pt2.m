% RVD Project Deliverable 4

%**************Change Weight Distribution Only*****************************

Wf = [0.35,0.605,0.99]; % Front Weight Distribution 

%==========================================================================
m = 287; % Mass [kg]
Iz = 61; % Yaw Inertia [kg*m^2]
l = 1.6; % Wheelbase [m]
Ff = Wf*m*9.81; % Front Load [N]
Fr = (1-Wf)*m*9.81; % Rear Load [N]

% Calculate Front and Rear Cornering Stiffness
Cf = 2.0*((-0.01.*abs(Ff).^2)+ 53.*abs(Ff) + 1670);
Cr = 1.7*((-0.01.*abs(Fr).^2)+ 53.*abs(Fr) + 1670);

V = 40*0.44704;% Velocity[m/s]
V_amph = linspace(1,50,1201);% Velocity Gradient [mph]
Va = V_amph'*0.44704;% Velocity Gradient [m/s]
R = 9.125; % Turning Radius [m]
%% Deliverable 1

ay = (Va.^2)./R;% Lateral Acceleration gradient [m/s^2]
figure(1)
plot(V_amph,ay/9.81,'linew',2)
title('Lateral Acceleration vs. Velocity for Steady State Cornering')
xlabel('Velocity[mph]'),ylabel('Lateral Acceleration [Gs]')

%% Deliverable 2

% Front and Rear Wheel Base
lr = Wf.*l;
lf = l - lr;
% Lateral Force Derivatives (Y->beta,r,delta)
Ybeta = -(Cr+Cf);
Yr = (Cr.*lr-Cf.*lf)./Va;
Ydelta = Cf;
% Yaw Moment Derivatives (N->beta,r,delta)
Nbeta = (Cr.*lr-Cf.*lf);
Nr = -(Cf.*lf.^2 + Cr.*lr.^2)./Va;
Ndelta = Cf.*lf;

% Understeer Gradient
UG = (m/l).*(Cr.*lr - Cf.*lf)./(Cr.*Cf);

% State Space: Intial Parameters
dt = 0.01;
t = linspace(0,12,1201);
N = length(t); % Number of Data Points

% Initialize Slip Angle,Beta,and r 
a_f = zeros(N,length(Wf));
a_r = zeros(N,length(Wf));
beta_star = zeros(N,length(Wf));
r_star = zeros(N,length(Wf));
delta_star = zeros(N,length(Wf));
for i=1:3
% Calculating Delta
delta_star(:,i) = (l/R)+UG(i).*ay;    

% Calculating r
r_star(:,i) = delta_star(:,i).*(Nbeta(i).*Ydelta(i)-Ndelta(i).*Ybeta(i))./...
(Nr(:,i).*Ybeta(i)-Nbeta(i).*Yr(:,i)+Nbeta(i)*m.*Va);

% Calculating Beta
beta_star(:,i) = delta_star(:,i).*((Ndelta(i).*(Yr(:,i)-m.*Va)-Ydelta(i).*Nr(:,i)))./...
(Nr(:,i).*Ybeta(i)-Nbeta(i).*Yr(:,i)+Nbeta(i)*m.*Va);

% Calculation alpha
a_f(:,i) = beta_star(:,i) + ((r_star(:,i).*lf(i))./Va)-delta_star(:,i);% Slip Angle Alpha Front
a_r(:,i) = beta_star(:,i) - ((r_star(:,i).*lr(i))./Va); % Slip Angle Alpha Rear
end


figure(2)
plot(ay/9.81,delta_star(:,1)*(180/pi),'linew',2)
hold on
plot(ay/9.81,delta_star(:,2)*(180/pi),'linew',2)
plot(ay/9.81,delta_star(:,3)*(180/pi),'linew',2)
hold off
title('Steer Angle vs. Lateral Acceleration ')
xlabel('Lateral Acceleration [Gs]'),ylabel('Steer Angle [deg]')
legend('Wf = 30%','Wf = 50%','Wf = 80%')
grid on

figure(3)
plot(ay/9.81,r_star(:,1)*(180/pi),'linew',2)
hold on
plot(ay/9.81,r_star(:,2)*(180/pi),'linew',2)
plot(ay/9.81,r_star(:,3)*(180/pi),'linew',2)
hold off
xlabel('Lateral Acceleration [Gs]')
ylabel('Yaw Rate, r [deg/s]')
title('Yaw Rate vs. Time ')
legend('Wf = 30%','Wf = 50%','Wf = 80%')
grid on
% 
figure(4)
plot(ay/9.81,beta_star(:,1)*(180/pi),'linew',2)
hold on
plot(ay/9.81,beta_star(:,2)*(180/pi),'linew',2)
plot(ay/9.81,beta_star(:,3)*(180/pi),'linew',2)
hold off
xlabel('Lateral Acceleration [Gs]')
ylabel('beta [deg]')
title('Sideslip Angle vs. Time ')
legend('Wf = 30%','Wf = 50%','Wf = 80%')
hold off
grid on
% % 
figure(5)
plot(ay/9.81,a_f(:,1)*(180/pi),'linew',2)
hold on
plot(ay/9.81,a_f(:,2)*(180/pi),'linew',2)
plot(ay/9.81,a_f(:,3)*(180/pi),'linew',2)
hold off
title('Steady-State Front Sideslip Angle vs. Lateral Acceleration')
xlabel('Lateral Acceleration [Gs]'),ylabel('Alpha[deg]')
legend('a_f,Wf = 30%','a_f,Wf = 50%','a_f,Wf = 80%')
      
grid on 
figure(6)
plot(ay/9.81,a_r(:,1)*(180/pi),'linew',2)
hold on
plot(ay/9.81,a_r(:,2)*(180/pi),'linew',2)
plot(ay/9.81,a_r(:,3)*(180/pi),'linew',2)
hold off
title('Steady-State Rear Sideslip Angle vs. Lateral Acceleration')
xlabel('Lateral Acceleration [Gs]'),ylabel('Alpha[deg]')
legend('a_r,Wf = 30%','a_r,Wf = 50%','a_r,Wf = 80%')
grid on

%% Deliverable 3
alpha_sat = 3*pi/180; % [rad]
tol = .00005;

sat_accel = zeros(2,length(Wf));% Saturation Acceleration
f_sat_accel = zeros(1,length(Wf));% Ruling Saturation Acceleration
CV = zeros(1,length(Wf));% Cornering Velocity
for i=1:3
    
  saf = find(abs(a_f(:,i)) > (alpha_sat-tol) & ...
             abs(a_f(:,i)) < (alpha_sat+tol));% Subindices Alpha Front 
  sar = find(abs(a_r(:,i)) > (alpha_sat-tol) & ...
             abs(a_r(:,i)) < (alpha_sat+tol)); % Subindices Alpha Rear 
  sat_accel(:,i) = [ay(saf);ay(sar)]; % Saturation Acceleration [m/s^2]
  f_sat_accel(:,i) = min(sat_accel(:,i));% Ruling Saturation Acceleration [m/s^2]
  CV(:,i) = sqrt(f_sat_accel(:,i)*R);% Cornering Velocity [m/s]
end
