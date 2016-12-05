classdef templateClass < solver
    
    %Use this as a template for later class implementations
    
    properties
        equation
    end
    
    methods
        function obj = templateClass(equation)
            obj.equation=equation;
        end
        function step(obj)
        end
        function plotState(obj)
            ezplot(obj.equation);
        end
    end
    
end


