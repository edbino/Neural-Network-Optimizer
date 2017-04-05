function [ind] = extract_data(individuos)

    temp = individuos{1};
    arquivo = fopen('dados.txt','w');
    fprintf(arquivo,'%d',1);
    fclose(arquivo);

    
    pesos = w_net;
    camadas = length(n_camadas_neuro);
    neuronios = n_camadas_neuro;
    f_ativs = func_ativ;
    f_trein = func_trein;

end