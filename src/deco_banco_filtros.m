%La funcion recibe la señal que se desea tratar y la frecuencia de muestreo
%devuelve el marcado realizado en codigo DTMF
function [salida]=deco_banco_filtros(x,fs)

%Se fijan las variables estaticas
frecuencias={[697 770 852 941],[1209,1336,1477,1633]};
matriz_frec=[frecuencias{:}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se filtra la señal con el filtro correspondiente a cada frecuencia

%Se fija el orden del filtro
orden=1000;
%Se fijan los tipos de ventanas a usar en los filtros
ventana1=kaiser(orden+1,0.5);
ventana2=blackman(orden+1);
cant_filtros=8;
tipo_filtro='bandpass';

%Se fija el umbral mediante el cual se distingue si hay informacion util o
%no en la señal (presencia de tonos)
THS=0.1*max(x);

%Se fija el ancho de la ventana que servira como promediadora en la
%deteccion de informacion
fragmentadora=200; 

for i=1:cant_filtros
    y(i,:)=Filtro(x,fs,orden,(matriz_frec(i)-5)/(fs/2),(matriz_frec(i)+5)/(fs/2),ventana1,tipo_filtro);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se detectan las porciones de señal donde hay informacion util(presencia
%de señal) para las bajas y altas frecuencias que forman el tono en codigo
%DTMF
for j=1:floor(cant_filtros/2)
     deteccion_baja_frec(j,:)=detectar_informacion(y(j,:),THS, fragmentadora);
     deteccion_alta_frec(j,:)=detectar_informacion(y(j+4,:),THS, fragmentadora);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se detecta la presencia de tonos
digito_1= (deteccion_alta_frec(1,:).*deteccion_baja_frec(1,:));
digito_4= (deteccion_alta_frec(1,:).*deteccion_baja_frec(2,:));
digito_7= (deteccion_alta_frec(1,:).*deteccion_baja_frec(3,:));
digito_aste= (deteccion_alta_frec(1,:).*deteccion_baja_frec(4,:));
digito_2= (deteccion_alta_frec(2,:).*deteccion_baja_frec(1,:));
digito_5= (deteccion_alta_frec(2,:).*deteccion_baja_frec(2,:));
digito_8= (deteccion_alta_frec(2,:).*deteccion_baja_frec(3,:));
digito_0= (deteccion_alta_frec(2,:).*deteccion_baja_frec(4,:));
digito_3= (deteccion_alta_frec(3,:).*deteccion_baja_frec(1,:));
digito_6= (deteccion_alta_frec(3,:).*deteccion_baja_frec(2,:));
digito_9= (deteccion_alta_frec(3,:).*deteccion_baja_frec(3,:));
digito_numeral=(deteccion_alta_frec(3,:).*deteccion_baja_frec(4,:));
digito_A= (deteccion_alta_frec(4,:).*deteccion_baja_frec(1,:));
digito_B= (deteccion_alta_frec(4,:).*deteccion_baja_frec(2,:));
digito_C= (deteccion_alta_frec(4,:).*deteccion_baja_frec(3,:));
digito_D= (deteccion_alta_frec(4,:).*deteccion_baja_frec(4,:));

%La suma de todas las coincidencias formara un vector de informacion util,
%donde hay 1 donde hay un tono y 0 donde no
suma=digito_1+digito_2+digito_3+digito_4+digito_5+digito_6+digito_7+digito_8+digito_9+digito_0+digito_aste+digito_numeral+digito_A+digito_B+digito_C+digito_D;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se buscan donde hay cambios
indices_cambios=diff(suma);
indices_up_temp=indices_cambios>0;
indices_subidas=find(indices_up_temp);
indices_down_temp=indices_cambios<0;
indices_bajadas=find(indices_down_temp);
cant_digitos=length(indices_bajadas);
duracion_tonos=indices_bajadas-indices_subidas;
marcado=zeros(1,cant_digitos);
for l=1:cant_digitos
    pos=indices_subidas(l)+round(duracion_tonos(l)/2); %Posiciona 
    %"el cursor" en el punto medio del tono l y se verifica la presencia de
    %digitos
    if(digito_1(pos))
        marcado(l)=1;
    elseif(digito_4(pos))
        marcado(l)=4; 
    elseif(digito_7(pos))
        marcado(l)=7; 
    elseif(digito_aste(pos))
        marcado(l)=10; 
    elseif(digito_2(pos))
        marcado(l)=2; 
    elseif(digito_5(pos))
        marcado(l)=5;
    elseif(digito_8(pos))
        marcado(l)=8; 
    elseif(digito_0(pos))
        marcado(l)=11;
    elseif(digito_3(pos))
        marcado(l)=3; 
    elseif(digito_6(pos))
        marcado(l)=6; 
    elseif(digito_9(pos))
        marcado(l)=9; 
    elseif(digito_numeral(pos))
        marcado(l)=12; 
    elseif(digito_A(pos))
        marcado(l)=13; 
    elseif(digito_B(pos))
        marcado(l)=14;
    elseif(digito_C(pos))
        marcado(l)=15;
    elseif(digito_D(pos))
        marcado(l)=16;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Debugging
% %------------------------------------------------------------------------%
% %Se define el eje temporal. Sirve para los graficos
% t=linspace(0,(length(x)/fs),length(x));
% s=0;
% for i=1:cant_filtros
%     figure(1);
%     subplot(4,2,i);
%     plot(t,y(i,:),'b-');
%      leyenda=sprintf('Señal filtrada por el filtro de %d  Hz',(matriz_frec(i)));
%      hold on;
%      leyenda_graf=legend(leyenda,'location', 'southeast');
%      set(leyenda_graf,'Box','on', 'fontsize', 7, 'fontname', 'Arial');
%      grid on;
%      grid minor;
%      xlabel('Tiempo[s]');
%      ylabel('Amplitud');
%      axis([0 (length(x)/fs) -2.5 2.5]);
%      s=s+y(i,:);
% end
  
% for j=1:4
%     figure(j)
%     plot(t,deteccion_baja_frec(j,:));
%     figure(j+4)
%     plot(t,deteccion_alta_frec(j,:));
% end
%-------------------------------------------------------------------------%
% figure(9);
% plot(t,digito_1);
% 
% figure(10);
% plot(t,digito_2);
% 
% figure(11);
% plot(t,digito_3);
% 
% figure(12);
% plot(t,digito_4);
% 
% figure(13);
% plot(t,digito_5);
% 
% figure(14);
% plot(t,digito_6);
% 
% figure(15);
% plot(t,digito_7);
% 
% figure(16);
% plot(t,digito_8);
% 
% figure(17);
% plot(t,digito_9);
% 
% figure(18);
% plot(t,digito_0);
% 
% figure(19);
% plot(t,digito_aste);
% 
% figure(20);
% plot(t,digito_numeral);
% 
% figure(21);
% plot(t,digito_A);
% 
% figure(22);
% plot(t,digito_B);
% 
% figure(23);
% plot(t,digito_C);
% 
% figure(24);
% plot(t,digito_D);
% 
% %-------------------------------------------------------------------------% 
% figure(25);
% subplot(2,1,1);
% plot(t,s);
% 
% leyenda2=sprintf('Señal luego del banco de filtros');
% leyenda2_graf=legend(leyenda2,'location', 'northeast');
%   set(leyenda_graf,'Box','on', 'fontsize', 9, 'fontname', 'Arial');
%   grid on;
%   grid minor;
%   xlabel('Tiempo[s]');
%   ylabel('Amplitud');
% axis([0 (length(x)/fs) -2.5 2.5]);
% 
% subplot(2,1,2);
% plot(t,suma);
% leyenda1=sprintf('Deteccion de presencia de señal');
% leyenda1_graf=legend(leyenda1,'location', 'northeast');
%   set(leyenda_graf,'Box','on', 'fontsize', 9, 'fontname', 'Arial');
%   grid on;
%   grid minor;
%   xlabel('Tiempo[s]');
%   ylabel('Amplitud');
% axis([0 (length(x)/fs) 0 1.5]);
% % %-------------------------------------------------------------------------%
% cantidad_muestras=length(y(1,:));
% %Se crea la ventana que servira como promediadora
% N=fragmentadora;
% hMA= ones([1,N])/N;
% p=floor(N/2+1);
% 
% figure(2000)
% se2=0;
% se3=0;
% for k=1:cant_filtros
%     
% e1=y(k,:).^2;
% 
% %Se realiza la convolucion 
% 
% e2=conv(e1,hMA);
% e2=e2(p:cantidad_muestras+p-1);%Accion para corregir el desfasaje que se 
%                                %produce por la convolucion
% 
% %Se utiliza el umbral para discernir entre informacion util y ruido
% %(presencia de señal)
% e3=e2>THS;
% 
% % Se fuerza el inicio y el fin en 0 
% e3(1)=0;
% e3(end)=0;
% 
% se2=se2+e2;
% se3=se3+e3;
% end
% 
% % figure(25+k)
% % plot(t,e1,'cx--');
% % hold on;
% plot(t,se2,'ro--');
% hold on;
% plot(t,se3,'b--');
% leyenda3=sprintf('Energia de la señal luego del banco de filtros');
% leyenda4=sprintf('Deteccion de informacion luego del banco de filtros');
% leyenda3_graf=legend(leyenda3,leyenda4,'location', 'northeast');
%   set(leyenda_graf,'Box','on', 'fontsize', 9, 'fontname', 'Arial');
%   grid on;
%   grid minor;
%   xlabel('Tiempo[s]');
%   ylabel('Amplitud');
% axis([0 (length(x)/fs) 0 2.1]);
% wvtool(ventana1,ventana2)
% %-------------------------------------------------------------------------%
salida=marcado;
end