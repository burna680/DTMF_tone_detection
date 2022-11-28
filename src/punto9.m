clc;
clear;
%-------------------------------Punto 9-----------------------------

%En este script se genera una señal correspondiente al marcado de tonos y
%se recupera el marcado original a partir de dicha señal, mediante su
%analisis en tiempo.

simbolos={1,2,'C'};
simbolos_convertidos=conversor_simb_num(simbolos);
[x,fs]=gen_tono_DTMF(simbolos_convertidos,0.2,0.2);
numeros=deco_banco_filtros(x,fs);
marcado=conversor_num_simb(numeros)