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
        end
        function objectData=get.stateData(obj)
            objectData=obj.stateData;
        end
        function objectTime=get.totalTime(obj)
            objectTime=obj.totalTime;
        end
    end
    
end

