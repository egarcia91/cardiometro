clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

%% 10 a.
ida_vuelta = filtfilt(b, a, brillo(:,2));
%filtrado = filter(b, a, brillo(:,2));

%figure;
%title('Senial filtro ida y vuelta');
%subplot(3,1,1);
%ylabel('brillo [dB]');
%plot(ejeXvideo, ida_vuelta, 'k');
%xlim([3 30]);
%
%subplot(3,1,2);
%ylabel('brillo [dB]');
%plot(ejeXvideo, ida_vuelta, 'k');
%xlim([30 60]);
%
%subplot(3,1,3);
%ylabel('brillo [dB]');
%plot(ejeXvideo, ida_vuelta, 'k');
%xlim([60 90]);
%
%xlabel('t [s]');
%print -djpg imagenes/punto_10_a_cardiometro.jpg; %Octave
%grid minor;

%% 10 b.
filtrado = filter([-2 -1 0 1 2], 1, ida_vuelta);

%figure;
%title('Senial filtro con derivada');
%subplot(3,1,1);
%ylabel('brillo [dB]');
%plot(ejeXvideo, filtrado, 'b');
%xlim([3 30]);
%
%subplot(3,1,2);
%ylabel('brillo [dB]');
%plot(ejeXvideo, filtrado, 'b');
%xlim([30 60]);
%
%subplot(3,1,3);
%ylabel('brillo [dB]');
%plot(ejeXvideo, filtrado, 'b');
%xlim([60 90]);
%xlabel('t [s]');
%print -djpg imagenes/punto_10_b_cardiometro.jpg; %Octave
%grid minor;

%% 10 c.
%length_Ma = video_length;
length_Ma = 12;
ma = ones(1,length_Ma)./(length_Ma); %Moving Average
filtMovingAverage = conv(ma, filtrado.^2);

filtMA_length = length(filtMovingAverage);
puntos_descarte = (length_Ma)/2;
filtMovingAverage = filtMovingAverage(puntos_descarte : (filtMA_length-puntos_descarte));

final = filtrado ./ sqrt(filtMovingAverage);

umbral_value = 0.65;
umbral = ones(1,video_length)*umbral_value; %Moving Average
%
%figure;
%title('Senial filtro con Moving Average');
%%legend('Moving Average','Umbral','Senial derivada normalizada');
%subplot(3,1,1);
%plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
%hold on;
%plot(ejeXvideo, umbral, 'r');
%plot(ejeXvideo, final/max(final), 'g');
%xlim([3 30]);
%
%subplot(3,1,2);
%plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
%hold on;
%plot(ejeXvideo, umbral, 'r');
%plot(ejeXvideo, final/max(final), 'g');
%xlim([30 60]);
%
%subplot(3,1,3);
%plot(ejeXvideo, (filtMovingAverage)/max(filtMovingAverage), 'b');
%hold on;
%plot(ejeXvideo, umbral, 'r');
%plot(ejeXvideo, final/max(final), 'g');
%xlim([60 90]);
%
%xlabel('t [s]');
%print -djpg imagenes/punto_10_c_cardiometro.jpg; %Octave
%grid minor;

%% 10 d.
ejeXsobreMuestreoVideo = 0 : t_video : (((video_length*4)-1)*t_video);
sobreMuestreo = upsample(final,4);

%figure;
%title('Senial sobre muestreada');
%%legend('Moving Average','Umbral','Senial derivada normalizada');
%subplot(3,1,1);
%plot(ejeXsobreMuestreoVideo, sobreMuestreo/max(sobreMuestreo), 'b');
%xlim([3 30]);
%
%subplot(3,1,2);
%plot(ejeXsobreMuestreoVideo, sobreMuestreo/max(sobreMuestreo), 'b');
%xlim([30 60]);
%
%subplot(3,1,3);
%plot(ejeXsobreMuestreoVideo, sobreMuestreo/max(sobreMuestreo), 'b');
%xlim([60 90]);
%
%xlabel('t [s]');
%print -djpg imagenes/punto_10_d_cardiometro.jpg; %Octave
%grid minor;

f = linspace(-frec_video/2, frec_video/2, video_length*4);
DFT_sobre_muestreo = fftshift(abs(fft(sobreMuestreo)));

[b, a] = butter( 27, 3.3*2/frec_video); %FiltroPasaBajoLimpia

impulso = zeros(1,190);
impulso(1) = 16/(frec_video);

%respuestaImpulso = zeros(1,video_length*4);
respuestaImpulso = filtfilt(b, a, impulso);
respuestaImpulso(video_length*4) = 0;

DFT_respuestaImpulso = 20*log(fftshift(abs(fft(respuestaImpulso))));

respuestaSobreMuestreo = filtfilt(b, a, sobreMuestreo);
DFT_respuestaSobreMuestreo = fftshift(abs(fft(respuestaSobreMuestreo)));

figure;

plot( f, DFT_sobre_muestreo, 'b');
hold on;
plot( f, DFT_respuestaSobreMuestreo, 'g');
plot( f, DFT_respuestaImpulso, 'k');
xlabel('f [Hz]');
ylabel('intensidad [modulo], Modulo [dB]');
title('FFT del sobremuestreo y el filtro');
legend('FFT senial sobremuestreada','FFT senial filtrada','Filtro');

print -djpg imagenes/punto_10_d_fft_cardiometro.jpg; %Octave
grid minor;

figure;

subplot(2,1,1);
plot( ejeXsobreMuestreoVideo, respuestaSobreMuestreo, 'g');
xlim([60 120]);
xlabel('tiempo [4*s]');
title('Comparacion de seniales');

subplot(2,1,2);
plot(ejeXvideo, final, 'k');
xlim([15 30]);
xlabel('tiempo [s]');
%legend('FFT senial sobremuestreada','FFT senial filtrada','Filtro');

print -djpg imagenes/punto_10_d_filtrado_sobremuestreo_cardiometro.jpg; %Octave
grid minor;

%% 10 e.
max_signal = max(respuestaSobreMuestreo);
umbralSignal = umbral_value*max_signal;

puntosMayoresUmbral = respuestaSobreMuestreo > umbralSignal;
derivadaMayoresUmbral = diff(puntosMayoresUmbral);

intervalos = find(derivadaMayoresUmbral);

picos = [];
for (i = 1:2:length(intervalos))
	picos((i+1)/2) = round((intervalos(i)+intervalos(i+1))/2);
endfor

umbral = ones(1,video_length*4)*umbral_value; %Umbral

figure;
title('Senial para busqueda de picos con umbral 0.7');
%legend('Moving Average','Umbral','Senial derivada normalizada');
subplot(3,1,1);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'o');
xlim([3 120]);

subplot(3,1,2);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'o');
xlim([120 240]);

subplot(3,1,3);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'o');
xlim([240 360]);

xlabel('t [4*s]');
print -djpg imagenes/punto_10_d_mas_definicion_cardiometro.jpg; %Octave
grid minor;


