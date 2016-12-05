classdef (Abstract) solver
    
    properties (SetAccess = protected)
        lastValue
        currentValue
        labels
        stateData
        totalTime
    end
    
    methods (Abstract)
        step(obj)
        plotState(obj)
    end
    
    methods 
        function approximateError = getAppError(obj)
            approximateError=(obj.currentValue-obj.lastValue)/obj.currentValue;
        end
        function objectLabel=get.labels(obj)
            objectLabel=obj.labels;
        end
        function objectData=get.stateData(obj)
            objectData=obj.data;
        end
        function objectTime=get.totalTime(obj)
            objectTime=obj.totalTime;
        end
    end
    
end

