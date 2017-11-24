clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

ida_vuelta = filtfilt(b, a, brillo(:,2));

filtrado = filter([-2 -1 0 1 2], 1, ida_vuelta);

length_Ma = 12;
ma = ones(1,length_Ma)./(length_Ma); %Moving Average
filtMovingAverage = conv(ma, filtrado.^2);

filtMA_length = length(filtMovingAverage);
puntos_descarte = (length_Ma)/2;
filtMovingAverage = filtMovingAverage(puntos_descarte : (filtMA_length-puntos_descarte));

final = filtrado ./ sqrt(filtMovingAverage);

umbral_value = 0.65;
umbral = ones(1,video_length)*umbral_value; %Moving Average

ejeXsobreMuestreoVideo = 0 : (t_video/4) : (((video_length)-(1/4))*(t_video));

sobreMuestreo = upsample(final,4);

[b, a] = butter( 27, 3.3*2/frec_video); %FiltroPasaBajoLimpia

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

tiempoIbi = [];
for (i = 1:(length(picos)-1))
	tiempoIbi(i) = ejeXsobreMuestreoVideo(picos(i));
endfor

ibi = [];
for (i = 1:(length(picos)-1))
	ibi(i) = ejeXsobreMuestreoVideo(picos(i+1))-ejeXsobreMuestreoVideo(picos(i));
endfor

%%a umbral de 200ms
separacionEntreDosLatidos = 0.2;
picosCercanos = find(ibi < separacionEntreDosLatidos);

for (i = 1:(length(picosCercanos)-1))
	index = picosCercanos(i);
	valorPico1 = respuestaSobreMuestreo(picos(index));
	valorPico2 = respuestaSobreMuestreo(picos(index+1));

	if(valorPico1 > valorPico2)
		picos((index+1)) = [];
	else
		picos(index) = [];
	endif

endfor

%%b diferencia de 1.5 veces el anterior
nuevosPicos = [];

for (i = 1:(length(ibi)-1))
	relacionA = ibi(i)/ibi(i+1);
	relacionB = 1/relacionA;

	if(relacionA >= 1.5)
		nuevosPicos(end+1) = picos(i);
		nuevosPicos(end+1) = picos(i+1);
		nuevosPicos(end+1) = picos(i+2);
	endif

	if(relacionB >= 1.5)
		nuevosPicos(end+1) = picos(i);
		nuevosPicos(end+1) = picos(i+1);
		nuevosPicos(end+1) = picos(i+2);
	endif

endfor

umbral_value_2 = umbral_value/2;
max_signal = max(respuestaSobreMuestreo);
umbralSignal2 = umbral_value_2*max_signal;

picos2 = [];

for (i = 1:3:(length(nuevosPicos)-1))
	posiblePico = zeros(1,length(respuestaSobreMuestreo));
	posiblePico(nuevosPicos(i):nuevosPicos(i+2)) = respuestaSobreMuestreo(nuevosPicos(i):nuevosPicos(i+2));

	puntosMayoresUmbral2 = posiblePico > umbralSignal2;
	derivadaMayoresUmbral2 = diff(puntosMayoresUmbral2);

	intervalos2 = find(derivadaMayoresUmbral2);

	for (j = 1:2:length(intervalos2))
		picos2(end+1) = round((intervalos2(j)+intervalos2(j+1))/2);
	endfor

endfor

figure;
%legend('Moving Average','Umbral','Senial derivada normalizada');
subplot(3,1,1);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
for (i = 1:3:(length(nuevosPicos)-1))
	tiemposNuevosPicos = ejeXsobreMuestreoVideo(nuevosPicos(i));
	sigTiemposNuevosPicos = ejeXsobreMuestreoVideo(nuevosPicos(i+2));
	plot([tiemposNuevosPicos, sigTiemposNuevosPicos], [umbral_value_2, umbral_value_2], '-.b');
endfor
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'or');
plot(ejeXsobreMuestreoVideo(nuevosPicos),respuestaSobreMuestreo(nuevosPicos)/max(respuestaSobreMuestreo), 'ob');
plot(ejeXsobreMuestreoVideo(picos2),respuestaSobreMuestreo(picos2)/max(respuestaSobreMuestreo), 'ok');
xlim([1 30]);
title('Busqueda de picos con umbral 0.65%');

subplot(3,1,2);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'or');
plot(ejeXsobreMuestreoVideo(nuevosPicos),respuestaSobreMuestreo(nuevosPicos)/max(respuestaSobreMuestreo), 'ob');
plot(ejeXsobreMuestreoVideo(picos2),respuestaSobreMuestreo(picos2)/max(respuestaSobreMuestreo), 'ok');
for (i = 1:3:(length(nuevosPicos)-1))
	tiemposNuevosPicos = ejeXsobreMuestreoVideo(nuevosPicos(i));
	sigTiemposNuevosPicos = ejeXsobreMuestreoVideo(nuevosPicos(i+2));
	plot([tiemposNuevosPicos, sigTiemposNuevosPicos], [umbral_value_2, umbral_value_2], '-.b');
endfor
xlim([30 60]);

subplot(3,1,3);
plot(ejeXsobreMuestreoVideo, umbral, 'r');
hold on;
plot(ejeXsobreMuestreoVideo, respuestaSobreMuestreo/max(respuestaSobreMuestreo), 'g');
plot(ejeXsobreMuestreoVideo(picos),respuestaSobreMuestreo(picos)/max(respuestaSobreMuestreo), 'or');
plot(ejeXsobreMuestreoVideo(nuevosPicos),respuestaSobreMuestreo(nuevosPicos)/max(respuestaSobreMuestreo), 'ob');
plot(ejeXsobreMuestreoVideo(picos2),respuestaSobreMuestreo(picos2)/max(respuestaSobreMuestreo), 'ok');
for (i = 1:3:(length(nuevosPicos)-1))
	tiemposNuevosPicos = ejeXsobreMuestreoVideo(nuevosPicos(i));
	sigTiemposNuevosPicos = ejeXsobreMuestreoVideo(nuevosPicos(i+2));
	plot([tiemposNuevosPicos, sigTiemposNuevosPicos], [umbral_value_2, umbral_value_2], '-.b');
endfor
xlim([60 90]);

xlabel('t [s]');
print -djpg imagenes/punto_12_cardiometro.jpg; %Octave
grid minor;

for (i = 1:3:(length(picos2)))
	find(picos == picos2(i))
endfor

