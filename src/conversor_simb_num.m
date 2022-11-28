function [numeros] = conversor_simb_num(simbolos)
%La funcion recibe un arreglo de celdas que contengan a los simbolos que se
%desean marcar y retorna el numero que se utiliza en las funciones

%La funcion devuelve numeros que representan a los simbolos marcados segun: 
%el equivalente a un asterisco es el 10, el cero 
%un 11, a un numeral es 12, a la letra 'A' es un 13, 'B' un 14, 'C' un 15
%y 'D' un 16. Los demas simbolos se representan mediante el numero que son.
%Ej: simbolo '1' se representa mediante el numero 1.



numeros=zeros(1,length(simbolos));
diccionario_simbolos={'1','2','3','4','5','6','7','8','9','*','0','#','A','B','C','D'};
largo=length(diccionario_simbolos);
for i=1:length(simbolos)
    if(isnumeric(simbolos{i}))
        simbolos{i}=num2str(simbolos{i});
    end
    for j=1:largo
        temp=strcmp(simbolos{i},diccionario_simbolos{j});
        if(temp)
            numeros(i)=j;
        end
    end
end

end

