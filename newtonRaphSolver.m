classdef newtonRaphSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'X0'}];
        dataLabels = [{'Xi'},{'Xi+1'},{'f(Xi)'},{'f(Xi+1)'},{'ep'}];
    end
    
    properties(SetAccess = protected)
        eqn
    end
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            
            xi = obj.currentValue;
            obj.lastValue = xi;
            fxi = obj.eqn(xi);
            ep = 1e-9;
            fdxi= (obj.eqn(xi+ep)-obj.eqn(xi-ep))/(2*ep);
            xip1 = xi - (fxi) / (fdxi);
            fxip1 = obj.eqn(xip1);
            %% Update state% Update obj.currentValue, obj.lastValue, obj.stateData
            obj.currentValue = xip1;
            
            obj.stateData = [xi xip1 fxi fxip1 obj.getAppError()];
            %% Set plotting range
            
            
        end
    end
    
    methods
        function obj = newtonRaphSolver(eqn, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.eqn = eqn;
            obj.currentValue = req(1); % set xi
            title('Newton-Raphson Method Solution: ');
            xlabel('X','FontSize',16)
            ylabel('F(x)','FontSize',16)
            hold on
        end
        
        
        function plotState(obj)
            % For demonstration only
            mi = min(obj.currentValue,obj.lastValue)-1;
            ma = max(obj.currentValue,obj.lastValue)+1;
            range = mi:0.05*abs(ma-mi):ma;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.eqn(range(i));
            end
            
            x1 = obj.lastValue;
            y1 = obj.eqn(x1);
            x2 = obj.currentValue;            
            plot(range, y, 'b', [x1 x2], [y1 0], 'r'...
                ,x1,y1, 'g-o'...
                ,x2, 0, 'r-x'...
                ,[mi ma], [0 0], 'g');  
        end
    end
    
end


