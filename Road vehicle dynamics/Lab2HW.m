m = [0.053662,0.036092,0.062474];
D = [0.00635,0.003,0.002];
V = [4.32455E-5,3.32357E-5,6.36225E-5];
t = [68.572,14.038,16.258];
dV = 5E-6;
dt = 0.2;
dm = 5E-6;

for i = 1:3
    
   delta_Visc(1,i) = sqrt(((((-D(1,i))^4*9.81*t(1,i)*m(1,i))/(64*(V(1,i))^3))^2*dV^2) +...
       (((((D(1,i))^4)*9.81*m(1,i))/(128*(V(1,i))^2))^2*dt^2) + ...
       (((((D(1,i))^4)*9.81*t(1,i))/(128*(V(1,i))^2))^2*dm^2));
end
disp(delta_Visc)