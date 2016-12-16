classdef newtonRaphSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xu'},{'Xl'}];
        dataLabels = [{'Xi'},{'Xi+1'}];
    end
    
    properties(SetAccess = protected)
        eqn
        x1=obj.currentvalue % represent xip1
        y1=obj.eqn(x1)
        x2=obj.lastvalue% represent xi
        %ep = 1e-9;
        fdx1= (obj.eqn(x1+ep)-obj.eqn(x1-ep))/(2*ep)% derivative of X1
        y2=x1-(y1/fdx1)
        tangent=y1+(x-x1)*fdx1
        
    end
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            
            xi = obj.lastValue;
            fxi = obj.eqn(xi);
            ep = 1e-9;
            fdxi= (obj.eqn(xi+ep)-obj.eqn(xi-ep))/(2*ep);
            xip1 = xi - (fxi) / (fdxi);
            fxip1 = obj.eqn(xip1);
            %% Update state% Update obj.currentValue, obj.lastValue, obj.stateData  
            obj.currentValue = xip1;
            
            obj.stateData = [ xi xip1  fxi fdxi obj.getAppError()];            
            %% Set plotting range
            
                      
        end
    end
    
    methods
        function obj = newtonRaphSolver(eqn, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.eqn = eqn;
            obj.currentvalue = req(1);% set Xu,xip1
            obj.lastvalue = req(2); % set Xl,xi 
            
        end
          
        
        function plotState(obj)
            % For demonstration only
            range = abs(obj.x1-obj.x2);
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.eqn(range(i));
                
                
            end
            
            
            title('Newton''s Method Solution: ');
            xlabel('Iteration','FontSize',16)
ylabel('$x$','FontSize',16,'Interpreter','latex')
            plot(range, y, 'b', [obj.X2 obj.X1], [obj.eqn(obj.X2) obj.eqn(obj.X1)], 'r'...
                , obj.currentValue, obj.eqn(obj.currentValue), 'g-o');
            
            
                
            
            hold on;
            pad=0.1*range;
            if(obj.x1>obj.x2)
            
            ezplot(obj.tangent, [obj.x2-pad,obj.x1+pad])
            end
            if(obj.x1<obj.x2)
            
            ezplot(obj.tangent, [obj.x1-pad,obj.x2+pad])
            end

 hold off;
            
        end
    end
    
end


