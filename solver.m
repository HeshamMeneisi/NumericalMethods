classdef (Abstract) solver < handle
    
    properties (Abstract, Constant, GetAccess = public)
        reqLabels
        dataLabels 
    end
    properties (SetAccess = protected)
        lastValue
        currentValue
        stateData
        totalTime
        f
    end
    
    methods (Abstract)
        plotState(obj)
    end
    
    methods (Abstract, Access = protected)        
        step(obj)
    end
    
    methods 
        function nextStep(obj)  
            tic;
            step(obj);         
            obj.totalTime = obj.totalTime + toc;            
        end
        function approximateError = getAppError(obj)
            approximateError = abs((obj.currentValue-obj.lastValue)/obj.currentValue);
            if obj.f(obj.currentValue) == 0
                approximateError = 0;
            elseif isempty(approximateError)
                approximateError = Inf;
            end
        end
        function value=get.stateData(obj)
            value = obj.stateData;
        end
        function value=get.totalTime(obj)
            value = obj.totalTime;
        end
        function value=get.currentValue(obj)
            value = obj.currentValue;
        end
    end
    
end

