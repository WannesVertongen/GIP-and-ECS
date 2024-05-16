%% Newest simulation file 
clear all
close all
clc
g = 9.81;


% Pendulum properties
l = 1.5; %cable length
omega = sqrt(g/l);
period = 2*pi/omega;

%Initial conditions
theta_init = 0;
omega_init = 0;

%Duration of the robot motion
if theta_init == 0
    T = 1.5*period; 
else
    T = 1.25*period;
end


% Experiment opstelling:
theta_opt = 60.85*pi/180; %optimale eindhoek kabel [rad]

dx_robot = 0.92;  %horizontale verplaatsing robot [m]
dx_object = dx_robot + l*sin(theta_opt); %horizontale verplaatsing bak [m]



x = 0:0.1:dx_robot; %m

offset = 0;

% Input = 7th order polynomial (3rd degree of continuity)


%max velocity 
v_max = 0.6; %m/s

%average velocity
v = v_max/2.2; %vmax = 2.2*v_avg


frequency = 50;
timestep = 1/frequency;
time = 0:timestep:10;


tau = (0:timestep:T)/T;

% Position 
S = dx_robot*(-20*tau.^7+70*tau.^6-84*tau.^5+35*tau.^4);

position(1:ceil(T/(timestep))+offset) = S;       
position(1+ceil(T/timestep):end) = dx_robot;

position_abrupt = zeros(1,length(time));
position_abrupt(1:ceil(T/(timestep*2))) = position(1:ceil(T/(timestep*2)));
position_abrupt(ceil(T/(timestep*2))+1:end) = position_abrupt(ceil(T/(timestep*2)));

% Velocity
V = v*(-7*20*tau.^6 + 6*70*tau.^5 -5*84*tau.^4 +4*35*tau.^3);

velocity(1:ceil(T/(timestep))+offset) = V;      
velocity(1+ceil(T/timestep):end) = 0;

velocity_abrupt = zeros(1,length(time));
velocity_abrupt(1:ceil(T/(timestep*2))) = velocity(1:ceil(T/(timestep*2)));
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. State space simulation: (begin conditions possible)
% Define system matrices
A = [0 1; -g/l 0];
B = [0; 1];
C = [1 0]; % Measure only theta
D = 0;
X0 = [theta_init,omega_init];

% Create state-space system
sys_ss = ss(A, B, C, D);

% Input
input = position_abrupt;

% Simulation
[theta1,time] = lsim(sys_ss, input, time, X0);

%Results
% Object position in time
x_obj1 = input' + l*sin(theta1);
y_obj1 = l*(1-cos(theta1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Normal TF: no beginconditions possible
sys = tf([-1 0 0], [l 0 g]);
[theta2, time] = lsim(sys, input, time);

% Object position in time
x_obj2 = input' + l*sin(theta2);
y_obj2 = l*(1-cos(theta2));

%% 

%plots

%Input: same for both methods
figure
subplot(2,1,1)
plot(time,position_abrupt)
title("Robot position")
xlabel('Time [s]')
ylabel('Distance [m]')

subplot(2,1,2)
plot(time,velocity_abrupt)
xlabel('Time [s]')
ylabel('Velocity [m/s]')
title('Robot velocity')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Output for method 1
figure
subplot(2,1,1)
plot(time,theta1)
xlabel('Time [s]')
ylabel('Angle [rad]')
xline(T, 'r', '--')
hold on
% xline(x(end)/i, 'Color', 'r', 'LineStyle', '--');
% yline(theta_opt, 'Color', 'g', 'LineStyle', '--');
title('Cable angle \theta - method 1')
legend('Simulation result','Abrupt stop')

subplot(2,1,2)
plot(x_obj1,y_obj1)
xlabel('x-distance [m]')
ylabel('y-distance [m]')
xline(position_abrupt(1,end), 'r', '--')
title('Object position - method 1')
axis([0 0.9 0 0.06]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Output for method 2
figure
subplot(2,1,1)
plot(time,theta2)
xlabel('Time [s]')
ylabel('Angle [rad]')
xline(T, 'r', '--')
title('Cable angle \theta - method 2')
legend('Simulation result','Abrupt stop')

subplot(2,1,2)
plot(x_obj2,y_obj2)
xlabel('x-distance [m]')
ylabel('y-distance [m]')
xline(position_abrupt(1,end), 'r', '--')
title('Object position - method 2')
axis([0 0.9 0 0.06]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




