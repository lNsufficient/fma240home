clear;
c = [10 5 5]';
a = [3 1 1]';
k = 3;
maxRounds = 10;

[optval optimal_chromosones Nfactor] = geneticKnapsack(c, a, k, maxRounds)
%%
%friluftsliv:
clear;
clc;

maxRounds = 10;

a = [1, 3, 0.5, 10, 0.1, 1, 1.5, 0.3, 0.2, 2]';
c = [10 10 6 12 8 1 3 7 8 10]';
k = 12;

[optval optimal_chromosones Nfactor] = geneticKnapsack(c, a, k, maxRounds)
optimal_chromosone*c