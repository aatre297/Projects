% RVD Project 
clear all
m = 287; % Mass [kg]
Iz = 61; % Yaw Inertia [kg*m^2]
l = 1.6; % Wheelbase [m]
Wf = 0.605; % Front Weight Distribution
Ff = Wf*m*9.81; % Front Load [N]
Fr = (1-Wf)*m*9.81; % Rear Load [N]

% Calculate Front and Rear Cornering Stiffness
Cf = 2.0*((-0.01.*abs(Ff).^2)+ 53.*abs(Ff) + 1670);
Cr = 1.7*((-0.01.*abs(Fr).^2)+ 53.*abs(Fr) + 1670);

V = 18.2083;
lr = Wf.*l;
lf = l - lr;


Ybeta = -(Cr+Cf) ;
Yr = (Cr*lr-Cf*lf)/V;
Ydelta =Cf;
Nbeta = (Cr*lr-Cf*lf);
Nr = -(Cf*lf^2 + Cr*lr^2)/V;
Ndelta = Cf*lf;
r0 = 0;
beta0 = 0;



states(:,1) = [beta0 ; r0];
dt  = 0.01;
t = (0:dt:14.27);
N = length(t)
R = 9.125;
UG = (m/l).*(Cr.*lr - Cf.*lf)./(Cr.*Cf);
ay = (V.^2)./R;

%T= 3
%omega = 2*pi/T;
%delta = sin(omega*t);
delta = zeros(1,N);
delta(1,85:715) = ((l/R)+UG.*-ay);
delta(1,716:1345.5) = -((l/R)+UG.*-ay);
%delta = -(zeros(1,N) + ((l/R)+UG.*-ay));


alpha_sat = 3
A = [Ybeta/(m*V), Yr/(m*V)-1;...
    Nbeta/Iz, Nr/Iz];
B = [Ydelta/(m*V); Ndelta/Iz];

dstates(:,1) = A*states(:,1) + B*delta(1);
for k = 1:N-1
   
      dstates(:,k) = A*states(:,k) + B*delta(k);
    states(:,k+1) = states(:,k) + dstates(:,k)*dt;  
 beta(k) = states(1,k);
 r(k) = states(2,k);
 alpha_r(k) = beta(k) + (r(k)*lf)/V - delta(k);
 alpha_f(k) = beta(k) - (r(k)*lr)/V;
 
 
end
figure(1)
hold on
plot(t(1,1:length(alpha_r)),alpha_r*(180/pi))
plot(t(1,1:length(alpha_f)),alpha_f*(180/pi))
legend('rear','front')
hold off
psi(1) = 0;
x(1) = 0;
y(1) = 0; 
for k = 1:N-1;
    psi(k+1) = psi(k) + r(k)*dt;
    
    Vx(k) = V*cos(psi(k)+beta(k));
    Vy(k) = V*sin(psi(k)+beta(k));
    x(k+1) = x(k) + Vx(k)*dt;
    y(k+1) = y(k) +Vy(k)*dt;
        
end
        
% plotting FSAE skid pad track
theta = linspace(0,2*pi,15)';
theta1 = linspace(0,2*pi,101)';
theta2 = linspace(-5*pi/6,5*pi/6,101)';

%inner radii
R_inner = 15.25/2;
x_inner = 2*R_inner + R_inner*sin(theta);
y_inner_right = R_inner*cos(theta)+15.25/2+1.5;
y_inner_left = R_inner*cos(theta)-15.25/2-1.5;

x_inner1 = 2*R_inner + R_inner*sin(theta1);
y_inner_right1 = R_inner*cos(theta1)+15.25/2+1.5;
y_inner_left1 = R_inner*cos(theta1)-15.25/2-1.5;

%outer radii
R_outer = (15.25+6)/2;
x_outer = 2*R_inner + R_outer*sin(theta);
y_outer_right = R_outer*cos(theta)+15.25/2+1.5;
y_outer_left = R_outer*cos(theta+pi)-15.25/2-1.5;
x_outer(7:9) = [];
y_outer_right(7:9) = [];
y_outer_left(7:9) = [];

x_outer2 = 2*R_inner + R_outer*sin(theta2);
y_outer_right2 = R_outer*cos(theta2)+15.25/2+1.5;
y_outer_left2 = R_outer*cos(theta2+pi)-15.25/2-1.5;

%entry and exit straights
y_right = 1.5;
y_left = -1.5;
x_entry = [0 5];
x_exit = [4*R_inner 4*R_inner-5];


figure (2)

hold on
plot(y,x,'linew',2)
plot(y_inner_left1,x_inner1,'k-',y_inner_right1,x_inner1,'k-'); 
grid on; hold on
plot(y_inner_left,x_inner,'r.',y_inner_right,x_inner,'r.','markersize',16); 
plot(y_outer_left2,x_outer2,'k-',y_outer_right2,x_outer2,'k-');
plot(y_outer_left,x_outer,'r.',y_outer_right,x_outer,'r.','markersize',16);
plot([y_left,y_left,y_right,y_right],[x_entry,x_entry],'r.','markersize',16);
plot([y_left,y_left,y_right,y_right],[x_exit,x_exit],'r.','markersize',16);
xlabel('y [meters]'),ylabel('y [meters]')
title('FSAE skid pad')
axis equal
hold off
xlabel('y [m]')
ylabel('x [m]')
%legend('passenger car')
grid on
figure(3)
plot(t,delta) 
        
        
        
        
        
        
        
        
        



