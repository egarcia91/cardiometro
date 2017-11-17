%% EJERCICIO 1 %%
clc;
close all;
Fs=FR;
Ts=1/Fs;
long_brillo=length(brillo);
t=1:1:long_brillo;

figure(1);
subplot(4,1,1);
plot(t*Ts,brillo(:,1),'r');
hold on;
plot(t*Ts,brillo(:,2),'g');
hold on;
plot(t*Ts,brillo(:,3),'b');
title('Señal "RGB proporcionada"');
ylabel('Intensidad');
subplot(4,1,2);
plot(t*Ts,brillo(:,1),'r');
title('Señal "R"');
ylabel('Intensidad');
subplot(4,1,3);
plot(t*Ts,brillo(:,2),'g');
title('Señal "G"');
ylabel('Intensidad');
subplot(4,1,4);
plot(t*Ts,brillo(:,3),'b');
title('Señal "B"');
xlabel('Tiempo [s]');
ylabel('Intensidad');

senal_verde=brillo(:,2);
figure(2) %señal elegida 
plot(t*Ts,senal_verde,'g'); 
xlabel('Tiempo [s]');
title('Señal "G" seleccionada');
ylabel('Intensidad');

%% EJERCICIO 2 %%

figure(3)
subplot(4,1,1);
plot(t*Ts,senal_verde,'g');
ylabel('Intensidad');
title('senal "G" fraccionada en cuatro partes');
xlim([2 24]);
subplot(4,1,2);
plot(t*Ts,senal_verde,'g');
ylabel('Intensidad');
xlim([24 46]);
subplot(4,1,3);
plot(t*Ts,senal_verde,'g');
ylabel('Intensidad');
xlim([46 68]);
subplot(4,1,4);
plot(t*Ts,senal_verde,'g');
xlabel('Tiempo [s]');
ylabel('Intensidad');
xlim([68 90]);

%%(LPM) cantidad de latidos en un minuto%%
figure(4)
[valor_pico, localizacion_pico] = findpeaks(senal_verde,Fs); %guardo los valores donde se localizan los picos
subplot(2,1,1);
findpeaks(senal_verde,Fs);
xlabel('Tiempo [s]');
ylabel('Intensidad');
title('LPM (Pulsaciones Por Minuto)');
legend('65 pulsos en un minuto');
xlim([2 60]);
ylim([-1e7 1e7]);
%%cantidad de latidos de los 60 a los 90 segundos%%
subplot(2,1,2);
findpeaks(senal_verde,Fs);
xlabel('Tiempo [s]');
ylabel('Intensidad');
title('Pulsaciones en medio minuto)');
legend('47 pulsos en medio minuto');
xlim([60 90]);
ylim([-1e7 1e7]);

%% EJERCICIO 3 %%
%DFT de la señal verde
DFT_senal_verde = fftshift(abs(fft(senal_verde)));
figure(5)
% subplot(2,1,1);
plot(linspace(-Fs/2,Fs/2,long_brillo), DFT_senal_verde,'g');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad [modulo]');
title('DFT de la señal "G"');

%% EJERCICIO 4 %%
%Utilizacion de un filtro pasabanda entre 0.5Hz y 10Hz del tipo butterworth
%chequeo el filtro y entre los 0.5hz y los 10hz caen 3dB por lo que estaria
%filtrando correctamente

orden_filtro= 4;
[b, a] = butter(orden_filtro, [0.4 10]/(Fs/2)); %b son los polos y a los zeros del filtro
fvtool(b,a);
%Respuesta en frecuencia al filtro
% freqz(b, a, 512, 'whole',Fs);

%% EJERCICIO 5 %%
figure(7)
senal_verde_filtrada = filter(b,a,senal_verde);
plot(t*Ts,senal_verde_filtrada,'b');
hold on;
plot(t*Ts,senal_verde,'g');
legend('Señal Filtrada','Señal Original sin Filtrar');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad');
title('Señal Original y Filtrada');

figure(8) 
%grafiqué la dft para chequear que haya filtrado bien correctamente,
%despues de los 10Hz hay algunos armonicos, y antes de los 0.5Hz tambien,
%pero son muy pequeños
DFT_senal_verde_filtrada = fftshift(abs(fft(senal_verde_filtrada)));
plot(linspace(-Fs/2,Fs/2,long_brillo), DFT_senal_verde_filtrada,'g');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad [modulo]');
title('DFT de la señal "G" Filtrada');

%% EJERCICIO 7 %%
%FILTRADO

ida_vuelta = filtfilt(b, a,senal_verde);
%fvtool(b,a);

figure(10)
subplot(2,1,1);
plot(t*Ts,senal_verde,'g');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad]');
hold on;
plot(t*Ts,senal_verde_filtrada,'b');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad');
legend('Señal verde original','Señal verde filtrada');
xlim([2 90]);
subplot(2,1,2);
plot(t*Ts,senal_verde,'g');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad');
hold on;
plot(t*Ts,ida_vuelta,'r');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad');
legend('Señal verde original','ida y vuelta');
xlim([2 90]);

%Grafico la DFT de la señal ida_vuelta
figure(11)
DFT = fftshift(abs(fft(ida_vuelta)));
plot(linspace(-Fs/2,Fs/2,long_brillo),DFT,'g');
xlabel('Frecuencia [Hz]');
ylabel('Intensidad [modulo]');
title('DFT de la señal con fase cero ');

%% EJERCICIO 8 %%

tamano_ventana=floor(long_brillo/12); %funcion floor redondea el numero
overlap_ventana=floor(tamano_ventana*0.95); %considero un 95% de overlap
freq_scale=max(256,2^nextpow2(tamano_ventana)); %busco el exponente de 2 mas cercano para mejorar la dft

figure(12)
spectrogram(senal_verde,tamano_ventana,overlap_ventana,freq_scale,Fs,'yaxis');
title('Espectrograma antes de filtrar');
figure(13)
spectrogram(ida_vuelta,tamano_ventana,overlap_ventana,freq_scale,Fs,'yaxis');
title('Espectrograma despues de filtrar');

%% EJERCICIO 9 %%
Fs_audio=fsa;
Ts_audio=1/Fs_audio;
long_audio=length(xa_det); %tiene 4484 muestras
t_audio=1:1:long_audio;

figure(14)
spectrogram(xa_det,tamano_ventana,overlap_ventana,freq_scale,Fs,'yaxis');
title('Espectrograma del audio');
% plot(t_audio*Ts_audio,xa_det);
% title('Señal de Audio');
% xlabel('Tiempo [s]')
% ylabel('Intensidad')

% figure(15)
% DFT_audio = fftshift(abs(fft(xa_det)));
% plot(linspace(-Fs_audio/2,Fs_audio/2,long_audio), DFT_audio,'g');
% xlabel('Frecuencia [Hz]');
% ylabel('Intensidad [modulo]');
% title('DFT de la señal de audio ');

%% EJERCICIO 10 %%
%A)Filtrado pasa-banda de la señal, utilizando el filtrado del ejercicio 7.
% ida_vuelta es la señal filtrada con filtfilt, ya fue creada previamente
%B)Filtro de derivada, implementado con un filtro FIR h(n)=[-2 -1 0 1 2].
hn=[-2 -1 0 1 2];
% filtrado = filter(h(n), 1, ida_vuelta);
filtro_derivada=filter(hn,1,ida_vuelta);
%C)Normalización con energía instantánea
length_Ma=12;
ma=ones(1,length_Ma)./(length_Ma); %Moving Average
energia_promedio=filtfilt(ma,1,ida_vuelta.^2);
FiltMovingAverage=filtro_derivada./sqrt(energia_promedio);%para que esten en las mismas unidades de la señal


%D)Sobre-muestreo en un factor 4 + interpolador

senal_obtenida=interp(FiltMovingAverage,4);

% -----------------------------------------------
umbral_value=0.50; %umbral elegido a partir de ver la figura(15)
umbral=ones(1,long_brillo)*umbral_value; %para hacer una linea que marque el umbral elegido


figure(15)
subplot(3,1,1);
plot(t*Ts,(FiltMovingAverage)/max(FiltMovingAverage),'b'); %use /max(),ya que si no lo usaba el umbral quedaba por debajo de lo necesitado
title('Señal Filtrada, con Moving Average');
hold on;
plot(t*Ts,umbral,'r');
legend('Filtro Moving Average','Umbral elegido');
xlim([3 30]);
subplot(3,1,2);
plot(t*Ts,(FiltMovingAverage)/max(FiltMovingAverage),'b'); %use /max(),ya que si no lo usaba el umbral quedaba por debajo de lo necesitado
hold on;
plot(t*Ts,umbral,'r');
legend('Filtro Moving Average','Umbral elegido');
xlim([30 60]);
subplot(3,1,3);
plot(t*Ts,(FiltMovingAverage)/max(FiltMovingAverage),'b'); %use /max(),ya que si no lo usaba el umbral quedaba por debajo de lo necesitado
hold on;
plot(t*Ts,umbral,'r');
legend('Filtro Moving Average','Umbral elegido');
xlim([60 90]);
xlabel('Tiempo [s]');
% plotyy(t*Ts,ida_vuelta,t*Ts,FiltMovingAverage);
% xlabel('Tiempo [s]');
% ylabel('Intensidad');
% legend('ida_vuelta','salida');
% xlim([3 90]);






