function [marcado] = deco_tono_DTMF(x,fs)
%La funcion convierte una señal en codigo DTMF en su discado
%correspondiente

%La funcion recibe un vector x que representa una senal en el tiempo y 
%devuelve un vector con los numeros discados

%El diccionario de tonos es necesario para clasificar
%a cada uno de los tonos
diccionario_tonos=[1906 2033 2174 1979 2106 2247 2061 2188 2329 2150 ...
                   2277 2418 2330 2403 2485 2574];

                           
x=[0 x 0]; %Esta accion sirve para que la cantidad de subidas sea igual a 
           %la de bajadas de la señal
ancho_ventana=75;
%Se calcula la energia de la señal
energia=filter(ones(1,ancho_ventana)/ancho_ventana,1,x.^2);
%energia=energia(ancho_ventana/2+1:end);
umbral=max(x)*0.1;
%Se genera un vector con informacion binaria: unos donde hay señal util,
%ceros donde no la hay.
vector_util=energia>umbral; %[0001110000000111110001111110011111]

%Se fijan los indices del vector x donde hay o no señal
indices_cambios=diff(vector_util);
indices_up_temp=indices_cambios>0;
indices_subidas=find(indices_up_temp);
indices_down_temp=indices_cambios<0;
indices_bajadas=find(indices_down_temp);
cant_tonos=length(indices_bajadas);
duracion_tonos=indices_bajadas-indices_subidas;
tono_mas_largo=max(duracion_tonos);

% plot(indices_up_temp,'y-')
% hold on
% plot(indices_down_temp,'g-')

%Se separa la señal original x en los tonos del marcado y se calcula la 
%DFT para cada tono

NFFT =length(x);

y=zeros(cant_tonos,tono_mas_largo);
Y=zeros(cant_tonos,NFFT);
Y_util=zeros(cant_tonos,NFFT);

for j=1:cant_tonos
    y(j,indices_subidas(j):indices_bajadas(j))=x(indices_subidas(j):indices_bajadas(j));
    Y(j,:)=abs(fft(y(j,:),NFFT));
    Y_util(j,round(NFFT*(640/fs)):round(NFFT*(1820/fs)))=(Y(j,round(NFFT*(640/fs)):round(NFFT*(1820/fs))));
   %Se verifican los maximos del espectro; uno en el intervalo 0-1000 y el
   %otro en 1000-2000
    [maximo1(j),indice_maximo1(j)]=max(Y_util(j,1:round(NFFT*(1000/fs))));
   [maximo2(j),indice_maximo2(j)]=max(Y_util(j,round(NFFT*(1000/fs)):round(NFFT*(2000/fs))));
   
   indice_maximo2(j)=indice_maximo2(j)+round(NFFT*(1000/fs)); %Es un factor de correccion al redefinir el vector para el cual se obtiene el maximo 2
   indice_maximo1(j)=((indice_maximo1(j))*fs)/NFFT; %Pasaje del eje de muestras al eje de frecuencias (Hz)
   indice_maximo2(j)=((indice_maximo2(j))*fs)/NFFT; %Pasaje del eje de muestras al eje de frecuencias (Hz)
   if ((indice_maximo1(j))>=640 && (indice_maximo1(j))<=734)
       indice_maximo1(j)=697;
   elseif ((indice_maximo1(j))>734 && (indice_maximo1(j))<=811)
       indice_maximo1(j)=770;
   elseif (indice_maximo1(j)>811 && (indice_maximo1(j))<=897)
       indice_maximo1(j)=852;
   elseif ((indice_maximo1(j))>897 && (indice_maximo1(j))<=971)
       indice_maximo1(j)=941;
   end
   
   if ((indice_maximo2(j))>=1100 && (indice_maximo2(j))<=1273)
       indice_maximo2(j)=1209;
   elseif ((indice_maximo2(j))>1273 && (indice_maximo2(j))<=1407)
       indice_maximo2(j)=1336;
   elseif ((indice_maximo2(j))>1407 && (indice_maximo2(j))<=1555)
       indice_maximo2(j)=1477;
   elseif((indice_maximo2(j))>1555 && (indice_maximo2(j))<=1817)
       indice_maximo2(j)=1633;
   end
   
   suma_maximo=indice_maximo1(j)+indice_maximo2(j);
   temp=find(diccionario_tonos==(suma_maximo)); %suma_maximo se utiliza para identificar al tono
   marcado(j)=temp;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %Grafico de los espectros resultantes, destacando los puntos maximos de
%  %c/u
%  t=linspace(0,(length(x)/fs),length(x));
%   figure(1);
%   leyenda=[];
%   for k=1:cant_tonos
%         plot(linspace(0,fs,length(Y(k,:))),Y(k,:))
%         hold on
%         axis([0 3000 0 900])
%         temp1=sprintf('Espectro del %d simbolo marcado',k);
%         leyenda=[leyenda;temp1];
%   end
%   for u=1:cant_tonos
%         plot(indice_maximo1(u),maximo1(u),'o',indice_maximo2(u),maximo2(u),'o')
%         hold on
%   end
%   leyenda_graf=legend(leyenda,'location', 'southeast');
%   set(leyenda_graf,'Box','on', 'fontsize', 9, 'fontname', 'Arial');
%   grid on;
%   grid minor;
%   xlabel('Frecuencia [Hz]');
%   ylabel('Amplitud');
% %Grafico de señal, energia e informacion sobre la señal
% figure(2);
% plot(t,x,'b-');
% hold on
% plot(t,energia,'cx--');
% plot(t,vector_util,'ro--');
% grid on;
% grid minor;
% LEYENDA1='Señal';
% LEYENDA2='Energia de la señal';
% LEYENDA3='Vector de informacion sobre la señal';
% leyenda=legend(LEYENDA1,LEYENDA2,LEYENDA3,'location','southeast');
% set(leyenda,'Box','on', 'fontsize', 9, 'fontname', 'Arial');
% xlabel('Tiempo [s]');
% ylabel('Amplitud');

end