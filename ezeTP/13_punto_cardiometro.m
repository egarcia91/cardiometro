clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load dedo_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

brillo = intensidad;

video_length = length(brillo);

frec_video = 10; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

figure;
plot( ejeXvideo, brillo(:, 1), 'r');
hold on;
plot( ejeXvideo, brillo(:, 2), 'g');
plot( ejeXvideo, brillo(:, 3), 'b');
title('video propio');
xlabel('t [s]');
ylabel('brillo');
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');
print -djpg imagenes/punto_13_RGB_cardiometro.jpg; %Octave
grid minor;

figure;
plot( ejeXvideo, brillo(:, 2), 'g');
title('video propio Verda');
xlabel('t [s]');
ylabel('brillo');
xlim([5 75]);
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');
print -djpg imagenes/punto_13_G_cardiometro.jpg; %Octave
grid minor;

[b, a] = butter( 4, [0.1*2/frec_video , 3*2/frec_video]); %FiltroPincripal

ida_vuelta = filtfilt(b, a, brillo(:,2));

filtrado = filter([-2 -1 0 1 2], 1, ida_vuelta);

length_Ma = 12;
ma = ones(1,length_Ma)./(length_Ma); %Moving Average
filtMovingAverage = conv(ma, filtrado.^2);

filtMA_length = length(filtMovingAverage);
puntos_descarte = (length_Ma)/2;
filtMovingAverage = filtMovingAverage(puntos_descarte : (filtMA_length-puntos_descarte));

final = filtrado ./ sqrt(filtMovingAverage);

umbral_value = 0.3;
umbral = ones(1,video_length)*umbral_value; %Moving Average

ejeXsobreMuestreoVideo = 0 : (t_video/4) : (((video_length)-(1/4))*(t_video));

sobreMuestreo = upsample(final,4);

[b, a] = butter( 27, 1.1*2/frec_video); %FiltroPasaBajoLimpia

respuestaSobreMuestreo = filtfilt(b, a, sobreMuestreo);

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
%legend('Moving Average','Umbral','Senial derivada normalizada');
subplot(3,1,1);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'o');
xlim([2 30]);
title('Busqueda de picos con umbral 0.3');

subplot(3,1,2);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'o');
xlim([30 60]);

subplot(3,1,3);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'o');
xlim([60 75]);

xlabel('t [s]');
print -djpg imagenes/punto_13_cardiometro.jpg; %Octave
grid minor;

tiempoIbi = [];
for (i = 1:(length(picos)-1))
	tiempoIbi(i) = ejeXsobreMuestreoVideo(picos(i));
endfor

ibi = [];
for (i = 1:(length(picos)-1))
	ibi(i) = ejeXsobreMuestreoVideo(picos(i+1))-ejeXsobreMuestreoVideo(picos(i));
endfor

figure;
plot(tiempoIbi,ibi, 'b');
ylabel('t [s]');
xlabel('t [s]');
xlim([2 75]);
%ylim([0.5 1.2]);
title('IBI');
print -djpg imagenes/punto_13_ibi_cardiometro.jpg; %Octave
grid minor;

tiempoTotal = ((video_length-1)*t_video);
picosTotal = length(picos);

lpmTotal = round((picosTotal/tiempoTotal)*60)

lpmTotal20 = round((length(find((tiempoIbi<=20) == 1))/20)*60)
lpmTotal2040 = round((length(find((tiempoIbi>=20 & tiempoIbi<=40) == 1))/20)*60)
lpmTotal4060 = round((length(find((tiempoIbi>=40 & tiempoIbi<=60) == 1))/20)*60)
lpmTotal6080 = round((length(find((tiempoIbi>=60 & tiempoIbi<=75) == 1))/15)*60)
