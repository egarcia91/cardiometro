% Descripcion
% ===========
%
% Este script carga un archivo de video y guarda en un vector las muestras
% del audio extraido del video (se promedian canales para pasarlo a mono).
%
%   (C) Señales y Sistemas, FI-UBA, 2do cuat 2017.

clc
clearvars

% Path hasta el archivo de video
FileName = 'path\al\video\pletismografia.mp4';


%% Lectura de audio
[audio,fsa] = audioread(FileName);

% Promedio de canales para pasar de stereo a mono y sustraigo media
audio = mean(audio,2); audio = audio - mean(audio);

% Graficamos para verificar
t_audio = (0:length(audio)-1)/fsa;
figure,plot(t_audio,audio),grid on,xlabel 'Tiempo [s]',ylabel 'Intensidad'


%% Guardamos audio
filename_srt = [FileName(1:end-4),'_audio.mat'];
save(filename_srt,'audio','fsa')

fprintf('Se guardo el archivo %s.\n',filename_srt);

