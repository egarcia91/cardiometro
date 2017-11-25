function [mySignal, FR] = mySignal()

load('../TPSyS2017-2c-ARCHIVOS/intensidad_RGB.mat');
mySignal = brillo(:, 2);
FR = FR;
