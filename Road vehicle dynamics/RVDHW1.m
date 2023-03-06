m=800;     %mass of the car
l=600;     %length of the straight
vi=17.881; %entry velocity in m/s
vf=40;     %exit velocity in mph
a1=14.715; %constant accelaration
a2=-39.24; %constant deccelaration

x1=linspace(0,436.363,100);     %creating a delta x vector fo the accelaration part
x2=linspace(0,163.636,100);     %creating a delta x vector for the deccelaration part
v1=(sqrt(vi^2+(2*a1*x1)));      %using the kinematic equation for the accelaration portion
v2=(sqrt((v1(1,100))^2+(2*a2*x2)));  %using the same kinematic equation for the decelaration portion with intial
                                      %velocity as the end velocity of the accelaration
hold on
plot(x1,v1*2.237,'g','linewidth',2) %plotting the accelaration portion
plot(linspace(436.363,l,100),v2*2.237,'r','linewidth',2) %plotting the deccelaration portion 
                                                 %and changing the x values to from delta values to absolute values
xlabel('position[m]')
ylabel('velocity[mph]')
legend('accelarating','braking')
title('velocity as a function of distance along a straight')
grid on
hold off