function Ej1()

load('../TPSyS2017-2c-ARCHIVOS/intensidad_RGB.mat');
colCount = size(brillo, 1);

X = (0:1:(colCount-1))/FR;
plot(X, brillo(:, 1), 'r', X, brillo(:, 2), 'g', X, brillo(:, 3), 'b');

title('Intensidad de la señal RGB')
xlabel('Tiempo [s]')
ylabel('Intensidad [???]')

print('Ej1 - IntensidadRGB','-dpng')