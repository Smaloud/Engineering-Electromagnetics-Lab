%% Clear
clear;
clc;
%% Initialization
% Basic Parameters
m = 0.02;
q = 0.016;
dt = 0.001;
T = 5;
E = [0, 0, 0];
B = [0, 0, 8];
% Particles
n = 16;
k = 0 : n - 1;
v = 0.1 * sin(k' * pi / 8) * [1, 0, 0] + 0.1 * cos(k' * pi / 8) * [0, 1, 0] + ones(n, 1) * [0, 0, 10];
r = zeros(n, 3);
% Recording
R = zeros(1, n * 3); % [x_0, x_1, ..., x_(n-1), y_0, ..., y_(n-1), z_0, ... , z_(n-1); ...]

%% Simulation
B_X = [0, -B(3), B(2); B(3), 0, -B(1); -B(2), B(1), 0];
for t = 0 : dt : T
    F = q * (E - v * B_X'); % F = q * (E + v x B)
    v = v + F / m * dt;
    r = r + v * dt;
    R = [R; reshape(r, 1, n * 3)];
end

%% Plotting
figure(1);
hold on, grid on;
plot3(R(:, 1:n), R(:, n+1:2*n), R(:, 2*n+1:3*n));
title(["Particle Motion Trajectories (dt = " + dt + "s, T = " + T + "s)", "(Gan Yuhao, 12211629)"]);
xlabel("x (m)"), ylabel("y (m)"), zlabel("z (m)");
daspect([0.5,0.5,50]);
view(3);
saveas(1,"dt = "+dt+"s"+", T = "+T+"s.png")