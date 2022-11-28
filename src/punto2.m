clc;
clear;
%-------------------------- Punto 2 -------------------------------------%
%%%%%%%%%%%%%%%%%%%%%% Generacion de tono de pueba %%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=0:0.0001:1;
sen_1200Hz=sin(1200*2*pi*t);
sen_800Hz=sin(800*2*pi*t);
suma_1200Hz_800Hz=sen_1200Hz+sen_800Hz;
%sound(suma_1200Hz_800Hz);

%%%%%%%%%%%  Generar los coeficientes de Fourier %%%%%%%%%%%%%%%%%%%%%%%
w = -8000:8000; %Se define el eje de frecuencias (en Hz) de manera que 
                %abarque todos los coeficientes de Fourier

%Coeficientes para la senoidal de 1200Hz 

[coef_fourier_sen_1200] = coef_fourier_senoidales(1200,w);


%Coeficientes para la senoidal de 800Hz 

[coef_fourier_sen_800] = coef_fourier_senoidales(800,w);

%Grafico resultante
h1=figure(1);
plot(w,coef_fourier_sen_1200,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_fourier_sen_800,'Color','k','LineWidth', 1);
grid on;
grid minor;
xlabel('Frecuencia [Hz]');
ylabel('Coeficientes de Fourier');
axis([0 1500 0 1]);
title('Distribucion de coeficientes para el tono de prueba');
saveas(h1,sprintf('punto2_distr_tono_prueba.png'));

%Coeficientes para las 16 combinaciones posibles de las frecuencias DTMF

%-----------Coeficientes para la senoidal de 800Hz----------------------

frecuencias=[697,770,852.941,1209,1336,1477,1633];


[coef_fourier_sen_697] = coef_fourier_senoidales(697,w);
[coef_fourier_sen_770] = coef_fourier_senoidales(770,w);
[coef_fourier_sen_852] = coef_fourier_senoidales(852,w);   
[coef_fourier_sen_941] = coef_fourier_senoidales(941,w);
[coef_fourier_sen_1209] = coef_fourier_senoidales(1209,w);
[coef_fourier_sen_1336] = coef_fourier_senoidales(1336,w);
[coef_fourier_sen_1477] = coef_fourier_senoidales(1477,w);
[coef_fourier_sen_1633] = coef_fourier_senoidales(1633,w);

coef_tono_1=coef_fourier_sen_697+coef_fourier_sen_1209;
coef_tono_2=coef_fourier_sen_697+coef_fourier_sen_1336;
coef_tono_3=coef_fourier_sen_697+coef_fourier_sen_1477;
coef_tono_A=coef_fourier_sen_697+coef_fourier_sen_1633;
coef_tono_4=coef_fourier_sen_770+coef_fourier_sen_1209;
coef_tono_5=coef_fourier_sen_770+coef_fourier_sen_1336;
coef_tono_6=coef_fourier_sen_770+coef_fourier_sen_1477;
coef_tono_B=coef_fourier_sen_770+coef_fourier_sen_1633;
coef_tono_7=coef_fourier_sen_852+coef_fourier_sen_1209;
coef_tono_8=coef_fourier_sen_852+coef_fourier_sen_1336;
coef_tono_9=coef_fourier_sen_852+coef_fourier_sen_1477;
coef_tono_C=coef_fourier_sen_852+coef_fourier_sen_1633;
coef_tono_asterisco=coef_fourier_sen_941+coef_fourier_sen_1209;
coef_tono_0=coef_fourier_sen_941+coef_fourier_sen_1336;
coef_tono_numeral=coef_fourier_sen_941+coef_fourier_sen_1477;
coef_tono_D=coef_fourier_sen_941+coef_fourier_sen_1633;

h2=figure(4);

plot(w,coef_tono_1,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_2,'Color','k','LineWidth', 1);
hold on;
plot(w,coef_tono_3,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_4,'Color','k','LineWidth', 1);
hold on;
plot(w,coef_tono_5,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_6,'Color','k','LineWidth', 1);
hold on;
plot(w,coef_tono_7,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_8,'Color','k','LineWidth', 1);
hold on;
plot(w,coef_tono_9,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_asterisco,'Color','k','LineWidth', 1);
hold on;
plot(w,coef_tono_0,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_numeral,'Color','k','LineWidth', 1);
hold on;
plot(w,coef_tono_A,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_B,'Color','k','LineWidth', 1);
hold on;
plot(w,coef_tono_C,'Color','b','LineWidth', 1);
hold on;
plot(w,coef_tono_D,'Color','k','LineWidth', 1);

xlabel('Frecuencia [Hz]');
ylabel('Coeficientes de Fourier');
grid on;
grid minor;
axis([0 2000 0 1]);
title('Distribucion de coeficientes para los 16 tonos');
saveas(h2,sprintf('punto2_distr_tonos.png'));