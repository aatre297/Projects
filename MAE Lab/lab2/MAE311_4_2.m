N_2 = [1,10,100,1000,10000,100000,1000000]';

sig_ef = 8.88E-3;
ep_f = 0.30;
b = -0.065;
c = -0.62;

es = sig_ef*(N_2).^b

ps = ep_f*(N_2).^c

tot_s = es+ps
log10(es)
log10(ps)
log10(tot_s)


%%
hold on
plot(N_2,es,'r')
plot(N_2,ps,'b')
plot(N_2,tot_s,'g')
xlabel('Reversals to failure (2N)')
ylabel('strain amplitude')
title('material A538A(b) HB=405')
legend('elastic strain','plastic strain','total strain')
hold off
