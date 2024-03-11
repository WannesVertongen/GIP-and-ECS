#include "velocity_buffer.h"

int main() {
    int motorValues[] = {10, 20, 30, 40, 50}; // Example values to send to the motor
    int array_size = sizeof(motorValues) / sizeof(motorValues[0]);
    int MAX_BUFFER_SIZE = 10; // Example buffer size

    // Initialize buffer
    VelocityBuffer buffer;
    initVelocityBuffer(&buffer, motorValues, MAX_BUFFER_SIZE);

    // Populate buffer with motor values
    for (int i = 0; i < array_size; i++) {
        writeToBuffer(&buffer, motorValues[i]);
    }

    // Send velocities to stepper motor
    sendVelocitiesToStepper(&buffer, 500);
    
    return 0;
}
