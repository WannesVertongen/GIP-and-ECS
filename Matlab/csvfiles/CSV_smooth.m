%% CSV FILE MAKER %%
clc
clear all
close all
frequency = 50;
timestep = 1/frequency;
time = 0:timestep:18;

v_max = 0.2*2;
if v_max == 0.2
    offset_1 = 1;
else
    offset_1 = 0;
end
offset_1 = 1;
offset_2 = 0;
% Experiment opstelling:
l = 1.5; %cable length
%l = 1;
%l = 1.5;
theta_opt = 60.85*pi/180; %optimale eindhoek kabel [rad]
%theta_opt = pi/4;
dx_robot = (2*pi)/(sqrt(9.81/1.5)) * 0.3 * 1.5;  
%0.6018*2; % 1 periode   %%% 1 m kabel lengte
%0.753*2;  %1.25 periode
%0.903*2;  % 1.5 periode
%0.737*2;  % 1 periode  % 1.5 m kabel lengte
%.9213*2; % 1.25 periode
%1.1*2;   % 1.5 periode
                        % 1.5m smooth
dx_robot = (2*pi)/(sqrt(9.81/1.5)) * 0.2 * 1.5;
v_max = 0.2;

%horizontale verplaatsing robot [m]
dx_object = dx_robot + l*sin(theta_opt); %horizontale verplaatsing bak [m]
position = dx_robot*ones(1,length(time));
velocity = zeros(1,length(time));

% 1. RAMP INPUT 
v = v_max;
t_eind = dx_robot/v;
ramp = v*[0:timestep:t_eind];

position = dx_robot*ones(1,length(time));
position(1,1:round(t_eind/timestep)+offset_1) = ramp;

velocity = zeros(1,length(time));
velocity(1,1:round(t_eind/timestep)+offset_1) = v;

figure
subplot(2,1,1)
plot(time,velocity)
title("velocity profile ramp")
subplot(2,1,2) 
plot(time,position)
title("position profile ramp ")


 writematrix(position,'pos_15_ramp.csv')
 writematrix(velocity,'vel_15_ramp.csv')

%% 2. BANG BANG INPUT

v = v_max;


disp(dx_robot)

 %horizontale verplaatsing robot [m]
T = dx_robot/v

tau1 = (0:timestep:T/2)/T;
tau2 = (T/2:timestep:T)/T;

% Position 
S1 = dx_robot*2*(tau1).^2;
S2 = dx_robot*(-2*tau2.^2+4*tau2-1);




position(1:ceil(T/(2*timestep)+offset_2)) = S1;   
position(ceil(T/(2*timestep)):(ceil(T/timestep))) = S2;
position(ceil(T/timestep):end) = dx_robot;



% Velocity
V1 = v*4*tau1;
V2 = v*(-4*tau2 + 4);


velocity(1:ceil(T/(2*timestep))+offset_2) = V1;
velocity(ceil(T/(2*timestep)):ceil(T/(timestep))) = V2;        
velocity(ceil(T/timestep):end) = 0;
disp(length(time))
disp(length(velocity))
figure
subplot(2,1,1)
plot(time,velocity)
title("velocity profile bangbang")
subplot(2,1,2) 
plot(time,position)
title("position profile bangbang ")


writematrix(position,'pos_15_bang.csv')
 writematrix(velocity,'vel_15_bang.csv')

%% 3. POLYNOOM INPUT
 
v = v_max;


frequency = 50;
timestep = 1/frequency;
  %horizontale verplaatsing robot [m]
T = dx_robot/v;


tau = (0:timestep:T)/T;

% Position 
S = dx_robot*(-20*tau.^7+70*tau.^6-84*tau.^5+35*tau.^4);

position(1:ceil(T/(timestep))+offset_2) = S;       
position(1+ceil(T/timestep):end) = dx_robot;

%position_abrupt = zeros(1,2*ceil(T/(timestep)));
%position_abrupt(1:ceil(T/(timestep*2))) = position(1:ceil(T/(timestep*2)));
%position_abrupt(ceil(T/(timestep*2))+1:end) = position_abrupt(ceil(T/(timestep*2)));

% Velocity
V = v*(-7*20*tau.^6 + 6*70*tau.^5 -5*84*tau.^4 +4*35*tau.^3);

velocity(1:ceil(T/(timestep))+offset_2) = V;      
velocity(1+ceil(T/timestep):end) = 0;

%velocity_abrupt = zeros(1,2*ceil(T/(timestep)));
%velocity_abrupt(1:ceil(T/(timestep*2))) = velocity(1:ceil(T/(timestep*2)));

 writematrix(position,'pos_15_poly.csv')
 writematrix(velocity,'vel_15_poly.csv')

figure
subplot(2,1,1)
plot(time,velocity)
title("velocity profile poly")

subplot(2,1,2)
plot(time,position)
title("position profile poly ")

