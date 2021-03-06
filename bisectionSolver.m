classdef bisectionSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xu'},{'Xl'}];
        dataLabels = [{'Xu'},{'Xl'},{'Xr'},{'f(Xu)'},{'f(Xl)'},{'f(Xr)'},{'ep'}];
    end
    
    properties (SetAccess = protected)
        Xu
        Xl
    end
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            % Update obj.currentValue, obj.lastValue, obj.stateData
            obj.lastValue = obj.currentValue;
            a= obj.Xu ;
            b= obj.Xl ;
            if obj.f(a)*obj.f(b)>0
                disp('Warning: Diverging!')
            end
            p = (a + b)/2;
            if obj.f(a)*obj.f(p)<0
                obj.Xl = p;
            else
                obj.Xu = p;
            end
            obj.currentValue=p;
            obj.stateData=[a b obj.currentValue obj.f(a) obj.f(b) obj.f(obj.currentValue) obj.getAppError()];
        end
    end
    methods
        function obj = bisectionSolver(equation, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.f = equation;
            obj.Xu = req(1);
            obj.Xl = req(2);
            title('Bisection Method Solution: ');
            xlabel('X','FontSize',16)
            ylabel('F(x)','FontSize',16)
            hold on
        end
        
        function plotState(obj)
            % For demonstration only
            xu = obj.stateData(1);
            xl = obj.stateData(2);
            mi = min(xl,xu)-1;
            ma = max(xl,xu)+1;
            range = mi:0.05*(ma-mi):ma;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.f(range(i));
            end
            plot(range, y, 'b'...
                ,[mi ma], [0 0], 'g'...
                ,obj.currentValue, 0, 'r-x'...
                ,xl, obj.f(xl), 'g-o'...
                ,xu, obj.f(xu), 'g-o');
        end
    end
    
end
