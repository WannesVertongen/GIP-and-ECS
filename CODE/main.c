#include "velocity_buffer.h"
#include "createPath.h"
#include <stdio.h>
#include <math.h>
int main() {
    int MAX_BUFFER_SIZE;
    int UPDATE_FREQUENCY = 500;
    // General input
    limit input_2 = {.T_s = 1/UPDATE_FREQUENCY, .lower_bound = 0, .x_upper_bound = 1000, .y_upper_bound = 500, .MAX_robot_speed = 1000, .MAX_cable_speed = 1000};
    float EPSILON = 1;

    // Input coordinates: different arrays for different parts of movement
    pathdata output_init;
    pathdata output_swing;

    coordinates input_1 = {.x_1 = 0, .y_1 = 20, .x_2 = 10, .y_2 = 15};

    //Initializing the robot position and cable length
    int result1 = GenInitPath(input_1, input_2, &output_init);
 
    
    // Calculating the swing path
    int result2 = createPath(input_1, input_2, &output_swing);
    printf("%f",output_swing.t_swing);
    printf("%f",output_swing.cl_1);

    //Max buffer size kan hier berekend worden adhv resultaten?

    
    //1. Initialize: cable length 
    MAX_BUFFER_SIZE = output_init.t_swing * UPDATE_FREQUENCY;
    int C_Values_init[MAX_BUFFER_SIZE]; // Array to hold velocity values
    VelocityBuffer cable_initialize; // Velocity buffer structure

    // Initialize the first buffer
    initVelocityBuffer(&cable_initialize, C_Values_init, MAX_BUFFER_SIZE);

    // Write the correct values to the buffer:  
    for (int i = 0; i < MAX_BUFFER_SIZE; ++i) {
        float cable_velocity = output_init.cable_speed_over_time[i] ;
        int result = writeToBuffer(&cable_initialize, cable_velocity); 

        if (result == -1) {
            printf("Buffer is full. Stopping writing.\n");
            break;
        }
    }

    //2. Initialize: robot position 
    int R_Values_init[MAX_BUFFER_SIZE]; // Array to hold velocity values
    VelocityBuffer robot_initialize; // Velocity buffer structure

    // Initialize the first buffer
    initVelocityBuffer(&robot_initialize, R_Values_init, MAX_BUFFER_SIZE);

    // Write the correct values to the buffer:  
    for (int i = 0; i < MAX_BUFFER_SIZE; ++i) {
        float robot_velocity = output_init.robot_speed_over_time[i] ;
        int result = writeToBuffer(&robot_initialize, robot_velocity); 

        if (result == -1) {
            printf("Buffer is full. Stopping writing.\n");
            break;
        }
    }

    //3. Send initialzing velocities to stepper motor: DIT MOET ZEKER EN VAST IN PARALLEL!!!!
    sendVelocitiesToStepper(&cable_initialize, UPDATE_FREQUENCY);
    sendVelocitiesToStepper(&robot_initialize, UPDATE_FREQUENCY);

    //4. Swing: cable length 
    MAX_BUFFER_SIZE = output_swing.t_swing*UPDATE_FREQUENCY;

    int C_Values_swing[MAX_BUFFER_SIZE]; // Array to hold velocity values
    VelocityBuffer cable_swing; // Velocity buffer structure

    // Initialize the first buffer
    initVelocityBuffer(&cable_swing, C_Values_swing, MAX_BUFFER_SIZE);

    // Write the correct values to the buffer:  
    for (int i = 0; i < MAX_BUFFER_SIZE; ++i) {
        float cable_velocity = output_swing.cable_speed_over_time[i] ;
        int result = writeToBuffer(&cable_swing, cable_velocity); 

        if (result == -1) {
            printf("Buffer is full. Stopping writing.\n");
            break;
        }
    }

    //5. Swing: robot position 
    int R_Values_swing[MAX_BUFFER_SIZE]; // Array to hold velocity values
    VelocityBuffer robot_swing; // Velocity buffer structure

    // Initialize the first buffer
    initVelocityBuffer(&robot_swing, R_Values_swing, MAX_BUFFER_SIZE);
    // Write the correct values to the buffer:  
    for (int i = 0; i < MAX_BUFFER_SIZE; ++i) {
        float robot_velocity = output_swing.robot_speed_over_time[i] ;
        int result = writeToBuffer(&robot_swing, robot_velocity); 

        if (result == -1) {
            printf("Buffer is full. Stopping writing.\n");
            break;
        }
    }

    //6. Send swing velocities to stepper motor: DIT MOET ZEKER EN VAST IN PARALLEL!!!!
    sendVelocitiesToStepper(&cable_swing, UPDATE_FREQUENCY);
    sendVelocitiesToStepper(&robot_swing, UPDATE_FREQUENCY);

    return 0;
}
