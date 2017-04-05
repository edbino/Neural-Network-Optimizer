function [ ind ] = ag_mutation_tf( ind )
%AG_MUTATION_TF Summary of this function goes here
%   Detailed explanation goes here

    %Funcoes
    funcoes = {'logsig','tansig','purelin'};

    %Escolhe uma camada intermediaria para mutar a TF da mesma
    n_camadas = size(ind, 2);
    n_camadas_ocultas = n_camadas - 2;
    i_camada_mutada = round(rand(1)*(n_camadas_ocultas-1)) + 1;
    
    %Desloca 1 pra frente para ignorar a camada de entrada
    i_camada_mutada = i_camada_mutada + 1;
    
    %Altera a TF, escolhendo uma aleatória da lista ali de cima
    ind{1,i_camada_mutada}(3) = funcoes((round(1) * 2) + 1); 

end
