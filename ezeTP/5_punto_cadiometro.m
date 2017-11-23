clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

filtrado = filter(b, a, brillo(:,2));

figure;

plot( ejeXvideo, brillo(:, 2), 'g');
hold on;
plot(ejeXvideo, filtrado, 'b');
title('Superposicion original y filtrada');
ylim([-1e+07 1e+07]);
xlabel('t [s]');
ylabel('Brillo');
legend('original','filtrada','location','northeast');
legend boxoff;

print -djpg imagenes/punto_5_superposicion_filtro_cardiometro.jpg; %Octave
grid minor;

figure;
subplot(3,1,1);
plot(ejeXvideo, filtrado);
ylim([-1e+07 1e+07]);
xlim([3 30]);
title('Zoom Filtrada');

subplot(3,1,2);
plot(ejeXvideo, filtrado);
ylim([-1e+07 1e+07]);
xlim([30 60]);

subplot(3,1,3);
plot(ejeXvideo, filtrado);
ylim([-1e+07 1e+07]);
xlim([60 90]);
xlabel('t [s]');

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
title('Superposicion FFTs');
legend('original','filtrada','location','northeast');
legend boxoff;
xlabel('F [Hz]');
ylabel('intensidad [modulo]');

print -djpg imagenes/punto_5_fft_filtrado_cardiometro.jpg; %Octave
grid minor;

cursor1 = zeros(1,length(filtrado)).+0.33e+07;
cursor2 = zeros(1,length(filtrado)).+0.11e+07;
figure;

plot( ejeXvideo, brillo(:, 2), 'g');
hold on;
plot(ejeXvideo, filtrado,'b');
plot(ejeXvideo, cursor1,'-.b');
plot(ejeXvideo, cursor2,'-.g');
plot([71.87, 71.87], ylim, '-.b');
plot([71.91, 71.91], ylim, '-.g');
title('Retardo respecto a la original');
legend('original','filtrada','location','northeast');
legend boxoff;
ylim([-1e+07 1e+07]);
xlim([71 73]);
xlabel('t [s]');
ylabel('Brillo');

print -djpg imagenes/punto_5_retardo_original_cardiometro.jpg; %Octave
grid minor;


