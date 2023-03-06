mB = 2079;
mF = 2612;
IzB = 3200;
IzF = 7910;
lB = 2.93;
lF = 3.385;
wB = 0.491;
wF = 0.571;
C_alpha_f_B = 80000;
C_alpha_f_F = 110000;
C_alpha_r_B = 90000;
C_alpha_r_F = 100000;
lrB = wB*lB;
lrF = wF*lF;
lfB = lB - lrB;
lfF = lF - lrF;
UG_B = (mB/lB)*(C_alpha_r_B*lrB - C_alpha_f_B*lfB)/(C_alpha_f_B*C_alpha_r_B)
UG_F = (mF/lF)*(C_alpha_r_F*lrF - C_alpha_f_F*lfF)/(C_alpha_f_F*C_alpha_r_F)
KB = UG_B/lB
KF = UG_F/lF
Vchar_B = sqrt(1/KB)*2.23694
Vchar_F = sqrt(1/KF)*2.23694
w_neut_B = 1/((C_alpha_r_B/(C_alpha_f_B))+1)
w_neut_F = 1/((C_alpha_r_F/(C_alpha_f_F))+1)
CfB = lrB/(lrB+lfB)
CfF = lrF/(lrF+lfF)
Vchar = 80/2.23694;
wfB = ((lB^2*C_alpha_r_B*C_alpha_f_B)/((Vchar^2*mB)*...
(C_alpha_r_B*lB+C_alpha_f_B))) + ((C_alpha_f_B*lB)/(C_alpha_r_B*lB+C_alpha_f_B*lB))
wfF = ((lF^2*C_alpha_r_F*C_alpha_f_F)/((Vchar^2*mF)*...
(C_alpha_r_F*lB+C_alpha_f_F))) + ((C_alpha_f_F*lF)/(C_alpha_r_F*lF+C_alpha_f_F*lF))
Vcrit = 40/2.23694;
wfcrit_B = -((C_alpha_r_B*C_alpha_f_B*lB)/(mB*Vcrit^2*(C_alpha_r_B+C_alpha_f_B)))...
   + C_alpha_f_B/(C_alpha_r_B+C_alpha_f_B)

wfcrit_F = -((C_alpha_r_F*C_alpha_f_F*lF)/(mF*Vcrit^2*(C_alpha_r_F+C_alpha_f_F)))...
   + C_alpha_f_F/(C_alpha_r_F+C_alpha_f_F)








