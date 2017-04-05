%Settings
 POP_SIZE        = 60;
 N_GENERATIONS   = 3;
 TX_MUTATION     = 0.3;
 N_MAX_LAYER     = 5;
 N_MAX_NEU       = 30;
 ALPHA           = 0.00001;
 
%Generates initial population
individuals = ag_gen_pop(POP_SIZE, N_MAX_LAYER, N_MAX_NEU);

%Stores maximum error
min_err = [];

%Execute
for i = 1 : N_GENERATIONS
   
    %Calculates fitness
    [fitness, individuals] = ag_calc_fitness(individuals, ALPHA);
       
    %Store min err
    min_err = [min_err; min(fitness)];
   
    %Sort
    [individuals, s_fitness] = ag_sort(individuals, fitness);
    
    %Crossover
    individuals = ag_crossover(individuals);
        
    %Mutation
    [individuals, qt_mutated] = ag_mutation(individuals, TX_MUTATION);
    
end

%Calculates fitness
[fitness, individuals] = ag_calc_fitness(individuals);
       
%Store min err
min_err = [min_err; min(fitness)];

disp('Training and choice completed with success');

%extract_data(individuals);
