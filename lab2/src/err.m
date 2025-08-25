clear;
clc;
rho = 1e-9;
separation = 100;
range_size_x = 4;
range_size_y = 3;
range_sampling_rate = 50;
range_vec_x = linspace(-range_size_x / 2, range_size_x /2, range_size_x * range_sampling_rate);
range_vec_y = linspace(-range_size_y / 2, range_size_y / 2, range_size_y * range_sampling_rate);
[mesh_x, mesh_y] = meshgrid(range_vec_x, range_vec_y);
%Calculate the true value first
V_diff = Constants.k .* rho .* ...
log((1 - mesh_x + sqrt((1 - mesh_x) .* (1 -mesh_x) + mesh_y .* mesh_y)) ...
./ (-1 - mesh_x + sqrt((-1 - mesh_x) .* (-1 - mesh_x) + mesh_y .* mesh_y)));
charges_part = 2 / separation;
V_diff_inf = zeros(size(mesh_x));
charges_q = rho * charges_part;
%minus the infinitesimal ones
for i = 0 : (separation - 1)
    V_diff_inf = V_diff_inf+Charge(charges_q, Point([-1 + charges_part / 2+ charges_part * i, 0])).PotentialField(mesh_x,mesh_y);
end
V_diff = V_diff - V_diff_inf;
val_rms = rms(V_diff(:));

%draw the error heatmap
figure(1);
axis equal;
heatmap(V_diff, "GridVisible", "off");
%grid only
%set labels
ax = gca;
ax.XDisplayLabels = nan(size(ax.XDisplayData));
ax.YDisplayLabels = nan(size(ax.YDisplayData));
title(["Difference - Potential Distribution", "separation = " + separation + ", RMS = " + val_rms + "(Gan Yuhao, 12211629)"]);
xlabel("x"), ylabel("y");
