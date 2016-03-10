function isValid = checkPopulation(x, a, k)
%ISOK Checks if x is okay for the knapsack problem
if isempty(x)
    isValid = [];
else
    isValid = (x*a <= k);
end


