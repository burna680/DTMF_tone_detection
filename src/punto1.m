clc;
clear;

%-------------------------- Punto 1 -------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Señal Original% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename='modemDialing.wav';
[audio_muestreado,frecuencia_muestreo]=audioread(filename); %Se lee el audio%

periodo_muestreo=1/frecuencia_muestreo; %Se define el periodo de muestreo para el eje temporal%

cant_muestras=length(audio_muestreado); %Se define la cantidad de muestras para el eje temporal%

eje_tiempo=(0:cant_muestras-1)*periodo_muestreo; %El eje temporal%

figure (1);

plot(eje_tiempo,audio_muestreado); %Grafico del audio original%

xlabel('Tiempo [s]');
ylabel('Señal de audio original');
grid on;
grid minor;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Señal Util %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);

audio_util=audio_muestreado(eje_tiempo> 3.3 & eje_tiempo<4.1);
eje_tiempo_util_2=eje_tiempo(eje_tiempo> 3.3 & eje_tiempo<4.1);
plot(eje_tiempo_util_2,audio_util);
xlabel('Tiempo [s]');
ylabel('Señal de audio util');
grid on;
grid minor;
