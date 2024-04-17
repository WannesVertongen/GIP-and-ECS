%% TRANSFER FUNCTION 
clear all
clc
g = 9.81;
c = 0.0001003302; %damping
l = 2.06; %cable length

sys = tf([-1 0 0], [l 0 g]);  

% Experiment opstelling:
theta_f = pi/4; %gewenste eindhoek kabel
dx_object = 4; %horizontale verplaatsing bak
dx_robot = dx_object - l*sin(theta_f); 



x = 0:0.1:dx_robot; %m
time = 0:0.01:10; %s



% Choose desired input: 
% 1 = ramp input constant speed
% 2 = bang-bang motion law
% 3 = minimal rms
input_type = 3;

% Loop for different velocities
iterations = 4;
indicators = zeros(iterations,2)';

for i = 1:iterations
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
        %constant position at x=5m
        input(ceil(t/0.01):end) = 5;

        indicators(2,i) = 2*max(y_obj*2*g/(v^2));
    end

    if input_type == 2

        % Duratie beweging zelf te kiezen. Neem zelfde tijden als ramp
        T = dx_robot/i;
        tau1 = time(1:ceil(T/(2*0.01)));
        tau2 = time(ceil(T/(2*0.01)):ceil(T/0.01));
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
        tau = time(1:ceil(T/0.01));
        % minimal rms
        S = dx_robot*(3*tau.^2 - 2*tau.^3);

        
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
    
    
    
    
    %plots
    if input_type == 1
        figure
        subplot(3,1,1)
        plot(time, input)
        title('Ramp input v=', i)

        subplot(3,1,2)
        plot(time,theta)
        hold on
        xline(x(end)/i, 'Color', 'r', 'LineStyle', '--');
        yline(pi/4)
        title('Ramp response v=', i)
        
        subplot(3,1,3)
        plot(x_obj,y_obj)
        hold on
        xline(x(end), 'Color', 'r', 'LineStyle', '--');
        title('Object position')
    end

    if input_type == 2
        figure
        subplot(3,1,1)
        plot(time, input)
        title('Bang bang input T=', T)

       
        subplot(3,1,2)
        plot(time,theta)
        hold on
        xline(T, 'Color', 'r', 'LineStyle', '--');
        yline(pi/4)
        title('Bang bang with duration T=', T)
        
        subplot(3,1,3)
        plot(x_obj,y_obj)
        hold on
        xline(x(end), 'Color', 'r', 'LineStyle', '--');
        title('Object position')
    end

    if input_type == 3
        figure
        subplot(3,1,1)
        plot(time, input)
        title('Minimal rms input T=', T)
        
        subplot(3,1,2)
        plot(time,theta)
        hold on
        xline(T, 'Color', 'r', 'LineStyle', '--');
        yline(pi/4)
        title('Minimal rms with duration T=', T)
        
        subplot(3,1,3)
        plot(x_obj,y_obj)
        hold on
        xline(x(end), 'Color', 'r', 'LineStyle', '--');
        title('Object position')
    end
end
%disp(indicators)
