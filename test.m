clear;
clear classes;
% %Define an equaiton using an annonymous function of x
eqnstr = '@(x) x^3+2*x^2+2*x+1';
equation = str2func(eqnstr);
% 
% %% Test initial
% 
% secantSolver.dataLabels
% secantSolver.reqLabels
% 
% %Instantiate the class
% obj = secantSolver(equation, [2 4]);
% 
% %% Step
% 
% obj.nextStep();
% 
% %% Test final
% 
% plotState(obj);
% obj.stateData
% obj.totalTime

%% Using equation to find f(x) and f'(x)
v = 5
ep = 1e-9;
fx = equation(v)
% Actual derivative
fxd = 3*v^2+4*v+2
% Estimated approximate derivative
fxdest = (equation(v+ep)-equation(v-ep))/(2*ep)
%% Using diff
syms x
d=matlabFunction(diff(equation,x))
d(5)