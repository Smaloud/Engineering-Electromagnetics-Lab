clear;
clc;
%The same as Integration Part
rho = 1e-9;
separation = 100;
range_size_x = 4;
range_size_y = 3;
range_sampling_rate = 50;
range_vec_x = linspace(-range_size_x / 2, range_size_x /2, range_size_x * range_sampling_rate);
range_vec_y = linspace(-range_size_y / 2, range_size_y / 2, range_size_y * range_sampling_rate);
[mesh_x, mesh_y] = meshgrid(range_vec_x, range_vec_y);

%Calculate the Sum Potiential of cell Charges
V = zeros(size(mesh_x));
charges_part = 2 / separation;
charges_q = rho * charges_part;
%Take middle of small charge to represent the whole small charge 
for i = 0 : (separation - 1)
    V = V + Charge(charges_q, Point([-1 + charges_part / 2+ charges_part * i,0])).PotentialField(mesh_x,mesh_y);
end

figure(1);
grid on, axis equal;
mesh(mesh_x, mesh_y, V);
axis([-range_size_x / 2, range_size_x / 2, -range_size_y /2, range_size_y / 2, 0,60]);
xlabel("x (m)"), ylabel("y (m)"), zlabel("V (V)");
title(["Infinitesimal Method - Potential Distribution","Separation = " + separation + " (Gan Yuhao,12211629)"]);

%Calculate Contours and draw
V_eq_min = 0;
V_eq_max = 60;
V_eq_sampling_num = 10;
V_eq = linspace(V_eq_min, V_eq_max, V_eq_sampling_num);

figure(2);
hold on, grid on, axis equal;
contour(mesh_x, mesh_y, V, V_eq)
xlabel("x (m)"), ylabel("y (m)");
title(["Infinitesimal Method - Contours Distribution","Number of Separation = " + separation + " (Gan Yuhao,12211629)"]);

%Draw Streamlines
[E_x, E_y] = gradient(-V);
angles = linspace(-pi / 2, pi / 2, 3);
Ori_Point = 0.05;
appear_x = [-1 - Ori_Point .* cos(angles), linspace(-1, 1, 10), linspace(-1, 1, 10), 1 + Ori_Point .* cos(angles)];
appear_y = [Ori_Point * sin(angles), Ori_Point * ones(1, 10),-Ori_Point * ones(1, 10), -Ori_Point * sin(angles)];

figure(3);
hold on, grid on, axis equal;
contourf(mesh_x, mesh_y, V, V_eq);
fig_3 = streamline(mesh_x, mesh_y, E_x, E_y, appear_x, appear_y);
set(fig_3, "lineWidth", 1.2, "color", [0.2, 0.7, 0.7]);
title(["Infinitesimal Method - Equipotential Lines and Streamlines ", "Separation = " +separation + " (Gan Yuhao,12211629)"]);
xlabel("x (m)"), ylabel("y (m)");































