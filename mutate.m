function mutatedPop = mutate(population, mutateProb)
%Mutates the population

[m, n] = size(population);
mutations = (rand(m, n) < mutateProb);
mutatedPop = mod(mutations + population, 2);
%[mutatedPop ones(m, 1)*8 population ones(m, 1)*8 mutations]
end

