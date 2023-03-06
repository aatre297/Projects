%% drawing boundries for discreet root locations
clear all
theta = (0:pi/50:2*pi);
theta2 = (0:pi/50:pi);
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

p2 = fill(real_ts2,imag_ts2,'g','LineStyle','none');
alpha(0.25);
p3 = fill(real_ts1,imag_ts1,'w','LineStyle','none');
alpha(p3,1);

%% overshoot

zeta_Mp = sqrt(log(Mpo)^2/(pi^2+log(Mpo)^2));
mag_Mp = exp(-zeta_Mp/sqrt(1-zeta_Mp^2)*theta2);

real_Mp = mag_Mp.*cos(theta2);
imag_Mp = mag_Mp.*sin(theta2);
real_Mp_2 = [real_Mp; flipud(real_Mp)];
imag_Mp_2 = [imag_Mp; flipud(-imag_Mp)];
% p4 = fill(real_Mp_2,imag_Mp_2,'b','LineStyle','none');
% p5 = fill(real_Mp,-imag_Mp,'b','LineStyle','none');
% alpha(p4,0.25);
% alpha(p5,0.25);

zeta_Mp_2 = sqrt(log(Mp0_2)^2/(pi^2+log(Mp0_2)^2));
mag_Mp_2 = exp(-zeta_Mp_2/sqrt(1-zeta_Mp_2^2)*theta2);
real_Mp_3 = mag_Mp_2.*cos(theta2);
imag_Mp_3 = mag_Mp_2.*sin(theta2);
real_Mp_4 = [real_Mp_3; flipud(real_Mp_3)];
imag_Mp_4 = [imag_Mp; flipud(-imag_Mp_3)];
p8 = fill(real_Mp_3,imag_Mp_3,'w','LineStyle','none');
p9 = fill(real_Mp_3,-imag_Mp_3,'w','LineStyle','none');
alpha(p8,1);
alpha(p9,1);

%% rise time
zeta_tr = linspace(0,0.999999999999,501)';
beta = atan(sqrt(1-zeta_tr.^2)./zeta_tr);

omegan_tr = (pi-beta)./(tr0*sqrt(1-zeta_tr.^2));
omegad_tr = omegan_tr.*sqrt(1-zeta_tr.^2);

mag_tr = exp(-zeta_tr.*omegan_tr*T);
ang_tr = omegad_tr*T;
real_tr = mag_tr.*cos(ang_tr);
imag_tr = mag_tr.*sin(ang_tr);
real_tr_2 = [flipud(real_tr);1*cos((ang_tr(1):0.1:pi)')];
imag_tr_2 = [flipud(imag_tr);1*sin((ang_tr(1):0.1:pi)')];

real_tr_3 = [real_tr_2; flipud(real_tr_2)];
imag_tr_3 = [imag_tr_2 ; flipud(-imag_tr_2)];
% p6 = plot(real_tr,imag_tr,'-k','linewi',2)
% p7 = plot(real_tr,-imag_tr,'-k','linewi',2)
% p6 = fill(real_tr_3,imag_tr_3,'r','LineStyle','none');
% alpha(p6,0.5)
p7 = fill(real_tr_2,-imag_tr_2,'r','LineStyle','none');
alpha(p7,0.5)
zgrid
legend([p1,p2,p6,p4],{'stability condition','settling time conditions','rise time conditions','overshoot conditions'});

 