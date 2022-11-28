%La funcion recibe una señal y devuelve un vector de 1 y 0 donde hay informacion
function salida=detectar_informacion(entrada,THS, fragmentadora)

cantidad_muestras=length(entrada);

%Se obtiene la energia de la señal
energia=entrada.^2;

%Se crea la ventana que servira como promediadora
N=fragmentadora;
hMA= ones([1,N])/N;

%Se realiza la convolucion 
p=floor(N/2+1);
e2=conv(energia,hMA);
e2=e2(p:cantidad_muestras+p-1);%Accion para corregir el desfasaje que se 
                               %produce por la convolucion

%Se utiliza el umbral para discernir entre informacion util y ruido
%(presencia de señal)
e3=e2>THS;

% Se fuerza el inicio y el fin en 0 
e3(1)=0;
e3(end)=0;
salida=e3;

end