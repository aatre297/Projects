mass = [250,500,750,1000,1250,1500,1750,2000]';

Force = (mass/1000)*9.81;

DAQ = zeros(8,1);

DAQ(1,1)=mean(g250);
DAQ(2,1)=mean(g500);
DAQ(3,1)=mean(g750);
DAQ(4,1)=mean(g1000);
DAQ(5,1)=mean(g1250);
DAQ(6,1)=mean(g1500);
DAQ(7,1)=mean(g1750);
DAQ(8,1)=mean(g2000);

tab = [mass , Force , DAQ];

%plot(DAQ,mass)
%xlabel('average voltage value (V)')
%ylabel('mass in grams')
%title('mass vs average voltage value')

%plot(DAQ,Force)
%xlabel('average voltage value (V)')
%ylabel('Force in Newtons')
%title('Force vs average voltage value (V)')

eq = polyfit(DAQ,Force,1);

F5v = 5*eq(1,1)+eq(1,2);

v875g = (((875/1000)*9.81)-eq(1,2))/eq(1,1);

Force_sw = gswinging*eq(1,1) + eq(1,2);

t = 0.001:0.001:5.2;

plot(t,Force_sw)
xlabel('time in seconds')
ylabel('Force in Newtons')
title('Force vs time (s)')