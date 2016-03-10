clear;

A = [1/8 -1/8; -1/12 5/12; -1/8 -7/8];
b = [17/4 19/6 -1/4]';
c = [-1/8 -15/8]';

dualA = -A';
dualb = -c;
dualc = -b;
dualc = [dualc(1); dualc(2); 0; 0; dualc(end)];

dualAslack = [dualA(:,[1 2]) eye(2) dualA(:,3)];
%dualAslack = [dualA eye(2)]


 clc;
 dualslack = [3 4]
[tableau,basicvars,steps]=simp(dualAslack,dualb,dualc, dualslack)

%[tableau,x,basic,feasible,optimal]=checkbasic1(dualAslack,dualb,dualc,dualslack)

%basicvars = setdiff(1:5, [4 5])
clc;
testA = dualAslack
testA = tableau(1:end-1, 1:end-1)
%[tableau,x,basic,feasible,optimal]=checkbasic1(dualAslack,dualb,dualc,basicvars)
testb = -tableau(1:end-1, end)
testc = -tableau(end, 1:end-1)'
%basicvars = [3 4]
[Aback,bback,cback] = dualproblem(testA,testb,testc, basicvars)