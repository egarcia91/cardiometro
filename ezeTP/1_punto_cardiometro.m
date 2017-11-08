clear all;

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

figure;
plot( ejeXvideo, brillo(:, 1), 'r');
hold on;
plot( ejeXvideo, brillo(:, 2), 'g');
plot( ejeXvideo, brillo(:, 3), 'b');
xlabel('t [s]');
ylabel('brillo [dB]');
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');
title('Seniales R G B');
print -djpg imagen_cardiometro.jpg; %Octave
grid minor;

