data = csvread('data_ramp.csv',1);
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

first_index= 10894;
figure
plot(time(first_index:end),x_position(first_index:end))