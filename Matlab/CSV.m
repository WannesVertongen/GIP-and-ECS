%% CSV FILE MAKER %%
clc
clear all

frequency = 50;
timestep = 1/frequency;
time = 0:timestep:15;

% Experiment opstelling:
l = 1; %cable length
theta_opt = 60.85*pi/180; %optimale eindhoek kabel [rad]
%theta_opt = pi/4;
dx_robot = 0.8;  %horizontale verplaatsing robot [m]
dx_object = dx_robot + l*sin(theta_opt); %horizontale verplaatsing bak [m]

%% 1. RAMP INPUT 
v = 0.3;
t_eind = dx_robot/v;
ramp = v*[0:timestep:t_eind];

position = dx_robot*ones(1,length(time));
position(1,1:round(t_eind/timestep)+1) = ramp;

velocity = zeros(1,length(time));
velocity(1,1:round(t_eind/timestep)+1) = v;

figure
plot(time,velocity)

 writematrix(position,'ramp_position.csv')
 writematrix(velocity,'ramp_velocity.csv')

%% 2. BANG BANG INPUT
v = 0.3;
T = dx_robot/v;

tau1 = (0:timestep:T/2)/T;
tau2 = (T/2:timestep:T)/T;

% Position 
S1 = dx_robot*2*(tau1).^2;
S2 = dx_robot*(-2*tau2.^2+4*tau2-1);

position(1:ceil(T/(2*timestep))) = S1;
position(ceil(T/(2*timestep)):ceil(T/(timestep))-1) = S2;        
position(ceil(T/timestep):end) = dx_robot;



% Velocity
V1 = v*4*tau1;
V2 = v*(-4*tau2 + 4);

velocity(1:ceil(T/(2*timestep))) = V1;
velocity(ceil(T/(2*timestep)):ceil(T/(timestep))-1) = V2;        
velocity(ceil(T/timestep):end) = 0;
figure
plot(time,velocity)

 writematrix(position,'bangbang_position.csv')
 writematrix(velocity,'bangbang_velocity.csv')

%% 3. POLYNOOM INPUT

v = 0.3;
T = dx_robot/v;

tau = (0:timestep:T)/T;

% Position 
S = dx_robot*(-20*tau.^7+70*tau.^6-84*tau.^5+35*tau.^4);

position(1:ceil(T/(timestep))) = S;       
position(1+ceil(T/timestep):end) = dx_robot;


% Velocity
V = v*(-7*20*tau.^6 + 6*70*tau.^5 -5*84*tau.^4 +4*35*tau.^3);

velocity(1:ceil(T/(timestep))) = V;      
velocity(1+ceil(T/timestep):end) = 0;

 writematrix(position,'poly_position.csv')
 writematrix(velocity,'poly_velocity.csv')
