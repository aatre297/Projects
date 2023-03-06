
angles = [-23.96,-18.43,-17.10,-14.03,0,180,15.9,21.8,26.56,33.69,90]';
angle_23 = readmatrix('-23.96.txt');
angle_18 = readmatrix('-18.43.txt');
angle_17 = readmatrix('-17.10.txt');
angle_14 = readmatrix('-14.03.txt');
angle0 = readmatrix('0angle.txt');
angle15 = readmatrix('+15.9.txt');
angle21 = readmatrix('+21.8.txt');
angle26 = readmatrix('+26.56.txt');
angle33 = readmatrix('+33.69.txt');
angle90 = readmatrix('90angle.txt');
angle180 = readmatrix('180angle.txt');
moving = readmatrix('moving.txt');

g_x = -9.81*sind(angles);

ADC = zeros(11,1);

ADC(1,1)=mean(angle_23);
ADC(2,1)=mean(angle_18);
ADC(3,1)=mean(angle_17);
ADC(4,1)=mean(angle_14);
ADC(5,1)=mean(angle0);
ADC(6,1)=mean(angle180);
ADC(7,1)=mean(angle15);
ADC(8,1)=mean(angle21);
ADC(9,1)=mean(angle26);
ADC(10,1)=mean(angle33);
ADC(11,1)=mean(angle90);

figure(1)
plot(ADC,angles)
xlabel('average ADC value')
ylabel('angle in degrees')
title('angles vs average ADC value')
figure(2)
plot(ADC,g_x)
xlabel('average ADC value')
ylabel('x component of the accelaration due to gravity in m/s^2')
title('x component of the accelaration due to gravity vs average ADC value')

eq = polyfit(ADC,g_x,1)

acc = eq(1,1)*moving+eq(1,2);
x = 1:1:54;

figure(3)
plot(x,acc)
xlabel('sample #')
ylabel('accelaration')
title('accelaration vs sample #')

max_gs = (eq(1,1)*675+eq(1,2))/9.81
min_gs = (eq(1,1)*0+eq(1,2))/9.81










