function [s_individuals, s_fitness] = ag_sort(individuals, fitness)

    size_pop = size(individuals,2);
    s_fitness = {};
    fitness(find(isnan(fitness))) = 1;

    i=1;
    while(i <= size_pop)
        pos = find(min(fitness)==fitness);
        for j=1:length(pos)
            s_fitness = [s_fitness;fitness(pos(j))];

            fitness(pos(j))=NaN;
            s_individuals{i} = individuals(pos(j));
            i = i + 1;
        end
    end

end

