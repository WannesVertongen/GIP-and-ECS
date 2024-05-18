clear all
close all
% Define your constants
m = 30; % robot mass
M = 5; % object mass
l = 2.06; % cable length
g = 9.81; % gravitational acceleration
omega = sqrt(g/l); %natural frequency
T = 2*pi/omega; %swing period
t_swing = T/2; %swing time
h = 0.24; %crate height
B = 0.3; %crate width
d = 0.4; %crate depth


R = sqrt(B^2/4 + h^2);
alpha = atan2(B,2*h);


% Initial conditions
initial_x = 0; % initial position
initial_vx = 0; % initial velocity in the x-direction
%initial_theta = -1.32; % initial angle
initial_theta = 0;
initial_vtheta = 0; % initial angular velocity
y0 = [initial_x; initial_vx; initial_theta; initial_vtheta];

t_loop = 5;

% Horizontal movement of robot
time = t_loop; 
L12 = 0.5; 
theta1 = -atan2(2,L12);
Lkantel = B/2 + R*cos(alpha+abs(theta1));
Ltot = (L12+Lkantel);

% Verhouding waarde 
ratio = Ltot/(time)^2;






% The force is defined by F = ma where a can be found from the motion law.
% s(tau) = 6tau^5 - 15tau^4 + 10tau^3
%s'(tau)= 30tau^4 - 60tau^3 + 30tau^2
%s''(tau) = 120tau^3 - 180tau^2 + 60tau
%d^2S/dt^2 = (Ltot/time^2)*s''(t/time)

%F_t = @(t) m*Ltot/(time^2) *(120*(t/time).^3 - 180*(t/time).^2 + 60*(t/time));

%Force= piecewise function
F_t = @(t) (t <= time) .* (m*Ltot./(time^2) .* (120*(t/time).^3 - 180*(t/time).^2 + 60*(t/time)));


% Define your functions f and g
f = @(x, theta, vx, vtheta, t) (F_t(t) + M * l * vtheta^2 * sin(theta) + M * g * sin(theta) * cos(theta)) / (M + m - M * cos(theta)^2);
g = @(x, theta, vx, vtheta, t) ((F_t(t) + M * l * vtheta^2 * sin(theta)) * -cos(theta) - (m + M) * g * sin(theta)) / (l * (M + m - M * cos(theta)^2));

% Define your system of equations
dxdt = @(t, y) [y(2); f(y(1), y(3), y(2), y(4), t)];
dthetadt = @(t, y) [y(4); g(y(1), y(3), y(2), y(4), t)];


% Solve the system of equations
t_start = 0;
t_end = time+5; % End time= duratin motion + time to look at oscillating behaviour
[t, y] = ode45(@(t,y) [dxdt(t,y); dthetadt(t,y)], [t_start, t_end], y0);

% Extract results
x = y(:,1);
theta = y(:,3);

%Object position
xobj = x + l*sin(theta);
yobj = l*cos(theta);

%Finding max amplitude of oscillation at the end
last_10_percent_time = t_end - 0.1 * (t_end - t_start);
last_10_percent_indices = t >= last_10_percent_time;
xobj_last_10_percent = xobj(last_10_percent_indices);
average_xobj_last_10_percent = mean(xobj_last_10_percent);


disp_value = abs(max(xobj));

disp(['Maximum x value: ', num2str(disp_value)])

disp(['Average last 10% of the time: ', num2str(average_xobj_last_10_percent)])

max_x_amp = max(xobj) - average_xobj_last_10_percent

figure
plot(t,xobj)
title('x')

%% 
% Plot F(t)
subplot(2,2,1)
plot(t, F_t(t));
xlabel('Time [s]');
ylabel('F [N]');
title('Force vs Time');

% Plot x(t) and theta(t)

subplot(2,2,2);
plot(t, x);
xlabel('Time [s]');
ylabel('x-position robot [m]');
title('Robot position vs Time');

subplot(2,2,3);
plot(t, theta);
xlabel('Time [s]');
ylabel('\theta cable [rad]');
title('Cable angle vs Time');


%Plot movement object
subplot(2,2,4)
plot(xobj,yobj)
xlabel('x-axis [m]')
ylabel('y-axis [m]')
title('Object movement')
ylim([2.04,2.08])


figure
plot(t,xobj)
xlabel('time [s]')
ylabel('x displacement [m]]')
title('Object displacement in x')

figure
plot(t,yobj)
xlabel('time [s]')
ylabel('y displacement [m]]')
title('Object displacement in y');

%% Transfer function
clc
g = 9.81;
l = 1; % assuming l is defined somewhere

sys = tf([-1 0 0], [l 0 g]);  % Define transfer function with correct arguments

x = 0:0.01:0.5; % m
time = 0:0.01:10; % s

iterations = 5;
indicators = zeros(2, iterations);

v = linspace(0.1, 0.3, iterations);
for i = 1:iterations
    V = v(i); % m/s
    indicators(1, i) = V;

    t = x(end) / V; % s
    ramp_length = ceil(t / 0.01);
    ramp = V * time(1:ramp_length);
    
    input = zeros(length(time), 1);
    input(1:ramp_length) = ramp;
    input(ramp_length:end) = 5;

    [theta, ~] = lsim(sys, input, time);

    x_obj = input + l * sin(theta);
    y_obj = l * (1 - cos(theta));

    indicators(2, i) = 2 * max(y_obj * 2 * g / (V ^ 2));

    figure
    subplot(2, 1, 1)
    plot(time, theta)
    hold on
    xline(t, 'Color', 'r', 'LineStyle', '--');
    yline(pi / 4, 'Color', 'b', 'LineStyle', '--');
    title(['Ramp response v = ', num2str(i)])

    subplot(2, 1, 2)
    plot(x_obj, y_obj)
    hold on
    xline(x(end), 'Color', 'r', 'LineStyle', '--');
    yline(l * (1 - cos(pi / 4)), 'Color', 'b', 'LineStyle', '--');
    title('Object position')
end
disp(indicators)

