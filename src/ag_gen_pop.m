function [individuals] = ag_gen_pop(POP_SIZE, N_LAYERS, N_NEU)
    
    funcActivHL = {'logsig','tansig'};
    funcActivOL = {'tansig','purelin'};
    funcTrein = {'trainbfg','trainbr','trainrp','trainlm','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx','traingd'};
    individuals = cell(1, POP_SIZE);
    
    disp('Generating the population...');
    
    for i = 1:POP_SIZE
                
        inputs = 2;
        %number of layers
        layers = round(rand*(N_LAYERS-1))+1;
        %number of neurons per layer
        neurons_layers = round(rand(1,layers)*(N_NEU-1))+1;
        %array with size: layers+1 and values from 1 to 2, referring to the activation functions
        %pos_functions = round(rand(1,camadas+1))+1;
        %init weights of input layer and middle layer
        net_IW = rand(neurons_layers(1),inputs);
        function_net = cell(1, layers+1); 
        net_LW = cell(1, layers);
        net_bias = cell(1, layers+1);
        for j = 1 : layers
            %sets the vector of the activation functions
            function_net{j} = funcActivHL{round(rand(1,1))+1}; 
            %sets the bias weight
            net_bias{j} = rand(neurons_layers(j), 1);
            if(j >= 2 && j <= layers)
                %Sets the weight of the intermediate layers
                net_LW{j-1} = rand(neurons_layers(j), neurons_layers(j-1));
            end
        end
        function_net{layers+1} = funcActivOL{round(rand(1,1))+1}; 
        %sets the weight of the layers inter/output
        net_LW{layers} = rand(1, neurons_layers(layers));
        %sets the bias of the output layer
        net_bias{layers+1} = rand(1,1);
        %sets the individual size
        individual = cell(1, layers+2);
        %fills the individual with the input weights
        individual{1} = net_IW;
        %fills the individual with the info of others layers
        for j = 1 : layers
            info{1} = net_LW{j};
            info{2} = net_bias{j};
            info{3} = function_net{j};
            info{4} = neurons_layers(j);
            individual{j+1} = info;
        end
        %fills the individual with the output layer info + training function
        info = {net_bias{layers+1},function_net{layers+1},rand(),funcTrein(round(rand()*10)+1)};
        individual{layers+2} = info;
        individuals{i} = individual;   
    end
end

