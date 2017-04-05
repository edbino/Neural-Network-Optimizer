function [ individuos, n ] = ag_crossover( individuos, TX_MUTACAO)
%AG_MUTATION Summary of this function goes here
%   Detailed explanation goes here

    %Qtde total de individuos
    n_pop = size(individuos,2);
    
    %Qtde de mutacoes
    n = 0;
    
    for i = 2 : n_pop
    
        if (rand(1) <= TX_MUTACAO)
            ind = individuos{i};
            valorRand = rand(1);
            %Transfer Functions
            if(valorRand < 0.333334)
                ind = ag_mutation_tf(ind);
            end
            %Layers 
            if(valorRand >= 0.333334 && valorRand < 0.66667)
               ind = ag_mutation_lr(ind); 
            end
            %Train Functions
            if(valorRand >= 0.66667)
                ind = ag_mutation_fb(ind);
            end
            individuos{i} = ind;
            
            n = n + 1;
        end
            
    end
      
end

