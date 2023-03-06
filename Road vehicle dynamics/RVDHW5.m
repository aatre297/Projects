data = load('tiredata.mat');
ET = data.ET;
V = data.V;
VMPH = V*.621371;
SA = data.SA;
IA = data.IA;
RL = data.RL;
P = data.P;
PPSI = P*0.145038;
FY = data.FY;
FZ = data.FZ;
MX = data.MX;
MZ = data.MZ;



noramlindeces1 = find(FZ>-260&FZ<-160&IA>-0.1&IA<0.1& VMPH>42&VMPH<49 & PPSI>11.5&PPSI<12.5);
noramlindeces2 = find(FZ>-480&FZ<-380&IA>-0.1&IA<0.1& VMPH>42&VMPH<49 & PPSI>11.5&PPSI<12.5);
noramlindeces3 = find(FZ>-740&FZ<-600&IA>-0.1&IA<0.1& VMPH>42&VMPH<49 & PPSI>11.5&PPSI<12.5);
noramlindeces4 = find(FZ>-1160&FZ<-1030&IA>-0.1&IA<0.1& VMPH>42&VMPH<49 & PPSI>11.5&PPSI<12.5);
noramlindeces5 = find(FZ>-1620&FZ<-1460&IA>-0.1&IA<0.1& VMPH>42&VMPH<49 & PPSI>11.5&PPSI<12.5);

SA1 = SA(noramlindeces1);
SA2 = SA(noramlindeces2);
SA3 = SA(noramlindeces3);
SA4 = SA(noramlindeces4);
SA5 = SA(noramlindeces5);
FY1 = FY(noramlindeces1);
FY2 = FY(noramlindeces2);
FY3 = FY(noramlindeces3);
FY4 = FY(noramlindeces4);
FY5 = FY(noramlindeces5);



linearindeces1 = find(SA1>-2&SA1<2);
poly1 = polyfit(SA1(linearindeces1),FY1(linearindeces1),1);
slope1 = poly1(1);
linfit1 = slope1*SA1+poly1(2);

linearindeces2 = find(SA2>-2&SA2<2);
poly2 = polyfit(SA2(linearindeces2),FY2(linearindeces2),1);
slope2 = poly2(1);
linfit2 = slope2*SA2+poly2(2);

linearindeces3 = find(SA3>-2&SA3<2);
poly3 = polyfit(SA3(linearindeces3),FY3(linearindeces3),1);
slope3 = poly3(1);
linfit3 = slope3*SA3+poly3(2);

linearindeces4 = find(SA4>-2&SA4<2);
poly4 = polyfit(SA4(linearindeces4),FY4(linearindeces4),1);
slope4 = poly4(1);
linfit4 = slope4*SA4+poly4(2);

linearindeces5 = find(SA5>-0.5&SA5<0.5);
poly5 = polyfit(SA5(linearindeces5),FY5(linearindeces5),1);
slope5 = poly5(1);
linfit5 = slope5*SA5+poly5(2);
figure (1)
hold on
plot(SA1,FY1,'r.','MarkerSize',10)
plot(SA2,FY2,'k.','MarkerSize',10)
plot(SA3,FY3,'g.','MarkerSize',10)
plot(SA4,FY4,'b.','MarkerSize',10)
plot(SA5,FY5,'m.','MarkerSize',10)
plot(SA1,linfit1,'r-')
plot(SA2,linfit2,'k-')
plot(SA3,linfit3,'g-')
plot(SA4,linfit4,'b-')
plot(SA5,linfit5,'m-')
hold off
grid on
xlabel('Lateral Force F_y [lb_f]')
ylabel('Slip angle a [deg]')
title('lateral force F_y vs slip angle a')
ylim([-3500,4000])
xlim([-10,10])
legend('F_z = -208.49','F_z = -433.95','F_z = -656.89','F_z = -1095.6','F_z = -1545.0')
Fz1 = mean(FZ(noramlindeces1));
Fz2 = mean(FZ(noramlindeces2));
Fz3 = mean(FZ(noramlindeces3));
Fz4 = mean(FZ(noramlindeces4));
Fz5 = mean(FZ(noramlindeces5));

C_alpha1 = -slope1;
C_alpha2 = -slope2;
C_alpha3 = -slope3;
C_alpha4 = -slope4;
C_alpha5 = -slope5;
figure (2)
hold on
plot(Fz1,C_alpha1,'r.','MarkerSize',20);
plot(Fz2,C_alpha2,'k.','MarkerSize',20)
plot(Fz3,C_alpha3,'g.','MarkerSize',20)
plot(Fz4,C_alpha4,'b.','MarkerSize',20)
plot(Fz5,C_alpha5,'m.','MarkerSize',20)
hold off
grid on
xlabel('normal load F_z [lb_f]')
ylabel('Cornering stiffness C_a [lb_f/deg]')
title('Cornering stiffness C_a vs normal load F_z')
legend('F_z = -208.49','F_z = -433.95','F_z = -656.89','F_z = -1095.6','F_z = -1545.0')
mu1 = abs(min(FY1)/mean(FZ(noramlindeces1)));
mu2 = abs(min(FY2)/mean(FZ(noramlindeces2)));
mu3 = abs(min(FY3)/mean(FZ(noramlindeces3)));
mu4 = abs(min(FY4)/mean(FZ(noramlindeces4)));
mu5 = abs(min(FY5)/mean(FZ(noramlindeces5)));
figure(3)
hold on
plot(Fz1,mu1,'r.','MarkerSize',20)
plot(Fz2,mu2,'k.','MarkerSize',20)
plot(Fz3,mu3,'g.','MarkerSize',20)
plot(Fz4,mu4,'b.','MarkerSize',20)
plot(Fz5,mu5,'m.','MarkerSize',20)
hold off
grid on
xlabel('normal load F_z [lb_f]')
ylabel('Friction coefficient')
title('Friction coefficient vs normal load F_z')
legend('F_z = -208.49','F_z = -433.95','F_z = -656.89','F_z = -1095.6','F_z = -1545.0')
Mz1 = MZ(noramlindeces1);
Mz2 = MZ(noramlindeces2);
Mz3 = MZ(noramlindeces3);
Mz4 = MZ(noramlindeces4);
Mz5 = MZ(noramlindeces5);

figure (4)
hold on
plot(SA1,Mz1,'r.','MarkerSize',10)
plot(SA2,Mz2,'k.','MarkerSize',10)
plot(SA3,Mz3,'g.','MarkerSize',10)
plot(SA4,Mz4,'b.','MarkerSize',10)
plot(SA5,Mz5,'m.','MarkerSize',10)
hold off
grid on
xlabel('slip angle a [deg]')
ylabel('Alligning moment M_z [lb_f*ft]')
title('aligning moment F_z vs slip angle a')
legend('F_z = -208.49','F_z = -433.95','F_z = -656.89','F_z = -1095.6','F_z = -1545.0')




