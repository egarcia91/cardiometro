clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

%[b, a] = butter( 3, [(0.5/frec_video) , (10/frec_video)]);
%[b, a] = butter( 5, [(0.5*2/frec_video) , (10*2/frec_video)]);
%[b, a] = butter( 5, [(0.1/frec_video) , (5/frec_video)]);

[b1, a1] = butter( 5, [(0.5/frec_video) , (7/frec_video)]);

[b2, a2] = butter( 5, [(1/frec_video) , (10/frec_video)]);



%f = linspace(-frec_video/2, frec_video/2, video_length);

figure;
freqz(b1, a1);
%freqz(b, a, 512, "whole", frec_video);
print -djpg imagenes/punto_4_diagrama_filtro_1_cardiometro.jpg; %Octave
grid minor;

figure;
freqz(b2, a2);
%freqz(b, a, 512, "whole", frec_video);
print -djpg imagenes/punto_4_diagrama_filtro_2_cardiometro.jpg; %Octave
grid minor;

