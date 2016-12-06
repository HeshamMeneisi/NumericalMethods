clear;
clear classes;
%Define an equaiton using an annonymous function of x
equation = @(x) x^3+2*x^2+2*x+1;

%Instantiate the class
obj = templateClass(equation);
obj.setReq([2 4]);

%% Test initial

obj.dataLabels
obj.reqLabels

%% Step

obj.nextStep();

%% Test final

plotState(obj);
obj.stateData
obj.totalTime