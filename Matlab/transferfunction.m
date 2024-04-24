%% TRANSFER FUNCTION 
clear all
clc
g = 9.81;
l = 2; %cable length

sys = tf([-1 0 0], [l 0 g]);  

% Experiment opstelling:
theta_opt = 60.85*pi/180; %optimale eindhoek kabel [rad]
dx_object = 4; %horizontale verplaatsing bak [m]
dx_robot = dx_object - l*sin(theta_opt);  %horizontale verplaatsing robot [m]



x = 0:0.1:dx_robot; %m
time = 0:0.01:3; %s



% Choose desired input: 

% 1 = ramp input constant speed
% 2 = bang-bang motion law (1e orde continu)
% 3 = minimal rms (2e orde continu)
% 4 = 7de graads polynoom (4e orde continu, heel smooth dus eig hoop ik dat
% dit minder goed werkt)

input_type = 2;


% Loop for different velocities
iterations = 4;
indicators = zeros(iterations,2)';

for i = 2:iterations+1
    input = zeros(length(time),1);

    if input_type == 1
        % snelheid robot = v
        v = i; %m/s
        indicators(1,i) =v;

        % t = x/v: tijd vd beweging vd robot voor constante v
        t = dx_robot/v; %s
    
    
        ramp = v*time(1:ceil(t/0.01)); 

        %ramp
        input(1:ceil(t/0.01)) = ramp;
        %constant position at dx_robot
        input(ceil(t/0.01):end) = dx_robot;

        
    end

    if input_type == 2

        % Duratie beweging zelf te kiezen. Neem zelfde tijden als ramp
        T = dx_robot/i;
        tau1 = time(1:ceil(T/(2*0.01)))/T;
        tau2 = time(ceil(T/(2*0.01)):ceil(T/0.01))/T;
        % bang-bang
        S1 = dx_robot*2*(tau1).^2;
        S2 = dx_robot*(-2*tau2.^2+4*tau2-1);

        
        %motion law input
        input(1:ceil(T/(2*0.01))) = S1;
        input(ceil(T/(2*0.01)):ceil(T/(0.01))) = S2;
        %constant position at end
        input(ceil(T/0.01):end) = dx_robot;
    end
    

    if input_type == 3

        % Duratie beweging zelf te kiezen. Neem zelfde tijden als ramp
        T = dx_robot/i;
        tau = time(1:ceil(T/0.01))/T;
        % minimal rms
        S = dx_robot*(3*tau.^2 - 2*tau.^3);

        
        %motion law input
        input(1:ceil(T/(0.01))) = S;
        
        %constant position at end
        input(ceil(T/0.01):end) = dx_robot;
    end

    if input_type == 4

        % Duratie beweging zelf te kiezen. Neem zelfde tijden als ramp
        T = dx_robot/i;
        tau = time(1:ceil(T/0.01))/T;
        % 7th degree polynomial
        S = dx_robot*(-20*tau.^7+70*tau.^6-84*tau.^5+35*tau.^4);

        
        %motion law input
        input(1:ceil(T/(0.01))) = S;
        
        %constant position at end
        input(ceil(T/0.01):end) = dx_robot;
    end

    % Simulation
    [theta,time] = lsim(sys, input, time); 
    
    % Object position in time
    x_obj = input + l*sin(theta);
    y_obj = l*(1-cos(theta));
    
    % Does the object reach the optimal angle at this speed
    max_angle = max(theta);

    %time = timeindex / 100
    disp('SPEED = ')
    disp(i)
    
    if max_angle >= theta_opt
        disp('VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV')
        disp('Destination can be reached at this speed')
        disp('VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV')
        
    else
        disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
        disp('Destination is not reached, speed too low')
        disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
    end

    disp('----------------------------------------------------------')
    
    
    %plots
    if input_type == 1
        figure
        subplot(3,1,1)
        plot(time, input)
        xlabel('Time [s]')
        ylabel('Distance [m]')
        title('Robot position for v=', i)

        subplot(3,1,2)
        plot(time,theta)
        xlabel('Time [s]')
        ylabel('Angle [rad]')
        hold on
        xline(x(end)/i, 'Color', 'r', 'LineStyle', '--');
        yline(theta_opt, 'Color', 'g', 'LineStyle', '--');
        title('Theta for v=', i)
        
        subplot(3,1,3)
        plot(x_obj,y_obj)
        xlabel('x-distance [m]')
        ylabel('y-distance [m]')
        hold on
        xline(x(end), 'Color', 'r', 'LineStyle', '--');
        title('Object position')

        indicators(2,i) = 2*max(y_obj*2*g/(v^2));

       
    end

    if input_type == 2
        figure
        subplot(3,1,1)
        plot(time, input)
        xlabel('Time [s]')
        ylabel('Distance [m]')
        title('Robot position for T=', T)

        subplot(3,1,2)
        plot(time,theta)
        xlabel('Time [s]')
        ylabel('Angle [rad]')
        hold on
        xline(x(end)/i, 'Color', 'r', 'LineStyle', '--');
        yline(theta_opt, 'Color', 'g', 'LineStyle', '--');
        title('Theta for T=', T)
        
        subplot(3,1,3)
        plot(x_obj,y_obj)
        xlabel('x-distance [m]')
        ylabel('y-distance [m]')
        hold on
        xline(x(end), 'Color', 'r', 'LineStyle', '--');
        title('Object position')
    end

    if input_type == 3
        figure
        subplot(3,1,1)
        plot(time, input)
        xlabel('Time [s]')
        ylabel('Distance [m]')
        title('Robot position for T=', T)

        subplot(3,1,2)
        plot(time,theta)
        xlabel('Time [s]')
        ylabel('Angle [rad]')
        hold on
        xline(x(end)/i, 'Color', 'r', 'LineStyle', '--');
        yline(theta_opt, 'Color', 'g', 'LineStyle', '--');
        title('Theta for T=', T)
        
        subplot(3,1,3)
        plot(x_obj,y_obj)
        xlabel('x-distance [m]')
        ylabel('y-distance [m]')
        hold on
        xline(x(end), 'Color', 'r', 'LineStyle', '--');
        title('Object position')
    end

    if input_type == 4
        figure
        subplot(3,1,1)
        plot(time, input)
        xlabel('Time [s]')
        ylabel('Distance [m]')
        title('Robot position for T=', T)

        subplot(3,1,2)
        plot(time,theta)
        xlabel('Time [s]')
        ylabel('Angle [rad]')
        hold on
        xline(x(end)/i, 'Color', 'r', 'LineStyle', '--');
        yline(theta_opt, 'Color', 'g', 'LineStyle', '--');
        title('Theta for T=', T)
        
        subplot(3,1,3)
        plot(x_obj,y_obj)
        xlabel('x-distance [m]')
        ylabel('y-distance [m]')
        hold on
        xline(x(end), 'Color', 'r', 'LineStyle', '--');
        title('Object position')
    end
end
%disp(indicators)
