power_hp = [10,40,80,160,220,240,270,330,400,480,540,620,660,670,675];
speed = [500,1000,1500,2000,2100,2300,2500,3000,3500,4000,4500,5000,5500,6000,6500];
torque = (5252*power_hp)./speed;

hold on
yyaxis left
plot(speed,power_hp,'linew',2)
ylabel('engine power [hp]')
yyaxis right
plot(speed,torque,'linew',2)
ylabel('engine torque[ft*lb]')
xlabel('engine speed RPM')
title('Z1 torque and power vs RPM')
hold off
figure(2)
hold on
yyaxis left
plot(speed,power_hp*0.7457,'linew',2)
ylabel('engine power [kW]')
yyaxis right
plot(speed,torque./0.73756,'linew',2)
ylabel('engine torque[Nm]')
xlabel('engine speed RPM')
title('Z1 torque and power vs RPM')
hold off