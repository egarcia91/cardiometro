clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.
%load audio_det.mat;
%
video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(2*pi*frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 5, [0.5/frec_video , 10/frec_video]);

ida_vuelta = filtfilt(b, a, brillo(:,2));

filtrado = filter(b, a, brillo(:,2));

%frec_audio = 50; %frecuencia muestreo audio
%t_audio = 1/(2*pi*frec_audio); %tiempo muestreo audio
%
%
%ejeXaudio = 0 : t_video : 10;


%yts = specgram(brillo, 256, 1000, [], 200);

Fs = 1000;
step = ceil(20*Fs/1000);
window = ceil(100*Fs/1000);

figure;

subplot(2,1,1);
specgram(brillo(:,2), 2^nextpow2(window), Fs, window, window - step);

subplot(2,1,2);
specgram(ida_vuelta, 2^nextpow2(window), Fs, window, window - step);

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
print -djpg espectograma_cardiometro.jpg; %Octave
grid minor;
 
