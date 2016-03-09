function [tableau,x,basicvars] = simplexItr(A, b, c, basicvars)
    [tableau,x,~,~,optimal]=checkbasic1(A,b,c,basicvars);
    TOL = 1e-7;
    while optimal ==0
        ctemp=tableau(end,1:end-1);
        btemp=tableau(1:end-1,end);
        Atemp=tableau(1:end-1,1:end-1);
        negativeIndex = find(ctemp<0);
        if length(negativeIndex) < 1
            tableau = 'No solution'
            break
        end
        result = [];
        for i = negativeIndex

            %Taking care of zero elements:
            nonZeroRows = find(abs(Atemp(:,i))>TOL);
            varVal=btemp(nonZeroRows)./Atemp(nonZeroRows,i);
            [~,j] = min(varVal);
            j = nonZeroRows(j);
            basicvars_temp = basicvars;
            basicvars_temp(j) = i;
            [tableau_temp,x,~,~,optimal]=checkbasic1(A,b,c,basicvars_temp);
            result = [result; tableau_temp(end,end)];
        end
        [~,index] = max(result);
        i = negativeIndex(index);

        %Taking care of zero elements:
        nonZeroRows = find(abs(Atemp(:,i))>TOL);
        varVal=btemp(nonZeroRows)./Atemp(nonZeroRows,i);
        [~,j] = min(varVal);
        j = nonZeroRows(j)
        basicvars(j) = i;
        [tableau_temp,x,~,~,optimal]=checkbasic1(A,b,c,basicvars);
        result = [result; tableau_temp(end,end)];

    end
    tableau = tableau_temp
end
