function [population, Nfactor] = fillPop(population, Nfactor, Nmax, Nmin, a, k)
%FILLPOP for a given population adds random new chromosones until desired
%size is achieved.
validChrom = checkPopulation(population, a, k);
population = population(validChrom, :);
chromLength = length(a);
[nbrChrom, ~] = size(population);
while(nbrChrom < Nmin)
    tempN = (Nmax - nbrChrom)*Nfactor;
    tempPopulation = randi(2, round(tempN), chromLength) - 1;
    tempValid = checkPopulation(tempPopulation, a, k);
    tempKept = tempPopulation(tempValid, :);
    [nbrNew, ~] = size(tempKept);
    population = [population; tempKept];
    nbrChrom = nbrNew + nbrChrom;
    %Nfactor = Nfactor*1.2; %Först trodde jag det kunde va lönt att göra
    %stora populationer och slänga bort, sen visade det sig att det var
    %inte smart, verkade ta lång tid.
end
if (nbrChrom > Nmax)
    population = population(1:Nmax, :);
    %Nfactor = Nfactor/1.05; %It is probably okay if this one is big.
    %this way, children of old generations are kept
end

end

