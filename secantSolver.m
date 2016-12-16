classdef secantSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xi-1'},{'Xi'}];
        dataLabels = [{'Xi-1'}, {'Xi'}, {'Xi+1'}, {'f(Xi-1)'}, {'f(Xi)'}, {'ep'}];
    end
    
    properties (SetAccess = protected)
        eqn
        %% Plot data        
        xpre       
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
            obj.xpre = xim1;
        end
    end
    
    methods
        function obj = secantSolver(eqn, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.eqn = eqn;
            obj.lastValue = req(1);     % set Xi-1
            obj.currentValue = req(2);  % set Xi
            title('Secant Method Solution: ');
            xlabel('X','FontSize',16)
            ylabel('F(x)','FontSize',16)
            hold on
        end                     
        
        function plotState(obj)       
            mi = min([obj.currentValue, obj.lastValue, obj.xpre])-1;
            ma = max([obj.currentValue, obj.lastValue, obj.xpre])+1;
            range = mi:0.05*(ma-mi):ma;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.eqn(range(i));
            end            
            xs = [obj.currentValue obj.lastValue obj.xpre];
            ys = [0 obj.eqn(xs(2)) obj.eqn(xs(3))];
            plot(range, y, 'b', xs, ys, 'r'...
                ,[mi ma], [0 0], 'g'...
                ,xs(1), ys(1), 'r-x'...
                ,xs(2), ys(2), 'g-o'...
                ,xs(3), ys(3), 'g-o');            
        end
    end
    
end