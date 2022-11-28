clc;
clear;

%-------------------------------Punto 3-----------------------------

filename='modemDialing.wav';
[x,fs]=audioread(filename); %Se lee el audio%

Ts=1/fs; %Se define el periodo de muestreo para el eje temporal%
cant_muestras=length(x); %Se define la cantidad de muestras para el eje temporal%
t=(0:cant_muestras-1)*Ts; %El eje temporal%
eje_frecuencia=linspace(0,2,cant_muestras); %Se define el eje de frecuencias en Omegon
%--------------Espectros---------------
%Señal util
X=fft(x);
X_normalizado=X/max(abs(X));
X_modulo=abs(X_normalizado);
cant_muestras_x=length(x);
w=linspace(0,fs,cant_muestras_x);

%Tonos presentes en la señal util



%Tono 1

x1=x(t > 3.3 & t<3.5);
eje_x1=t(t > 3.3 & t<3.5);
X1=fft(x1);
X1_normalizado=X1/max(abs(X1));
X1_modulo=abs(X1_normalizado);
cant_muestras_x1=length(x1);
w1=linspace(0,fs,cant_muestras_x1);
eje_frecuencia1=linspace(0,2,cant_muestras_x1);
%Tono 2

x2=x(t > 3.5 & t<3.6);
eje_x2=t(t > 3.5 & t<3.6);
X2=fft(x2);
X2_normalizado=X2/max(abs(X2));
X2_modulo=abs(X2_normalizado);
cant_muestras_x2=length(x2);
w2=linspace(0,fs,cant_muestras_x2);
eje_frecuencia2=linspace(0,2,cant_muestras_x2);

%Tono 3

x3=x(t > 3.65 & t<3.8);
eje_x3=t(t > 3.65 & t<3.8);
X3=fft(x3);
X3_normalizado=X3/max(abs(X3));
X3_modulo=abs(X3_normalizado);
cant_muestras_x3=length(x3);
w3=linspace(0,fs,cant_muestras_x3);
eje_frecuencia3=linspace(0,2,cant_muestras_x3);

%Tono 4
x4=x(t > 3.81 & t<3.95);
eje_x4=t(t > 3.81 & t<3.95);
X4=fft(x4);
X4_normalizado=X4/max(abs(X4));
X4_modulo=abs(X4_normalizado);
cant_muestras_x4=length(x4);
w4=linspace(0,fs,cant_muestras_x4);
eje_frecuencia4=linspace(0,2,cant_muestras_x4);

%Tono 5 

x5=x(t > 3.96 & t<4.1);
eje_x5=t(t > 3.96 & t<4.1);
X5=fft(x5);
X5_normalizado=X5/max(abs(X5));
X5_modulo=abs(X5_normalizado);
cant_muestras_x5=length(x5);
w5=linspace(0,fs,cant_muestras_x5);
eje_frecuencia5=linspace(0,2,cant_muestras_x5);

%Grafico de cada señal con su respectivo espectro


h1=figure(1);
subplot(2,2,[1 2]);
plot(t,x);
xlabel('Tiempo[s]');
ylabel('Amplitud');
grid on;
grid minor;
subplot(2,2,3);
plot(w,X_modulo);
grid on;
grid minor;
xlabel('Frecuencia[Hz]');
ylabel('Amplitud normalizada');
axis([0 3000 0 2 ]);
subplot(2,2,4);
plot(eje_frecuencia,X_modulo);
xlabel('Frecuencia \pi x (rad/seg)');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 1 0 2 ]);
saveas(h1,sprintf('punto3_discado_completo_sye.png'));

h2=figure(2);
subplot(2,2,[1 2]);
plot(eje_x1,x1);
xlabel('Tiempo[s]');
ylabel('Amplitud');
grid on;
grid minor;
subplot(2,2,3);
plot(w1,X1_modulo);
xlabel('Frecuencia[Hz]');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 3000 0 2 ]);
subplot(2,2,4);
plot(eje_frecuencia1,X1_modulo);
xlabel('Frecuencia \pi x (rad/seg)');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 1 0 2 ]);
saveas(h2,sprintf('punto3_tono1.png'));

h3=figure(3);
subplot(2,2,[1 2]);
plot(eje_x2,x2);
xlabel('Tiempo[s]');
ylabel('Amplitud');
grid on;
grid minor;
subplot(2,2,3);
plot(w2,X2_modulo);
xlabel('Frecuencia[Hz]');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 3000 0 2 ]);
subplot(2,2,4);
plot(eje_frecuencia2,X2_modulo);
xlabel('Frecuencia \pi x (rad/seg)');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 1 0 2 ]);
saveas(h3,sprintf('punto3_tono2.png'));

h4=figure(4);
subplot(2,2,[1 2]);
plot(eje_x3,x3);
xlabel('Tiempo[s]');
ylabel('Amplitud');
grid on;
grid minor;
subplot(2,2,3);
plot(w3,X3_modulo);
xlabel('Frecuencia[Hz]');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 3000 0 2 ]);
subplot(2,2,4);
plot(eje_frecuencia3,X3_modulo);
xlabel('Frecuencia \pi x (rad/seg)');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 1 0 2 ]);
saveas(h4,sprintf('punto3_tono3.png'));

h5=figure(5);
subplot(2,2,[1 2]);
plot(eje_x4,x4);
xlabel('Tiempo[s]');
ylabel('Amplitud');
grid on;
grid minor;
subplot(2,2,3);
plot(w4,X4_modulo);
xlabel('Frecuencia[Hz]');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 3000 0 2 ]);
subplot(2,2,4);
plot(eje_frecuencia4,X4_modulo);
xlabel('Frecuencia \pi x (rad/seg)');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 1 0 2 ]);
saveas(h5,sprintf('punto3_tono4.png'));

h6=figure(6);
subplot(2,2,[1 2]);
plot(eje_x5,x5);
xlabel('Tiempo[s]');
ylabel('Amplitud');
grid on;
grid minor;
subplot(2,2,3);
plot(w5,X5_modulo);
xlabel('Frecuencia[Hz]');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 3000 0 2 ]);
subplot(2,2,4);
plot(eje_frecuencia5,X5_modulo);
xlabel('Frecuencia \pi x (rad/seg)');
ylabel('Amplitud normalizada');
grid on;
grid minor;
axis([0 1 0 2 ]);
saveas(h6,sprintf('punto3_tono5.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Realizacion  del espectrograma con distintas ventanas
orden1=256;
orden2=2048;

ventana1=hamming(orden1);
ventana2=blackman(orden1);
nfft=orden1;
overlap=round(orden1/2); 

h7=figure(7);
subplot(2,1,1);
spectrogram(x,ventana1,overlap,nfft,fs,'yaxis');
title('Espectrograma con ventana de Hamming');
subplot(2,1,2);
spectrogram(x,ventana2,overlap,nfft,fs,'yaxis');
title('Espectrograma con ventana de Blackman');
saveas(h7,sprintf('punto3_espectrograma_265.png'))