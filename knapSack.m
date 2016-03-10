clear;
c = [10 5 5]';
a = [3 1 1]';
k = 3;
maxRounds = 10;

[optval optimal_chromosones Nfactor] = geneticKnapsack(c, a, k, maxRounds)