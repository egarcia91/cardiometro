clear all;

addpath('/usr/share/octave/packages/signal-1.3.2'); %incluye el specgram

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

[b, a] = butter( 4, [0.4*2/frec_video , 10*2/frec_video]); %FiltroPincripal

ida_vuelta = filtfilt(b, a, brillo(:,2));
filtrado = filter(b, a, brillo(:,2));

figure;

subplot(3, 1, 1);

plot(ejeXvideo, brillo(:,2), 'g');
ylabel('brillo');
hold on;
%subplot(3, 1, 2);
plot(ejeXvideo, filtrado, 'b');
%subplot(3, 1, 3);
plot(ejeXvideo, ida_vuelta, 'k');
xlim([2 30]);
ylim([-1e+07 1e+07]);

title('Superposicion');
legend({'Original','Filtrada','Ida y Vuelta'},'location','northeast');
legend boxoff;

subplot(3, 1, 2);
plot(ejeXvideo, brillo(:,2), 'g');
ylabel('brillo');
hold on;
%subplot(3, 1, 2);
plot(ejeXvideo, filtrado, 'b');
%subplot(3, 1, 3);
plot(ejeXvideo, ida_vuelta, 'k');
xlim([30 60]);
ylim([-1e+07 1e+07]);

subplot(3, 1, 3);
plot(ejeXvideo, brillo(:,2), 'g');
hold on;
%subplot(3, 1, 2);
plot(ejeXvideo, filtrado, 'b');
%subplot(3, 1, 3);
plot(ejeXvideo, ida_vuelta, 'k');
xlim([60 90]);
ylim([-1e+07 1e+07]);
%%plot( ejeXvideo, brillo(:,2));
xlabel('t [s]');
ylabel('brillo');
print -djpg imagenes/punto_7_filtro_ida_vuelta_cardiometro.jpg; %Octave
grid minor;
