#ifndef SWINGPATH_H
#define SWINGPATH_H
#include <math.h>
#include <stdlib.h>

#define MAX_RANGE 10000    // maximum length of the output arrays. with a 500hz system this is equal to 20 seconds.

typedef struct input_coordinates {
    
    float x_1;
    float y_1;
    float x_2;
    float y_2;
} coordinates;

typedef struct input_robot_limitations {
    float T_s;
    float lower_bound;
    float x_upper_bound;
    float y_upper_bound;
    float MAX_robot_speed;
    float MAX_cable_speed; 
    float MAX_cable_length;
} limit;

typedef struct output_PathData {
    float cable_length_over_time[MAX_RANGE]; // Assuming maximum size
    float robot_pos_over_time[MAX_RANGE];
    float Object_x[MAX_RANGE];
    float Object_y[MAX_RANGE];
    float theta[MAX_RANGE];
    float robot_speed_over_time[MAX_RANGE-1];
    float cable_speed_over_time[MAX_RANGE-1];
    float t_swing;
    float x_m;
    float cl_1;
    float cl_2;
    float theta_1;
    float theta_2;
} pathdata;



extern int calculate_speed(coordinates co, limit lim, pathdata *pdat);
#endif
