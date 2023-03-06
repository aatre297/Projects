Vs = data2(45606:45905,1);
Vc = data2(45606:45905,2);

R = 3.20E3;
C = 142.4E-9;
L = 494E-3;
sys = tf([1],[L*C R*C 1]);

t2 = linspace(0,.075,300);
U = zeros(300,1);

for x = 86:1:300
    U(x) = 1;
end


Vct = lsim(sys,U,t2);

plot(t2,Vct,'r',t2,Vc,'b',t2,Vs,'g')
xlabel('time in seconds')
ylabel('voltage')
title('voltage vs time')
legend('capacitor voltage theorotical','capacitor voltage measured','source voltage')