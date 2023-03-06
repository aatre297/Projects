k_1 = linspace(0,40,40);
y_k = zeros(40,1);
y_k(1) = 0;
y_k(2) = 1;
u_k_1 = ones(40,1);

for n = 3:40;
    
    y_k(n) = 1.273*y_k(n-1)-0.81*y_k(n-2)+u_k_1(n);
    
end
figure
scatter(k_1,y_k,'*')
ylabel('x(t)')
xlabel('t[s]')
title('discrete time solution')
grid on
%%
u_k = ones(50,1);
u_k(1) = 1;
u_k(2) = 1;
x_k = zeros(50,1);
x_k(1) = 0;
x_k(2) = 0.6;
for a = 3:50
    x_k(a) = 1.542*x_k(a-1)-0.792*x_k(a-2)+0.6*u_k(a-1)+0.65*u_k(a-2);
    
end
k = linspace(0,50,50);
t = k*0.5;
figure
scatter(t,x_k,'*','r')
ylabel('x(t)')
xlabel('t[s]')
title('discrete time solution')
grid on
