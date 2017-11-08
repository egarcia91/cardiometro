clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 1, [0.5/frec_video , 10/frec_video]);

%f = linspace(-frec_video/2, frec_video/2, video_length);

figure;
freqz(b,a);
%subplot(2,1,1);
%plot(abs([b,a]));
%subplot(2,1,2);
%plot(angle([b,a]));
%xlabel('t [s]');
%ylabel('brillo [dB]');
%title('Titulo');
print -djpg imagenes/punto_4_diagrama_filtro_cardiometro.jpg; %Octave
grid minor;

