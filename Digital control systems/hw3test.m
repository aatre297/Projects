clear all
theta = (0:pi/50:2*pi)';
theta2 = (0:pi/50:pi)';
real_unit = cos(theta);
imag_unit = sin(theta);

figure; hold on
p1 = plot(real_unit,imag_unit,'r--','linewi',2)
axis([-1.2 1.2 -1.2 1.2]),axis equal
title('discrete root loctions part 3','FontSize',16)
xlabel('real axis')
ylabel('imaginary axis')
ax = gca;
ax.FontSize = 16;

%% perfomance constraints
ts01 = 3;
ts02 = 1;
f_s = 5; 
omega_s  = 2*pi*f_s;
T = 1/f_s;
Mpo = 0.5266;
Mp0_2 = 0.0948;
tr0 = 0.8;

%% settling time constraints
mag_ts2 = exp(-(4/ts01)*T);
real_ts2 = mag_ts2*cos(theta);
imag_ts2 = mag_ts2*sin(theta);
mag_ts1 = exp(-(4/ts02)*T);
real_ts1 = mag_ts1*cos(theta);
imag_ts1 = mag_ts1*sin(theta);
plo_real_ts = [real_ts1; real_ts2];
plo_imag_ts = [imag_ts1; imag_ts2];
p2 = fill(plo_real_ts,plo_imag_ts,'g','LineStyle','none');
alpha(0.25);
%  p3 = fill(real_ts1,imag_ts1,'w','LineStyle','none');
%  alpha(p3,1);

%% overshoot

zeta_Mp = sqrt(log(Mpo)^2/(pi^2+log(Mpo)^2));
mag_Mp = exp(-zeta_Mp/sqrt(1-zeta_Mp^2)*theta2);

real_Mp = mag_Mp.*cos(theta2);
imag_Mp = mag_Mp.*sin(theta2);
real_Mp_2 = [real_Mp; flipud(real_Mp)];
imag_Mp_2 = [imag_Mp; flipud(-imag_Mp)];
% p3 = fill(real_Mp_2,imag_Mp_2,'b','LineStyle','none');
% p5 = fill(real_Mp,-imag_Mp,'b','LineStyle','none');
% alpha(p3,0.25);
% alpha(p5,0.25);
zeta_Mp_2 = sqrt(log(Mp0_2)^2/(pi^2+log(Mp0_2)^2));
mag_Mp_2 = exp(-zeta_Mp_2/sqrt(1-zeta_Mp_2^2)*theta2);
real_Mp_3 = mag_Mp_2.*cos(theta2);
imag_Mp_3 = mag_Mp_2.*sin(theta2);
real_Mp_4 = [real_Mp; flipud(real_Mp);real_Mp_3; flipud(real_Mp_3)];
imag_Mp_4 = [imag_Mp; flipud(-imag_Mp);imag_Mp_3; flipud(-imag_Mp_3)];
p8 = fill(real_Mp_4,imag_Mp_4,'b','LineStyle','none');
% p9 = fill(real_Mp_3,-imag_Mp_3,'w','LineStyle','none');
alpha(p8,0.25);
% alpha(p9,1);
 zgrid

%%
k = -1:1:40;
y_k(1) = 0.6543;
y_k(2) = 1;

for y = 3:42;
%     k = y-3;
%     if k >= 0;
%         u_k = 0;
%     else
%         u_k = 0;
%     end
    y_k(y) = 1.034*y_k(y-1)-0.157*y_k(y-2);
end
k = -1:1:40;
T = 0.2;
plot(k*T,y_k)
grid on

