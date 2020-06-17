clear, clc, clear all
t = 0:1e-3:3;                           %vettore tempo
yt = exp(t);
f0= 20;                                 %valore frequenza segnale sinusoidale 
xt = zeros(1,length(t));;
Indt2 = find (t<=2);                                   %restituisce elementi diversi da zero
t2 = t(Indt2);
Indt1 = find(t2>=1);
xt(Indt1) = ones(1, length(Indt1));
zt = yt.*xt
figure(1)
h = plot(t, yt,'k', t, zt,'c')
set(h, 'LineWidth',2)
l = legend('exp(t)', 'exp(2t')
set(l, 'Location', 'northwest')
grid
h = xlabel('t(sec)')
set (h, 'Fontsize', 18, 'FontName', 'Helvetica')