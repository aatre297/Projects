load('/Users/adityaatre/Desktop/lab 4/MotA_rand_mtrx.mat');
load('/Users/adityaatre/Desktop/lab 4/delta_rand_mtrx.mat');
t = 0:0.002:19.998;
 figure(1)
hold on
plot(t,MotA_rand_mtrx(:,3))
xlabel('time in seconds');
ylabel('motor angle in degrees')
title('motor angle vs time ')
figure(2)
plot(t,delta_rand_mtrx(:,3))
xlabel('time is seconds')
ylabel('beam deflection in inches')
title('beam deflection in in. vs time ')
grid on
hold off
freq = [1,2.75,3,3.25,3.5,3.75,4,4.5,5,6,21.6];
amp_rat1 = [0.05714071;1.006277792;2.406907895;8.438566553;2.925690521;1.165541385;1.112515803;0.71982588;0.583581306;0.455878635;5.809534646];
phi1 = [152.4000228
181.5000271
180.0000269
136.0000933
0.840000126
1.350000202
14.40000215
1.080000161
0.60000009
0.720000108
15.55200233];

N = 10000; %number of samples collected
fs = 500; %sampling frequency [Hz]
df = fs/N; %frequency resolution
f = df*(1:N/2); 
runs = 5;

% taking FFT of each column
A = fft(MotA_rand_mtrx); %each column of this matrix is motor data from one random vibration experiment
B = fft(delta_rand_mtrx); %each column of this matrix is beam deflection data from one random vibration experiment

% calculating the auto- and cross-power densities, respectively
AA = sum(A.*conj(A),2)/runs; %auto power density
AB = sum(B.*conj(A),2)/runs; %cross power density

FRF = AB./AA; %frequency response function, evaluated at frequencies stored in the variable ?f?
mag_FRF = abs(FRF); %amplitude ratio (magnitude of frequency response function)
ang_FRF = angle(FRF)*180/pi; 
figure(2)
subplot(211),

semilogx(f,mag_FRF(1:N/2),'k.')
hold on
semilogx(freq,amp_rat1,'r.')
hold off
grid on
title('magnitude of frequency response function')
xlabel('Frequency [Hz]')
ylabel('amplitude ratio')
legend('FFT analysis','part one results')

subplot(212)
semilogx(f,ang_FRF(1:N/2),'k.')
hold on
semilogx(freq,phi1,'r.')
hold off
grid on
title('phase of frequency response function')
xlabel('Frequency [Hz]')
ylabel('phase angle [deg]')
legend('FFT analysis','part one results')

bode1 = 20*log10(amp_rat1);
bode2 = 20*log10(mag_FRF(1:N/2));
figure(3)
subplot(211)
semilogx(f,bode2,'k.')
hold on
semilogx(freq,bode1,'r.')
title('magnitude of frequency response function')
xlabel('Frequency [Hz]')
ylabel('amplitude ratio')
legend('FFT analysis','part one results')
xlim([1,10])
grid on
hold off

subplot(212)

semilogx(f,ang_FRF(1:N/2),'k.')
hold on
semilogx(freq,phi1,'r.')
title('phase of frequency response function')
xlabel('Frequency [Hz]')
ylabel('phase angle [deg]')
legend('FFT analysis','part one results')
xlim([1,10])
grid on
hold off


omega= 0:0.01:30;
omega2 = omega.^2;
damprat_1=1/(2*10^((18.41+10.77)/20));

damprat_2=1/(2*10^((24.97+10.322)/20));

damprat_3 = 1/(2*10^((30.35)/20));


natfreq_1 = 3.3;
natfreq_2 = 20.6
natfreq_3 = 15.05

num2 = natfreq_2^2*omega2;
de1_2 = (natfreq_2^2-omega2).^2;
de2_2 = 4*damprat_2^2*natfreq_2^2*omega2;
de_2 = sqrt(de2_2+de1_2);

num3 = natfreq_3^2*omega2;
de1_3 = (natfreq_3^2-omega2).^2;
de2_3 = 4*damprat_3^2*natfreq_3^2*omega2;
de_3 = sqrt(de1_3+de2_3);





k=10^(-29.32/20);
num = natfreq_1^2*omega2;
de1 = (natfreq_1^2-omega2).^2;
de2 = 4*damprat_1^2*natfreq_1^2*omega2;
de = sqrt(de1+de2);
theo_amp_rat = k*(num./de).*(num2./de_2).*(de_3./num3);
bode_theo = 20*log10(theo_amp_rat);
figure(4)
subplot(211)
semilogx(f,bode2,'k.')
hold on
semilogx(omega,bode_theo,'r.')

xlabel('frequency [Hz]')
ylabel('amplitude ratio [dB]')
title('magnitude of frequency response function till 30Hz')
legend('FFT analysis','transfer function fit')
grid on
xlim([1,30])
hold off

%num_phi = (natfreq_1^2*omega2).*(natfreq_2^2*omega2).*(4*damprat_3^2*natfreq_1^2*omega2);
%de_phi = (4*damprat_1^2*natfreq_1^2*omega2).*(4*damprat_2^2*natfreq_1^2*omega2).*(4*damprat_3^2*natfreq_1^2*omega2).*(natfreq_3^2*omega2);
%phi_theo = atand(num_phi./de_phi)

%num_phi = ((4*damprat_1*natfreq_1*damprat_2*natfreq_2).*omega).*(natfreq_3-omega2);
%de_phi = (natfreq_1-omega2).*(natfreq_2-omega2).*(2*damprat_3*natfreq_3.*omega);
%phi_theo = -atand(num_phi./de_phi);
for i=3001;
phi_theo(:,i) =atand(((natfreq_1^2-omega2(:,i)))/(4*damprat_1^2*natfreq_1^2*omega2(:,i)))-atand(((natfreq_2^2*omega2(:,i)))/(4*damprat_2^2*natfreq_2^2*omega2(:,i)))+atand(((4*damprat_3^2*natfreq_3^2*omega2(:,i))/(natfreq_3^2-omega2(:,i))));
end
subplot(212)
semilogx(f,ang_FRF(1:N/2),'k.')

hold on
semilogx(omega,phi_theo,'r.')
title('phase of frequency response function')
xlabel('Frequency [Hz]')
ylabel('phase angle [deg]')
legend('FFT analysis','transfer function fit')
xlim([1,30])
ylim([-50,200])
grid on
hold off
