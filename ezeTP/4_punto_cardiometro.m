clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

%Disenia el filtro para una senial compuesta por un uno y todo los demas ceros escalado por Fs
figure;
freqz(b, a, 512, "whole", frec_video);
print -djpg imagenes/punto_4_diagrama_filtro_cardiometro.jpg; %Octave
grid minor;
