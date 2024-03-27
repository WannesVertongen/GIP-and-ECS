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
theta1 = -atan2(2,0.5);

R = sqrt(B^2/4 + h^2);
alpha = atan2(B,2*h);

%% 

% Initial conditions
initial_x = 0; % initial position
initial_vx = 0; % initial velocity in the x-direction
%initial_theta = -1.32; % initial angle
initial_theta = 0;
initial_vtheta = 0; % initial angular velocity
y0 = [initial_x; initial_vx; initial_theta; initial_vtheta];

% Horizontal movement of robot
time = 5; %adjustable
L12 = 0.5; %adjustable
Lkantel = B/2 + R*cos(alpha+abs(theta1));
Ltot = L12+Lkantel;


%%

% Define your time-varying force function
%F_t = @(t) 2 * t + 0.5*sin(10 * t); % Example of a sinusoidal force with an amplitude of 100
%F_t = @(t) 0;


% The force is defined by F = ma where a can be found from the motion law.
% s(tau) = 6tau^5 - 15tau^4 + 10tau^3
%s'(tau)= 30tau^4 - 60tau^3 + 30tau^2
%s''(tau) = 120tau^3 - 180tau^2 + 60tau
%d^2S/dt^2 = (Ltot/time^2)*s''(t/time)

%F_t = @(t) m*Ltot/(time^2) *(120*(t/time).^3 - 180*(t/time).^2 + 60*(t/time));
F_t = @(t) (t <= time) .* (m*Ltot./(time^2) .* (120*(t/time).^3 - 180*(t/time).^2 + 60*(t/time)));
%% 

% Define your functions f and g
f = @(x, theta, vx, vtheta, t) (F_t(t) + M * l * vtheta^2 * sin(theta) + M * g * sin(theta) * cos(theta)) / (M + m - M * cos(theta)^2);
g = @(x, theta, vx, vtheta, t) ((F_t(t) + M * l * vtheta^2 * sin(theta)) * -cos(theta) - (m + M) * g * sin(theta)) / (l * (M + m - M * cos(theta)^2));

% Define your system of equations
dxdt = @(t, y) [y(2); f(y(1), y(3), y(2), y(4), t)];
dthetadt = @(t, y) [y(4); g(y(1), y(3), y(2), y(4), t)];


% Solve the system of equations
t_start = 0;
t_end = time+5; % Example end time
[t, y] = ode45(@(t,y) [dxdt(t,y); dthetadt(t,y)], [t_start, t_end], y0);

% Extract results
x = y(:,1);
theta = y(:,3);

%Object position
xobj = x + l*sin(theta);
yobj = l*cos(theta);
%% 

% Plot x(t) and theta(t)
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time');
ylabel('Position (x)');
title('Position vs Time');

subplot(2,1,2);
plot(t, theta);
xlabel('Time');
ylabel('Angle (theta)');
title('Angle vs Time');

% Plot F(t)
figure;
plot(t, F_t(t));
xlabel('Time');
ylabel('Force (F)');
title('Force vs Time');

%Plot movement object
figure
plot(xobj,yobj)
xlabel('x-axis')
ylabel('y-axis')
title('Object movement')
axis equal

figure
plot(t,xobj)
title('x')

figure
plot(t,yobj)
title('y')
