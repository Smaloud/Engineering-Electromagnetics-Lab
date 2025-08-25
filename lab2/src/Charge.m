classdef Charge
    %定义一个Charge类，用于计算电位
     
    properties
        q
        p
    end

    methods
        function obj = Charge(q,p)
            obj.p = p;
            obj.q = q;
        end

        function d = Distance(obj,p)
            displacement = obj.p-p;
            d = displacement.length;
        end

        function V = PotentialField(obj,x_mesh,y_mesh)
            [ny,nx] = size(x_mesh);
            V = zeros(ny,nx);
            for x_dx = 1:nx
                for y_dy = 1:ny
                    r = obj.Distance(Point([x_mesh(y_dy,x_dx),y_mesh(y_dy,x_dx)]));
                    V(y_dy,x_dx) = Constants.k * obj.q/r;
                end
            end
        end
    end
end