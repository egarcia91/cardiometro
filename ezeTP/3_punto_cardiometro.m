clear all;

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video

DFT_senial_roja = fftshift(abs(dft(brillo(:,1))));
DFT_senial_verde = fftshift(abs(dft(brillo(:,2))));
DFT_senial_azul = fftshift(abs(dft(brillo(:,3))));

f = linspace(-frec_video/2, frec_video/2, video_length);

figure;
plot( f, DFT_senial_roja, 'r');
hold on;
plot( f, DFT_senial_verde, 'g');
plot( f, DFT_senial_azul, 'b');
xlabel('F [Hz]');
ylabel('intensidad [modulo]');
title('DFT de las seniales');
print -djpg fft_cardiometro.jpg; %Octave
grid minor;
 
