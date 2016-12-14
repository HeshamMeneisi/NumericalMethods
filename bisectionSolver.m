classdef bisectionSolver < solver

    %Use this as a template for later class implementations
    properties (Constant)
        reqLabels = [{'Xu'},{'Xl'}];
        dataLabels = [{'Xu'},{'Xl'},{'Xr'},{'f(Xu)'},{'f(Xl)'},{'f(Xr)'},{'ep'}];
    end

    properties (SetAccess = protected)
        f
        Xu
        Xl
    end

    methods (Access = protected)
        function step(obj)
            % Do one iteration
            % Update obj.currentValue, obj.lastValue, obj.stateData
            temp = obj.currentValue;
           a= obj.Xu ;
           b= obj.Xl ;
                    if f(a)*f(b)>0
            disp('error ')
        else
            p = (a + b)/2;
           if f(a)*f(p)<0
               b = p;
           else
               a = p;
           end
           obj.Xu =a;
            obj.Xl =b;
            p = (a + b)/2;
            obj.currentValue=p
              end
       obj.lastValue=temp;
       obj.stateData=[ a b p f(a) f(b) f(P) obj.getAppError()]

        end
    end
    methods
        function obj = bisectionSolver(equation, req)
            % req contain requirements
            obj.totalTime = 0;
            obj.f = equation;
            obj.Xu = req(1);
            obj.Xl = req(2);
        end
        function plotState(obj)
            % For demonstration only

            range = obj.Xu:0.05:obj.Xl;
            y = zeros(1,length(range));
            for i = 1:length(y)
                y(i) = obj.f(range(i));
            end
            plot(range, y, 'b'...
                , obj.currentValue, obj.f(obj.currentValue), 'g-x'...
                , obj.currentValue, obj.f(obj.currentValue), 'g-x'...
                , obj.lastValue, obj.f(obj.lastValue), 'g-x');
        end
    end

end
