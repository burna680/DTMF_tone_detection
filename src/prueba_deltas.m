%--------Generar los coeficientes de Fourier-------------%
w = -1500:1500; %Se define el eje de frecuencias (en Hz) de manera que 
                %abarque todos los coeficientes de Fourier

%Coeficientes para la senoidal de 1200Hz 

delta_1200= dirac(w-1200); 
delta_neg_1200= dirac(w+1200);
iddelta_1200 = delta_1200 == Inf;
delta_1200(iddelta_1200) = 1;
iddelta_neg_1200= delta_neg_1200 == Inf;
delta_neg_1200(iddelta_neg_1200) = -1;
coef__fourier_sen_1200=delta_1200+delta_neg_1200;

%Coeficientes para la senoidal de 800Hz 

delta_800= dirac(w-800); 
delta_neg_800= dirac(w+800);
iddelta_800 = delta_800 == Inf;
delta_800(iddelta_800) = 1;
iddelta_neg_800= delta_neg_800 == Inf;
delta_neg_800(iddelta_neg_800) = -1;

coef__fourier_sen_800=delta_800+delta_neg_800;

%Grafico resultante
plot(w,coef__fourier_sen_1200,w,coef__fourier_sen_800);

axis([-1300 1300 -3 3]);
