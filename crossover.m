function children = crossover(parentPop, crossoverPoint, probOrd)
%CROSSOVER randomly pairs the parents and performs crossover

%As is now, it is most likely that the best parents are in the bottom of a
%vector. With a probability (probKeptOrder) they will be kept there - in
%real life, maybe a good looking induvidual has a greater chance of mating
%with another good looking induvidual.

[nbrParents, ~] = size(parentPop);
parentIndicies = (1:nbrParents)'.*(probOrd-(1-probOrd)*rand(nbrParents, 1));

parentList = [parentIndicies parentPop];
sortedParents = sortrows(parentList);

male = 1:2:nbrParents-1;
female = 2:2:nbrParents;

males = sortedParents(male, 2:end);
females = sortedParents(female, 2:end);


children = [males(:, 1:crossoverPoint) females(:, crossoverPoint+1:end);
    females(:, 1:crossoverPoint), males(:, crossoverPoint+1:end)];


end

