function [optval optimal_chromosones Nfactor] = geneticKnapsack(c, a, k, maxRounds)
%GENETICKNAPSACK Summary of this function goes here
%   Detailed explanation goes here

if (length(a) ~= length(c)) 
    error('invalid a, c')
end
if (k < min(a))
    error('invalid a, k')
end
if (min(a) <= 0)
    error('invalid a, zero weight')
end
if (min(c) <= 0)
    disp('not knapsack problem?')
end

N = 30;
Nmin = round(N*0.8);
Nmax = round(N*1.2);
Ncorr = 2;
fitnessProb = 0.1;
crossoverPoint = round(length(a)/2);
nbrParents = round(N/4)*2; %To make sure it is an even number.
%Generate population:

meanSum = sum(a)/2;
Nfactor = min(meanSum/k, 1)*Ncorr;


% population = randi(2, round(Ntry), chromLength) - 1;
% validVector = checkPopulation(population, a, k);
% keptPop = population(validVector, :);
population = [];
optval = [];
noImprovement = 0;
optimal_chromosones = [];

while (noImprovement < maxRounds)
    [keptPop Nfactor] = fillPop(population, Nfactor, Nmax, Nmin, a, k);
    optval = [optval max(keptPop*c)];
    if (optval(end) == max(optval))
        noImprovement = noImprovement + 1;
        optimal_chromosones = [optimal_chromosones; keptPop(min(find(keptPop*c == max(optval))), :)];
    elseif (optval(end) > max(optval))
        optimal_chromosones = keptPop(min(find(keptPop*c == max(optval))), :);
        noImprovement = 1;
    end
    %size(keptPop)
    %checkPopulation(keptPop, a, k)'
    %z = keptPop*c;
    %z'
    fitness = getFitness(keptPop, c);
    parentIndicies = selectParents(fitness, nbrParents, fitnessProb);
    parentPop = keptPop(parentIndicies,:);
    childrenPop = crossover(parentPop, crossoverPoint, 0.7);
    population = mutate(childrenPop,0.1);
    validChrom = checkPopulation(population, a, k);
    population = population(validChrom, :);
end
optval = max(optval);

end

