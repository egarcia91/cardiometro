clear all;

pkg load control;
addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

%Diagrama polos y ceros
figure;
pzmap(tf(b,a));
print -djpg imagenes/punto_4_diagrama_polos_ceros_cardiometro.jpg; %Octave
grid minor;

%Disenia el filtro para una senial compuesta por un uno y todo los demas ceros escalado por Fs
figure;
freqz(b, a, 512, "half", frec_video);
print -djpg imagenes/punto_4_diagrama_filtro_cardiometro.jpg; %Octave
grid minor;

impulso = zeros(1,240);
impulso(1) = 1;

respuestaImpulso = filter(b, a, impulso);
respuestaImpulso(video_length) = 0;

figure;
plot( ejeXvideo, respuestaImpulso, 'b');
xlabel('t [s]');
ylabel('brillo');
xlim([0 1]);
title('Respuesta al Impulso');
ylim([-0.6 0.6]);
print -djpg imagenes/punto_4_respuesta_impulso_cardiometro.jpg; %Octave
grid minor;

%f = linspace(-frec_video/2, frec_video/2, video_length);
%
%DFT_respuestaImpulso = 20*log(fftshift(abs(fft(respuestaImpulso))));
%
%figure;
%
%plot( f, DFT_respuestaImpulso, 'b');
%xlabel('f [Hz]');
%ylabel('Modulo [dB]');
%title('FFT del filtro');
%
%print -djpg imagenes/punto_4_respuesta_frec_cardiometro.jpg; %Octave
%grid minor;


