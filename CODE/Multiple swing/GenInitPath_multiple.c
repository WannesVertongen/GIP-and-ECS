#include "createPath_multiple.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h> // Include stdlib.h for malloc


int GenInitPath(coordinates *co, limit lim, pathdata *pdat, int *index) {
    if (co->y_1 < lim.lower_bound || co->y_1 > lim.y_upper_bound ||
        co->x_1 < lim.lower_bound || co->x_1 > lim.x_upper_bound ||
        lim.T_s <= 0) {
        return 1; // Error: Invald input
    }

    float x_t = co->x_2 - co->x_1;
    float x_m_value = (x_t * (2 * co->y_1 * co->y_2 + co->y_1 * sqrt(4 * co->y_1 * co->y_2 + pow(x_t, 2)) - co->y_2 * sqrt(4 * co->y_1 * co->y_2 + pow(x_t, 2)) + pow(x_t, 2) - 2 * pow(co->y_1, 2))) / (4 * co->y_1 * co->y_2 + 2 * pow(x_t, 2) - 2 * pow(co->y_1, 2) - 2 * pow(co->y_2, 2));
    pdat->x_m = x_m_value;

    float cl_1_value = co->x_1;
    float cl_2_value = co->x_2;
    pdat->cl_1 = cl_1_value;
    pdat->cl_2 = cl_2_value;
    float distance_x = ceil(lim.x_upper_bound / 2) - co->x_1;
    float distance_cl = ceil(co->x_2-co->x_1);

    int t_swing_value = 10; // arbitrary choice of 2 succesive motion, each 5 seconds.
    pdat->t_swing = t_swing_value;

    // using constant motor speed.
    if (fabs(pdat->cl_2 - pdat->cl_1) / t_swing_value > lim.MAX_cable_speed) {
        return 1;
        //Dit zou ik aanpassen aangezien we onze t_swing zelf kiezen. Als we buiten de limiet vallen moet tswing gewoon groter. We kunnen tswing ook kiezen
        //door te zeggen ga tot 0.8*MAX_speed ofzo
    }

    int array_size = ceil(pdat->t_swing / lim.T_s);
    
    int i = index;

    // Initialize robot_pos_over_time with co->x_1 values

    //Wat is dit? Hele lijst robot positie aan x2 and kabel aan y2? Sws heel inefficiente manier om dit te doen met loop
    //Ge kunt gewoon robot[] = {cox2} doen ofzo
     for (i = index; i < MAX_RANGE; i++) {
        pdat->robot_pos_over_time[i] = co->x_2;
        pdat->cable_length_over_time[i] = co->y_2;
    }

    // Calculate cable_length_over_time and update robot_pos_over_time accordingly
    float time;
    for (time = 0, i = index; i < array_size; time += lim.T_s, i++) {

        // cable length in the first 5 seconds with a bang-bang motion

        if (i < ceil(array_size/4)) {
            float cl = pdat->cl_1 + 2*distance_cl * pow(time/pdat->t_swing,2);
            pdat->cable_length_over_time[i] = cl;
            pdat->Object_y[i] = cl; //Hoezo update de object coordinaat? Object staat toch nog stil hier?
        }
        if (i >= ceil(array_size/4) && i < ceil(array_size/2)) {
            float cl = pdat->cl_1 - 2*distance_cl * pow(time/pdat->t_swing,2)  + 4*distance_cl*(time/lim.T_s) - distance_cl;
            pdat->cable_length_over_time[i] = cl;
            pdat->Object_y[i] = cl;
        }

         // position of the motor after the cable also with a bang-bang motion 
        if (i >= ceil(array_size/2) && i < ceil(array_size * 0.75)) {
            pdat->robot_pos_over_time[i] = co->x_1 + 2*distance_x * pow((time-array_size*lim.T_s)/pdat->t_swing,2);
        }
        if (i >= ceil(array_size * 0.75) && i < array_size) {
            pdat->robot_pos_over_time[i] = co->x_1 -2*distance_x * pow((time-array_size*lim.T_s)/pdat->t_swing,2) + 4*distance_x*((time-array_size*lim.T_s)/pdat->t_swing) -distance_x;
        }
    }
    //Update index
    *index = i;

    //Hoezo hier wel hele range en niet gewoon tot array_size??
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
