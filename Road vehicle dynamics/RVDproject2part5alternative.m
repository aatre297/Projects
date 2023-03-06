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
T = 5;
omega = 2*pi/T;


%creating a time vector and a delta vector
dt  = 0.01;
t = (0:dt:16.63);
N = length(t);
R = 9.125;
UG = (m/l).*(Cr.*lr - Cf.*lf)./(Cr.*Cf);
ay = (V.^2)./R;
delta = zeros(1,N);
delta(1,85:715) = ((l/R)+UG.*-ay);
delta(1,716:1100) = -((l/R)+UG.*-ay);
delta(1,1100:1111) = sin(omega*t(1,1100:1111));
delta(1,1311:1471) = ((l/R)+UG.*-ay);
%initializing r and beta
alpha_sat = 3;
r(1) = 0;
beta(1) = 0;
% using forward euler to integrate rdot and betadot 
for k = 1:N-1
    % calculating the front and rear slip angles;
 alpha_f(k) = beta(k) + (r(k)*lf)/V - delta(k);
 alpha_r(k) = beta(k) - (r(k)*lr)/V;
 % using the if loop and the bi linear model to decide front and rear
 % lateral loads
 if alpha_r(k) < -alpha_sat;
    Fr(k) = Cr*alpha_sat;
 elseif alpha_r(k) >= -alpha_sat & alpha_r(k) <= alpha_sat;
     Fr(k) = -Cr*alpha_r(k);
 else 
     Fr(k) = -Cr*alpha_sat;
 end
 if alpha_f(k) < -alpha_sat;
    Ff(k) = Cf*alpha_sat;
 elseif alpha_f(k) >= -alpha_sat & alpha_f(k) <= alpha_sat;
     Ff(k) = -Cf*alpha_f(k);
 else 
     Ff(k) = -Cf*alpha_sat;
 end
 
 rdot(k) = (lf*Ff(k))/Iz - (lr*Fr(k))/Iz;
 r(k+1) = r(k) + rdot(k)*dt;
 
 betadot(k) = Fr(k)/(m*V) + Ff(k)/(m*V) + r(k);
 beta(k+1) = beta(k) + betadot(k)*dt;
 
 
end

% using forward euler to find the pisition of the car on the track from the
% velocity and the nose angle psi
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


figure (1)

hold on
plot(y,x,'linew',2)
plot(y_inner_left1,x_inner1,'k-',y_inner_right1,x_inner1,'k-'); 
grid on; hold on
plot(y_inner_left,x_inner,'r.',y_inner_right,x_inner,'r.','markersize',16); 
plot(y_outer_left2,x_outer2,'k-',y_outer_right2,x_outer2,'k-');
plot(y_outer_left,x_outer,'r.',y_outer_right,x_outer,'r.','markersize',16);
plot([y_left,y_left,y_right,y_right],[x_entry,x_entry],'r.','markersize',16);
plot([y_left,y_left,y_right,y_right],[x_exit,x_exit],'r.','markersize',16);
xlabel('length'),ylabel('girth')
title('dick')
axis equal
hold off
xlabel('girth')
ylabel('length')
%legend('passenger car')
grid on
figure (2)
plot(t,delta,'linew',2)
xlabel('time [s]')
ylabel('delta [degs]')
title('steering input for the required course')
grid on
time = length(t)/100;
fprintf('our car takes %2.2f seconds to complete the given course\n',time)