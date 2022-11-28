function salida=Filtro(x,fs,orden,frecuencia_inicial,frecuencia_final,ventana,tipo_filtro)

%Se definen las constantes filtro
wn=[frecuencia_inicial frecuencia_final];
filtro=fir1(orden,wn,tipo_filtro,ventana);
salida=filter(filtro,1,x);
end