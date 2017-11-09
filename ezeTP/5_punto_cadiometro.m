clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 5, [(0.5/frec_video) , (7/frec_video)]);

filtrado1 = filter(b, a, brillo(:,2));

[b, a] = butter( 5, [(1/frec_video) , (10/frec_video)]);

filtrado2 = filter(b, a, brillo(:,2));

[b, a] = butter( 5, [(4/frec_video) , (15/frec_video)]);

filtrado3 = filter(b, a, brillo(:,2));

[b, a] = butter( 5, [(7/frec_video) , (20/frec_video)]);

filtrado4 = filter(b, a, brillo(:,2));

[b, a] = butter( 5, [(11/frec_video) , (25/frec_video)]);

filtrado5 = filter(b, a, brillo(:,2));


figure;
subplot(5,1,1);
plot(ejeXvideo, filtrado1);
title('Comparacion de filtros');
legend('buen filtro 1');
ylim([-1e+07 1e+07]);
subplot(5,1,2);
plot(ejeXvideo, filtrado2);
legend('buen filtro 2');
ylim([-1e+07 1e+07]);
subplot(5,1,3);
plot(ejeXvideo, filtrado3);
legend('mal filtro 3');
ylim([-1e+07 1e+07]);
subplot(5,1,4);
plot(ejeXvideo, filtrado4);
legend('mal filtro 4');
ylim([-1e+07 1e+07]);
subplot(5,1,5);
plot(ejeXvideo, filtrado5);
legend('mal filtro 5');
ylim([-1e+07 1e+07]);
print -djpg imagenes/punto_5_filtro_cardiometro.jpg; %Octave
grid minor;

DFT_senial_filtrada1 = fftshift(abs(fft(filtrado1)));
DFT_senial_filtrada2 = fftshift(abs(fft(filtrado2)));

f = linspace(-frec_video/2, frec_video/2, video_length);

figure;

subplot(2,1,1);
plot( f, DFT_senial_filtrada1, 'g');
ylim([0 2e+09]);
xlim([0 5]);
legend('buen filtro 1');
xlabel('F [Hz]');
ylabel('intensidad [modulo]');

subplot(2,1,2);
plot( f, DFT_senial_filtrada2, 'g');
ylim([0 2e+09]);
xlim([0 5]);
legend('buen filtro 2');
xlabel('F [Hz]');
ylabel('intensidad [modulo]');
title('DFT de las seniales');
print -djpg imagenes/punto_5_fft_filtrado_cardiometro.jpg; %Octave
grid minor;
 
