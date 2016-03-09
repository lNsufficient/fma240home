function [dualA,dualb,dualc] = dualproblem(A,b,c,slackvars);
% for a problem that is in canonical form but which comes from a problem in
% standard form, the following can be used to transfer to a dual tableau
% It is assumed that A(:,basicvars) = [eye(m)]
% and that c(slackvars) = 0. This will not be checked.
% The function transforms the problem into a new LP problem for the dual in
% canonical form so that checkbasic1 can be used for the dual problem.
basicvars = slackvars;
m = size(A,1);
n = size(A,2);
nonbasicvars = setdiff(1:n,basicvars);
dualbasicvars = nonbasicvars;
dualnonbasicvars = basicvars;
dualm = n-m;
dualn = n;
dualA = zeros(dualm,dualn);
dualA(:,dualnonbasicvars) = -A(:,nonbasicvars)';
dualA(:,dualbasicvars) = eye(dualm);
dualc = zeros(dualn,1);
dualb = -c(nonbasicvars);
dualc(dualnonbasicvars) = -b;


