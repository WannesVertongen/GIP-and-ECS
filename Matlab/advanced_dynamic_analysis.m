clear all
syms  x xdot xdotdot theta thetadot thetadotdot l ldot ldotdot m M g F s 

eq1 = (M+m)*xdotdot+M*(thetadotdot*l*cos(theta)+ldot*thetadot*cos(theta)-thetadot^2*l*sin(theta))==0;
eq2 = 0.5*M*(4*l*ldot*thetadot+2*l^2*thetadotdot+2*xdotdot*l*cos(theta)+2*xdot*ldot*cos(theta)-2*xdot*l*thetadot*sin(theta)+2*xdot*l*thetadot*sin(theta)+2*g*l*sin(theta))==0;
eq3 = 2*ldotdot-0.5*M*(2*l*thetadot^2+2*xdot*thetadot*cos(theta)+g*cos(theta))==0;

sol = solve([eq1,eq2,eq3],[xdotdot,thetadotdot,ldotdot])
%laplace_eq = s^2*theta == -(F*l+2*m*s^2*l^2*theta+M*g*l*theta+M*s^2*l*x+m*g*l*theta+m*s^2*x*l+2*M*s^2*l^2*theta+M*s^2*l^2*theta^3-M*s^2*l*theta)/(m*l^2);
%opl=solve(laplace_eq, theta);

%%
% Define the initial conditions for theta and its derivative
theta0 = 0; % Initial value of theta
theta_dot0 = 0; % Initial value of theta_dot
y0 = [theta0; theta_dot0]; % Initial conditions vector

% Define the time span
tspan = [0,9]; % Define the time span for integration

% Solve the ODE using MATLAB's ODE solver
[t, y] = ode45(@(t, y) odefunc(t, y, x, xdot, xdotdot, l, ldot, ldotdot), tspan, y0);

% Results
theta_sol = y(:, 1);
theta_dot_sol = y(:, 2);

%% Plots
figure 
plot(t, theta_sol)
title('theta')

figure
plot(t, theta_dot_sol)
title('theta_dot')

%Object position: repeat description of x and l
x = 5 * t;
l = 20 - 0.1*t.^2;

xobj = x + l.*sin(theta_sol);
yobj = 100-l.*cos(theta_sol);

figure
plot(xobj,yobj)
title('Object position')



%% Function

% Define the function representing the system of first-order ODEs
function dydt = odefunc(t, y, x, xdot, xdotdot, l, ldot, ldotdot)
    %define constants
    M=8; %crate
    m=10; %robot
    g=9.81;
    F=0;

    % Extract theta and its derivative y (i.e., theta_dot)
    theta = y(1);
    theta_dot = y(2);

    % Define x and l
    x = 5 * t ;
    xdot = 5 ;
    xdotdot = 0;

    l = 20-0.1*t^2;
    ldot = -0.2*t;
    ldotdot = -0.2;
    
     % Calculate the derivative of theta (thetadot)
    thetadot = theta_dot; % Since theta_dot is directly available from the solution y
    
    % Compute the second derivative of theta
    theta_dot_dot = -(2*l*ldot*m*thetadot + M*g*l*sin(theta) + M*ldot*xdot*cos(theta) + g*l*m*sin(theta) + ldot*m*xdot*cos(theta) + 2*M*l*ldot*thetadot + M*l^2*thetadot^2*cos(theta)*sin(theta) - M*l*ldot*thetadot*cos(theta)^2)/(l^2*(- M*cos(theta)^2 + M + m));
    
    % Return the derivatives dydt = [theta_dot; theta_dot_dot]
    dydt = [theta_dot; theta_dot_dot];
end

