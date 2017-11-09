clear all;

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video

DFT_senial_verde = fftshift(abs(fft(brillo(:,2))));

f = linspace(-frec_video/2, frec_video/2, video_length);

figure;

subplot(2,1,1);
plot( f, DFT_senial_verde, 'g');
xlabel('f [Hz]');
ylabel('intensidad [modulo]');
title('FFT de la senial G');
ylim([0 2e+09]);

subplot(2,1,2);
plot( f, DFT_senial_verde, 'g');
xlabel('f [Hz]');
ylabel('intensidad [modulo]');
ylim([0 2e+09]);
xlim([0 5]);

print -djpg imagenes/punto_3_fft_G_cardiometro.jpg; %Octave
grid minor;
 
