classdef secantSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xi-1'},{'Xi'}];
        dataLabels = [{'Xi-1'}, {'Xi'}, {'Xi+1'}, {'f(Xi-1)'}, {'f(Xi)'}, {'ep'}];
    end
    
    properties (SetAccess = protected)
        eqn
        %% Plot data        
        x1        
        x2        
    end
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            xim1 = obj.lastValue;
            xi = obj.currentValue;
            fxim1 = obj.eqn(xim1);
            fxi = obj.eqn(xi);    
            xip1 = xi - (fxi*(xim1-xi)) / (fxim1-fxi);
            %% Update state
            obj.currentValue = xip1;
            obj.lastValue = xi;
            obj.stateData = [xim1 xi xip1 fxim1 fxi obj.getAppError()];            
            %% Set plotting range
            obj.x1 = min([xim1 xi xip1]);
            obj.x2 = max([xim1 xi xip1]);
        end
    end
    
    methods
        function obj = secantSolver(eqn, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.eqn = eqn;
            obj.lastValue = req(1);     % set Xi-1
            obj.currentValue = req(2);  % set Xi
        end       
        
        function value = get.x1(obj)
            value = obj.x1;
        end
        
        function value = get.x2(obj)
            value = obj.x2;
        end                
        
        function plotState(obj)            
            range = obj.x1:0.05:obj.x2;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.eqn(range(i));
            end            
            plot(range, y, 'b', [obj.x1 obj.x2], [obj.eqn(obj.x1) obj.eqn(obj.x2)], 'r'...
                , obj.currentValue, obj.eqn(obj.currentValue), 'g-o');
        end
    end
    
end