clear;

A0 = [4 2 5 5; 4 2 5 5; 3 5 4 1; 3 5 4 1; 1 1 1 1];
slack = [1 0 0 0; 0 -1 0 0; 0 0 -1 0; 0 0 0 1; 0 0 0 0];
A1 = [A0 slack];
[m1, n1] = size(A1);
c1 = [2 1 3 4 zeros(1, n1)]';

A2 = [A1 eye(5)];
[m2, n2] = size(A2);
c2 = [zeros(1, n1), -ones(1, n2 - n1)]';

b = [10 5 8 15 3]';

%tableau(:, end)./tableau(:,n1) minsta värdet väljer rad.

basicvars = (n1+1):n2
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b, c2, basicvars);
tableau

basicvars = [9 3 11 12 13]
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b, c2, basicvars);
tableau

basicvars = [9     3    2    12    13]
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b, c2, basicvars);
tableau

basicvars = [9     7    2    12    13]
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b, c2, basicvars);
tableau

basicvars = [9     7     2    6    13]
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b, c2, basicvars);
tableau

basicvars = [9     7     2    6    4]
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b, c2, basicvars);
tableau

basicvars = [3     7     2    6    4]
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b, c2, basicvars);
tableau

disp('basic vars have been chosen for the auxillary problem, result was')
basicvars = basicvars
disp('moving on to solving the first problem')

basicvars
[tableau,x,basic,feasible,optimal] = checkbasic1(A1, b, c1, basicvars);
tableau

basicvars = [3     7     2    6    8]
[tableau,x,basic,feasible,optimal] = checkbasic1(A1, b, c1, basicvars);
tableau

basicvars = [4     7     2    6    8]
[tableau,x,basic,feasible,optimal] = checkbasic1(A1, b, c1, basicvars);
tableau


Sol = tableau(1:end-1, basicvars)
bfinal = tableau(1:end-1, end)
xsol = Sol\bfinal
x = zeros(m1, 1);
x(basicvars) = xsol
A1*x
