%rampl=4; ampl=0.72; ku=4*rampl/(pi*ampl);% cu histereza 2*0.1
rampl=4; ampl=0.35; ku=4*rampl/(pi*ampl);%cu histereza 2*eps ku=factorul de amplificare critic
tu=0.8; %timpul intre 2 perioade
% kreg=0.45*ku;tireg=0.83*tu %PI
kreg=0.6*ku;tireg=0.5*tu; tdreg=0.125*tu; %PID

trampl=10; tampl=4; tku=4*trampl/(pi*tampl);
ttu=1.6;
%tkreg=0.45*tku;ttireg=0.83*ttu
tkreg=0.6*tku;ttireg=0.5*ttu; ttdreg=0.125*ttu;

% clf
% plot(tsim,texp-T0,'r')
% hold on
% step(HTrT)
% legend("Ziegler-Nichols","HTrT")

P_reg = kreg;
I_reg = kreg/tireg;
D_reg = kreg*tdreg;
