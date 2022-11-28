clc;
clear;
%-------------------------------Punto 11-----------------------------

%En este script se genera una señal correspondiente al marcado de tonos sumado a un ruido y
%se recupera el marcado original a partir de dicha señal, mediante su
%analisis en tiempo y mediante su analisis en frecuencia.

%%%%%%%%%%%%%%%%%%%%%%Se prueba la inmunidad al ruido%%%%%%%%%%%%%%%%%%%%%%

simbolos={1,2,'C'};
simbolos_convertidos=conversor_simb_num(simbolos);
[x,fs]=gen_tono_DTMF(simbolos_convertidos,0.2,0.2);

t=linspace(0,(length(x)/fs),length(x));


a=0:0.3:2.1;
for i=1:length(a)
   h=figure(i);
    ruido(i,:)=a(i)*(rand(1,length(x))-0.5);
    y(i,:)=ruido(i,:)+x;
%     sound(y(i,:));
    subplot(2,1,1)
    plot(t,ruido,'k-');
    grid on;
    grid minor;
    xlabel('Tiempo[s]');
    ylabel('Amplitud');
    title('Ruido');
    
    subplot(2,1,2)
    plot(t,y(i,:),'k-');
    grid on;
    grid minor;
    xlabel('Tiempo[s]');
    ylabel('Amplitud');
    title('Señal con ruido');
    saveas(h,sprintf('punto11_senalconruido_%d.png',i));
%     %Para el analisis en frecuencia
%     numeros1=deco_tono_DTMF(y(i,:),fs);
%     marcado_deco1=conversor_num_simb(numeros1);
% 
%     %Para el analisis en tiempo
%     numeros2=deco_banco_filtros(y(i,:),fs);
%     marcado_deco2=conversor_num_simb(numeros2);
end