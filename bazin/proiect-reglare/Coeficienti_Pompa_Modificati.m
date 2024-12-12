clear all 
close all
clc

% coeficienti model pompa
k1 = 0.624; 
k2 = -0.015; 
k3 = -0.0006;
k = 0.025;

% nivel rezervor
h = 1;
% coeficient de curgere
C = 5.75;

k11 = k2^2 + 4* (k - k3) * k1;
k12 = 8* (k - k3) * h;
k13 = 2* (k - k3);

% randament pompa
keta = 8e-5;


%Structură clasică de reglare cu reacție negativă
uc = 4.5;
ua = 4.5;
q0 = 29.2;
h0 = 14.32;
hpert = 18.15;
deltah = hpert - h0;
deltaq = 5;
deltau = 0.5;
Hp = tf(deltah/3,[145 1]);
H0 = tf(1,[36.25 1]);
HR = minreal((1/Hp)*(H0/(1-H0)));
HRPID = pidtune(HR, 'PID');

%feed-forward
kcompensare = (deltah/deltaq)/(deltah/deltau);

%cascada
kp2 = deltaq/deltau;
Tp2 = 1;
Hp2 = tf(kp2, [Tp2 1]);
H02 = tf(1, [1 1]);
HR2 = minreal((1/Hp2)*(H02/(1-H02)));
HR2PID = pidtune(HR2, 'PID');

kp = (deltah/3)/deltaq;
Tp = 245;
Hp = tf(kp, [Tp 1]);
H01 = tf(1, [36.25 1]);
HR1 = minreal((1/Hp)*(H01/(1-H01)));
HR1PID = pidtune(HR1, 'PID');