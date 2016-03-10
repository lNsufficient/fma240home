function fitness = getFitness(population, c)
%GETFITNESS returns the fitness of the population
% it is assumed that the population is valid/okay
z = population*c;
maxFit = max(z);
fitness = z/maxFit;



end

