load('/Users/adityaatre/Desktop/lab 4/MotA_p1_mtrx');

load('/Users/adityaatre/Desktop/lab 4/delta_p1_mtrx.mat');

t = 0:0.002:19.998;
MotA_p1_1 = MotA_p1_mtrx(:,4);
delta_p1_1 = delta_p1_mtrx(:,4);
figure (1)

plot(t,MotA_p1_1)
xlabel('time in seconds');
ylabel('motor angle in degrees')
title('motor angle vs time ')
figure 2
plot(t,delta_p1_1)
xlabel('time in seconds');
ylabel('beam deflection in inches')
title('beam deflection in in. vs time ')
legend('motor','beam')
grid on
hold off
grid on
%%
mot_pks_1 = findpeaks(MotA_p1_mtrx(5000:7000,1));
beam_pks_1 = findpeaks(delta_p1_mtrx(5000:7000,1));
mot_pks_2 = findpeaks(MotA_p1_mtrx(5000:7000,2));
beam_pks_2 = findpeaks(delta_p1_mtrx(5000:7000,2));
mot_pks_3 = findpeaks(MotA_p1_mtrx(5000:7000,3));
beam_pks_3 = findpeaks(delta_p1_mtrx(5000:7000,3));
mot_pks_4 = findpeaks(MotA_p1_mtrx(5000:7000,4));
beam_pks_4 = findpeaks(delta_p1_mtrx(5000:7000,4));
mot_pks_5 = findpeaks(MotA_p1_mtrx(5000:7000,5));
beam_pks_5 = findpeaks(delta_p1_mtrx(5000:7000,5));
mot_pks_6 = findpeaks(MotA_p1_mtrx(5000:7000,6));
beam_pks_6 = findpeaks(delta_p1_mtrx(5000:7000,6));
mot_pks_7 = findpeaks(MotA_p1_mtrx(5000:7000,7));
beam_pks_7 = findpeaks(delta_p1_mtrx(5000:7000,7));
mot_pks_8 = findpeaks(MotA_p1_mtrx(5000:7000,8));
beam_pks_8 = findpeaks(delta_p1_mtrx(5000:7000,8));
mot_pks_9 = findpeaks(MotA_p1_mtrx(5000:7000,9));
beam_pks_9 = findpeaks(delta_p1_mtrx(5000:7000,9));
mot_pks_10 = findpeaks(MotA_p1_mtrx(5000:7000,10));
beam_pks_10 = findpeaks(delta_p1_mtrx(5000:7000,10));
mot_pks_11 = findpeaks(MotA_p1_mtrx(5500:6000,11));
beam_pks_11= findpeaks(delta_p1_mtrx(5000:7000,11));

idx1 = mot_pks_1 >3;
idx2 = mot_pks_2 >3;
idx3 = mot_pks_3 >1;
idx4 = mot_pks_4 >0.35;
idx5 = mot_pks_5 >1;
idx6 = mot_pks_6 >1;
idx7 = mot_pks_7 >1;
idx8 = mot_pks_8 >3;
idx9 = mot_pks_9 >3;
idx10 = mot_pks_10 >5;
idx11 = mot_pks_11 >0.4;

mot_avg=zeros(1,11);
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

idxp1 = beam_pks_1 >0.43;
idxp2 = beam_pks_2 >3;
idxp3 = beam_pks_3 >3;
idxp4 = beam_pks_4 >2;
idxp5 = beam_pks_5 >3;
idxp6 = beam_pks_6 >4;
idxp7 = beam_pks_7 >4;
idxp8 = beam_pks_8 >3;
idxp9 = beam_pks_9 >3;
idxp10 = beam_pks_10 >2;
idxp11 = beam_pks_11 >1.139;

beam_avg=zeros(1,11);
beam_avg(1,1)=mean(beam_pks_1(idxp1));
beam_avg(1,2)=mean(beam_pks_2(idxp2));
beam_avg(1,3)=mean(beam_pks_3(idxp3));
beam_avg(1,4)=mean(beam_pks_4(idxp4));
beam_avg(1,5)=mean(beam_pks_5(idxp5));
beam_avg(1,6)=mean(beam_pks_6(idxp6));
beam_avg(1,7)=mean(beam_pks_7(idxp7));
beam_avg(1,8)=mean(beam_pks_8(idxp8));
beam_avg(1,9)=mean(beam_pks_9(idxp9));
beam_avg(1,10)=mean(beam_pks_10(idxp10));
beam_avg(1,11)=mean(beam_pks_11(idxp11));

amp_rat = zeros(1,11);
for i=1:11
    
amp_rat(1,i)=beam_avg(1,i)/mot_avg(1,i);
end

bode = 20*log10(amp_rat);
freq = [1,2.75,3,3.25,3.5,3.75,4,4.5,5,6,21.6];

omega_given = freq*6.28;
%semilogx(omega_given,bode,'o-');