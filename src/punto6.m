clc;
clear;
%----------------------Punto 6--------------------------

%Considerese x la señal original y X su transformada de Fourier

filename='modemDialing.wav';

[x,fs]=audioread(filename); %Se lee el audio%
periodo_muestreo=1/fs; %Se define el periodo de muestreo para el eje temporal%
cant_muestras=length(x); %Se define la cantidad de muestras para el eje temporal%
eje_tiempo=(0:cant_muestras-1)*periodo_muestreo; %El eje temporal%

X=fft(x); %Transformada de la señal de entrada
X_normalizado=X/max(abs(X)); %Transformada normalizada 
X_modulo=abs(X_normalizado); % Modulo de la transformada 
eje_frecuencia=linspace(0,fs,cant_muestras); %Se define el eje de 
                                             %frecuencias entre
                                             % -1 y 1 para una mejor
                                             % visualizacion
orden1=256;
orden2=2048;

ventana1=hamming(orden1);
ventana2=blackman(orden1);
nfft=orden1;
overlap=round(orden1/2); 

h1=figure(1);
subplot(2,2,[1 2]);
plot(eje_frecuencia,X_modulo);
xlabel('Frecuencia[Hz]');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 3000 0 1])
subplot(2,2,3); 
spectrogram(x,ventana2,overlap,nfft,fs,'yaxis');
title('Espectrograma');
subplot(2,2,4) 
spectrogram(x,ventana2,overlap,nfft,fs,'yaxis');
title('Zoom Discado');
saveas(h1,sprintf('punto6.png'))