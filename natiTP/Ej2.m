% Consultar!!!!!
function Ej2()

[signal, FR] = mySignal();

[pks, loc] = findpeaks(signal - min(signal), 'MinPeakHeight', 100, 'MinPeakDistance', 13);

colCount = length(signal);
X = (0:1:(colCount-1))/FR;

figure;
plot(X, signal, 'g', X(loc), signal(loc), '.m');
title('Intensidad de la señal del Canal Verde')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')
xlim([0 30]);
ylim([-1e+07 1e+07]);
print('Ej2 - LPM 0-30seg','-dpng')

figure;
plot(X, signal, 'g', X(loc), signal(loc), '.m');
title('Intensidad de la señal del Canal Verde')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')
xlim([30 60]);
ylim([-1e+07 1e+07]);
print('Ej2 - LPM 30-60seg','-dpng')

figure;
plot(X, signal, 'g', X(loc), signal(loc), '.m');
title('Intensidad de la señal del Canal Verde')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')
xlim([60 90]);
ylim([-1e+07 1e+07]);
print('Ej2 - LPM 60-90seg','-dpng')

%%----------------------------------------
figure;
plot(X, signal, 'g', X(loc), signal(loc), '.m');
title('Intensidad de la señal del Canal Verde')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')
xlim([0 20]);
ylim([-1e+07 1e+07]);
print('Ej2 - LPM 0-20seg','-dpng')

figure;
plot(X, signal, 'g', X(loc), signal(loc), '.m');
title('Intensidad de la señal del Canal Verde')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')
xlim([20 40]);
ylim([-1e+07 1e+07]);
print('Ej2 - LPM 20-40seg','-dpng')

figure;
plot(X, signal, 'g', X(loc), signal(loc), '.m');
title('Intensidad de la señal del Canal Verde')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')
xlim([40 60]);
ylim([-1e+07 1e+07]);
print('Ej2 - LPM 40-60seg','-dpng')