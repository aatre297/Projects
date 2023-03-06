Vs = data1(44790:45289,1);
Vc = data1(44790:45289,2);

R = 513;
C = 142.4E-9;
L = 494E-3;
sys = tf([1],[L*C R*C 1]);

t2 = linspace(0,.125,500);
U = zeros(500,1);

for x = 86:1:500
    U(x) = 1;
end


Vct = lsim(sys,U,t2);

plot(t2,Vct,'r',t2,Vc,'b',t2,Vs,'g')
xlabel('time in seconds')
ylabel('voltage')
title('voltage vs time')
legend('capacitor voltage theorotical','capacitor voltage measured','source voltage')