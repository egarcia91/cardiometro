function Ej5()

[signal, FR] = mySignal();

[b, a] = filter4();

filteredSignal = filter(b, a, signal);

colCount = length(signal);
X = (0:1:(colCount-1))/FR;

plot(X, signal, 'g', X, filteredSignal, 'k')
title('Se�al del Canal Verde Original y Filtrada')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')
print('Ej5 - Se�al filtrada','-dpng')