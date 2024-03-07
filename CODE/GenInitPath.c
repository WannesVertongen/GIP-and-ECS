#include "createPath.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h> // Include stdlib.h for malloc


int createPath(coordinates co, limit lim, pathdata *pdat) {
    if (co.y_1 < lim.lower_bound || co.y_1 > lim.y_upper_bound ||
        co.x_1 < lim.lower_bound || co.x_1 > lim.x_upper_bound ||
        lim.T_s <= 0) {
        return 1; // Error: Invalid input
    }

    float cl_1_value = co.x_1;
    float cl_2_value = co.x_2;
    pdat->cl_1 = cl_1_value;
    pdat->cl_2 = cl_2_value;

    int t_swing_value = 5; // arbitrary choice of 5 seconds.
    pdat->t_swing = t_swing_value;

    // using constant motor speed.
    if (fabs(pdat->cl_2 - pdat->cl_1) / t_swing_value > lim.MAX_motor_speed) {
        return 1;
    }

    int array_size = ceil(pdat->t_swing / lim.T_s);
    
    int i = 0;

    // Initialize robot_pos_over_time with co.x_1 values
    for (i = 0; i < MAX_RANGE; i++) {
        pdat->robot_pos_over_time[i] = co.x_2;
        pdat->cable_length_over_time[i] = co.y_2;
    }

    // Calculate cable_length_over_time and update robot_pos_over_time accordingly
    float time;
    for (time = 0, i = 0; i < array_size; time += lim.T_s, i++) {
        if (time <= pdat->t_swing) {
            float cl = pdat->cl_1 + (pdat->cl_2 - pdat->cl_1) * (time / pdat->t_swing);
            pdat->cable_length_over_time[i] = cl;
            pdat->Object_y[i] = cl;
        }

        if (time >= pdat->t_swing && time <= pdat->t_swing * 2) {
            pdat->robot_pos_over_time[i] = co.x_1 + (ceil(lim.x_upper_bound / 2) - co.x_1) * (time / pdat->t_swing);
        }
    }
    for (int i = 1; i < MAX_RANGE; i++) {
        // Calculate the position difference between consecutive time steps
        float position_difference_cl = pdat->cable_length_over_time[i] - pdat->cable_length_over_time[i - 1];
        float position_difference_robot = pdat->robot_pos_over_time[i] - pdat->robot_pos_over_time[i - 1];
        // Calculate the speed by dividing the position difference by the time interval
        float speed_cl = position_difference_cl / lim.T_s;
        float speed_robot = position_difference_robot / lim.T_s;
        // Store the calculated speed in the speeds array
        pdat->cable_speed_over_time[i - 1] = speed_cl;
        pdat->robot_speed_over_time[i - 1] = speed_robot;
    }

    return 0;



}
