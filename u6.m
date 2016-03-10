clear;
c = [10 5 2]';
a = [1 1 1]';
k = 1.2;

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

%Generate population:
N = 30;
meanSum = sum(a)/2;
nfactor = min(meanSum/k, 1);
Ncorr = 2;
Ntry = nfactor*N*Ncorr;
chromLength = length(a);
population = randi(2, round(Ntry), chromLength) - 1;
validVector = checkPopulation(population, a, k);
keptPop = population(validVector, :);
[nbrChrom, ~] = size(keptPop);
while(nbrChrom < N*0.8)
    tempN = (N - nbrChrom)*nfactor;
    tempPopulation = randi(2, round(tempN), chromLength) - 1;
    tempValid = checkPopulation(tempPopulation, a, k);
    tempKept = tempPopulation(tempValid, :);
    [nbrNew, ~] = size(tempKept);
    keptPop = [keptPop; tempKept];
    nbrChrom = nbrNew + nbrChrom;
    Ncorr = Ncorr*1.1
end
if (nbrChrom > N*1.2)
    keptPop = keptPop(1:round(N*1.2), :);
end
%size(keptPop)
%checkPopulation(keptPop, a, k)'
%z = keptPop*c;
%z'
fitness = getFitness(keptPop, c);


parentIndicies = selectParents(fitness, round(N/2), 0.7)

