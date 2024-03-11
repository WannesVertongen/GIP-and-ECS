#include "createPath.h"
#include <math.h>
#include <stdio.h>


int GenInitPath(coordinates co, limit lim, pathdata *pdat) {
    if (co.y_1 < lim.lower_bound || co.y_1 > lim.y_upper_bound ||
        co.x_1 < lim.lower_bound || co.x_1 > lim.x_upper_bound ||
        lim.T_s <= 0) {
        return 1; // Error: Invald input
    }

    float cl_1_value = co.y_1;
    pdat->cl_1 = cl_1_value;
    float distance_x = ceil(lim.x_upper_bound / 2) - co.x_1;
    float distance_cl = ceil(co.x_2-co.x_1);

    float t_swing_value = fabs(distance_cl) / (0.5 * lim.MAX_cable_speed) + fabs(distance_x) / (0.5 * lim.MAX_robot_speed) ; // arbitrary choice of 2 succesive motion, each 5 seconds.
    pdat->t_swing = t_swing_value;

    
    int array_size = ceil(pdat->t_swing / lim.T_s);
    
    int i;

    // Calculate cable_length_over_time and update robot_pos_over_time accordingly
    float time;
    for (time = 0, i = 0; i < array_size; time += lim.T_s, i++) {

        // cable length in the first 5 seconds with a bang-bang motion

        if (i < ceil(array_size/4)) {
            float cl = pdat->cl_1 + 2*distance_cl * pow(time/pdat->t_swing,2);
            pdat->cable_length_over_time[i] = cl;
            pdat->Object_y[i] = cl; //Object is here the gripper at the end of the cable, not the object that will be moved.
        }
        if (i >= ceil(array_size/4) && i < ceil(array_size/2)) {
            float cl = pdat->cl_1 - 2*distance_cl * pow(time/pdat->t_swing,2)  + 4*distance_cl*(time/lim.T_s) - distance_cl;
            pdat->cable_length_over_time[i] = cl;
            pdat->Object_y[i] = cl;
        }

         // position of the motor after the cable also with a bang-bang motion 
        if (i >= ceil(array_size/2) && i < ceil(array_size * 0.75)) {
            float pos = co.x_1 + 2*distance_x * pow((time-array_size*lim.T_s)/pdat->t_swing,2);
            pdat->robot_pos_over_time[i] = pos ;
            pdat->Object_x[i] = pos;
        }
        if (i >= ceil(array_size * 0.75) && i < array_size) {
            float pos = co.x_1 -2*distance_x * pow((time-array_size*lim.T_s)/pdat->t_swing,2) + 4*distance_x*((time-array_size*lim.T_s)/pdat->t_swing) -distance_x;
            pdat->robot_pos_over_time[i] = pos;
            pdat->Object_x[i] = pos;
        }
    }

    //Initial velocity is zero:
    pdat->cable_speed_over_time[0] = 0;
    pdat->robot_speed_over_time[0] = 0;


    for (int i = 1; i < MAX_RANGE; i++) {
        
        // Calculate the position difference between consecutive time steps
        float position_difference_cl = pdat->cable_length_over_time[i] - pdat->cable_length_over_time[i - 1];
        float position_difference_robot = pdat->robot_pos_over_time[i] - pdat->robot_pos_over_time[i - 1];
        // Calculate the speed by dividing the position difference by the time interval
        float speed_cl = position_difference_cl / lim.T_s;
        float speed_robot = position_difference_robot / lim.T_s;
        // Store the calculated speed in the speeds array
        pdat->cable_speed_over_time[i] = speed_cl;
        pdat->robot_speed_over_time[i] = speed_robot;
    }

    return 0;



}
