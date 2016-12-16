classdef falsePosSolver < solver
    
    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xu'},{'Xl'}];
        dataLabels = [{'Xu'},{'Xl'},{'Xr'},{'f(Xu)'},{'f(Xl)'},{'f(Xr)'},{'ep'}];
    end
    
    properties
        Xu
        Xl
    end
    
    
    methods (Access = protected)
        function step(obj)
            % Do one iteration
            % Update obj.currentValue, obj.lastValue, obj.stateData
            obj.lastValue = obj.currentValue;
            a = obj.Xl;
            b = obj.Xu;
            if obj.f(a)*obj.f(b)>0
                disp('Warning: Diverging!')
            end
            root = (b*obj.f(a)-a*obj.f(b))/(obj.f(a)-obj.f(b));
            if (root-obj.currentValue < 1e4) & (obj.f(root) > 1)
                root = (a+b)/2;
                disp('Convergence too slow, bisection step taken.');
            end
            obj.currentValue=root;
            if(obj.f(a)*obj.f(root) < 0)
                obj.Xu = root;
            else
                obj.Xl = root;
            end
            obj.stateData=[b a root obj.f(b) obj.f(a) obj.f(root) obj.getAppError()];
        end
    end
    
    methods
        function obj = falsePosSolver(equation, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.f = equation;
            obj.Xu = req(1);
            obj.Xl = req(2);
            title('False Position Method Solution: ');
            xlabel('X','FontSize',16)
            ylabel('F(x)','FontSize',16)
            hold on
        end
        
        function plotState(obj)
            xu = obj.stateData(1);
            xl = obj.stateData(2);
            mi = min(xl,xu)-1;
            ma = max(xl,xu)+1;
            range = mi:0.05*(ma-mi):ma;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.f(range(i));
            end
            plot(range, y, 'b'...
                ,[mi ma], [0 0], 'g'...
                ,obj.currentValue, 0, 'r-x'...
                ,[xl xu], [obj.f(xl) obj.f(xu)], 'g-o');
        end
    end
    
end


