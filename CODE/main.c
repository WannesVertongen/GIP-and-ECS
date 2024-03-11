#include "velocity_buffer.h"
#include "createPath.h"
#include <stdio.h>
#include <math.h>
int main() {
    int MAX_BUFFER_SIZE = 1000;
    int UPDATE_FREQUENCY = 500;

    int bufferValues[MAX_BUFFER_SIZE]; // Array to hold velocity values
    VelocityBuffer buffer; // Velocity buffer structure

    // Initialize the buffer
    initVelocityBuffer(&buffer, bufferValues, MAX_BUFFER_SIZE);

    // Write some velocities to the buffer
    printf("Writing velocities to buffer...\n");
    for (int i = 0; i < MAX_BUFFER_SIZE + 5; ++i) {
        float velocity = i ;
        int result = writeToBuffer(&buffer, velocity); // Write velocities in increments of 10
        if (result == -1) {
            printf("Buffer is full. Stopping writing.\n");
            break;
        }
    }

    // Send velocities to stepper motor
    printf("Sending velocities to stepper motor...\n");
    sendVelocitiesToStepper(&buffer, UPDATE_FREQUENCY);

    return 0;
}
