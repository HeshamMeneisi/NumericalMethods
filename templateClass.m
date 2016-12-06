classdef templateClass < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xu'},{'Xl'}];
        dataLabels = [{'Xi'},{'Xi+1'}];
    end
    
    properties
        equation
        r1
        r2
    end
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            % Update obj.currentValue, obj.lastValue, obj.stateData            
        end
    end
    
    methods
        function obj = templateClass(equation, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.equation = equation;
            obj.r1 = req(1);
            obj.r2 = req(2);
        end
        function plotState(obj)
            % For demonstration only
            ezplot(obj.equation);
        end
    end
    
end


