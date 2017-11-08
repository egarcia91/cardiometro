clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 1, [0.5/frec_video , 10/frec_video]);

filtrado = filter(b, a, brillo(:,2));

%figure;
plot(ejeXvideo, brillo(:,2), 'g');
hold on;
plot(ejeXvideo, filtrado);
%%plot( ejeXvideo, brillo(:,2));
%xlabel('t [s]');
%ylabel('brillo [dB]');
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');
%title('Titulo');
print -djpg filtro_cardiometro.jpg; %Octave
grid minor;

DFT_senial_filtrada = fftshift(abs(fft(filtrado)));

f = linspace(-frec_video/2, frec_video/2, video_length);

figure;
plot( f, DFT_senial_filtrada, 'g');
xlabel('F [Hz]');
ylabel('intensidad [modulo]');
title('DFT de las seniales');
print -djpg fft_filtrado_cardiometro.jpg; %Octave
grid minor;
 
