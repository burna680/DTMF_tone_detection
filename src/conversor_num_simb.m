function [simbolos]=conversor_num_simb(numeros)
%La funcion recibe numeros que representan a los simbolos marcados segun: 
%el equivalente a un asterisco es el 10, el cero 
%un 11, a un numeral es 12, a la letra 'A' es un 13, 'B' un 14, 'C' un 15
%y 'D' un 16.Los demas simbolos se representan mediante el numero que son.
%Ej: simbolo '1' se representa mediante el numero 1

diccionario_simbolos={'1','2','3','4','5','6','7','8','9','*','0','#','A','B','C','D'};

largo=length(numeros);
simbolos=cell(1,largo);
for i=1:largo
    simbolos{i}=diccionario_simbolos{numeros(i)};
end

