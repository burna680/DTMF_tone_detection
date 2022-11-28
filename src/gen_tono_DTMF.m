%----------------------Punto 7--------------------------

%Falta el conversor de digitos a numeros ('A'=11, '*'=11, 0=10...)
function [tono,fs] = gen_tono_DTMF(marcado,duracion_tono,duracion_silencio)
%La funcion recibe en un vector el marcado a crear, la
%duracion de los tonos y la duracion de los silencios. Devuelve una señal
%con los tonos deseados separados por silencios
%'Marcado' debe ser un vector de numeros con lo que se desea maracar. Dicho
%vector toma en cuenta que el equivalente a un asterisco es el 10, el cero 
%un 11, a un numeral es 12, a la letra 'A' es un 13, 'B' un 14, 'C' un 15
%y 'D' un 16


diccionario_frecuencias_tonos=[697 1209;697 1336;697 1477;...
                               770 1209;770 1336;770 1477;...
                               852 1209;852 1336;852 1477;...
                               941 1209;941 1336;941 1477;...
                               697 1633;770 1633;852 1633;941 1633;];

fs=8000; %Se define la frecuencia para generar los tonos(Transmicion de 
         %datos para banca telefonica, donde se usa 4kHz)

t_silencio=zeros(1,round(duracion_silencio*fs));%Vector de ceros (silencio)
t_tono=0:1/fs:duracion_tono; %Vector de tonos
largo_marcado=length(marcado); 
tono=t_silencio; %Se inicializa el vector de los tonos con un silencio(Debe
                 %iniciarse para su utilizacion posterior)

for i=1:largo_marcado

    temp=diccionario_frecuencias_tonos(marcado(i),:);
    tono=[tono sin(2*pi*(temp(1))*(t_tono))+sin(2*pi*(temp(2))*(t_tono)) t_silencio];
end    
 %sound(tono,fs);
end