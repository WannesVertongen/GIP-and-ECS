% Define your constants
m = 30; % robot mass
M = 5; % object mass
l = 2.06; % cable length
g = 9.81; % gravitational acceleration
omega = sqrt(g/l);
T = 2*pi/omega;
t_swing = T/2;


% Initial conditions
initial_x = 0; % initial position
initial_vx = 0; % initial velocity in the x-direction
%initial_theta = -1.32; % initial angle
initial_theta = 0;
initial_vtheta = 0; % initial angular velocity
y0 = [initial_x; initial_vx; initial_theta; initial_vtheta];

theta_t = initial_theta*cos(omega* t);
ar_t = @(t) l*initial_theta^2*omega^2*sin(omega * t)^2;

% Define your time-varying force function
%F_t = @(t) 2 * t + 0.5*sin(10 * t); % Example of a sinusoidal force with an amplitude of 100
%F_t = @(t) 0;
F_t = @(t) 10;

% Define your functions f and g
f = @(x, theta, vx, vtheta, t) (F_t(t) + M * l * vtheta^2 * sin(theta) + M * g * sin(theta) * cos(theta)) / (M + m - M * cos(theta)^2);
g = @(x, theta, vx, vtheta, t) ((F_t(t) + M * l * vtheta^2 * sin(theta)) * -cos(theta) - (m + M) * g * sin(theta)) / (l * (M + m - M * cos(theta)^2));

% Define your system of equations
dxdt = @(t, y) [y(2); f(y(1), y(3), y(2), y(4), t)];
dthetadt = @(t, y) [y(4); g(y(1), y(3), y(2), y(4), t)];


% Solve the system of equations
t_start = 0;
t_end = t_swing; % Example end time
[t, y] = ode45(@(t,y) [dxdt(t,y); dthetadt(t,y)], [t_start, t_end], y0);

% Extract results
x = y(:,1);
theta = y(:,3);

%Object position
xobj = x + l*sin(theta);
yobj = l*cos(theta);

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

figure
plot(t,xobj)
title('x')

figure
plot(t,yobj)
title('y')
