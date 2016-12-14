classdef bisectionSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xu'},{'Xl'}];
        dataLabels = [{'Xu'},{'Xl'},{'Xr'},{'f(Xu)'},{'f(Xl)'},{'f(Xr)'},{'ep'}];
    end
    
    properties (SetAccess = protected)
        f
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
                disp('error ')
            else
                p = (a + b)/2;
                if obj.f(a)*obj.f(p)<0
                    b = p;
                else
                    a = p;
                end
                obj.Xu =a;
                obj.Xl =b;
                p = (a + b)/2;
                obj.currentValue=p;
            end
            obj.stateData=[ a b obj.currentValue obj.f(a) obj.f(b) obj.f(obj.currentValue) obj.getAppError()];            
        end
    end
    methods
        function obj = bisectionSolver(equation, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.f = equation;
            obj.Xu = req(1);
            obj.Xl = req(2);
        end
        function plotState(obj)
            % For demonstration only
            
            range = obj.Xl:0.05:obj.Xu;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.f(range(i));
            end
            plot(range, y, 'b'...
                ,[obj.Xl obj.Xu], [0 0], 'g'...
                ,obj.currentValue, 0, 'r-x'...
                ,obj.Xl, 0, 'r-x'...
                ,obj.Xu, 0, 'r-x');
        end
    end
    
end
