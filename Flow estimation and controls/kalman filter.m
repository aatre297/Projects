clc
clear
gamma_1 = 2;
gamma_2 = 1;
x0 = [-1,0,2,0];
tspan = linspace(0,118,118);
t_sig = 10:10:110;

[t,x] = ode45(@odefun1,tspan,x0,[]);

x_sig = zeros(length(t_sig),4);
j = 0;
for i = t_sig
    j = j+1;
    W = sqrt(0.01).*randn(1,4);
    x_sig(j,:) = x(i,:)+W;
end

hold on
plot(tspan,x(:,1),'b','LineWidth',2)
plot(tspan,x(:,2),'r','LineWidth',2)
plot(tspan,x(:,3),'k','LineWidth',2)
plot(tspan,x(:,4),'g','LineWidth',2)
scatter(0,0,"squarek")
plot(t_sig,x_sig(:,1),'squareb','LineWidth',2)
plot(t_sig,x_sig(:,2),'squarer','LineWidth',2)
plot(t_sig,x_sig(:,3),'squarek','LineWidth',2)
plot(t_sig,x_sig(:,4),'squareg','LineWidth',2)
legend('x_1','x_2','y_1','y_2','Meas')
xlabel('time(sec)')
ylabel('state component')
hold off
%% part b
x1 = sym('x1');
x2 = sym('x2');
y1 = sym('y1');
y2 = sym('y2');
g1 = sym('g1');
g2 = sym('g2');

x1_dot = (-g2/(2*pi))*((y1-y2)/((x1-x2)^2+(y1-y2)^2));
y1_dot = (g2/(2*pi))*((x1-x2)/((x1-x2)^2+(y1-y2)^2));
x2_dot = (-g1/(2*pi))*((y2-y1)/((x1-x2)^2+(y1-y2)^2));
y2_dot = (g1/(2*pi))*((x2-x1)/((x1-x2)^2+(y1-y2)^2));
g1_dot = 0;
g2_dot = 0;

Jac = [diff(x1_dot,x1),diff(x1_dot,y1),diff(x1_dot,x2),diff(x1_dot,y2),diff(x1_dot,g1),diff(x1_dot,g2);
        diff(y1_dot,x1),diff(y1_dot,y1),diff(y1_dot,x2),diff(y1_dot,y2),diff(y1_dot,g1),diff(y1_dot,g2);
        diff(x2_dot,x1),diff(x2_dot,y1),diff(x2_dot,x2),diff(x2_dot,y2),diff(x2_dot,g1),diff(x2_dot,g2);
        diff(y2_dot,x1),diff(y2_dot,y1),diff(y2_dot,x2),diff(y2_dot,y2),diff(y2_dot,g1),diff(y2_dot,g2);
        diff(g1_dot,x1),diff(g1_dot,y1),diff(g1_dot,x2),diff(g1_dot,y2),diff(g1_dot,g1),diff(g1_dot,g2);
        diff(g2_dot,x1),diff(g2_dot,y1),diff(g2_dot,x2),diff(g2_dot,y2),diff(g2_dot,g1),diff(g2_dot,g2);]

%% Kalman filter
x_sig = [x_sig,2+zeros(11,1),1+zeros(11,1)];
x_for = zeros(11,6);
x_dot_for = zeros(11,6);
x_anal = zeros(11,6);
x_anal(1,:) = [-1.25,0.1,1.75,-0.2,3,0.5];

% x_anal(1,:) = [-1,0,2,0,2,1];
t_k = 10:10:120;
P = eye(6);
dt = 10;
R = eye(6);
R(1,1) = 0.01;
H = eye(6);
H(5,5) = 1;
H(6,6) = 1;
k=0;
% x_inc = zeros(27,1);
% x_inc(1:6) = [-1.25,0.1,1.75,-0.2,3,0.5]';
% lower_indic = tril(ones(6));
%     x_inc(7:27) = P(lower_indic == 1);
%%
for i = 2:length(t_k)-1
%    
    lower_indic = tril(ones(6));
    p_entries = P(lower_indic == 1);
    x_state_A = [x_anal(i-1,:)';p_entries];
% 
    tspan = 0+k:10:110;

    [t_u,x_int] = ode45(@odefun,tspan,x_state_A,[],Jac);
%     tspan(1);
%     xhwe    = x_int
    a = i-1;
    x_for(a,:)=x_int(2,1:6)';
    P_new_entries = x_int(2,7:27);
    L = tril(ones(6));
    L(L == 1) = P_new_entries;
    tmp = L + L.';
    Pnew = tmp - diag(diag(tmp)/2);

%     A = double(subs(Jac));
    K = Pnew*H'/(H*Pnew*H'+R);
    h = x_for(a,:)';
%     +sqrt(0.01).*randn(1,6);
    x_anal(i,:) = x_for(i-1,:)'+K*(x_sig(i-1,:)'-H*h);
    P_anal = (eye(6)-K*H)*Pnew*(eye(6)-K*H)'+K*R*K';
%     P_anal = (eye(6)-K*H)*Pnew
    P = P_anal;
    k=k+10;
end
figure
hold on
plot(t,x(:,1),'b','LineWidth',2)
plot(t,x(:,2),'r','LineWidth',2)
plot(t,x(:,3),'k','LineWidth',2)
plot(t,x(:,4),'g','LineWidth',2)
scatter(0,0,'squarek')
scatter(0,0,'ok')
scatter(0,0,'diamondk')
plot(t_sig,x_sig(:,1),'squareb','LineWidth',2)
plot(t_sig,x_for(:,1),'ob','LineWidth',2)
plot(t_sig-10,x_anal(:,1),'diamondb','LineWidth',2)
plot(t_sig,x_sig(:,2),'squarer','LineWidth',2)
plot(t_sig,x_sig(:,3),'squarek','LineWidth',2)
plot(t_sig,x_sig(:,4),'squareg','LineWidth',2)
plot(t_sig,x_for(:,2),'or','LineWidth',2)
plot(t_sig,x_for(:,3),'ok','LineWidth',2)
plot(t_sig,x_for(:,4),'og','LineWidth',2)
plot(t_sig-10,x_anal(:,2),'diamondr','LineWidth',2)
plot(t_sig-10,x_anal(:,3),'diamondk','LineWidth',2)
plot(t_sig-10,x_anal(:,4),'diamondg','LineWidth',2)
legend('x_1','x_2','y_1','y_2','Meas','forcast','analysis')
hold off
xlabel('time(sec)')
ylabel('state component')
figure
hold on
plot(t_sig,x_anal(:,5),'LineWidth',2)
plot(t_sig,x_anal(:,6),'LineWidth',2)
hold off
xlabel('time(sec)');
ylabel('vortex strength')
legend('gamma1','gamma2')






%%


function dydt = odefun(t,x,Jac);
    Q = eye(6)*2.5e-4;
    L = eye(6);
    dydt = zeros(6,1);
    x_1 = x(1,1);
    y_1 = x(2,1);
    x_2 = x(3,1);
    y_2 = x(4,1);
    g_1 = x(5,1);
    g_2 = x(6,1);
    
    dydt(1) = (-g_2/(2*pi))*((y_1-y_2)/((x_1-x_2)^2+(y_1-y_2)^2));
    dydt(2) = (g_2/(2*pi))*((x_1-x_2)/((x_1-x_2)^2+(y_1-y_2)^2));
    dydt(3) = (-g_1/(2*pi))*((y_2-y_1)/((x_1-x_2)^2+(y_1-y_2)^2));
    dydt(4) = (g_1/(2*pi))*((x_2-x_1)/((x_1-x_2)^2+(y_1-y_2)^2));
    dydt(5) = 0;
    dydt(6) = 0;
    x1 = x_1;
    y1 = y_1;
    x2 = x_2;
    y2 = y_2;
    g1 = g_1;
    g2 = g_2;
    A = double(subs(Jac));
    P_entries = x(7:27,1);
    O = tril(ones(6));
    O(O == 1) = P_entries;
    tmp = O + O.';
    P = tmp - diag(diag(tmp)/2);
    P_dot = A*P+P*A'+L*Q*L';
    lower_indic = tril(ones(6));
    p_dot_entries = P_dot(lower_indic == 1);
    for k = 7:27;
        dydt(k) = p_dot_entries(k-6);
    end
end

function x_dot = odefun1(t,x)
    gamma_1 = 2;
    gamma_2 = 1;
    x_1 = x(1,1);
    y_1 = x(2,1);
    x_2 = x(3,1);
    y_2 = x(4,1);
    x_dot = zeros(4,1);
    x_dot(1) = (-gamma_2/(2*pi))*((y_1-y_2)/((x_1-x_2)^2+(y_1-y_2)^2));
    x_dot(2) = (gamma_2/(2*pi))*((x_1-x_2)/((x_1-x_2)^2+(y_1-y_2)^2));
    x_dot(3) = (-gamma_1/(2*pi))*((y_2-y_1)/((x_1-x_2)^2+(y_1-y_2)^2));
    x_dot(4) = (gamma_1/(2*pi))*((x_2-x_1)/((x_1-x_2)^2+(y_1-y_2)^2));


end












