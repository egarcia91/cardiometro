function Ej3()

[signal, FR] = mySignal();

colCount = length(signal);

X = (-colCount/2:colCount/2-1)*(FR/colCount);
stem(X, abs(fftshift(fft(signal))));
title('DFT de la señal del Canal Verde')
xlabel('Frecuencia [Hz]')
ylabel('|X(k)|')
print('Ej3 - DFT','-dpng')