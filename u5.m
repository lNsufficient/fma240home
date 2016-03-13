clear;
clc;
%a = 1:64;
%vec2mat(a, 16)

%c1 = 2;
%c = c1:16:64

startA = eye(16);

aa1 = ones(1, 4);
Oa = zeros(1, 4);
Ob = zeros(1, 16);
A1 = kron(startA, aa1);

O3 = zeros(1, 3);
ab3 = [1 O3 1 O3 1 O3 1];

ac1 = [1 zeros(1,15)];
ac2 = [ac1 ac1 ac1 1];

ad = [1 0 0 0 1 zeros(1, 11) 1 0 0 0 1];
Oda = zeros(4, 8);
Odb = zeros(4, 16);

A2sub = zeros(4, 16);
A4sub = A2sub;
for i = 1:4
    A2sub(i, i:(12+i)) = ab3;
    A4sub(i, i:(20+i)) = ad;
end
starta = eye(4);
A2 = kron(starta, A2sub);

A4 = [A4sub zeros(4,40);
    zeros(4, 8) A4sub zeros(4, 32);
    zeros(4, 32) A4sub zeros(4, 8);
    zeros(4, 40) A4sub];

A3 = zeros(16,64);
for i = 1:16
    A3(i, i:(48+i)) = ac2;
end
A5 = zeros(4, 64);
A5(1, 17) = 1;
A5(2, 27) = 1;
A5(3, 52) = 1;
A5(4, 62) = 1;

A = [A1; A2; A3; A4; A5];
%A = [A1; A2; A3; A4];
b = ones(68, 1);
c = -ones(64, 1); %Så det optimala värdet är -16

Astandard = [A; -A];
bstandard = [b; -b];
cstandard = c;

%This should be correct
dualA = -Astandard';
[m, n] =  size(dualA);
dualAslack = [dualA eye(m)];
slackvars = (n+1):(n+m);
dualb = -cstandard; %Här är det viktigt att dualb >= 0 för alla element
%Annars hade det inte varit okej att införa slack-variabler som vi har
%gjort

if (min(dualb)<0)
    error('dualb har element < 0')
end
dualc = -bstandard;


dualcslack = -[bstandard; zeros(64,1)]; %Så att vi maximerar i stället för minimerar



basicvars = slackvars;
size(dualAslack);
size(dualb);
size(dualc);
[tableau,basicvars,steps]=simp(dualAslack,dualb,dualcslack,basicvars);
[tableau,xb,basic,feasible,optimal]=checkbasic1(dualAslack,dualb,dualcslack,basicvars);

lb = zeros(n, 1);
intcon = 1:n;
x1 = intlinprog(-dualc,intcon,dualA,dualb, [], [], lb)
x2 = intlinprog(c,1:64,Astandard,bstandard, [], [], lb) %Gives the correct solution...

% testA = tableau(1:end-1, 1:end-1)
% testb = tableau(1:end-1, end)
% testc = -tableau(end, 1:end-1)'
% 
% [Aback,bback,cback] = dualproblem(testA,testb,testc, basicvars)
% 
% [m, n] = size(Aback);
% 
% newBasicvars = setdiff((1:n), basicvars);
% 
% [tableau,x,basic,feasible,optimal]=checkbasic1(Aback,bback,cback,newBasicvars)
% 
% x = x(newBasicvars)

%Try getting back basicVariables
dualAtest = [-A' A' eye(64)];
newBasicvars = setdiff((1:n), basicvars);
Afirst = [Astandard [eye(68); -eye(68)]];
[tableau,xb,basic,feasible,optimal]=checkbasic1(Afirst,b,c,newBasicvars);
%Detta funkade inte, för newBasicvars innehöll basicVars av för stort
%index. Detta får mig att tro att simplexmetoden inte fungerar som den ska.
%

csIndex = find(xb > 0.1);
csIndex = find(x1 > 0.1);
csAstandard = Astandard(csIndex, :);
csbstandard = bstandard(csIndex);
x = [csAstandard; A5]\[csbstandard; ones(4,1)]; %Detta borde räcka, men det blir tyvärr fel.
%x = [csAstandard; A5;A1; A2; A3; A4]\[csbstandard; ones(36, 1)]; %Detta borde räcka, men det blir tyvärr fel.
%x = csAstandard\csbstandard;
xindicies = find(x>0.1)

standardProblem = find(Astandard*x >= bstandard)

dualAnoSlack = [dualA zeros(64,64)];
dualSol = dualAnoSlack*xb

%xb innehåller bara ettor och nollor, inga negativa. Bra!
%Detta ger mig en lösning med exakt 16 ettor i x - bra!
%Dessutom är x - 64x1-vector - bra!
%Slutligen är också det optimala värdet för maximeringen av dual 16, alltså
%-(-16) vilket stämmer bra. 
%Dock är det inte lösningen till sudoku och det är framför allt inte
%lösningen till problemet, vars dual jag försökte lösa.

%En anledning till detta kan vara att csAstandard - [16x64], när
%operationen csAstandard\csbstandard utförs så hittas bara en av alla
%möjliga lösningar. Jag testade med den korrekta lösningen här och
%(självklart) ger den rätt lösning. Detta ger viss information om att
%csAstandard inte kan vara den rätta, problemet är tydligen inte entydigt
%bestämt. 

%Testar den givna uppgiften:
% Testsol = [3 8 10 13 17 22 27 32 34 37 44 47 52 55 57 62];
% xtest = zeros(64, 1);
% xtest(Testsol) = 1;
% [tableau,xb,basic,feasible,optimal]=checkbasic1(Astandard,bstandard,cstandard,Testsol);
% bstandardtest = find((Astandard*xtest <= bstandard)==0)
% btest = find((A*xtest <= b)==0)
% 
% %borde ge samma lösning om jag använder compl slackness på denna...
% %OBS detta va inte bra...
% isone = find(xtest == 1)
% dualAcs = dualA(isone,:);
% dualbcs = -dualb(isone);
% y = dualAcs\dualbcs;
% dualCstest = find((dualAcs*y <= dualbcs) == 0)
% dualtest = find((dualA*y <= dualb) == 0)
% dualSlacktest =  find((dualAslack*[y; zeros(64,1)] <= dualb) == 0)
% basicvars = find(y)


%[tableau,xb,basic,feasible,optimal]=checkbasic1(dualAslack,dualb,dualc,(1:64));
% dualbasicvars = basicvars;
% 
% [startA,startb,startc] = dualproblem(dualAslack,dualb,dualc,slackvars);
% [mstart,nstart] = size(startA);
% 
% basicvars = 1:mstart;
% basicvars = setdiff(basicvars, dualbasicvars);
% 
% [tableau,xb,basic,feasible,optimal]=checkbasic1(startA,startb,startc,basicvars);
% 
% disp('WIN')
% 
% %ac1 = [1 0 0 0 Oa Oa Oa]
% %ac2 = [ac1 ac1 ac1 1]
% 
% 
% %A3 = [ac2 0 0 0 Oa Oa Oa]