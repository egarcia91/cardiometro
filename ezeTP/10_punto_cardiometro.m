clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

ida_vuelta = filtfilt(b, a, brillo(:,2));
%filtrado = filter(b, a, brillo(:,2));

figure;
title('Senial filtro ida y vuelta');
subplot(3,1,1);
ylabel('brillo [dB]');
plot(ejeXvideo, ida_vuelta, 'k');
xlim([3 30]);

subplot(3,1,2);
ylabel('brillo [dB]');
plot(ejeXvideo, ida_vuelta, 'k');
xlim([30 60]);

subplot(3,1,3);
ylabel('brillo [dB]');
plot(ejeXvideo, ida_vuelta, 'k');
xlim([60 90]);

xlabel('t [s]');
print -djpg imagenes/punto_10_a_cardiometro.jpg; %Octave
grid minor;

filtrado = filter([-2 -1 0 1 2], 1, ida_vuelta);

figure;
title('Senial filtro con derivada');
subplot(3,1,1);
ylabel('brillo [dB]');
plot(ejeXvideo, filtrado, 'b');
xlim([3 30]);

subplot(3,1,2);
ylabel('brillo [dB]');
plot(ejeXvideo, filtrado, 'b');
xlim([30 60]);

subplot(3,1,3);
ylabel('brillo [dB]');
plot(ejeXvideo, filtrado, 'b');
xlim([60 90]);
xlabel('t [s]');
print -djpg imagenes/punto_10_b_cardiometro.jpg; %Octave
grid minor;

%length_Ma = video_length;
length_Ma = 12;
ma = ones(1,length_Ma)./(length_Ma); %Moving Average
%filtMovingAverage = filter(ma, 1, ida_vuelta.^2);
%ida_vuelta(end/2:end) =  ida_vuelta(end/2:end)*10;
%filtMovingAverage = conv(ma, ida_vuelta.^2); %%Enunciado dice con ida y vuelta pero con filtrado es con la que funciona
filtMovingAverage = conv(ma, filtrado.^2);
%filtMovingAverage = filtfilt(ma, 1, ida_vuelta.^2);
%filtMovingAverage = filtfilt(ma, 1, filtrado.^2);
filtMA_length = length(filtMovingAverage);
puntos_descarte = (length_Ma)/2;
%
filtMovingAverage = filtMovingAverage(puntos_descarte : (filtMA_length-puntos_descarte));

final = filtrado ./ sqrt(filtMovingAverage);

umbral_value = 0.7;
umbral = ones(1,video_length)*umbral_value; %Moving Average

figure;
title('Senial filtro con Moving Average');
%legend('Moving Average','Umbral','Senial derivada normalizada');
subplot(3,1,1);
plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
hold on;
plot(ejeXvideo, umbral, 'r');
plot(ejeXvideo, final/max(final), 'g');
xlim([3 30]);

subplot(3,1,2);
plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
hold on;
plot(ejeXvideo, umbral, 'r');
plot(ejeXvideo, final/max(final), 'g');
xlim([30 60]);

subplot(3,1,3);
plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
hold on;
plot(ejeXvideo, umbral, 'r');
plot(ejeXvideo, final/max(final), 'g');
xlim([60 90]);

xlabel('t [s]');
print -djpg imagenes/punto_10_c_cardiometro.jpg; %Octave
grid minor;

%DFT_senial_filtrada = fftshift(abs(fft(filtrado)));
%
%f = linspace(-frec_video/2, frec_video/2, video_length);
%
%figure;
%plot( f, DFT_senial_filtrada, 'g');
%xlabel('F [Hz]');
%ylabel('intensidad [modulo]');
%title('DFT de las seniales');
%print -djpg fft_filtrado_cardiometro.jpg; %Octave
%grid minor;
 
max_signal = max(final);
tolerancia = 0.1;
umbral_signal = umbral_value*max_signal;

%picos = [1, 500, 900];
picos = find(final >= (umbral_signal*(1-tolerancia)) & final <= (umbral_signal*(1+tolerancia)));

figure;
title('Senial para busqueda de picos con umbral 0.35');
%legend('Moving Average','Umbral','Senial derivada normalizada');
subplot(3,1,1);
plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
hold on;
plot(ejeXvideo, umbral, 'r');
plot(ejeXvideo, final/max(final), 'g');
plot(ejeXvideo(picos),final(picos)/max(final), 'o')
xlim([3 30]);

subplot(3,1,2);
plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
hold on;
plot(ejeXvideo, umbral, 'r');
plot(ejeXvideo, final/max(final), 'g');
plot(ejeXvideo(picos),final(picos)/max(final), 'o')
xlim([30 60]);

subplot(3,1,3);
plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
hold on;
plot(ejeXvideo, umbral, 'r');
plot(ejeXvideo, final/max(final), 'g');
plot(ejeXvideo(picos),final(picos)/max(final), 'o')
xlim([60 90]);

xlabel('t [s]');
print -djpg imagenes/punto_10_d_cardiometro.jpg; %Octave
grid minor;


