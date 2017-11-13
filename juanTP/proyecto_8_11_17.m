clear all
close all
load('intensidad_RGB.mat');
load('audio_det.mat');
% Variables utilizadas
N_muestras=2636;
frec_muestreo=FR;
periodo_muestreo=1/frec_muestreo;
v_frame=1:1:N_muestras;
canal_utilizado=2;


%Comparaci?n de los tres canales RGB ESCALA LINEAL
figure(1);
    Ha = axes;
    
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    hold on
    plot(v_frame*periodo_muestreo, brillo(:,1),'-','Markersize',6,'linewidth',2,'color','r');
    plot(v_frame*periodo_muestreo,brillo(:,2),'-','Markersize',6,'linewidth',2,'color','g');
    plot(v_frame*periodo_muestreo,brillo(:,3),'-','Markersize',6,'linewidth',2,'color','b');
    grid minor;
    Hleg=legend('Red','Green','Blue','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Tiempo')
    ylabel('Intensidad')
    %axis([0 2636 -2*1E7 6*1E7])

%------------------------------------------------------------------------

%Comparaci?n de los tres canales RGB ESCALA LOGARITMICA
figure(2);
    Ha = axes;
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    brillo_ref_1=max(brillo(:,1));
    brillo_ref_2=max(brillo(:,2));
    brillo_ref_3=max(brillo(:,3));

    hold on
    plot(v_frame*periodo_muestreo,log(abs(brillo(:,1)/brillo_ref_1)),'-','Markersize',6,'linewidth',2,'color','r');
    plot(v_frame*periodo_muestreo,log(abs(brillo(:,2)/brillo_ref_2)),'-','Markersize',6,'linewidth',2,'color','g');
    plot(v_frame*periodo_muestreo,log(abs(brillo(:,3)/brillo_ref_3)),'-','Markersize',6,'linewidth',2,'color','b');
    grid minor;
    Hleg=legend('Red','Green','Blue','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Tiempo [s]')
    ylabel('Magnitud [dB]')
    %axis([0 2636 -2*1E7 6*1E7])

%------------------------------------------------------------------------

%DFT de la se?al brillo(:,2);

fft_canal=fft(brillo(:,canal_utilizado));
fft_canal_menos_pi_a_pi=fftshift(fft_canal);
eje_frec_normalizada=linspace(-pi,pi,length(fft_canal));
eje_frec_hz= eje_frec_normalizada*frec_muestreo/(2*pi);
figure(3);
    Ha = axes;
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    plot(eje_frec_hz,abs((fft_canal_menos_pi_a_pi)));
    grid minor;
    Hleg=legend('FFT del canal','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Frecuencia [Hz]')
    ylabel('Magnitud')
%-----------------------------------------------------------------------
%. Dise?ar un filtro pasa-banda tipo Butterworth con banda de paso entre 0.5 Hz y 10 Hz. 
% Graficar respuesta en frecuencia (m?dulo y fase), diagrama de polos y ceros y respuesta 
% al impulso (sugerencia: usar las funciones butter y fvtool de Matlab). 
% Que papel juega el orden del filtro seleccionado en su dise?o? 

n_order = 10; %debe sacar la componente de respiracion de alrededor de 0,3hz. 
Wn = [0.5 10]; %[Hz]
[b,a] = butter(n_order,Wn/(frec_muestreo/2));
fvtool(b,a);

%-----------------------------------------------------------------------
% Filtrar la se?al FPG utilizando el filtro dise?ado en el punto anterior 
% mediante la funci?n filter. Grafique en superposici?n la se?al original 
% con la filtrada y comente acerca de: a. Remoci?n de derivas b. 
% Cambios en la forma de la se?al c. Retardo de la se?al filtrada respecto 
% de la original 

canal_filtrado = filter(b,a,brillo(:,canal_utilizado));
fft_canal_filtrado=fft(canal_filtrado);
fft_canal_filtrado_menos_pi_a_pi=fftshift(fft_canal_filtrado);

figure(5)
    Ha = axes;
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    plot(eje_frec_hz,abs((fft_canal_filtrado_menos_pi_a_pi)));
    grid minor;
    Hleg=legend('FFT del canal filtrado','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Frecuencia [Hz]')
    ylabel('Intensidad')
    
figure(6)
    
    Ha = axes;
    hold on
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    plot(v_frame*periodo_muestreo,canal_filtrado,'-','Markersize',6,'linewidth',2,'color','b');
    plot(v_frame*periodo_muestreo, brillo(:,canal_utilizado),'-','Markersize',6,'linewidth',2,'color','r');
    grid minor;
    Hleg=legend('Canal filtrado','Canal original','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Tiempo [s]')
    ylabel('Intensidad')

%Implementar un filtrado IIR ida y vuelta para anular la fase del filtro (puede utilizar la funci?n filtfilt de Matlab). 
%Justificar te?ricamente el funcionamiento de este tipo de filtrado y cu?l resulta su ventaja. 
%Filtrar nuevamente la se?al FPG y comparar el resultado con lo obtenido en el punto anterior, 
%particularmente en la forma de la se?al y su retardo.

canal_filtrado_fase_cero = filtfilt(b,a,brillo(:,canal_utilizado));
fft_canal_filtrado_fase_cero=fft(canal_filtrado);
fft_canal_filtrado_menos_pi_a_pi_fase_cero=fftshift(fft_canal_filtrado_fase_cero);

figure(7)
    
    Ha = axes;
    hold on
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    %subplot(2,1,1)
    plot(v_frame*periodo_muestreo,canal_filtrado_fase_cero,'-','Markersize',6,'linewidth',2,'color','b');
    %subplot(2,1,2)
    plot(v_frame*periodo_muestreo,canal_filtrado,'-','Markersize',6,'linewidth',2,'color','r');
    grid minor;
    Hleg=legend('Canal filtrado con fase cero','Canal filtrado con funci?n FILTER','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Tiempo [s]')
    ylabel('Intensidad')

figure(8)
spectrogram(brillo(:,canal_utilizado),256,255,256,FR);
caxis auto
figure(9)
spectrogram(canal_filtrado_fase_cero,256,255,256,FR);
caxis auto

%-------------- Se?al de audio---------------------
frec_sampling_audio= fsa;
periodo_sampling_audio=1/fsa;
N_muestras_audio=4484;
v_frame_audio=1:1:4484;

figure(10);
    Ha = axes;
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    hold on
    plot(v_frame_audio*periodo_sampling_audio,xa_det,'-','Markersize',6,'linewidth',2,'color','r');
    grid minor;
    Hleg=legend('Canal de audio','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Tiempo')
    ylabel('Intensidad')

    
fft_canal_audio=fft(xa_det);
fft_canal_audio_pi_a_pi=fftshift(fft_canal_audio);
eje_frec_audio_normalizada=linspace(-pi,pi,length(fft_canal_audio));
eje_frec_audio_hz= eje_frec_audio_normalizada*frec_sampling_audio/(2*pi);

figure(11)
    Ha = axes;
    set(Ha,'Box','on','FontName','Arial','FontSize',11,'GridLineStyle','--','LineWidth',1,'TickDir','in');
    plot(eje_frec_audio_hz,abs((fft_canal_audio_pi_a_pi)));
    grid minor;
    Hleg=legend('FFT del canal filtrado','location','southeast');
    set(Hleg,'FontName','Arial','FontSize',10);
    xlabel('Frecuencia [Hz]')
    ylabel('Intensidad')
