%% PART 1
k = linspace(0,40,40);
x_k_1 = zeros(40,1);
x_k_1(1) = 1;
t = k*0.2;
for n=2:40;
    
    x_k_1(n) = 0.6*x_k_1(n-1);
end
figure
scatter(t,x_k_1,'*')
ylabel('x(t)')
xlabel('t[s]')
title('discrete time solution')
grid on

%% PART 2

x_k_2 = zeros(40,1);
x_k_2(1) = 1;
x_k_2(2) = 1.342;
for n=2:39;
    
    x_k_2(n+1) = 0.992*x_k_2(n)-0.350*x_k_2(n-1);
end
figure
scatter(t,x_k_2,'*')
ylabel('x(t)')
xlabel('t[s]')
title('discrete time solution')
grid on

%% Part 3

x_k_3 = zeros(40,1);
x_k_3(1) = 1;
x_k_3(2) = 0.53;
for n=2:39;
    
    x_k_3(n+1) = 0.28*x_k_2(n)-0.25*x_k_3(n-1);
end
figure
scatter(t,x_k_3,'*')
ylabel('x(t)')
xlabel('t[s]')
title('discrete time solution')
grid on
