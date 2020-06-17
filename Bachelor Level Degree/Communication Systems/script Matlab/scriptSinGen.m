clear, clc, close all;
DT= 1e-3;
f0 = 2;
phi_iniz = pi/12;
DurataSim = 10;
for A=1:3,
  sim('SinGen',DurataSim)  
end
