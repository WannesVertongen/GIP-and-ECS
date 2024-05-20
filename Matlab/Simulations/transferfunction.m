%% TRANSFER FUNCTION
clear all
clc
set(0,'DefaultFigureWindowStyle','docked')
g = 9.81;
l = 1.5; %cable length

% Pendulum properties
omega = sqrt(g/l);
period = 2*pi/omega;
T = 1.5*period;

v_avg = 0.2;

% Experiment opstelling:
theta_opt = 65.5*pi/180; %optimale eindhoek kabel [rad]
%theta_opt = pi/4;
dx_robot = v_avg*T;  %horizontale verplaatsing robot [m]
dx_object = dx_robot + l*sin(theta_opt); %horizontale verplaatsing bak [m]

%Initial conditions
theta_init = -pi/4;
omega_init = 0;

x = 0:0.1:dx_robot; %m
time = 0:0.01:10; %s


%% 

% Choose desired input: 

% 1 = ramp input constant speed
% 2 = bang-bang motion law (1e orde continu)

% 3 = 7de graads polynoom (4e orde continu, heel smooth dus eig hoop ik dat
% dit minder goed werkt)







for input_type = 1:3

    input = zeros(length(time),1);
    velocity = zeros(length(time),1);

    if input_type == 1
        % snelheid robot = v
        v = 0.2; %m/s
        

        % t = x/v: tijd vd beweging vd robot voor constante v
        t = dx_robot/v; %s
    
    
        ramp = v*time(1:ceil(t/0.01)); 

        %ramp
        input(1:ceil(t/0.01)) = ramp;
        %constant position at dx_robot
        input(ceil(t/0.01):end) = dx_robot;

        
        velocity(1:ceil(t/0.01)) = v;

        
    end

    if input_type == 2

        % Duratie beweging zelf te kiezen. Neem zelfde tijden als ramp
        T = dx_robot/0.2;
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
        
        v = 0.2;
        V1 = v*4*tau1;
        V2 = v*(-4*tau2 + 4);

        
        velocity(1:ceil(T/(2*0.01)),1) = V1;
        velocity(ceil(T/(2*0.01)):ceil(T/(0.01)),1) = V2;        
        velocity(ceil(T/0.01)+1:end,1) = 0;
    end
    


    if input_type == 3

        % Duratie beweging zelf te kiezen. Neem zelfde tijden als ramp
        T = dx_robot/0.2;
        tau = time(1:ceil(T/0.01))/T;
        % 7th degree polynomial
        S = dx_robot*(-20*tau.^7+70*tau.^6-84*tau.^5+35*tau.^4);

        
        %motion law input
        input(1:ceil(T/(0.01))) = S;
        
        %constant position at end
        input(ceil(T/0.01):end) = dx_robot;
        v=0.2;
        V = v*(-7*20*tau.^6 + 6*70*tau.^5 -5*84*tau.^4 +4*35*tau.^3);

        velocity(1:ceil(T/0.01),1) = V;      
        velocity(1+ceil(T/0.01):end) = 0;
    end
    
   
    
   % Define system matrices
    A = [0 1; -g/l 0];
    B = [0; 1];
    C = [1 0]; % Measure only theta
    D = 0;
    X0 = [theta_init,omega_init];
   
    % Create state-space system
    sys_ss = ss(A, B, C, D);


    % Simulation
    %[theta,time] = lsim(sys_ss, input, time, X0); 
    sys = tf([-1 0 0], [l 0 g]);
    [theta, time] = lsim(sys, input, time);
    
    % Object position in time
    x_obj = input + l*sin(theta);
    y_obj = l*(1-cos(theta));
    
    % Does the object reach the optimal angle at this speed
    max_angle = max(theta);

    %time = timeindex / 100
    disp('SPEED = ')
    disp(0.2)
    
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
    figure
    subplot(3,1,1)
    plot(time, velocity)
    xlabel('Time [s]')
    ylabel('Velocity [m/s]')
    title('Robot velocity')
    

    subplot(3,1,2)
    plot(time,theta*180/pi)
    xlabel('Time [s]')
    ylabel('Angle [°]')
    hold on
    xline(input(end)/0.2, 'Color', 'r', 'LineStyle', '--')
    title('Cable angle')
    %yline(theta_opt, 'Color', 'g', 'LineStyle', '--');
    legend('Simulation result', 'End of robot movement')
    
    
    subplot(3,1,3)
    plot(x_obj,y_obj)
    xlabel('x-distance [m]')
    ylabel('z-distance [m]')
    hold on
    xline(input(end), 'Color', 'r', 'LineStyle', '--');
    title('Object position')
end

