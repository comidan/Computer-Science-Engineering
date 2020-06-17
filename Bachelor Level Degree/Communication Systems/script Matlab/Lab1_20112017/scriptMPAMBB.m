clear , clc, close all

% Sample time: symbol rate
M = 4;      %valore random integer generator
OSF = 64;  %over sampling factor per il filtro rettangolare FIR
hrn = ones(1,OSF)/OSF %vettore normalizzato di unos
EbN0dB = 7;