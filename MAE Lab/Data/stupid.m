R = 55.7E3;
C = 142.5E-9;
sys = tf([1],[R*C+1]);
step(sys)