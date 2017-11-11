clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 5, [(0.5/frec_video) , (10/frec_video)]);

filtrado = filter(b, a, brillo(:,2));

figure;

subplot(2,1,1);
plot( ejeXvideo, brillo(:, 2), 'g');
hold on;
plot(ejeXvideo, filtrado);
title('Senial filtrada');
ylim([-1e+07 1e+07]);

subplot(2,1,2);
plot(ejeXvideo, filtrado);
ylim([-1e+07 1e+07]);
xlim([20 60]);

print -djpg imagenes/punto_5_filtro_cardiometro.jpg; %Octave
grid minor;

DFT_senial_filtrada = fftshift(abs(fft(filtrado)));

DFT_senial_verde = fftshift(abs(fft(brillo(:,2))));

f = linspace(-frec_video/2, frec_video/2, video_length);

figure;

plot( f, DFT_senial_filtrada, 'b');
hold on;
plot( f, DFT_senial_verde, 'g');
ylim([0 2e+09]);
xlim([0 10]);
legend('filtrada','senial original');
xlabel('F [Hz]');
ylabel('intensidad [modulo]');

print -djpg imagenes/punto_5_fft_filtrado_cardiometro.jpg; %Octave
grid minor;
