clear;
clc;
% The same as before
rho = 1e-9; 
separation = 100;
range_size_x = 4;
range_size_y = 3;
range_sampling_rate = 50;
range_vec_x = linspace(-range_size_x / 2, range_size_x /2, range_size_x * range_sampling_rate);
range_vec_y = linspace(-range_size_y / 2, range_size_y /2, range_size_y * range_sampling_rate);
[mesh_x, mesh_y] = meshgrid(range_vec_x, range_vec_y);

%Calculate the Potential Distribution Difference 
val_range = [1, 5 : 5 : 100];
% range segment from 5 to 100, separation of 5
val_rms = [];
i = 0;
for separation = val_range
disp(separation);
i = i + 1;
V_diff = Constants.k .* rho .* ...
log((1 - mesh_x + sqrt((1 - mesh_x) .* (1 - mesh_x) + mesh_y .* mesh_y)) ...
./ (-1 - mesh_x + sqrt((-1 - mesh_x) .* (-1 -mesh_x) + mesh_y .* mesh_y)));
charges_part = 2 / separation;
charges_q = rho * charges_part;
for i = 0 : (separation - 1)
V_diff = V_diff - Charge(charges_q, Point([-1 + charges_part / 2+ charges_part * i,0])).PotentialField(mesh_x,mesh_y);
end
val_rms = [val_rms, rms(V_diff(:))];
end

%plot
figure(1);
grid on, axis equal;
plot(val_range, val_rms, '-o', 'lineWidth', 1.0);
xlim([0, 100]);
title("RMS Curve (Gan Yuhao,12211629)");
xlabel("Segments"), ylabel("RMS (V)")