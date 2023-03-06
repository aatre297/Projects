Ts = 5772;
dse = 1.5E8;
Ds = 1.394E6;
Ee = 0.826;
Es = 1;
ae = 0.94;
delta_Ts = 0.01;
delta_dse = 0.01;
delta_Ds = 0.01;
delta_Ee = 0.01;
delta_Es = 0.01;
delta_ae = 0.01;


dTs = (1/2)*sqrt(Ds/dse)*((Es*ae)/(Ee))^(1/4);

ddse = -(((Es*ae)/Ee)^(1/4)*Ts*sqrt(Ds)*dse)/(4*dse^(5/2));

dDs = (((Es*ae)/Ee)^(1/4)*Ts*Ds)/(4*sqrt(dse)*Ds^(3/2));

dEe = -(Es*ae*Ts*sqrt(Ds))/(8*sqrt(dse)*((Es*ae)/Ee)^(3/4)*Ee^2);

dEs = (ae*Ts*sqrt(Ds))/(8*Ee*sqrt(dse)*((ae*Es)/Ee)^(3/4));

dae = (Es*Ts*sqrt(Ds))/(8*Ee*sqrt(dse)*((Es*ae)/Ee)^(3/4));


deltaTe = sqrt((dTs)^2*(delta_Ts)^2+(ddse)^2*(delta_dse)^2+(dDs)^2*(delta_Ds)^2+(dEe)^2*(delta_Ee)^2+(dEs)^2*(delta_Es)^2+(dae)^2*(delta_ae)^2);

deltaTe_F = 1.8*deltaTe




