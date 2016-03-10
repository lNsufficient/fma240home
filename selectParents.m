function parentIndicies = selectParents(fitness, nbrParents, fitnessprob)
%SELECTPARENTS Selects parents where parents with high fitness is more
%likely to be chosen.
%if fitnessprob is set to 1, most fit will be chosen. If it is set to zero
%randomness will have greater impact.

nbrChroms = length(fitness);

%Se till att alla har viss chans - även en nolla kan vara bra om exempelvis
%endast en pryl är värd att ta med - mutation kan leda till att den tas
%med.
zeroIndicies = find(fitness == 0);
fitness(zeroIndicies) = 0.1*rand(length(zeroIndicies), 1);
%fitness = fitness + 0.1*rand(nbrChroms, 1); %this is probably more fair


%Following line: if fitnessprob = 1, only the fittest will be chosen
parentProb = fitness.*(fitnessprob + (1-fitnessprob)*rand(nbrChroms,1));
%parentList = [parentProb (1:nbrChroms)'];
%parentSort = sortrows(parentList);
[~, parentSort] = sortrows(parentProb);
parentIndicies = parentSort(end-nbrParents+1:end);

%parents = find(parentProb >= medianProb) %hade kunnat användas om hälften
%alltid bevaras...

end

