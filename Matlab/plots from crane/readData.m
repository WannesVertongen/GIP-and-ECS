function [data,input_data_pos, input_data_vel, current_file, reverse] = readData(configuration)
    switch configuration
        case 'cl1_no_angle_up'
            crane_file = csvread('crane_cl1_0903.csv',1);
            input_data_pos = csvread('cl1_pos_0903.csv');
            input_data_vel = csvread('cl1_vel_0903.csv');
            current_file = csvread('crane_cl1_0903_current.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = false;

            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(6580:end,:);
            %data = crane_file(last_zro_index+10:end,:);
            
        case 'cl1_no_angle_down'
            crane_file = csvread('crane_cl1_0602.csv',1);
            input_data_pos = csvread('cl1_pos_0602.csv');
            input_data_vel = csvread('cl1_vel_0602.csv');
            current_file = csvread('crane_cl1_0602_current.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = false;

            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(6580:end,:);
            
        case 'cl2_no_angle_up'
            crane_file = csvread('crane_cl2_1100.csv',1);
            input_data_pos = csvread('cl2_pos_1100.csv');
            input_data_vel = csvread('cl2_vel_1100.csv');
            current_file = csvread('crane_cl2_1100_current.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = true;
            
            
            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(6580:end,:);

        case 'cl2_no_angle_down'
            crane_file = csvread('crane_cl2_0737.csv',1);
            input_data_pos = csvread('cl2_pos_0737.csv');
            input_data_vel = csvread('cl2_vel_0737.csv');
            current_file = csvread('crane_cl2_0737_current.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = false;


            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(6580:end,:);
            
        case 'cl1_angle_down'
            crane_file = csvread('crane_cl1_0753_down.csv',1);
            input_data_pos = csvread('cl1_pos_0753.csv');
            input_data_vel = csvread('cl1_vel_0753.csv');
            current_file = csvread('crane_cl1_0753_current_down.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = true;

            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(6580:end,:);
            
        case 'cl1_angle_up'
            crane_file = csvread('crane_cl1_0753_up.csv',1);
            input_data_pos = csvread('cl1_pos_0753.csv');
            input_data_vel = csvread('cl1_vel_0753.csv');
            current_file = csvread('crane_cl1_0753_current_up.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = false;

            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(6580:end,:);
            
        case 'cl2_angle_down'
            crane_file = csvread('crane_cl2_0921_down.csv',1);
            input_data_pos = csvread('cl2_pos_0921.csv');
            input_data_vel = csvread('cl2_vel_0921.csv');
            current_file = csvread('crane_cl2_0921_current_down.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = true;

            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(7000:end,:);
            
        case 'cl2_angle_up'
             crane_file = csvread('crane_cl2_0921_up.csv',1);
            input_data_pos = csvread('cl2_pos_0921.csv');
            input_data_vel = csvread('cl2_vel_0921.csv');
            current_file = csvread('crane_cl2_0921_current_up.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = false;



            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(7000:end,:);
            
        case 'pickup'
            crane_file = csvread('pickup.csv',1);
            input_data_pos = csvread('cl1_pos_0903.csv');
            input_data_vel = csvread('cl1_vel_0903.csv');
            current_file = csvread('pickup_current.csv',1);
            %current =current_file((length(current_file)-length(input_data_vel))+1:end,:);
            reverse = false;

            x_position_full = crane_file(:, 4);
            last_zero_index = find(x_position_full <0.0001, 1, 'last');
            data = crane_file(6580:end,:);
            
        otherwise
            error('Invalid configuration');
    end
end