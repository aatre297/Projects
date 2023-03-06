clc 
clear

ap = linspace(0,0.2,100);
A = linspace(0,1,100);
[X,Y] = meshgrid(ap,A);
G = 1;
r = 0.0135;
x = 0.02;
sig = 0.1;
y_k = 0.5;

Fv = (1/(2*sqrt(pi)*sig))*exp(-(((y_k+G.*(Y.^2).*4.*X*sqrt(x))/(x+r/2)).^2)./4*sig^2);
H = (Y.^2)/(x+(r/2));
J = 4*X*x^(1/2);
M = ((y_k+G.*H.*J).^2)./(4*sig^2);
Fv = (1/(2*sqrt(pi)*sig)).*exp(-M);
figure(1)
surf(X,Y,Fv);
xlabel('ap')
ylabel('A')
title('liklihood')
view(2)


%%

m = [0.1,0.2]';
cov = [0.0015,0.005;0.005,0.03];
xpts = [X(:),Y(:)];
% for i = length(ap);
%     for j= length(A);
for k = 1: size(xpts,1)
   f_x(k) = (1/(2*pi*sqrt(det(cov))))*exp(-(1/2)*((xpts(k,:))-m')/cov*((xpts(k,:))'-m));
end
% % end
% 
% surf(X,Y,f_x)
% 
F_x = reshape(f_x,[100,100]);
figure(2)
surf(X,Y,F_x)
xlabel('ap')
ylabel('A')
title('prior')
view(2)
%%
F_pos = (Fv.*F_x)./(sum(sum(Fv.*F_x)));
[M,I_MAP] = max(F_pos(:));
figure(3)
hold on
surf(X,Y,F_pos)
plot3(X(I_MAP),Y(I_MAP),F_pos(I_MAP),'r.','MarkerSize',50)
view(2)
xlabel('ap')
ylabel('A')
title('posterior')
legend('posterior','MAP')
hold off

%%

x = linspace(-0.02,0.05,21);
y = linspace(-0.05,0.05,21);
% x = -0.02:0.005:0.05;
% y = -0.05:0.005:0.05;
map_I = X(:);
map = map_I(I_MAP);

[X_f,Y_f] = meshgrid(x,y);
Z = X_f + 1i*Y_f;

Beta = map/sqrt(r/2);

T = (Beta-1i)./sqrt((2.*Z)/r);
Q = imag(sqrt((2.*Z)/r));
% Q = imag(W);


I = find(Q < 1);

T(I) = T(I)*(-1);


T = 1 + T;
u = real(T);
v = imag(T);
ran = linspace(0,0.05,1000)';
ran_plot = [flipud(ran);ran];
para = sqrt(2*r.*ran);
plot_para = [flipud(para);-para];
% real_para = real(plot_para);
% imag_para = imag(plot_para);
figure(4)
hold on
quiver(X_f,Y_f,u,v)
plot(map^2,-map*sqrt(2*r),'r.','MarkerSize',20)
fill(ran_plot,plot_para,'b')
xlabel('X')
ylabel('Y')
title('flowfield')
legend('flowfield','stagnantion point','parabola')
hold off
















