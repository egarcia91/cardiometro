% Descripcion
% ===========
%
% Este script carga un archivo de video y guarda en una matriz de 3
% columnas la intensidad total de cada color (R,G,B) para cada frame. 
% La intensidad total es la suma del valor de todos los pixeles de un 
% color dado, para un frame dado.
%
%   (C) Señales y Sistemas, FI-UBA, 2do cuat 2017.

clc
%clearvars
clear all;
%pkg install -forge video;

% Path hasta el archivo de video
FileName = 'dedo.mp4';


%% Lectura de frames de video
%videoObj = VideoReader(FileName);
FR = 29.37;
%T = videoObj.Duration;
%N = floor(FR*T);
%N = 2054;
N = 765;

intensidad = zeros(N,3);  % cada columna tiene un color (R,G,B), cada fila un frame
for(i = 1 : N)
	imageNumber = strcat('0000',num2str(i*3-2));
	len = length(imageNumber); 

	if(len > 5)
		imageNumber(1:len-5) = [];
	endif

	files = strcat('./imagesDedo/scene',imageNumber,'.png');
	aux = imread(files);

	intensidad(i,1) = squeeze(sum(sum(aux(:,:,1))));
	intensidad(i,2) = squeeze(sum(sum(aux(:,:,2))));
	intensidad(i,3) = squeeze(sum(sum(aux(:,:,3))));

	if ~mod(i,200)
		fprintf('%d de %d\n',i,N)
	end
endfor

%tic
%intensidad = zeros(N,3);  % cada columna tiene un color (R,G,B), cada fila un frame
%for k=1:N
%    aux = double(readFrame(videoObj));
%    intensidad(k,1) = squeeze(sum(sum(aux(:,:,1))));
%    intensidad(k,2) = squeeze(sum(sum(aux(:,:,2))));
%    intensidad(k,3) = squeeze(sum(sum(aux(:,:,3))));
%    if ~mod(k,200)
%        fprintf('%d de %d\n',k,N)
%    end
%end
%toc
%
% Sustraemos el promedio de cada color y normalizamos entre 0 y 1
intensidad = bsxfun(@minus,intensidad,mean(intensidad));
intensidad = intensidad/(255*size(aux,1)*size(aux,2));

% Graficamos los 3 canales para verificar
t_intensidad = (0:size(intensidad,1)-1)/FR;
figure,plot(t_intensidad,intensidad(:,1),'r'),grid on,hold on,xlabel 'Tiempo [s]',ylabel 'Intensidad normalizada'
plot(t_intensidad,intensidad(:,2),'g'),plot(t_intensidad,intensidad(:,3),'b'),legend('R','G','B')


%% Guardamos matriz de intensidad y frecuencia de muestreo
% intensidad: matriz con intensidad normalizada para cada frame y color
% FR: frecuencia de muestreo del video (la separacion temporal entre frames
% o filas de la matriz es es 1/FR)

filename_srt = [FileName(1:end-4),'_RGB.mat'];
save(filename_srt,'intensidad','FR')

fprintf('Se guardo el archivo %s.\n',filename_srt);

