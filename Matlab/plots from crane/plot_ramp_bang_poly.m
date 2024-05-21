    % Configuration
set(0,'DefaultFigureWindowStyle','normal')
configuration = 'bangbang';
% ramp
% bang
% poly

% pickup
clc 
close all

% Load data based on the configuration
[data, input_data_pos, input_data_vel, current_file, reverse, T] = readData(configuration);


% Constants
freq = 50;
time_step = 1/freq;
R_x = 0.04;  % Distance from motor axis to motion line
R_z = 0.1;
% Extract and preprocess data
time = data(:, 1) - data(1, 1);
x_position = data(:, 4);
x_velocity = data(:, 5);
angle = smoothdata(data(:, 15));
z_position = data(:, 8) * 100;

% Find zero crossing and collision index
first_zero_index = find(x_position < 0.04 & x_position > -0.01, 1, 'last');

%shift all data


time = time(first_zero_index:end);
x_position = x_position(first_zero_index:end);
x_velocity = x_velocity(first_zero_index:end);
angle = angle(first_zero_index:end);
z_position = z_position(first_zero_index:end);

[~, collision_index] = max(x_position)
last_zero_index =  find(x_position < 0.01 & x_position > -0.01, 1, 'first');
ids = find(x_position <0.01 ,1,'last');
time_shift = time(find(x_position <0.04,1,'last'))-0.10;

[~, collision_index] = max(x_position);

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
current_amp = current_file(:, 1) / 1000;
load_angle = current_file(:, 2) / 1000;

% Plot X Position and X Velocity
figure;
subplot(2,1,1)
plot(time, x_position);
xlabel('Time (s)');
ylabel('X Position (cm)');
hold on;
scatter(input_time/freq + time_shift - pickup_shift, input_position * 100, 2, 'r', 'filled');
hold off;
legend('Measured data', 'Expected data', 'Location', 'best');
xlim([time(1), time(collision_index*2)]);
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight = 'bold';
%title('X Position vs Time');

subplot(2,1,2)
plot(time, x_velocity);
xlabel('Time (s)');
ylabel('X Velocity (cm/s)');
hold on;
scatter(input_time(1+pickup_shift_2:end)/freq + time_shift - pickup_shift, input_velocity * 100, 2, 'r', 'filled');
hold off;
legend('Measured data', 'Expected data', 'Location', 'best');
xlim([time(1), time(collision_index*2)]);
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight = 'bold';
%title('X Velocity vs Time');


% Plot Object Angle over Time
TwoPeriodShift= find(time >2*T+time(collision_index), 1, 'first');
figure
plot(time(1:TwoPeriodShift), angle(1:TwoPeriodShift));
xlabel('Time (s)');
ylabel('Object Angle (deg)');
hold on;
xline(time(collision_index));
start_angle = min(angle(1:collision_index-1))
new_angle = max(angle(collision_index:TwoPeriodShift))


if reverse
    new_angle = max(angle(collision_index+1000:end));
end


gain = abs(new_angle / start_angle);

dh2 = 1.5*(cos(abs(start_angle*pi/180)) - cos(abs(new_angle*pi/180))) 

yline(0, 'r');
yline(start_angle);
yline(new_angle);
hold off;
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight = 'bold';

