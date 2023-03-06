%Vs = data(24303:26302,1);
%Vc = data(24303:26302,2);

R = 55.7E3;
C = 142.5E-9;
sys = tf([1],[R*C 1]);


t2 = linspace(0,.2,2000);
U = zeros(2000,1);

for x = 86:1:2000
    U(x) = 1;
end


%Vct = lsim(sys,U,t2);
%%plot(t2,Vct,'r',t2,Vc,'b',t2,Vs,'--')
%%xlabel('time in seconds')
%%ylabel('voltage')
%%title('voltage vs time')
%%legend('capacitor voltage theorotical','capacitor voltage measured','source voltage')
%ef = log((Vc-1.001)/(0-1.001))
%efpoly = ef(89:413,1)'
%tpoly = t2(1,89:413)
%eq = polyfit(tpoly,efpoly,1)
%plot(t2,ef)
%timeconstant = -(1/eq(1,1))
%tau = R*C
bode(sys)