clear all 
close all
clc

%% Coeficienti model pompa
k1 = 0.624; 
k2 = -0.015; 
k3 = -0.0006;
k = 0.037;

%% Nivel rezervor
h = 1;
%% Coeficient de curgere
C = 7.55;

k11 = k2^2 + 4* (k - k3) * k1;
k12 = 8* (k - k3) * h;
k13 = 2* (k - k3);

%% Randament pompa
keta = 8e-5;


%% Structura clasica de reglare cu reactie negativa
uc = 5.7;
ua = 5.7;
q0 = 30.86;
h0 = 16.69;
hpert = 20.85;
deltah = hpert - h0;
deltaq = 5;
deltau = 0.5;
Hp = tf(deltah/3,[175 1]);
H0 = tf(1,[43.75 1]);
HR = minreal((1/Hp)*(H0/(1-H0)));
HRPID = pidtune(HR, 'PID');

%% Feed-Forward
kcompensare = (deltah/deltaq)/(deltah/deltau);

%% Cascada
kp2 = deltaq/deltau;
Tp2 = 1;
Hp2 = tf(kp2, [Tp2 1]);
H02 = tf(1, [1 1]);
HR2 = minreal((1/Hp2)*(H02/(1-H02)));
HR2PID = pidtune(HR2, 'PID');

kp = (deltah/3)/deltaq;
Tp = 305;
Hp = tf(kp, [Tp 1]);
H01 = tf(1, [43.75 1]);
HR1 = minreal((1/Hp)*(H01/(1-H01)));
HR1PID = pidtune(HR1, 'PID');