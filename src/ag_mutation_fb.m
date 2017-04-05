function [ ind ] = ag_mutation_fb( ind )
%AG_MUTATION_TF Summary of this function goes here
%   Detailed explanation goes here

    n_camadas = size(ind, 2);
    funcoesBack = {'trainlm','trainbr','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx','traingd'};

        
    ind{n_camadas}{4} = funcoesBack(round(rand()*10)+1);

       
end
