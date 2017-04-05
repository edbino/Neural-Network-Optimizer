function [net] = cria_RNA(layers, n_neurons_layer, functions_net, net_bias, net_IW,net_LW, learningRate, backFunction)
    
    load('dados_norm');
    in = in_monitnorm;
    out = out_monitnorm;
    input = in';
	output = out';
   
    net = newff(input, output, n_neurons_layer, functions_net,  backFunction{1});
    net.divideFcn = '' ;
    % goal
    net.trainParam.goal = 1e-7;
    % Learning rate used in some gradient schemes
    net.trainParam.lr = learningRate;
    % Max number of iterations
    net.trainParam.epochs = 3000; 
    %view(net);
    %net.performParam.regularization = 0.5;
    %net.trainFcn = backFunction{1};
    %net.divideParam.trainRatio = 0.7;
    %net.divideParam.valRatio = 0.15;
    %net.divideParam.testRatio = 0.15;
    net.IW{1,1} = net_IW;
    net.b = net_bias';

    for i = 2 : layers+1
        net.LW{i,i-1}= net_LW{i-1};
    end
end
 