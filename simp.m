function [tableau,basicvars,steps]=simp(A,b,c,basicvars)
% [y,basicvars,steps] = simpmovie(A,b,c,basicvars)
%
% A    m*n-matrix
% b    m*1-matrix, b>=0
% c    n*1-matrix
% basicvars 1*m - matrix with indices for feasible basic variables.
%
% Shows a movie of how the simplex method works
% on the problem
%                   max(c'x), when Ax=b, x>=0.
%
TOL = 1e-6;
[m,n]=size(A);

% Create a tableau with slack variables
[tableau,xb,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);

steps=0;
% Loop until all reduced costs are non-positive
while min(tableau(m+1,1:n)) < -1e-6
    steps = steps+1;
    
    %clc
    %disp(tableau);
    basicvars
    
    
    
    % Input variables to enter and leave
    btemp=tableau(1:end-1,end);
    Atemp=tableau(1:end-1,1:end-1);
    %q=min(find(tableau(end,1:end-1)< 0));
    [~,q]=min(tableau(end,1:end-1));
    nonZeroRows = find(abs(Atemp(:,q))>TOL);
    varVal=btemp(nonZeroRows)./Atemp(nonZeroRows,q);
    bZeroRows = find(abs(btemp) < TOL);
    j = [];
    if (~isempty(bZeroRows))
        bZeroPositiveRows = find(Atemp(bZeroRows,q)>TOL); %Detta stämmer nog inte BORDE VA TOL HÄR, fick med en nolla....
        jtemp = min(bZeroPositiveRows); %Ändrade till jtemp för enklare felsökning
        j = bZeroRows(jtemp);
    %-detta ändrades under hemtentan:   
    %<----
        %if (isempty(j))
        %    error('Problemet är inte bounded')
        %end
    %else
    %---->
    end
    if (isempty(j))
    %----
        jtemp = min(find(varVal == min(varVal(find(varVal>0)))));
        if (isempty(jtemp)) %Ändrade till jtemp för enklare felsökning
            error('Problemet är inte bounded')
        end
        j= nonZeroRows(jtemp);
    end

    p = basicvars(j);
    % Update basic vars
    basicvars = union(basicvars, q);
    q
    basicvars = setdiff(basicvars, p);
    
    % Compute new tableau with the new basic variables
    
    [tableau,xb,basic,feasible,optimal]=checkbasic1(A,b,c,basicvars);
    if ~feasible
        disp(tableau)
        error('You have chosen an incorrect pivot element. Restart.');
    end
end
basicvars

