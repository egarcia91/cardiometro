clear all
close all
load('intensidad_RGB.mat');
load('audio_det.mat');
% Variables utilizadas
N_muestras=2636;
frec_muestreo=FR;
periodo_muestreo=1/frec_muestreo;
v_frame=1:1:N_muestras;
canal_utilizado=2;

%Craci?n del filtro
n_order = 10; %debe sacar la componente de respiracion de alrededor de 0,3hz. 
Wn = [0.5 10]; %[Hz]
[b,a] = butter(n_order,Wn/(frec_muestreo/2));
%fvtool(b,a);

%Filtrado de se?al por Buter con fase cero
canal_filtrado_fase_cero = filtfilt(b,a,brillo(:,canal_utilizado));

%Filtrado de derivadas
hn=[-2 -1 0 1 2];
canal_filtrado_derivadas = conv2(hn,canal_filtrado_fase_cero,'same');



