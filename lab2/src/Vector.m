classdef Vector
    properties
        x
        y
        z
    end

    properties(Dependent)
        length;
        matr;
    end

    methods
        function obj = Vector(p)
            obj.x = p(1);
            if (length(p)>=2)
                obj.y = p(2);
            end
            if (length(p)>=3)
                obj.z = p(3);
            end
        end

        function length = get.length(obj)
            length = sqrt(obj.x*obj.x+obj.y*obj.y);
        end

        function matr = get.matr(obj)
            matr = [obj.x;obj.y;obj.z];
        end
    end 
end
          