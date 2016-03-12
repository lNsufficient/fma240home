clear;
c1 = [10 5 5]';
a1 = [3 1 1]';
k1 = 3;



a2 = [10, 30, 5, 20, 1, 10, 15, 3, 2, 20]';
c2 = [10 10 6 12 8 1 3 7 8 10]';
k2 = 120;

a3 = (1:2:31)';
c3 = (6:21)';
k3 = 45;

s = 22;
a4 = (1:s)';
c4 = (s:-1:1)';
k4 = round(sum(a4)/4);
timeResults = [22 31; 21 16; 20 14];

%first column s value.
timeResults = [22 51 54 38 35 35;21 16 26 44 17 31; 20 13 13 16 9 12; 19 17 6 8 5 8
    18 4 3 3 3 3; 17 2 2 2 1 1; 16 0.6 2 0.6 0.9 0.8;
    15 0.3 0.6 0.6 0.5 0.9; 14 0.2 0.2 0.2 0.4 0.2];
%plot(timeResults(:,1), sum((timeResults(:, 2:end))')/5);


maxRounds = 10;
Nfactor = 3;

c = c1; a= a1; k = k1;
c = c2; a= a2; k = k2;
c = c3; a= a3; k = k3;
c = c4; a = a4; k = k4;
%[optval optimal_chromosones Nfactor] = geneticKnapsack(c1, a1, k1, maxRounds, Nfactor)
%[optval optimal_chromosones Nfactor] = geneticKnapsack(c2, a2, k2, maxRounds, Nfactor)
%[optval optimal_chromosones Nfactor] = geneticKnapsack(c3, a3, k3, maxRounds, Nfactor)
%[optval optimal_chromosones Nfactor] = geneticKnapsack(c, a, k, maxRounds, Nfactor)

endi = 200;
endj = 5;
times = zeros(endi, endj);
for i = 1:endi
   for j = 1:endj
       a = ones(i, 1); c = ones(i, 1); k = round(i/2);
       %a = (1:i)'; c = ones(i,1); k = round(sum(a)/2);
       %a= (1:i)'; c = (i:-1:1)'; k = round(sum(a)/2);
       tic
       [optval optimal_chromosones Nfactor] = geneticKnapsack(c, a, k, maxRounds, Nfactor);
       toc
       times(i, j) = toc;
   end
end
semilogy(1:endi,sum(times'))

optimal_chromosones*c