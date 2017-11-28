clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(2*pi*frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

ida_vuelta = filtfilt(b, a, brillo(:,2));

filtrado = filter(b, a, brillo(:,2));

windowLength = 128;
window = hamming(windowLength);
%Hamming 128 puntos

figure;

subplot(2,1,1);
specgram(brillo(:,2), 2^nextpow2(windowLength), frec_video, window, windowLength-1);
ylim([0  8]);
title('Senal Original');
xlabel('t [s]');
ylabel('f [Hz]');

subplot(2,1,2);
specgram(ida_vuelta, 2^nextpow2(windowLength), frec_video, window, windowLength-1);
xlabel('t [s]');
ylabel('f [Hz]');
%caxis([0 70]);
ylim([0  8]);
title('Senal Filtrada');

print -djpg imagenes/punto_8_espectograma_cardiometro.jpg; %Octave
grid minor;
 
