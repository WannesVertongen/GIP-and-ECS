#include "createPath_multiple.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h> 

#define PI 3.14159265

int createPath(coordinates *co, limit lim, pathdata *pdat, int *index) {
    if (co->y_1 < lim.lower_bound || co->y_1 > lim.y_upper_bound ||
        co->y_2 < lim.lower_bound || co->y_2 > lim.y_upper_bound ||
        co->x_1 < lim.lower_bound || co->x_1 > lim.x_upper_bound ||
        co->x_2 < lim.lower_bound || co->x_2 > lim.x_upper_bound ||
        lim.T_s <= 0) {
        return 1; // Error: Invalid input
    }

    const float g = 9.81;
    float time;

    float x_t = co->x_2 - co->x_1;
    float x_m_value = (x_t * (2 * co->y_1 * co->y_2 + co->y_1 * sqrt(4 * co->y_1 * co->y_2 + pow(x_t, 2)) - co->y_2 * sqrt(4 * co->y_1 * co->y_2 + pow(x_t, 2)) + pow(x_t, 2) - 2 * pow(co->y_1, 2))) / (4 * co->y_1 * co->y_2 + 2 * pow(x_t, 2) - 2 * pow(co->y_1, 2) - 2 * pow(co->y_2, 2));
    pdat->x_m = x_m_value;

    float cl_1_value = sqrt(pow((pdat->x_m - co->x_1), 2) + pow(co->y_1, 2));
    float cl_2_value = sqrt(pow((pdat->x_m - co->x_2), 2) + pow(co->y_2, 2));
    pdat->cl_1 = cl_1_value;
    pdat->cl_2 = cl_2_value;

    float theta_1_value = -atan2(pdat->x_m, co->y_1);
    float theta_2_value = atan2(x_t - pdat->x_m, co->y_2);
    pdat->theta_1 = theta_1_value;
    pdat->theta_2 = theta_2_value;

    float t_swing_value = PI * (sqrt(pdat->cl_1 / g) + sqrt(pdat->cl_2 / g)) / 2;
    pdat->t_swing = t_swing_value;

    int array_size = ceil(pdat->t_swing / lim.T_s);

    //Calculating positions
    int i = index;
    for (time = 0; time < pdat->t_swing; time += lim.T_s) {
        float cl = pdat->cl_1 + (pdat->cl_2 - pdat->cl_1) * (time / t_swing_value);
        float current_angle = pdat->theta_1 * cos(sqrt(g / cl) * time);

        // Assign values to arrays

        //Robot
        pdat->cable_length_over_time[i] = cl;
        pdat->theta[i] = current_angle;
        pdat->robot_pos_over_time[i] = pdat->x_m;

        //Object
        pdat->Object_x[i] = (pdat->robot_pos_over_time[i]) + cl * sin(pdat->theta[i]);
        pdat->Object_y[i] = cl * cos(pdat->theta[i]);
        i++;
    }

    // Calculating velocities
    for (int i = index+ 1; i < array_size; i++) {
        // Calculate the robot position and cable length difference between consecutive time steps
        float position_difference = pdat->robot_pos_over_time[i] - pdat->robot_pos_over_time[i - 1];
        float cable_difference = pdat->cable_length_over_time[i] - pdat->cable_length_over_time[i-1];

        // Calculate the speed by numerical differentiation
        float robot_speed = position_difference / lim.T_s;
        float cable_speed = cable_difference / lim.T_s;

        //Check for speed limitations
        if(robot_speed > lim.MAX_robot_speed || cable_speed > lim.MAX_cable_speed)
        {
            return 1;
        }
 
        // Store the calculated speeds in the speed arrays
        pdat->robot_speed_over_time[i - 1] = robot_speed;
        pdat->cable_speed_over_time[i - 1] = cable_speed;
    }

    //Update array index
    *index = i;

    return 0;
}
