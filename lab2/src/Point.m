classdef Point
    properties
        x
        y
        z
    end

    properties(Dependent)
        matr
    end

    methods
        function obj = Point(p)
            %定义坐标
            obj.x = p(1);
            if(length(p)>=2)
                obj.y = p(2);
            end 
            if(length(p)>=3)
                obj.z = p(3);
            end
        end

        function matr = get.matr(obj)
            %定义点坐标
            matr = [obj.x;obj.y;obj.z];
        end
        function y = minus(a,b)
            %重写minus函数，以满足Point与Vector相减的情况
            if(isa(b,"Point"))
                y = Vector(a.matr-b.matr);
            elseif(isa(b,"Vector"))
                y = Point(a.matr-b.matr);
            end
        end
    end
end
      

    