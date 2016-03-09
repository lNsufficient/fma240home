clear;

A = [2 1 3 1; 2 3 0 4; 3 1 2 0];
A1 = [A eye(3)];
b1 = [8 12 18]';
c1 = [1 2 1 1 0 0 0]';

[m1, n1] = size(A1);

basicvars = [5 6 7]
[tableau,x,basic,feasible,optimal] = checkbasic1(A1, b1, c1, basicvars);
tableau

basicvars = [5 2 7]
[tableau,x,basic,feasible,optimal] = checkbasic1(A1, b1, c1, basicvars);
tableau

basicvars = [3 2 7]
[tableau,x,basic,feasible,optimal] = checkbasic1(A1, b1, c1, basicvars);
tableau

optval = tableau(end, end)
optval2 = c1'*x

x1 = x

disp('upper bound')
optval

disp('branch x3 <= 1')

A2 = [A1 zeros(3,1); 0 0 1 0 0 0 0 1];
basicvars = [3 2 7 8];
c2 = [c1; 0];
b2 = [b1; 1];
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b2, c2, basicvars);

feasible
disp('no longer feasible');
disp('searches for feasible sol using dual');

[dualA2,dualb2,dualc2] = dualproblem(A2, b2, c2, [5, 6, 7, 8]);

dualbasicvars = setdiff(1:8,basicvars);
[tableau,x,basic,feasible,optimal] = checkbasic1(dualA2, dualb2, dualc2, dualbasicvars);
tableau

dualbasicvars = [1 4 8 6];
[tableau,x,basic,feasible,optimal] = checkbasic1(dualA2, dualb2, dualc2, dualbasicvars);
tableau
optimal
optval = -tableau(end, end)

basicvars = setdiff(1:8, dualbasicvars);
[tableau,x,basic,feasible,optimal] = checkbasic1(A2, b2, c2, basicvars);
x2 = x

disp('branch x3 >= 2')

A3 = [A1 zeros(3,1); 0 0 -1 0 0 0 0 1];
basicvars = [3 2 7 8];
c3 = [c1; 0];
b3 = [b1; -2];

[tableau,x,basic,feasible,optimal] = checkbasic1(A3, b3, c3, basicvars)
feasible
disp('no longer feasible')
disp('searches for feasible solution using dual');

[dualA3,dualb3,dualc3] = dualproblem(A3, b3, c3, [5, 6, 7, 8]);

dualbasicvars = setdiff(1:8,basicvars);
[tableau,x,basic,feasible,optimal] = checkbasic1(dualA3, dualb3, dualc3, dualbasicvars);
tableau

dualbasicvars = [1 4 5 8];
[tableau,x,basic,feasible,optimal] = checkbasic1(dualA3, dualb3, dualc3, dualbasicvars);
tableau


optval = -tableau(end, end)

basicvars = setdiff(1:8, dualbasicvars);
[tableau,x,basic,feasible,optimal] = checkbasic1(A3, b3, c3, basicvars);
x3 = x


% atest = [2 5 1 0; 8 3 0 1];
% a2test = [atest zeros(2, 1); 1 0 0 0 1];
% ctest = [7 3 0 0]';
% c2test = [ctest; 0];
% btest = [30 48]';
% b2test = [btest; 4];
% 
% [dualA2,dualb2,dualc2] = dualproblem(a2test, b2test, c2test, [3 4 5]);
% 





%endresult = A1*xopt

%tableau(:, end)./tableau(:,4)
%tableau(:, end)./tableau(:,n1) minsta positiva värdet väljer rad.
