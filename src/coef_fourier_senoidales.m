function [coef_fourier_sen_frecuencia] = coef_fourier_senoidales( frecuencia, w)
%w es el rango de frecuencias que se debe considerar

delta_frecuencia= dirac(w-frecuencia); 
delta_neg_frecuencia= dirac(w+frecuencia);
%Dado que la delta tiene valor infinito, se  le "asigna" el valor deseado
%(el peso de la delta) a infinito
iddelta_frecuencia = delta_frecuencia == Inf; 
delta_frecuencia(iddelta_frecuencia) = 0.5;
iddelta_neg_frecuencia= delta_neg_frecuencia == Inf;
delta_neg_frecuencia(iddelta_neg_frecuencia) = 0.5;

coef_fourier_sen_frecuencia=delta_frecuencia+delta_neg_frecuencia;

end

