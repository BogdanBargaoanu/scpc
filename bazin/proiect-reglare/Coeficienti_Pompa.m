clear all 
close all
clc

% coeficienti model pompa
k1 = 0.624; 
k2 = -0.015; 
k3 = -0.0006;
k = 0.035;

% nivel rezervor
h = 1;
% coeficient de curgere
C = 9;

k11 = k2^2 + 4* (k - k3) * k1;
k12 = 8* (k - k3) * h;
k13 = 2* (k - k3);

% randament pompa
keta = 8e-5;


%Structură clasică de reglare cu reacție negativă
uc = 5;
ua = 5;
q0 = 29.2;
h0 = 10.5;
deltah = 2.5;
deltaq = 5;
deltau = 0.5;
Hp = tf(1.67,[160 1]);
H0 = tf(1,[40 1]);
HR = minreal((1/Hp)*(H0/(1-H0)));
HRPID = pidtune(HR, 'PID');

%feed-forward
kcompensare = (deltah/deltaq)/(deltah/deltau);

%cascada
kp2 = deltaq/deltau;
Tp2 = 0.7325;
Hp2 = tf(kp2, [Tp2 1]);
H02 = tf(1, [1 1]);
HR2 = minreal((1/Hp2)*(H02/(1-H02)));

kp = (deltah/3)/deltaq;
Tp = 260;
Hp = tf(kp, [Tp 1]);
H01 = tf(1, [40 1]);
HR1 = minreal((1/Hp)*(H01/(1-H01)));