function [ ind ] = ag_crossover(individuals)
    modi = round(size(individuals,2)/2)+1;
    cont = 1;
    ind = {};
    
    for i=1:modi
        ind_1 = individuals{i};
        ind_1 = ind_1{1};
        ind{i} = ind_1;
    end
    
   for i = modi:size(individuals,2)-1
  %      for i = 1:1
       ind_1 = individuals{cont};
       ind_2 = individuals{cont+1};
       
       ind_1 = ind_1{1};
       ind_2 = ind_2{1};
       
       n_cromo_1 = round(size(ind_1,2)/2);
       n_cromo_2 = round(size(ind_2,2)/2);
       

       check = mod( size(ind_2,2),2);
       if check==1
           pos = n_cromo_2;
       else
           pos = n_cromo_2+1;
       end
       
       n_ind = {};
       
       for j = 1:n_cromo_1

          if (j==n_cromo_1)
               temp = ind_2{pos};
               n_size = size(temp{2},1);
               temp =  ind_1{n_cromo_1};
               n_size_act = size(temp{2},1);
               temp{1} = rand(n_size,n_size_act);
               ind_1{j}=temp;
          end
          n_ind{j} = ind_1{j};
       end
       
   
       for k = n_cromo_1+1:n_cromo_2+n_cromo_1
          n_ind{k} = ind_2{pos};
          pos = pos + 1;
       end
       
       ind{i+1} = n_ind;
       cont = cont + 1; 
    end
    
end

