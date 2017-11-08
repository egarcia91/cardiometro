clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.
%load audio_det.mat;
%
%video_length = length(brillo);
%
%frec_video = 29.37; %frecuencia muestreo video
%t_video = 1/(2*pi*frec_video); %tiempo muestreo video
%
%frec_audio = 50; %frecuencia muestreo audio
%t_audio = 1/(2*pi*frec_audio); %tiempo muestreo audio
%
%ejeXvideo = 0 : t_video : ((video_length-1)*t_video);
%
%ejeXaudio = 0 : t_video : 10;

%printf('hola\n');

%yts = specgram(brillo, 256, 1000, [], 200);

x = chirp([0:0.001:2],0,2,500);
length(x)
length(brillo(:,1))
Fs = 1000;
step = ceil(20*Fs/1000);
window = ceil(100*Fs/1000);
%yts = specgram(x, 2^nextpow2(window), Fs, window, window - step);

figure;

specgram(brillo(:,3), 2^nextpow2(window), Fs, window, window - step);

%%semilogy(5:25,PeDig,'b');
%%ylim([10^-6  1]);
%%hold on;
%%semilogy(5:25,PeDigTeorica,'k');
%%ylim([10^-6  1]);
%%plot( ejeXvideo, brillo);
%%plot( ejeXvideo, brillo(:,2));
%xlabel('t [s]');
%ylabel('brillo [dB]');
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');
%title('Titulo');
print -djpg imagen_cardiometro.jpg; %Octave
%grid minor;
 
