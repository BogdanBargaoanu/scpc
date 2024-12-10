rcp=2093;
V=10;
x=(4*V/pi)^(1/3); 
At=pi*(x^2/4+x^2)
k0=34930800;
EdR= 49584/8.32;
kT=293*3;%   am adaugat *3 //daca
hA=kT*At;
mdH=24953;

q=10;
ci=10;
Ti=38+273;% am adaugar 38 in loc de 25
Tri=38+273;
Tv=270:0.001:450;

cvC=(q*ci)./(q+V*k0*exp(-EdR./Tv));
Tr=Tri;
Q1=-(rcp*q*(Ti-Tv)-kT*At*(Tv-Tr));
Q2=mdH*V*k0*exp(-EdR./Tv).*cvC;
cx=-(rcp*q*(Ti-Tv)-kT*At*(Tv-Tr))./(mdH*V*k0*exp(-EdR./Tv));
figure(1)
plot(Tv,[Q1',Q2']);
xlabel('T [K]');ylabel('Q [kJ/h]')

buf=sign(Q1-Q2);
buf=diff(buf);
buf=find(buf~=0);
if length(buf)==1
T0t=Tv(buf(1));
c0t=cvC(buf(1));
else
T0=Tv(buf(2));
c0=cvC(buf(2));
end

c0=5.4698;
T0=339.437; 
%c0=8.574;

A=zeros(2,2);
B=zeros(2,4);
C=zeros(2,2);
D=zeros(2,4);

A(1,1)=-q/V-(k0*exp(-EdR/T0));
A(1,2)=-k0*exp(-EdR/T0)*EdR*c0/T0^2;
A(2,1)=(mdH/rcp)*k0*exp(-EdR/T0);
A(2,2)=-q/V-hA/(rcp*V)+mdH*k0*exp(-EdR/T0)*EdR*c0/(T0^2*rcp);
B(1,1)=(ci-c0)/V;
B(1,2)=q/V;
B(2,1)=(Ti-T0)/V;
B(2,3)=q/V;
B(2,4)=hA/(rcp*V);

C=eye(2);
D=zeros(2,4);

[NUM,DEN] = ss2tf(A,B,C,D,4)
numtrc=NUM(1,1:3); numtrt=NUM(2,1:3); den=DEN;
Htrc=tf(numtrc,den);
Htrt=tf(numtrt,den);

[NUM,DEN] = ss2tf(A,B,C,D,1)
numqc=NUM(1,1:3); numqt=NUM(2,1:3); den=DEN;
Hqc=tf(numqc,den);
Hqt=tf(numqt,den);

Kp = 0.113;
Tp = 0.78;
Hp = tf(Kp,[Tp 1]);
T0int = Tp/4;
Ho = tf(1,[T0int 1]);
Kr = Tp/(T0int*Kp);
Tint = Tp;

%% Metoda modulului

T = 0.5;
HdmC = tf(1,[2*T*T 2*T 0]);
HrmC = minreal(zpk(HdmC/Hp));
Hpid = pid(HrmC);
