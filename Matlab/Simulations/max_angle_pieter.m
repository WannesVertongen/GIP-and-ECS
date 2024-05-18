clear all
%gegevens
syms x_m y_g 
cl1 = 2;
h = 0.24;
B = 0.4;

%% Analyse lukt enkel voor groot genoege hoeken
theta_opt = [linspace(30,90,1000)]*pi/180;
theta_opt_plot = theta_opt;

% Theta_pl ifv theta_opt: recursief functievoorschrift:
% dx = B/2*(cos(theta_o)-cos(theta_pl))+h*sin(theta_pl);
% equation = theta_pl == asin((cl1*sin(theta_o)-dx)/cl1);
% theta_platform = solve(equation,theta_pl);

%Te moeilijk om op te lossen, versimpel naar:
theta_platform = asin((cl1-h)*sin(theta_opt)/cl1);

%% 

figure
plot(theta_opt*180/pi,theta_platform*180/pi)
title('\theta platform')

%% 


% Hoogteval delta y: 
%cl2 is ook niet exact juist want exacte formule werkt enkel met juiste
%theta_pl
% cl2 = cl1*(sin(theta_opt)/sin(asin(((cl1-h)*sin(theta_opt))/cl1)));
cl2 = cl1+ sqrt(2)*h*sin(theta_opt);
figure
plot(theta_opt*180/pi, cl2)
title('cl2')
%% 
dy = cl1*cos(theta_opt)-cl2.*cos(theta_platform); 
%delta y is negatief om aan te tonen dat het een val is
figure
plot(theta_opt*180/pi,dy)
title('\Delta y')

%%
% yeind kan volgens mij op 2 manieren

%manier 1
y_eind = cl1 - cl2.*cos(theta_platform);
[M,I]= max(y_eind);
plot(theta_opt*180/pi,y_eind)
hold on
scatter(theta_opt(I)*180/pi , y_eind(I))
hold off
title('y_{eind}')
best_angle_1 = theta_opt(I)*180/pi

%manier 2
y_eind2 = cl1*(1-cos(theta_opt))+dy; %+dy want dy is negatief
[M2,I2]= max(y_eind2);
figure
plot(theta_opt*180/pi,y_eind2)
hold on
scatter(theta_opt(I2)*180/pi , y_eind2(I))
hold off
title('y_{eind}')
best_angle_2 = theta_opt(I2)*180/pi

%eerste resultaat lijkt het best 

%% 

%trade_off = (-dy)./y_eind;
trade_off = y_eind./(-dy);
ylim([0,3])
[M,I]= min(trade_off);
figure
plot(theta_opt*180/pi,trade_off)
hold on
scatter(theta_opt(I)*180/pi , trade_off(I))
xlim([30,90])

hold off
title('Trade Off')

optimal_angle = theta_opt(I)*180/pi
platform_angle = theta_platform(I)*180/pi
final_height = y_eind(I)
height_drop = dy(I)
end_position_platform = [x_m + round(cl1*sin(theta_platform(I)),2);y_g + round(cl1-cl1*cos(theta_platform(I)),2)]

figure
plot(cl1*cos(theta_opt(1:I)),-cl1*sin(theta_opt(1:I)))
axis equal


