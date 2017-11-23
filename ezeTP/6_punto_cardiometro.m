clear all;

pkg load control;
addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

%Disenia el filtro para una senial compuesta por un uno y todo los demas ceros escalado por Fs
[h, f] = freqz(b, a, 512, "half", frec_video);

degreePhase = angle(h)*180/pi;

rotacion = find(diff(degreePhase > 0) == 1);

final = zeros(1,length(degreePhase));
final(1:rotacion(1)) = degreePhase(1:rotacion(1)).+360;
final(rotacion(1)+1:rotacion(2)) = degreePhase(rotacion(1)+1:rotacion(2));
final(rotacion(2)+1:end) = degreePhase(rotacion(2)+1:end).-360;

cursor1 = zeros(1,length(f)-1).+0.4;

f = f(1:end-1);
figure;
plot(f,diff(final)*-1,'b');
hold on;
plot(f, cursor1,'-.b');
xlabel('f[Hz]');
ylabel('Retardo');
xlim([0 15]);
title('Retardo fase filtro');
print -djpg imagenes/punto_6_fase_cardiometro.jpg; %Octave
grid minor;

