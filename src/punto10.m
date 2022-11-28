clc;
clear;
%-------------------------------Punto 10-----------------------------

%En este script se genera una señal correspondiente al marcado de tonos y
%se recupera el marcado original a partir de dicha señal, mediante su
%analisis en frecuencia.

orden=300;
fs=8000;
ventana1=kaiser(orden+1,0.5);
ventana2=blackman(orden+1);
cant_filtros=8;
tipo_filtro='bandpass';

frecuencias={[697 770 852 941],[1209,1336,1477,1633]};
matriz_frec=[frecuencias{:}];

for i=1:cant_filtros
   temp=fir1(orden,[(matriz_frec(i)-5)/(fs/2),(matriz_frec(i)+5)/(fs/2)],tipo_filtro,ventana1);
   
   
    h1=figure(matriz_frec(i));
    zplane(temp,1);
    axis([-1.5 1.5 -1.5 1.5]);
    str1 = sprintf('Diagrama de Polos y Ceros para filtro de %d Hz',matriz_frec(i));
    title(str1);
    saveas(h1,sprintf('punto10_dpz_%d_v2.png',matriz_frec(i)));
    
    
    h2=figure(matriz_frec(i)+cant_filtros);
    freqz(temp);
    str2 = sprintf('Respuesta en frecuencia para filtro de %d Hz',matriz_frec(i));
    title(str2);
    saveas(h2,sprintf('punto10_rta_frec_%d_v2.png',matriz_frec(i)));
    
end
