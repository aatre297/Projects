load('/Users/adityaatre/Desktop/lab 3/MotData_L07.mat');
load('/Users/adityaatre/Desktop/lab 3/PenData_L07.mat');
mot_1=Mot7(150000:200001,1);
pen_1=Pen7(150000:200001,1);
mot_2=Mot7(150000:200001,2);
pen_2=Pen7(150000:200001,2);
mot_3=Mot7(150000:200001,3);
pen_3=Pen7(150000:200001,3);
mot_4=Mot7(150000:200001,4);
pen_4=Pen7(150000:200001,4);
mot_5=Mot7(150000:200001,5);
pen_5=Pen7(150000:200001,5);
mot_6=Mot7(150000:200001,6);
pen_6=Pen7(150000:200001,6);
mot_7=Mot7(150000:200001,7);
pen_7=Pen7(150000:200001,7);
mot_8=Mot7(150000:200001,8);
pen_8=Pen7(150000:200001,8);
mot_9=Mot7(150000:200001,9);
pen_9=Pen7(150000:200001,9);
mot_10=Mot7(150000:200001,10);
pen_10=Pen7(150000:200001,10);
mot_11=Mot7(150000:200001,11);
pen_11=Pen7(150000:200001,11);
mot_12=Mot7(150000:200001,12);
pen_12=Pen7(150000:200001,12);
mot_13=Mot7(150000:200001,13);
pen_13=Pen7(150000:200001,13);
mot_14=Mot7(150000:200001,14);
pen_14=Pen7(150000:200001,14);

t= 15:0.0001:20.0001;

c1 = polyfit(t',mot_1,1);
c2 = polyfit(t',mot_2,1);
c3 = polyfit(t',mot_3,1);
c4 = polyfit(t',mot_4,1);
c5 = polyfit(t',mot_5,1);
c6 = polyfit(t',mot_6,1);
c7 = polyfit(t',mot_7,1);
c8 = polyfit(t',mot_8,1);
c9 = polyfit(t',mot_9,1);
c10 = polyfit(t',mot_10,1);
c11 = polyfit(t',mot_11,1);
c12 = polyfit(t',mot_12,1);
c13 = polyfit(t',mot_13,1);
c14 = polyfit(t',mot_14,1);
linfitmot1=t*c1(1,1)+c1(1,2);
linfitmot2=t*c2(1,1)+c2(1,2);
linfitmot3=t*c3(1,1)+c3(1,2);
linfitmot4=t*c4(1,1)+c4(1,2);
linfitmot5=t*c5(1,1)+c5(1,2);
linfitmot6=t*c6(1,1)+c6(1,2);
linfitmot7=t*c7(1,1)+c7(1,2);
linfitmot8=t*c8(1,1)+c8(1,2);
linfitmot9=t*c9(1,1)+c9(1,2);
linfitmot10=t*c10(1,1)+c10(1,2);
linfitmot11=t*c11(1,1)+c11(1,2);
linfitmot12=t*c12(1,1)+c12(1,2);
linfitmot13=t*c13(1,1)+c13(1,2);
linfitmot14=t*c14(1,1)+c14(1,2);
mot_d_1=mot_1-linfitmot1';
mot_d_2=mot_2-linfitmot2';
mot_d_3=mot_3-linfitmot3';
mot_d_4=mot_4-linfitmot4';
mot_d_5=mot_5-linfitmot5';
mot_d_6=mot_6-linfitmot6';
mot_d_7=mot_7-linfitmot7';
mot_d_8=mot_8-linfitmot8';
mot_d_9=mot_9-linfitmot9';
mot_d_10=mot_10-linfitmot10';
mot_d_11=mot_11-linfitmot11';
mot_d_12=mot_12-linfitmot12';
mot_d_13=mot_13-linfitmot13';
mot_d_14=mot_14-linfitmot14';

d1 = polyfit(t',pen_1,1);
d2 = polyfit(t',pen_2,1);
d3 = polyfit(t',pen_3,1);
d4 = polyfit(t',pen_4,1);
d5 = polyfit(t',pen_5,1);
d6 = polyfit(t',pen_6,1);
d7 = polyfit(t',pen_7,1);
d8 = polyfit(t',pen_8,1);
d9 = polyfit(t',pen_9,1);
d10 = polyfit(t',pen_10,1);
d11= polyfit(t',pen_11,1);
d12= polyfit(t',pen_12,1);
d13= polyfit(t',pen_13,1);
d14= polyfit(t',pen_14,1);


linfitpen1=t*d1(1,1)+d1(1,2);
linfitpen2=t*d2(1,1)+d2(1,2);
linfitpen3=t*d3(1,1)+d3(1,2);
linfitpen4=t*d4(1,1)+d4(1,2);
linfitpen5=t*d5(1,1)+d5(1,2);
linfitpen6=t*d6(1,1)+d6(1,2);
linfitpen7=t*d7(1,1)+d7(1,2);
linfitpen8=t*d8(1,1)+d8(1,2);
linfitpen9=t*d9(1,1)+d9(1,2);
linfitpen10=t*d10(1,1)+d10(1,2);
linfitpen11=t*d11(1,1)+d11(1,2);
linfitpen12=t*d12(1,1)+d12(1,2);
linfitpen13=t*d13(1,1)+d13(1,2);
linfitpen14=t*d14(1,1)+d14(1,2);

pen_d_1=pen_1-linfitpen1';
pen_d_2=pen_2-linfitpen2';
pen_d_3=pen_3-linfitpen3';
pen_d_4=pen_4-linfitpen4';
pen_d_5=pen_5-linfitpen5';
pen_d_6=pen_6-linfitpen6';
pen_d_7=pen_7-linfitpen7';
pen_d_8=pen_8-linfitpen8';
pen_d_9=pen_9-linfitpen9';
pen_d_10=pen_10-linfitpen10';
pen_d_11=pen_11-linfitpen11';
pen_d_12=pen_12-linfitpen12';
pen_d_13=pen_13-linfitpen13';
pen_d_14=pen_14-linfitpen14';

figure(1)
hold on
plot(t,mot_2)
plot(t,mot_d_2)
plot(t,linfitmot2)

xlabel('time in seconds')
ylabel('motorangle [deg]')
title('final oscilations of motor 0.9Hz');
legend('original signal','debiased signal','linear fit')
grid on
hold off



figure(2)
hold on
plot(t,pen_2)
plot(t,pen_d_2)
plot(t,linfitpen2)

xlabel('time in seconds')
ylabel('pendulum angle [deg]')
title('final oscilations of pendulum 0.9Hz');
legend('original signal','debiased signal','linear fit')
grid on
hold off

mot_pks_1 = findpeaks(mot_d_1);
pen_pks_1 = findpeaks(pen_d_1);
mot_pks_2 = findpeaks(mot_d_2);
pen_pks_2 = findpeaks(pen_d_2);
mot_pks_3 = findpeaks(mot_d_3);
pen_pks_3 = findpeaks(pen_d_3);
mot_pks_4 = findpeaks(mot_d_4);
pen_pks_4 = findpeaks(pen_d_4);
mot_pks_5 = findpeaks(mot_d_5);
pen_pks_5 = findpeaks(pen_d_5);
mot_pks_6 = findpeaks(mot_d_6);
pen_pks_6 = findpeaks(pen_d_6);
mot_pks_7 = findpeaks(mot_d_7);
pen_pks_7 = findpeaks(pen_7);
mot_pks_8 = findpeaks(mot_d_8);
pen_pks_8 = findpeaks(pen_d_8);
mot_pks_9 = findpeaks(mot_d_9);
pen_pks_9 = findpeaks(pen_d_9);
mot_pks_10 = findpeaks(mot_d_10);
pen_pks_10 = findpeaks(pen_d_10);
mot_pks_11 = findpeaks(mot_d_11);
pen_pks_11= findpeaks(pen_d_11);
mot_pks_12 = findpeaks(mot_d_12);
pen_pks_12 = findpeaks(pen_d_12);
mot_pks_13 = findpeaks(mot_d_13);
pen_pks_13 = findpeaks(pen_d_13);
mot_pks_14 = findpeaks(mot_d_14);
pen_pks_14 = findpeaks(pen_d_14);




idx1 = mot_pks_1 >3;
idx2 = mot_pks_2 >3;
idx3 = mot_pks_3 >3;
idx4 = mot_pks_4 >3;
idx5 = mot_pks_5 >3;
idx6 = mot_pks_6 >1;
idx7 = mot_pks_7 >1;
idx8 = mot_pks_8 >3;
idx9 = mot_pks_9 >3;
idx10 = mot_pks_10 >5;
idx11 = mot_pks_11 >3;
idx12 = mot_pks_12 >3;
idx13 = mot_pks_13 >3;
idx14 = mot_pks_14 >2;
mot_avg=zeros(1,14);
mot_avg(1,1)=mean(mot_pks_1(idx1));
mot_avg(1,2)=mean(mot_pks_2(idx2));
mot_avg(1,3)=mean(mot_pks_3(idx3));
mot_avg(1,4)=mean(mot_pks_4(idx4));
mot_avg(1,5)=mean(mot_pks_5(idx5));
mot_avg(1,6)=mean(mot_pks_6(idx6));
mot_avg(1,7)=mean(mot_pks_7(idx7));
mot_avg(1,8)=mean(mot_pks_8(idx8));
mot_avg(1,9)=mean(mot_pks_9(idx9));
mot_avg(1,10)=mean(mot_pks_10(idx10));
mot_avg(1,11)=mean(mot_pks_11(idx11));
mot_avg(1,12)=mean(mot_pks_12(idx12));
mot_avg(1,13)=mean(mot_pks_13(idx13));
mot_avg(1,14)=mean(mot_pks_14(idx14));

 
idxp1 = pen_pks_1 >4;
idxp2 = pen_pks_2 >4;
idxp3 = pen_pks_3 >4;
idxp4 = pen_pks_4 >4;
idxp5 = pen_pks_5 >4;
idxp6 = pen_pks_6 >4;
idxp7 = pen_pks_7 >4;
idxp8 = pen_pks_8 >4;
idxp9 = pen_pks_9 >4;
idxp10 = pen_pks_10 >4;
idxp11 = pen_pks_11 >4;
idxp12 = pen_pks_12 >4;
idxp13 = pen_pks_13 >3;
idxp14 = pen_pks_14 >2;
pen_avg=zeros(1,14);
pen_avg(1,1)=mean(pen_pks_1(idxp1));
pen_avg(1,2)=mean(pen_pks_2(idxp2));
pen_avg(1,3)=mean(pen_pks_3(idxp3));
pen_avg(1,4)=mean(pen_pks_4(idxp4));
pen_avg(1,5)=mean(pen_pks_5(idxp5));
pen_avg(1,6)=mean(pen_pks_6(idxp6));
pen_avg(1,7)=mean(pen_pks_7(idxp7));
pen_avg(1,8)=mean(pen_pks_8(idxp8));
pen_avg(1,9)=mean(pen_pks_9(idxp9));
pen_avg(1,10)=mean(pen_pks_10(idxp10));
pen_avg(1,11)=mean(pen_pks_11(idxp11));
pen_avg(1,12)=mean(pen_pks_12(idxp12));
pen_avg(1,13)=mean(pen_pks_13(idxp13));
pen_avg(1,14)=mean(pen_pks_14(idxp14));

amp_rat = zeros(1,14);
for i=1:14
    
amp_rat(1,i)=pen_avg(1,i)/mot_avg(1,i);
end

bode = 20*log10(amp_rat);
freq = [0.5,0.9,0.95,0.98,1,1.03,1.05,1.07,1.1,1.2,1.3,2,3,5];
omega= 3:0.001:33;
omega2 = omega.^2;
omega_given = freq*6.28;


damp_rat=1/(2*10^((max(bode)-0.3767)/20));

nat_freq = 6.468;
k=0.02037;

num = k*nat_freq^2*omega2;
de1 = (nat_freq^2-omega2).^2;
de2 = 4*damp_rat^2*nat_freq^2*omega2;
de = sqrt(de1+de2);
theo_amp_rat = num./de;
bode_theo = 20*log10(theo_amp_rat);
figure(3)
semilogx(omega_given,bode,'o-')
hold on
semilogx(omega,bode_theo)

xlabel('frequency [rad/s]')
ylabel('amplitude ratio [dB]')
title('experimental bode plot')
legend('experimental data','transfer function fit')
grid
hold off







