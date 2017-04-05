function [ft,fb,lr,nh,npc] = analisaConjunto(individuos)
    
    nh = zeros(10,1);
    lr = [];
    fb = zeros(11,1);
    ft = zeros(3,9);
    npc = zeros(10,12);
    
    for i = 1 : length(individuos)
       ind =  individuos{i};
       nh(length(ind)) = nh(length(ind)) + 1;
       
       ultimaCamada = ind{length(ind)};
       lr = [lr;ultimaCamada{3}];
       
       
       fbp = ultimaCamada{4};
       
       if(strcmp(fbp,'trainlm'))
        fb(1) = fb(1) + 1;
       end
       
       if(strcmp(fbp,'trainbr'))
        fb(2) = fb(2) + 1;
       end
       
       if(strcmp(fbp,'trainbfg'))
        fb(3) = fb(3) + 1;
       end
       
       if(strcmp(fbp,'trainrp'))
        fb(4) = fb(4) + 1;
       end
       
       if(strcmp(fbp,'trainscg'))
        fb(5) = fb(5) + 1;
       end
       
       if(strcmp(fbp,'traincgb'))
        fb(6) = fb(6) + 1;
       end
       
       if(strcmp(fbp,'traincgf'))
        fb(7) = fb(7) + 1;
       end
       
       if(strcmp(fbp,'traincgp'))
        fb(8) = fb(8) + 1;
       end
       
       if(strcmp(fbp,'trainoss'))
        fb(9) = fb(9) + 1;
       end
       
       if(strcmp(fbp,'traingdx'))
        fb(10) = fb(10) + 1;
       end
       
       if(strcmp(fbp,'traingd'))
        fb(11) = fb(11) + 1;
       end
       
       npc(9,1) = length(individuos);
       npc(1,12) = length(ind);
       
       for j = 2 : length(ind)
           camada = ind{j};
  
           if (j==length(ind))
                fun = camada{2};
  
           else
                fun = camada{3};
                npc(size(camada{1},2),j) = npc(size(camada{1},2),j)+1;
           end
           
           if(strcmp(fun,'purelin'))
               ft(1,j-1) = ft(1,j-1) + 1; 
           else 
               if (strcmp(fun,'logsig'))
                                  ft(2,j-1) = ft(2,j-1) + 1; 
               else
                                  ft(3,j-1) = ft(3,j-1) + 1; 
               end
           end
       end
        
    end
end