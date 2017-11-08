clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 5, [0.5/frec_video , 10/frec_video]);

ida_vuelta = filtfilt(b, a, brillo(:,2));
filtrado = filter(b, a, brillo(:,2));

figure;
%subplot(3, 1, 1);
plot(ejeXvideo, brillo(:,2), 'g');
hold on;
%subplot(3, 1, 2);
plot(ejeXvideo, filtrado, 'b');
%subplot(3, 1, 3);
plot(ejeXvideo, ida_vuelta, 'k');
xlim([15  20]);
%%plot( ejeXvideo, brillo(:,2));
%xlabel('t [s]');
%ylabel('brillo [dB]');
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');
%title('Titulo');
print -djpg filtro_ida_vuelta_cardiometro.jpg; %Octave
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
 
