%% plotting FSAE skid pad track
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


figure
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