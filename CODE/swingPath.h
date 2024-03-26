#ifndef SWINGPATH_H
#define SWINGPATH_H

#include <math.h>
#include <stdlib.h>

// Define MAX_RANGE as a constant (optional)
#define MAX_RANGE 10000

// Structure for input robot limitations
typedef struct input_robot_limitations {
    float T_s;
    float P_nom;
    float h_b;
    float b_b;
    float m_b;
    float L_p;
    float a_max_bang;
} limit;

// Structure for input coordinates
typedef struct input_coordinates {
    float x_1;
    float y_1;
} coordinates;

// Structure for output path data
typedef struct output_PathData {
    float cable_length_over_time[MAX_RANGE];
    float robot_pos_over_time[MAX_RANGE];
    float Object_x[MAX_RANGE];
    float Object_y[MAX_RANGE];
    float theta[MAX_RANGE];
    float robot_speed_over_time[MAX_RANGE];
    float cable_speed_over_time[MAX_RANGE];
    float t_swing;
    float x_m;
    float cl_1;
    float cl_2;
    float cl_3;
    float theta_1;
    float theta_2;
    float theta_3;

} pathdata;

// Function declaration for swingPath
extern int swingPath(coordinates co, limit lim, pathdata *pdat);

#endif /* SWINGPATH_H */
