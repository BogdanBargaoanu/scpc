y = dateident0.VarValue;
y_step = y(111:end);
u0 = 35;
uss = 40;
yss = 56.21;
y0 = 35.76;
k = (yss-y0)/(uss-u0);
nivel_t = 0.63*(yss-y0)+y0;
T = 107;
plot(y_step);

Hf = tf(k,[T 1]);
Ho = tf(1,[T/4 1]);
Hr = pidstd((1/Hf)*Ho/(1-Ho));
Ho_sim = minreal(Hr*Hf/(1+Hr*Hf));
figure;
step(Ho_sim);