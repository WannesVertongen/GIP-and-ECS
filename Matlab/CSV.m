%% CSV FILE MAKER %%
clc
clear all
close all
frequency = 50;
timestep = 1/frequency;
time = 0:timestep:15;

v_max = 0.3*2;
if v_max == 0.2
    offset = 1;
else
    offset = 0;
end
offset = 0;

% Experiment opstelling:
l = 1; %cable length
theta_opt = 60.85*pi/180; %optimale eindhoek kabel [rad]
%theta_opt = pi/4;
dx_robot = 0.753*2;  %horizontale verplaatsing robot [m]
dx_object = dx_robot + l*sin(theta_opt); %horizontale verplaatsing bak [m]
position = dx_robot*ones(1,length(time));
velocity = zeros(1,length(time));

%% 1. RAMP INPUT 
% v = v_max;
% t_eind = dx_robot/v;
% ramp = v*[0:timestep:t_eind];
% 
% position = dx_robot*ones(1,length(time));
% position(1,1:round(t_eind/timestep)+offset) = ramp;
% 
% velocity = zeros(1,length(time));
% velocity(1,1:round(t_eind/timestep)+offset) = v;
% 
% figure
% plot(time,velocity)
% title("velocity profile ramp")
% figure 
% plot(time,position)
% title("position profile ramp ")
% 
% 
%  writematrix(position,'ramp_position.csv')
%  writematrix(velocity,'ramp_velocity.csv')

% %% 2. BANG BANG INPUT
% 
% v = v_max/2;
% 
% 
% 
% frequency = 50;
% timestep = 1/frequency;
% time = 0:timestep:15;
% dx_robot = 0.8;  %horizontale verplaatsing robot [m]
% T = dx_robot/v;
% 
% tau1 = (0:timestep:T/2)/T;
% tau2 = (T/2:timestep:T)/T;
% 
% % Position 
% S1 = dx_robot*2*(tau1).^2;
% S2 = dx_robot*(-2*tau2.^2+4*tau2-1);
% 
% disp(size(1:ceil(T/(2*timestep)+1)));
% 
% disp(size(S1));
% 
% 
% position(1:ceil(T/(2*timestep)+offset)) = S1;   
% position(ceil(T/(2*timestep)):(ceil(T/timestep))) = S2;
% position(ceil(T/timestep):end) = dx_robot;
% 
% 
% 
% % Velocity
% V1 = v*4*tau1;
% V2 = v*(-4*tau2 + 4);
% 
% 
% velocity(1:ceil(T/(2*timestep))+offset) = V1;
% velocity(ceil(T/(2*timestep)):ceil(T/(timestep))) = V2;        
% velocity(ceil(T/timestep):end) = 0;
% figure
% plot(time,velocity)
% title("velocity profile bangbang")
% figure 
% plot(time,position)
% title("position profile bangbang ")
% 
% 
%  writematrix(position,'bangbang_position.csv')
%  writematrix(velocity,'bangbang_velocity.csv')

%% 3. POLYNOOM INPUT
 
v = v_max/2.2;


frequency = 50;
timestep = 1/frequency;
time = 0:timestep:15;
  %horizontale verplaatsing robot [m]
T = dx_robot/v;


tau = (0:timestep:T)/T;

% Position 
S = dx_robot*(-20*tau.^7+70*tau.^6-84*tau.^5+35*tau.^4);

position(1:ceil(T/(timestep))+offset) = S;       
position(1+ceil(T/timestep):end) = dx_robot;

position_abrupt = zeros(1,ceil(T/(timestep)));
position_abrupt(1:ceil(T/(timestep*2))) = position(1:ceil(T/(timestep*2)));
position_abrupt(ceil(T/(timestep*2))+1:end) = position_abrupt(ceil(T/(timestep*2)));

% Velocity
V = v*(-7*20*tau.^6 + 6*70*tau.^5 -5*84*tau.^4 +4*35*tau.^3);

velocity(1:ceil(T/(timestep))+offset) = V;      
velocity(1+ceil(T/timestep):end) = 0;

velocity_abrupt = zeros(1,ceil(T/(timestep)));
velocity_abrupt(1:ceil(T/(timestep*2))) = velocity(1:ceil(T/(timestep*2)));

 writematrix(position_abrupt,'poly_position_abrupt_060_075.csv')
 writematrix(velocity_abrupt,'poly_velocity_abrupt_060_075.csv')

figure(1)
plot(time(1:ceil(T/(timestep))),velocity_abrupt)
title("velocity profile poly")

figure(2)
plot(time(1:ceil(T/(timestep))),position_abrupt)
title("position profile poly ")

