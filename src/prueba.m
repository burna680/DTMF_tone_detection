function [coef_fourier_sen_frecuencias] = prueba( frecuencias, w)
%w es el rango de frecuencias que se debe considerar

cant_frecuencias= length(frecuencias);
for i=1:cant_frecuencias
   
    delta_frecuencias(i)= dirac(w-frecuencias(i)); 
    delta_neg_frecuencias(i)= dirac(w+frecuencias(i));
    iddelta_frecuencias = delta_frecuencias(i) == Inf;
    delta_frecuencias(i,iddelta_frecuencias) = 0.5;
    iddelta_neg_frecuencias= delta_neg_frecuencias(i) == Inf;
    delta_neg_frecuencias(i,iddelta_neg_frecuencias) = -0.5;

    coef_fourier_sen_frecuencias=delta_frecuencia+delta_neg_frecuencia;

end
end