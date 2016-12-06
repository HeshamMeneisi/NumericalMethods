classdef templateClass < solver
    
    %Use this as a template for later class implementations
    
    properties
        equation
        r1
        r2
    end
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            % Update obj.lastValue, obj.currentValue, obj.stateData            
        end
    end
    methods
        function obj = templateClass(equation)
            % req contain requirements
            obj.totalTime = 0;
            obj.equation = equation;
            % reqLabels (e.g Xu,Xl)
            obj.reqLabels = [{'Xu'},{'Xl'}];
            % dataLabels (e.g Xi,Xi+1)
            obj.dataLabels = [{'Xi'},{'Xi+1'}];
        end
        function setReq(obj,req)
            obj.r1 = req(1)
            obj.r2 = req(2)
        end
        function plotState(obj)
            % For demonstration only
            ezplot(obj.equation);
        end
    end
    
end


