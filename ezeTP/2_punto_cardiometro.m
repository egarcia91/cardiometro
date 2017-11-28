clear all;

load intensidad_RGB.mat; % brillo, 1 es R, 2 es G, 3 es B.

video_length = length(brillo);

frec_video = 29.37; %frecuencia muestreo video
t_video = 1/(frec_video); %tiempo muestreo video

ejeXvideo = 0 : t_video : ((video_length-1)*t_video);

figure;
subplot(4, 1, 1);
plot( ejeXvideo, brillo(:, 2), 'g');
ylabel('brillo');
xlim([1.5 20]);
ylim([-1e+07 1e+07]);
legend('18 pulsos');
legend boxoff;
%title('Senal Verde conteo de pulsos');

subplot(4, 1, 2);
plot( ejeXvideo, brillo(:, 2), 'g');
ylabel('brillo');
xlim([20 40]);
ylim([-1e+07 1e+07]);
legend('22 pulsos');
legend boxoff;
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');

subplot(4, 1, 3);
plot( ejeXvideo, brillo(:, 2), 'g');
ylabel('brillo');
xlim([40 60]);
ylim([-1e+07 1e+07]);
legend('28 pulsos');
legend boxoff;
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');

subplot(4, 1, 4);
plot( ejeXvideo, brillo(:, 2), 'g');
xlabel('t [s]');
ylabel('brillo');
xlim([60 80]);
ylim([-1e+07 1e+07]);
legend('32 pulsos');
legend boxoff;
%%legend('Curva simulada','Curva teorica','location','NorthEastOutside');
print -djpg imagenes/punto_2_G_zoom_cardiometro.jpg; %Octave
grid minor;

