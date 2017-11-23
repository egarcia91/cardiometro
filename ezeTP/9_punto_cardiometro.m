clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load audio_det.mat;

frec_audio = fsa;
t_audio = 1/(2*pi*frec_audio); %tiempo muestreo audio
audio_length = length(xa_det);
N_muestras_audio = 4484;

v_frame_audio = 1: t_audio : ((audio_length-1)*t_audio);

%yts = specgram(brillo, 256, 1000, [], 200);

large = 512;
window = hamming(large);

figure;

specgram(xa_det, 2^nextpow2(large), frec_audio, window, large-1);
ylim([0  8]);
title('Espectrograma Audio');

print -djpg imagenes/punto_9_espectograma_cardiometro.jpg; %Octave
grid minor;
 
