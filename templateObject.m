%Define an equaiton using an annonymous function of x
equation = @(x) x^3+2*x^2+2*x+1;

%Instantiate the class
test = templateClass(equation);

%Plot
test.plotState();