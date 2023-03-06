%% loading data
clc
clear all
data = importdata('CFDdata.txt');
aerofoil_shape = importdata("airfoilShape.txt");
%% Calculating curl
x_data = data(:,1);
x_dim = -0.15:0.0025:0.05;
x  = reshape(x_data,[],length(x_dim));
y_data = data(:,2);
y_dim = -0.08:0.0025:0.08;
y  = reshape(y_data,length(y_dim),[]);

u_data = data(:,3:2:end);
v_data = data(:,4:2:end);

u = reshape(u_data,65,81,[]);
v = reshape(v_data,65,81,[]);

for i = 1:1000;

    [crl(:,:,i),cav] = curl(x,y,u(:,:,i),v(:,:,i));


end
x_aero = aerofoil_shape(:,1);
y_aero = aerofoil_shape(:,2);
z_aero = zeros(2000,1)+15;
figure(1)
hold on
surf(x,y,crl(:,:,220),'EdgeColor','none');
fill3(x_aero,y_aero,z_aero,'k');
hold off
xlabel('x')
ylabel('y')
title('vorticity at time instant 220')
view(2)

%% Forming the data matrix

% Y_SVD_trial= [reshape(u,1000,5265,1);reshape(v,1000,5265,1);reshape(crl,1000,5265,1)];
% Y_SVD = zeros(3000,5265);
%     Y_SVD(:,i) = reshape(u(:,:,i),[],1);

for i = 1:1000;
    C = zeros(5265,1);
    a = 0;
      for j = 1:81
        C(1+a:65+a,1) = u(:,j,i);
        
        a = a+65;

      end
        Y_SVD_u(:,i) = C;
end

for i = 1:1000;
    C = zeros(5265,1);
    a = 0;
      for j = 1:81
        C(1+a:65+a,1) = v(:,j,i);
        
        a = a+65;

      end
        Y_SVD_v(:,i) = C;
end

for i = 1:1000;
    C = zeros(5265,1);
    a = 0;
      for j = 1:81
        C(1+a:65+a,1) = crl(:,j,i);
        
        a = a+65;

      end
        Y_SVD_crl(:,i) = C;
end
Y_SVD = [Y_SVD_u;Y_SVD_v;Y_SVD_crl];
% Nt = length(x(1,1,:));
% Y_SVD = Y_SVD - repmat(mean(Y_SVD,1), Nt, 1);
%% POD
tic
R = Y_SVD*Y_SVD';
R_size = size(R)
[V_eig,D_eig] = eig(R,'vector');
% eigen_values_1 = diag(D_eig);
toc
[eigen_val,ind] = sort(D_eig,'descend');
V_eig = V_eig(:, ind);
%%
tic
R_snapshot = Y_SVD'*Y_SVD;
R_snap_size = size(R_snapshot)
[V_snap,D_snap] = eig(R_snapshot,'vector');
% eigen_values_2 = diag(D_snap);
toc
[eigen_val_snap,ind_snap] = sort(D_snap,'descend');
V_snap = V_snap(:, ind_snap);
%% Plotting POD modes
u_plot = V_eig(:,2);
uu_plot = reshape(u_plot(1:5265,1),65,81,1);
vv_plot = reshape(u_plot(5266:2*5265,1),65,81,1);
vort_plot = reshape(u_plot(2*5265+1:15795,1),65,81,1);
figure(2)
hold on
quiver(x,y,uu_plot,vv_plot);
fill(x_aero,y_aero,'k');
xlim([-0.15,0.05])
ylim([-0.08,0.08])
title('POD velocity mode 1')
figure (3)
hold on
surf(x,y,vort_plot,'EdgeColor','none')
fill3(x_aero,y_aero,z_aero,'k');
hold off
title('POD vorticity mode 1')

u_plot = V_eig(:,3);
uu_plot = reshape(u_plot(1:5265,1),65,81,1);
vv_plot = reshape(u_plot(5266:2*5265,1),65,81,1);
vort_plot = reshape(u_plot(2*5265+1:15795,1),65,81,1);
figure(4)
hold on
quiver(x,y,uu_plot,vv_plot);
fill(x_aero,y_aero,'k');
xlim([-0.15,0.05])
ylim([-0.08,0.08])
title('POD velocity mode 2')
figure (5)
hold on
surf(x,y,vort_plot,'EdgeColor','none')
fill3(x_aero,y_aero,z_aero,'k');
hold off
title('POD vorticity mode 2')

u_plot = V_eig(:,4);
uu_plot = reshape(u_plot(1:5265,1),65,81,1);
vv_plot = reshape(u_plot(5266:2*5265,1),65,81,1);
vort_plot = reshape(u_plot(2*5265+1:15795,1),65,81,1);
figure(6)
hold on
quiver(x,y,uu_plot,vv_plot);
fill(x_aero,y_aero,'k');
xlim([-0.15,0.05])
ylim([-0.08,0.08])
title('POD velocity mode 3')
figure (7)
hold on
surf(x,y,vort_plot,'EdgeColor','none')
fill3(x_aero,y_aero,z_aero,'k');
hold off
title('POD vorticity mode 3')

%% plotting the POD snapshot modes
eigen_snap = Y_SVD*V_snap(:,2)*(sqrt(D_snap(999)));
u_plot = eigen_snap;
uu_plot = reshape(u_plot(1:5265,1),65,81,1);
vv_plot = reshape(u_plot(5266:2*5265,1),65,81,1);
vort_plot = reshape(u_plot(2*5265+1:15795,1),65,81,1);
figure (8)
hold on
quiver(x,y,uu_plot,vv_plot);
fill(x_aero,y_aero,'k');
xlim([-0.15,0.05])
ylim([-0.08,0.08])
hold off 
title('POD snapshot velocity mode 1')
figure(9)
hold on
surf(x,y,vort_plot,'EdgeColor','none')
fill3(x_aero,y_aero,z_aero+300000000,'k');
hold off
title('POD snapshot vorticity mode 1')

eigen_snap = Y_SVD*V_snap(:,3)*(sqrt(D_snap(998)));
u_plot = eigen_snap;
uu_plot = reshape(u_plot(1:5265,1),65,81,1);
vv_plot = reshape(u_plot(5266:2*5265,1),65,81,1);
vort_plot = reshape(u_plot(2*5265+1:15795,1),65,81,1);
figure (10)
hold on
quiver(x,y,uu_plot,vv_plot);
xlim([-0.15,0.05])
ylim([-0.08,0.08])
fill(x_aero,y_aero,'k');
hold off 
title('POD snapshot velocity mode 2')
figure(11)
hold on
surf(x,y,vort_plot,'EdgeColor','none')
fill3(x_aero,y_aero,z_aero+30000000,'k');
hold off
title('POD snapshot vorticity mode 2')


eigen_snap = Y_SVD*V_snap(:,4)*(sqrt(D_snap(997)));
u_plot = eigen_snap;
uu_plot = reshape(u_plot(1:5265,1),65,81,1);
vv_plot = reshape(u_plot(5266:2*5265,1),65,81,1);
vort_plot = reshape(u_plot(2*5265+1:15795,1),65,81,1);
figure (12)
hold on
quiver(x,y,uu_plot,vv_plot);
fill(x_aero,y_aero,'k');
xlim([-0.15,0.05])
ylim([-0.08,0.08])
hold off 
title('POD snapshot velocity mode 3')
figure (13)
hold on
surf(x,y,vort_plot,'EdgeColor','none')
fill3(x_aero,y_aero,z_aero+1000000,'k');
hold off
title('POD snapshot vorticity mode 3')

%% 1d) temporal coeffs
A = Y_SVD'*V_eig; % unsure how this multiplication gives the time coeffs since it gives a 1000x15795 matrix
figure(14)
plot(eigen_val_snap(1:5),'LineWidth',2) % just plotting the eigen values
title('eigen values')
%% question 2
tic
X = Y_SVD(:,1:end-1);
X_prime = Y_SVD(:,2:end);

[U,S,V] = svd(X,'econ');

r = rank(S);
U_r = U(:,1:r);
S_r = S(1:r,1:r);
V_r = V(:,1:r);

Ftilde = U_r'*X_prime*V_r*inv(S_r);

[W,Lam] = eig(Ftilde);

modes = X_prime*V_r*inv(S_r)*W;
toc
[~,ind] = min(abs(diag(Lam)-1));







%%

eigen_val = diag(S);
% figure
% semilogy(1:1:length(eigen_val),eigen_val)
eigen_val_2 = diag(Lam);
x_eig = real(eigen_val_2);
y_eig = imag(eigen_val_2);
figure (15)
plot(x_eig,y_eig,'o')
title('eigen values in the complex plane')

u_plot = modes(:,ind);
uu_plot = reshape(u_plot(1:5265,1),65,81,1);
vv_plot = reshape(u_plot(5266:2*5265,1),65,81,1);
vort_plot = reshape(u_plot(2*5265+1:15795,1),65,81,1);
figure (16)
hold on
quiver(x,y,uu_plot,vv_plot);
fill(x_aero,y_aero,'k');
xlim([-0.15,0.05])
ylim([-0.08,0.08])
hold off 
title('DMD mode with eigen value 1')
figure (17)
hold on
surf(x,y,vort_plot,'EdgeColor','none')
fill3(x_aero,y_aero,z_aero+1000000,'k');
hold off
title('DMD mode with eigen value 1')




































