classdef fixedPointSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = {'X0'};
        dataLabels = [{'Xi+1'},{'Xi'},{'ep'}];
    end
    
    properties
        f
    end
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            obj.lastValue = obj.currentValue;
            obj.currentValue = obj.f(obj.currentValue); 
            % Update obj.currentValue, obj.lastValue, obj.stateData            
            obj.stateData=[obj.currentValue obj.lastValue obj.getAppError()];            
        end
    end
    
    methods
        function obj = fixedPointSolver(equation, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.f = equation;
            obj.currentValue = req(1);
        end
        function plotState(obj)
            fplot(obj.f);
            hold on;
            range = obj.currentValue:0.05*abs(obj.currentValue-obj.lastValue):obj.lastValue;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.f(range(i));
            end
            plot(range, y, 'b', obj.currentValue,obj.f(obj.currentValue), 'r-x');
        end
    end
    
end


