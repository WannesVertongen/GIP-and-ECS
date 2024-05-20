% Configuration
set(0,'DefaultFigureWindowStyle','docked')
configuration = 'cl1_angle_up';
clc 
close all

% Load data based on the configuration
[data, input_data_pos, input_data_vel, current_file, reverse, T] = readData(configuration);

% Parameters for 'pickup' configuration
if strcmp(configuration, 'pickup')
    fs = 50;
    total_time = 9.7551;
    t1 = 0.5365;
    t2 = 3.506;
    t3 = 5.225;
    t4 = 9.7551;
    t_pickup = 0:1/fs:total_time;
    path_pickup = zeros(size(t_pickup));
    
    path_pickup(t_pickup <= t1) = 50;
    path_pickup(t_pickup > t1 & t_pickup <= t2) = 50 * (1 - (t_pickup(t_pickup > t1 & t_pickup <= t2) - t1) / (t2 - t1));
    path_pickup(t_pickup > t2 & t_pickup <= t3) = 0;
    path_pickup(t_pickup > t3 & t_pickup <= t4) = 80 * (t_pickup(t_pickup > t3 & t_pickup <= t4) - t3) / (t4 - t3);
    
    input_data_pos = path_pickup / 100;
    input_data_vel = diff(input_data_pos) / (1/fs);
end

% Constants
freq = 50;
time_step = 1/freq;
R_x = 0.015;  % 1.5cm
R_z = 0.055; %5.5cm

% Extract and preprocess data
time = data(:, 1) - data(1, 1);
x_position = data(:, 4);
x_velocity = data(:, 5);
angle = smoothdata(data(:, 15));
z_position = data(:, 8) * 100;

% Find zero crossing and collision index
first_zero_index = find(x_position < 0.01 & x_position > -0.01, 1, 'last');
time_shift = time(first_zero_index);
[~, collision_index] = max(x_position(first_zero_index:end));

% Adjust for pickup configuration
pickup_shift = 0;
pickup_shift_2 = 0;
if strcmp(configuration, 'pickup')
    pickup_shift = time_shift;
    pickup_shift_2 = 1;
end

% Prepare input data for plotting
input_time = 1:length(input_data_pos);
current_time = 1:length(current_file);
input_position = input_data_pos(1, :);
[~, collision_index_input] = max(input_position);
input_velocity = input_data_vel(1, :);

% Current and load angle data
current_x_pos = current_file(:, 1);
current_amp = current_file(:, 2) / 1000;
load_angle = current_file(:, 3) / 1000;
z_torque = current_file(:,4);
current_x_velocity = [diff(current_x_pos);zeros(1,1)];


% Plot Current and Load Angle
figure;
plot(current_time / freq, current_x_pos);
xlabel('Time (s)');
ylabel('X-position (m)');
xlim([time(1), time(end)]);
title('X-position vs time')

figure;
plot(current_time / freq, current_x_velocity);
xlabel('Time (s)');
ylabel('X-velocity (m/s)');
xlim([time(1), time(end)]);
ylim([-5, 10]);
title('X-velocity vs time')

figure;
plot(current_time / freq, current_amp);
xlabel('Time (s)');
ylabel('Current (mA)');
xlim([time(1), time(end)]);
xline(current_time(collision_index_input) / freq + time_shift);
title('Current vs Time');

figure;
plot(current_time / freq, load_angle);
xlabel('Time (s)');
ylabel('Load Angle (rad)');
xlim([time(1), time(end)]);
title('Load Angle vs Time');

% Calculate and plot Power and Energy
angular_velocity = current_x_velocity/R_x;
current = current_amp .* cos(load_angle);
index_min = min(length(input_velocity), length(current));
power = current(end-index_min+1:end)' .* angular_velocity';
current_time_adjusted = current_time(end-index_min+1:end);
energy = cumtrapz(power);

figure;
plot(current_time_adjusted / freq, power);
xlabel('Time (s)');
ylabel('Power (W)');
xlim([time(1), time(end)]);
title('Power Relation');

figure;
plot(current_time_adjusted / freq, energy);
xlabel('Time (s)');
ylabel('Energy (J)');
xlim([time(1), time(end)]);
title('Energy Relation');

