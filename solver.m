classdef (Abstract) solver < handle
    
    properties (SetAccess = protected)
        lastValue
        currentValue
        reqLabels
        dataLabels
        stateData
        totalTime
    end
    
    methods (Abstract)
        plotState(obj)
        setReq(obj,req)
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
            approximateError=(obj.currentValue-obj.lastValue)/obj.currentValue;
        end
        function objectLabel=get.reqLabels(obj)
            objectLabel=obj.reqLabels;
        end
        function objectLabel=get.dataLabels(obj)
            objectLabel=obj.dataLabels;
        end
        function objectData=get.stateData(obj)
            objectData=obj.stateData;
        end
        function objectTime=get.totalTime(obj)
            objectTime=obj.totalTime;
        end
    end
    
end

