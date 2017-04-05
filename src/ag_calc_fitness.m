function [fitness, individuals] = ag_calc_fitness(individuals, ALPHA)
    warning('off','all')

    %data: input and target
    load('dados_norm');
    in = in_monitnorm;
    out = out_monitnorm;
    input = in';
	output = out';
    %end data 
    
    fitness = [];
    n = 0;
    for i = 1 : length(individuals)       
        temp = individuals{i};
        net_LW = cell(1,size(temp,2)-2); 
        net_bias =  cell(1,size(temp,2)-1);
        functions_net =  cell(1,size(temp,2)-1); 
        net_IW = temp{1};
        n_neurons_layer = [];
        
        for j = 2 : size(temp,2)-1
           b = temp{j};
           net_LW{j-1}= b{1};
           net_bias{j-1} = b{2};
           functions_net{j-1} = b{3};
           n_neurons_layer(j-1) = cell2mat(b(4));          
        end
        b = temp{j+1};
        net_bias{j} = b{1};
        functions_net{j} = b{2};
        learningRate = b{3};
        backFunction = b{4};
        
        net = cria_RNA(size(temp,2)-2,n_neurons_layer,functions_net,net_bias,net_IW,net_LW,learningRate,backFunction);
   
%         for j = 1 : length(n_neurons_layer)
%             net = initnw(net,j);
%         end
        net.trainParam.showWindow=0; %default is 1 = show train
        net = init(net);
        net = train(net,input,output);
        out = net(input);
        err = out-output;   
        error = perform(net, output, out);
        
        %err or error, change the choice
        fitness = [fitness;length(find(abs(err)>ALPHA))];
    
        temp{1} = net.IW{1};
        net_bias = net.b';
        for j =2:length(temp)-1
            temp{j}{1} = net.lw{j,j-1};
            temp{j}{2} = net_bias{j-1};
            temp{j}{3} = net.layers{j-1}.transferFcn;
        end
        j = length(temp);
        temp{j}{1} = net_bias{j-1};
        temp{j}{2} = net.layers{j-1}.transferFcn;
        individuals{i} = temp;
        n = n+1;
        fprintf('Network %i.\n', n);
    end
   
end


