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

    float time;
    float cl_1_value = co.x_1;
    float cl_2_value = co.x_2;
    pdat->cl_1 = cl_1_value;
    pdat->cl_2 = cl_2_value;

    int t_swing_value = 5; // arbitrachose of 5 seconds.
    pdat->t_swing = t_swing_value;

    // using constant motor speed.
    if (fabs(pdat->cl_2 - pdat->cl_1) / t_swing_value > lim.MAX_motor_speed) {
        return 1;
    }

    int array_size = ceil(pdat->t_swing / lim.T_s);
    int freq = ceil(1 / lim.T_s);
    int i = 0;

    // Initialize robot_pos_over_time with co.x_1 values
    for (i = 0; i < array_size; i++) {
        pdat->robot_pos_over_time[i] = ceil(lim.x_upper_bound / 2);
        
    }

    // Calculate cable_length_over_time and update robot_pos_over_time accordingly
    for (time = 0, i = 0; time < pdat->t_swing * 2; time += lim.T_s, i++) {
        if( time < pdat->t_swing){
         float cl = pdat->cl_1 + (pdat->cl_2 - pdat->cl_1) * (time / t_swing_value);   
         pdat->cable_length_over_time[i] = pdat->cl_1 + (pdat->cl_2 - pdat->cl_1) * time / pdat->t_swing;
         pdat->robot_pos_over_time[i] = co.x_1;
        }
        
        if (i <= t_swing_value * freq) {
            pdat->robot_pos_over_time[i + t_swing_value * freq] = co.x_1 + (ceil(lim.x_upper_bound / 2) - co.x_1) * (time / t_swing_value);
        } else {
            pdat->robot_pos_over_time[i] = co.x_2;
        }
        pdat->Object_x[i] = pdat->robot_pos_over_time[i];
        pdat->Object_y[i] = cl;
    }

    return 0;
}
