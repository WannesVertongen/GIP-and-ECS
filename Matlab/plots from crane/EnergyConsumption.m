% Configuration
set(0,'DefaultFigureWindowStyle','docked')
configuration = 'ramp';
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

if strcmp(configuration, 'experiment1')
    fs = 50;
    total_time = 21;
    t0 = 7.032;
    t1 = 7.7 - t0;
    t2 = 12.4768 -t0;
    t3 = 13.5 -t0;
    t4 = 16.6 -t0;
    t5 = 20.6224 -t0;
    t_exp1 = 0:1/fs:t5;
    path_exp1 = zeros(size(t_exp1));
    
    path_exp1(t_exp1 <= t1) = 85;
    path_exp1(t_exp1 > t1 & t_exp1 <= t2) = 85 * (1 - (t_exp1(t_exp1 > t1 & t_exp1 <= t2) - t1) / (t2 - t1));
    path_exp1(t_exp1 > t2 & t_exp1 <= t3) = 15 *(t_exp1(t_exp1 > t2 & t_exp1 <= t3) - t2) / (t3 - t2);
    path_exp1(t_exp1 > t3 & t_exp1< t4) = 15;
    path_exp1(t_exp1 > t4 & t_exp1 <= t5) = 15+ 70 * (t_exp1(t_exp1 > t4 & t_exp1 <= t5) - t4) / (t5 - t4);
    
    input_data_pos = path_exp1 / 100;
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
first_zero_index = find(x_position < 0.01 & x_position > -0.01, 1, 'first');
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
if ismember(configuration, {'ramp', 'bangbang', 'poly'})
    z_torque = zeros(length(current_x_pos),1);
else
    z_torque = current_file(:,4);
end
current_x_velocity = [diff(current_x_pos);zeros(1,1)];

%Find starting point
starting_time = 4;
ending_time = 7.5;
start_index = starting_time*freq + find(load_angle(starting_time*freq:ending_time*freq)==0,1,"last")-1;
if strcmp(configuration, 'cl2_no_angle_down')
    start_index = 1;
elseif strcmp(configuration, 'cl1_angle_up')
    start_index = 235;

elseif strcmp(configuration, 'experiment1')
    start_index = 296;

elseif strcmp(configuration, 'ramp')
     start_index = 262;
end

current_time_adjusted = current_time(start_index:end);

% Plot Current and Load Angle
figure;
plot(current_time_adjusted / freq, current_x_pos(start_index:end));
xlabel('Time (s)');
ylabel('X-position (m)');

title('X-position vs time')

figure;
plot(current_time_adjusted / freq, current_x_velocity(start_index:end));
xlabel('Time (s)');
ylabel('X-velocity (m/s)');

ylim([-5, 10]);
title('X-velocity vs time')

figure;
plot(current_time_adjusted / freq, current_amp(start_index:end));
xlabel('Time (s)');
ylabel('Current (mA)');

%xline(current_time(collision_index_input) / freq + time_shift);
title('Current vs Time');

figure;
plot(current_time_adjusted / freq, load_angle(start_index:end));
xlabel('Time (s)');
ylabel('Load Angle (rad)');

title('Load Angle vs Time');

figure;
plot(current_time_adjusted / freq, z_torque(start_index:end));
xlabel('Time (s)');
ylabel('Z - torque (Nm)');

title('Cable torque vs Time');

% Calculate and plot Power and Energy
angular_velocity = current_x_velocity/R_x;
current = abs(current_amp .* cos(load_angle));
power = (current(start_index:end)' + z_torque(start_index:end)') .* angular_velocity(start_index:end)';
energy_plot = cumtrapz(power)*time_step;
energy = trapz(power)*time_step

figure;
plot(current_time_adjusted / freq, power);
xlabel('Time (s)');
ylabel('Power (W)');

title('Power Relation');

figure;
plot(current_time_adjusted / freq, energy_plot);
xlabel('Time (s)');
ylabel('Energy (J)');

title('Cumulative Energy consumption [J]');
